// ignore_for_file: unawaited_futures

import 'dart:async';
import 'dart:developer';

import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/models/auth/auth_model.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bundlegram/core/router/route_constants.dart';
import 'package:go_router/go_router.dart';

final registerProvider = ChangeNotifierProvider.autoDispose((ref) {
  final api = ref.read(apiServiceProvider);
  final storage = ref.read(secureStorageHelperProvider);
  return RegisterProvider(api, storage, ref);
});

class RegisterProvider extends ChangeNotifier {
  final ApiService _api;
  final SecureStorageHelper _storage;
  final Ref _ref;

  RegisterProvider(this._api, this._storage, this._ref) {
    // listen for field changes to validate form
    for (final c in [
      firstNameCtrl,
      lastNameCtrl,
      emailCtrl,
      phoneCtrl,
      passwordCtrl,
      confirmCtrl
    ]) {
      c.addListener(_validate);
    }
  }

  // controllers
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // UI state
  bool _isValid = false;
  bool get isValid => _isValid;

  bool _agreed = false;
  bool get agreed => _agreed;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  bool _termsTapped = false;
  bool _privacyTapped = false;

  // toggles
  bool showPassword = false;
  bool showConfirm = false;

  void markTermsTapped() {
    _termsTapped = true;
    _checkAgreement();
  }

  void markPrivacyTapped() {
    _privacyTapped = true;
    _checkAgreement();
  }

  void _checkAgreement() {
    final agreedNow = _termsTapped && _privacyTapped;
    if (_agreed != agreedNow) {
      _agreed = agreedNow;
      notifyListeners();
    }
  }

  void toggleAgreement(bool? v) {
    _agreed = v ?? false;
    notifyListeners();
  }

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  void _setError(String? msg) {
    _error = msg;
    notifyListeners();
  }

  void _validate() {
    final valid = formKey.currentState?.validate() ?? false;
    if (valid != _isValid) {
      _isValid = valid;
      notifyListeners();
    }
  }

  Future<void> submit(BuildContext context) async {
    if (!_isValid || !_agreed) return;

    _setLoading(true);
    _setError(null);

    // Show fullscreen loading dialog
    context.showLoadingDialog(message: 'Registering...');

    final req = RegisterRequest(
      email: emailCtrl.text.trim(),
      phone: '+234${phoneCtrl.text.trim()}',
      firstName: firstNameCtrl.text.trim(),
      lastName: lastNameCtrl.text.trim(),
      password: passwordCtrl.text,
      passwordConfirm: confirmCtrl.text,
    );

    // final Either<Failure, RegisterResponse> res = await _api.register(req);

    // context.dismissDialog(); // Dismiss loader

    // await res.fold(
    //   (fail) {
    //     _setError(fail.props.isNotEmpty
    //         ? fail.props.first.toString()
    //         : 'Registration failed');
    //     _setLoading(false);
    //   },
    //   (data) async {
    //     await _storage.setAuthToken(data.data!.token!);
    //     if (context.mounted) {
    //       Navigator.of(context).pushNamed(RouteConstants.chooseUsername);
    //     }
    //     _setLoading(false);
    //   },
    // );

    final result = await _api.register(req);
    context.dismissDialog();
    result.fold(
      (failure) {
        final msg = failure.properties.isNotEmpty
            ? failure.properties.join('\n')
            : 'Registration failed';
        context.showErrorSnackBar(msg);

        _setLoading(false);
      },
      (data) async {
        await _storage.setAuthToken(data.data!.token!);
        _setLoading(false);
        context.pushReplacement(RouteConstants.chooseUsername);
      },
    );
  }

  @override
  void dispose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    passwordCtrl.dispose();
    confirmCtrl.dispose();
    super.dispose();
  }
}
