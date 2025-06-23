import 'dart:async';
import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/models/auth/auth_model.dart';
import 'package:bundlegram/data/models/auth/registeration/username/username_response.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  void _onUsernameChanged() {
    final text = usernameController.text.trim();
    isValid = text.length >= 3;
    if (!isValid) {
      isAvailable = false;
      notifyListeners();
      return;
    }

    _debounce?.cancel();
    _debounce =
        Timer(const Duration(milliseconds: 500), () => checkUsername(text));
  }

  Future<void> checkUsername(String username) async {
    isChecking = true;
    notifyListeners();

    final result = await _api.checkUsername(username);
    result.fold(
      (failure) {
        isAvailable = false;
        errorMessage = 'Check failed';
      },
      (res) {
        isAvailable = res.message == "Username is available";
        errorMessage = null;
      },
    );

    isChecking = false;
    notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    if (!isValid || !isAvailable || isSubmitting) return;

    isSubmitting = true;
    notifyListeners();

    await context.showLoadingDialog(message: 'Saving username...');

    final token = await _storage.getAuthToken();
    if (token == null) {
      context.dismissDialog();
      context.showErrorSnackBar("Missing auth token");
      isSubmitting = false;
      notifyListeners();
      return;
    }

    final result =
        await _api.addUsername(token, usernameController.text.trim());

    context.dismissDialog();

    result.fold(
      (failure) => context.showErrorSnackBar(failure.props.first.toString()),
      (res) => context.goNamed(RouteConstants.onboardResult),
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
