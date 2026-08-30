import 'dart:async';
import 'package:bundlegram/core/error/error_sanitixed_users.dart';
import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/models/auth/auth_model.dart';
import 'package:bundlegram/data/models/auth/registeration/username/username_response.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';

final chooseUsernameProvider = ChangeNotifierProvider((ref) {
  final api = ref.read(apiServiceProvider);
  final storage = ref.read(secureStorageHelperProvider);
  return ChooseUsernameProvider(api, storage);
});

class ChooseUsernameProvider extends ChangeNotifier {
  final ApiService _api;
  final SecureStorageHelper _storage;

  ChooseUsernameProvider(this._api, this._storage) {
    usernameController.addListener(_onUsernameChanged);
  }

  final usernameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isValid = false;
  bool isAvailable = false;
  bool isChecking = false;
  bool isSubmitting = false;
  String? errorMessage;
  Timer? _debounce;
  bool _fromLogin = false;

  bool get fromLogin => _fromLogin;

  void setFromLogin(bool value) {
    _fromLogin = value;
    notifyListeners();
  }

  void _onUsernameChanged() {
    final text = usernameController.text.trim();
    isValid = text.length >= 3;
    if (!isValid) {
      isAvailable = false;
      errorMessage = 'Username must be at least 3 characters';
      notifyListeners();
      return;
    }

    _debounce?.cancel();
    _debounce =
        Timer(const Duration(milliseconds: 500), () => checkUsername(text));
  }

  Future<void> checkUsername(String username) async {
    isChecking = true;
    errorMessage = null; // Clear error during check
    notifyListeners();

    final result = await _api.checkUsername(username);
    result.fold(
      (failure) {
        isAvailable = false; // Treat failure as unavailable
        errorMessage = 'Failed to check username availability';
      },
      (res) {
        isAvailable =
            res.message == "Username is available"; // True if available for use
        errorMessage = isAvailable ? null : 'This username is already taken';
      },
    );

    isChecking = false;
    notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    if (isSubmitting) {
      debugPrint('[chooseUsername] Already submitting');
      return;
    }
    if (!isValid) {
      context.showErrorSnackBar("Username is invalid");
      debugPrint('[chooseUsername] Invalid username');
      return;
    }
    if (!isAvailable) {
      context.showErrorSnackBar("Username not available");
      debugPrint('[chooseUsername] Username not available');
      return;
    }

    isSubmitting = true;
    notifyListeners();

    print('Step 1: Showing loading dialog');
    unawaited(context.showLoadingDialog(message: 'Saving username...'));

    print('Step 2: Getting auth token');
    final token = await _storage.getAuthToken();
    if (token == null) {
      print('Step 3: Token is null');
      context.dismissDialog();
      context.showErrorSnackBar("Missing authentication token");
      isSubmitting = false;
      notifyListeners();
      return;
    }

    print('Step 4: Calling addUsername API');
    final result =
        await _api.addUsername(token, usernameController.text.trim());

    print('Step 5: Dismissing loading dialog');
    context.dismissDialog();

    result.fold(
      (failure) {
        print('Step 6: API call failed - ${failure.properties.first}');
        final userMsg = userFacingMessageFromFailure(failure);
        context.showErrorSnackBar(userMsg);
      },
      (success) {
        print('Step 7: API call succeeded');
        if (_fromLogin) {
          context
            ..go(RouteConstants.dashboard)
            ..showSuccessSnackBar('Login Successful');
        } else {
          context.go(RouteConstants.onboardResult); // Default flow
        }
      },
    );

    isSubmitting = false;
    notifyListeners();
  }

  @override
  void dispose() {
    usernameController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}

