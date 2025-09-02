// 📦 Login Provider with Remember Me

import 'dart:async';
import 'dart:io';

import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/presentation/features/dashboard/provider/dashboard_provider.dart';
import 'package:bundlegram/presentation/features/wallet/screen/enterpin_screen.dart';
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
  // --- Replace existing _isDeviceInfoValid with this ---
  bool _isDeviceInfoValid(Map<String, String> deviceInfo) {
    final macAddress = deviceInfo['macAddress'];
    final ipAddress = deviceInfo['ipAddress'];
    final platform = deviceInfo['platform'];

    // Make location optional — only require device id, ip and platform
    return macAddress != null &&
        macAddress != 'unknown' &&
        ipAddress != null &&
        ipAddress != '0.0.0.0' &&
        platform != null &&
        platform != 'unknown';
  }

// --- New helper: collect and persist device info safely (non-blocking) ---
  Future<void> _collectAndStoreDeviceInfoSafely() async {
    String macAddress = 'unknown';
    String ipAddress = '0.0.0.0';
    String latitude = '0.0';
    String longitude = '0.0';
    String platform = 'unknown';

    try {
      // device id / platform
      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        macAddress = androidInfo.id ?? 'unknown';
        platform = 'android';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        macAddress = iosInfo.identifierForVendor ?? 'unknown';
        platform = 'ios';
      }

      // wifi ip (best-effort)
      try {
        final info = NetworkInfo();
        ipAddress = await info.getWifiIP() ?? '0.0.0.0';
      } catch (e) {
        debugPrint('Failed to get wifi ip: $e');
      }

      // Request location permission gracefully and only attempt location if granted
      PermissionStatus locationStatus;
      if (Platform.isIOS) {
        locationStatus = await Permission.locationWhenInUse.status;
        if (!locationStatus.isGranted) {
          locationStatus = await Permission.locationWhenInUse.request();
        }
      } else {
        locationStatus = await Permission.location.status;
        if (!locationStatus.isGranted) {
          locationStatus = await Permission.location.request();
        }
      }

      if (locationStatus.isGranted) {
        try {
          final position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          latitude = position.latitude.toString();
          longitude = position.longitude.toString();
        } catch (e) {
          debugPrint('Could not get geolocation: $e');
        }
      } else {
        // Expected: user denied location. Log for analytics/dev only.
        debugPrint('Location permission not granted: $locationStatus');
        // If you want to detect permanentlyDenied and later prompt user to open settings,
        // you can check: locationStatus.isPermanentlyDenied and act accordingly (not here).
      }

      // Persist whatever we have (do not block UI)
      await _storage.setDeviceInfo(
        macAddress: macAddress,
        ipAddress: ipAddress,
        latitude: latitude,
        longitude: longitude,
        platform: platform,
      );
    } catch (e, st) {
      // Unexpected error — log or report to analytics. Do NOT show user-facing error.
      debugPrint('Unexpected error collecting device info: $e\n$st');
      // Optionally send to crash reporting service.
    }
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
            ..showErrorSnackBar('Token missing in response');
          _setLoading(false);
          return;
        }

        await _storage.setAuthToken(token);
        await _storage.setPassword(passwordCtrl.text.trim());
        final userEmail = emailCtrl.text.trim();

        // if (_rememberMe) {
        await _storage.setRememberedEmail(emailCtrl.text.trim());
        // } else {
        //   await _storage.clearRememberedEmail();
        // }

        final existingDeviceInfo = await _storage.getDeviceInfo();
        final isDeviceInfoValid = _isDeviceInfoValid(existingDeviceInfo);

        if (!isDeviceInfoValid) {
          // Try to collect device info but do NOT block login if it fails.
          // Fire-and-forget so users who denied location won't see errors.
          unawaited(_collectAndStoreDeviceInfoSafely());
        }

        _setLoading(false);

        // Check if username creation is required
        final message = loginData.message;
        if (message != null &&
            message == 'Please create a username to continue') {
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
        final profile = profileRes.fold((_) => null, (r) => r);

        if (profile?.data?.username != null) {
          await _storage.setUsername(profile!.data!.username!);
        }

        // unawaited(context.showLoadingDialog(message: 'Fetching banks...'));
        final bankRes = await _api.getAllBanks(token);
        if (bankRes.isLeft()) {
          context
            ..dismissDialog()
            ..showErrorSnackBar('Failed to fetch banks');
          _setLoading(false);
          return;
        }

        // unawaited(context.showLoadingDialog(message: 'Fetching wallet...'));
        final walletRes = await _api.getWallet(token);
        if (walletRes.isLeft()) {
          context.showErrorSnackBar('Failed to fetch wallet');
          // ..dismissDialog()
          _setLoading(false);
          return;
        }
        // Fetch and cache users' transactions before routing
        await _ref
            .read(globalProvider.notifier)
            .fetchUsersTransactions(context);
        final localPin = await _storage.getPin(userEmail);
        if (localPin == null) {
          context.dismissDialog();
          unawaited(
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => EnterPinScreen(
                  onVerified: (pin) async {
                    final result = await _api.createPin(token, pin, pin);
                    await result.fold(
                      (failure) {
                        context.showErrorSnackBar(
                          'Failed to verify PIN',
                        );
                      },
                      (data) async {
                        if (data.status == 'success') {
                          await _storage.setPin(userEmail, pin);
                          ctx.pushReplacement(RouteConstants.dashboard);
                        } else {
                          context.showErrorSnackBar(
                            'Failed to verify PIN',
                          );
                        }
                      },
                    );
                  },
                  isChangedAccountPin: false, // Use existing flag for context
                ),
              ),
            ),
          );
        } else {
          context
            ..dismissDialog()
            ..pushReplacement(RouteConstants.dashboard);
        }
        // context
        //   ..dismissDialog()

        //   // Proceed to dashboard if username is not required
        //   ..pushReplacement(RouteConstants.dashboard);
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
          context.go(RouteConstants.login);
          // ..showSuccessSnackBar(response.message ?? 'Logged out');
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
