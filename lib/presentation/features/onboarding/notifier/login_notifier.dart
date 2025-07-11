// 📦 Login Provider with Remember Me

import 'dart:async';

import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/data/models/auth/auth_model.dart';
import 'package:bundlegram/data/models/auth/login/login_response.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:bundlegram/core/error/failures.dart';
import 'package:go_router/go_router.dart';

final loginProvider = ChangeNotifierProvider((ref) {
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
  bool _showPassword = true;
  bool get showPassword => _showPassword;

  void togglePasswordVisibility() {
    _showPassword = !_showPassword;
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

  Future<void> _loadRememberedEmail() async {
    final remembered = await _storage.getRememberedEmail();
    if (remembered != null) {
      emailCtrl.text = remembered;
      _rememberMe = true;
      notifyListeners();
    }
  }

  Future<void> submit(BuildContext context) async {
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
        await _storage.setPassword(passwordCtrl.text.trim()); // Save password

        if (_rememberMe) {
          await _storage.setRememberedEmail(emailCtrl.text.trim());
        } else {
          await _storage.clearRememberedEmail();
        }

        // Check if username creation is required
        // final dataStatus = loginData.data;
        final message = loginData.message;
        if (message != null &&
            message == "Please create a username to continue") {
          context.dismissDialog();
          _setLoading(false);
          // Navigate to ChooseUsernameScreen with fromLogin flag
          context.go(
            RouteConstants.chooseUsername,
            extra: {'fromLogin': true},
          );
          return;
        }

        // Proceed with fetching data if username is not required
        context
          ..dismissDialog()
          ..showLoadingDialog(message: 'Fetching profile...');
        final profileRes = await _api.getProfile(token);
        if (profileRes.isLeft()) {
          context
            ..dismissDialog()
            ..showErrorSnackBar("Failed to fetch profile");
          _setLoading(false);
          return;
        }

        context
          ..dismissDialog()
          ..showLoadingDialog(message: 'Fetching banks...');
        final bankRes = await _api.getAllBanks(token);
        if (bankRes.isLeft()) {
          context
            ..dismissDialog()
            ..showErrorSnackBar("Failed to fetch banks");
          _setLoading(false);
          return;
        }

        // context
        //   ..dismissDialog()
        //   ..showLoadingDialog(message: 'Fetching wallet...');
        // final walletRes = await _api.getWallet(token);
        // if (walletRes.isLeft()) {
        //   context
        //     ..dismissDialog()
        //     ..showErrorSnackBar("Failed to fetch wallet");
        //   _setLoading(false);
        //   return;
        // }

        context.dismissDialog();
        _setLoading(false);
        context.pushReplacement(RouteConstants.dashboard);
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
          // Clear secure storage
          await _storage.clearAll();

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
