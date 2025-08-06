// 📦 Login Provider with Remember Me

import 'dart:async';
import 'dart:io';

import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/presentation/features/dashboard/provider/dashboard_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/data/models/auth/auth_model.dart';
import 'package:bundlegram/data/models/auth/login/login_response.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:bundlegram/core/error/failures.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

final loginProvider = ChangeNotifierProvider.autoDispose((ref) {
  final api = ref.read(apiServiceProvider);
  final storage = ref.read(secureStorageHelperProvider);
  return LoginProvider(api, storage, ref);
});

class LoginProvider extends ChangeNotifier {
  final ApiService _api;
  final SecureStorageHelper _storage;
  final Ref _ref;

  LoginProvider(this._api, this._storage, this._ref) {
    emailCtrl.addListener(validate);
    passwordCtrl.addListener(validate);
    _loadRememberedEmail();
  }

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool _isValid = false;
  bool _isLoading = false;
  bool _rememberMe = false;
  String? _error;

  bool get isValid => _isValid;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get rememberMe => _rememberMe;
  bool showPasswrd = true;
  bool get showPassword => showPasswrd;

  void togglePasswordVisibility() {
    showPasswrd = !showPasswrd;
    notifyListeners();
  }

  void toggleRememberMe(bool? value) {
    _rememberMe = value ?? false;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _error = message;
    notifyListeners();
  }

  void validate() {
    final valid = formKey.currentState?.validate() ?? false;
    if (valid != _isValid) {
      _isValid = valid;
      notifyListeners();
    }
  }

  // Helper method to validate device info
  bool _isDeviceInfoValid(Map<String, String> deviceInfo) {
    final macAddress = deviceInfo['macAddress'];
    final ipAddress = deviceInfo['ipAddress'];
    final latitude = deviceInfo['latitude'];
    final longitude = deviceInfo['longitude'];
    final platform = deviceInfo['platform'];

    // Define validation criteria (adjust as needed)
    return macAddress != null &&
        macAddress != 'unknown' &&
        ipAddress != null &&
        ipAddress != '0.0.0.0' &&
        latitude != null &&
        latitude != '0.0' &&
        longitude != null &&
        longitude != '0.0' &&
        platform != null &&
        platform != 'unknown';
  }

  Future<void> _loadRememberedEmail() async {
    final remembered = await _storage.getRememberedEmail();
    if (remembered != null) {
      emailCtrl.text = remembered;
      _rememberMe = true;
      notifyListeners();
    }
  }

  Future<void> submit(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (!_isValid) return;

    _setError(null);
    _setLoading(true);

    final request = LoginRequest(
      email: emailCtrl.text.trim(),
      password: passwordCtrl.text.trim(),
    );

    unawaited(context.showLoadingDialog(message: 'Logging in...'));

    final loginResult = await _api.login(request);

    await loginResult.fold(
      (fail) async {
        context.dismissDialog();
        FocusScope.of(context).unfocus();

        await Future.delayed(const Duration(milliseconds: 100));
        final message = fail.properties.isNotEmpty
            ? fail.properties.join('\n')
            : 'Login failed';

        context.showErrorSnackBar(message);
        _setLoading(false);
      },
      (loginData) async {
        final token = loginData.data?.token;
        if (token == null) {
          context
            ..dismissDialog()
            ..showErrorSnackBar("Token missing in response");
          _setLoading(false);
          return;
        }

        await _storage.setAuthToken(token);
        await _storage.setPassword(passwordCtrl.text.trim());

        // if (_rememberMe) {
        await _storage.setRememberedEmail(emailCtrl.text.trim());
        // } else {
        //   await _storage.clearRememberedEmail();
        // }

        // Device info collection
        String macAddress = 'unknown';
        String ipAddress = '0.0.0.0';
        String latitude = '0.0';
        String longitude = '0.0';
        String platform = 'unknown';

        final existingDeviceInfo = await _storage.getDeviceInfo();
        final isDeviceInfoValid = _isDeviceInfoValid(existingDeviceInfo);

        if (!isDeviceInfoValid) {
          // unawaited(
          //     context.showLoadingDialog(message: 'Collecting device info...'));
          try {
            final locationStatus = await Permission.location.request();
            if (!locationStatus.isGranted) {
              throw Exception('Location permission denied');
            }

            final deviceInfo = DeviceInfoPlugin();
            if (Platform.isAndroid) {
              final androidInfo = await deviceInfo.androidInfo;
              macAddress = androidInfo.id ?? 'unknown';
              platform = 'android';
            } else if (Platform.isIOS) {
              final iosInfo = await deviceInfo.iosInfo;
              macAddress = iosInfo.identifierForVendor ?? 'unknown';
              platform = 'iOS';
            }

            final info = NetworkInfo();
            ipAddress = await info.getWifiIP() ?? '0.0.0.0';

            final position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high);
            latitude = position.latitude.toString();
            longitude = position.longitude.toString();

            await _storage.setDeviceInfo(
              macAddress: macAddress,
              ipAddress: ipAddress,
              latitude: latitude,
              longitude: longitude,
              platform: platform,
            );
          } catch (e) {
            context.showErrorSnackBar('Failed to collect device info: $e');
          }
        }

        _setLoading(false);

        // Check if username creation is required
        final message = loginData.message;
        if (message != null &&
            message == "Please create a username to continue") {
          context.dismissDialog();
          context.go(
            RouteConstants.chooseUsername,
            extra: {'fromLogin': true},
          );
          return;
        }
        passwordCtrl.clear();

        // unawaited(context.showLoadingDialog(message: 'Fetching profile...'));
        final profileRes = await _api.getProfile(token);
        if (profileRes.isLeft()) {
          context.dismissDialog();
          // ..showErrorSnackBar("Failed to fetch profile");
          _setLoading(false);
          return;
        }
        // unawaited(context.showLoadingDialog(message: 'Fetching banks...'));
        final bankRes = await _api.getAllBanks(token);
        if (bankRes.isLeft()) {
          context
            ..dismissDialog()
            ..showErrorSnackBar("Failed to fetch banks");
          _setLoading(false);
          return;
        }

        // unawaited(context.showLoadingDialog(message: 'Fetching wallet...'));
        final walletRes = await _api.getWallet(token);
        if (walletRes.isLeft()) {
          context.showErrorSnackBar("Failed to fetch wallet");
          // ..dismissDialog()
          _setLoading(false);
          return;
        }
        // Fetch and cache users' transactions before routing
        await _ref
            .read(globalProvider.notifier)
            .fetchUsersTransactions(context);
        context.dismissDialog();

        // Proceed to dashboard if username is not required
        context.go(RouteConstants.dashboard);
      },
    );
  }

  Future<void> logoutUser(BuildContext context) async {
    final token = await _storage.getAuthToken();

    if (token == null) {
      context.showErrorSnackBar('No token found.');
      return;
    }

    // Optional: Show a loading dialog
    unawaited(context.showLoadingDialog(message: 'Logging out...'));

    final result = await _api.logout('Bearer $token');

    context.dismissDialog();

    result.fold(
      (failure) {
        context.showErrorSnackBar(
          failure.properties.join('\n') ?? 'Logout failed',
        );
      },
      (response) async {
        if (response.success) {
// Clear all secure storage, including device info
          await _storage.clearAll();
          _ref.read(dashboardProvider).resetIndex();
          // Navigate to login
          context
            ..go(RouteConstants.login)
            ..showSuccessSnackBar(response.message ?? 'Logged out');
        } else {
          context.showErrorSnackBar(response.message ?? 'Logout failed');
        }
      },
    );
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }
}
