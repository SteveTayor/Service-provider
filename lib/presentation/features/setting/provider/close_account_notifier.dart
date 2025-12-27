import 'package:bundlegram/core/error/error_sanitixed_users.dart';
import 'package:bundlegram/core/error/errors.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/models/auth/auth_model.dart';

import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:bundlegram/presentation/features/setting/screens/close_account_screen.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transaction_success_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final closeAccountProvider =
    ChangeNotifierProvider.autoDispose<CloseAccountController>((ref) {
  return CloseAccountController(
    ref,
    ref.read(apiServiceProvider),
    ref.read(secureStorageHelperProvider),
  );
});

class CloseAccountController extends ChangeNotifier {
  CloseAccountController(this._ref, this._api, this._storage);

  final Ref _ref;
  final ApiService _api;
  final SecureStorageHelper _storage;

  Future<void> verifyPinAndCloseAccount(
      BuildContext context, String pin) async {
    final token = await _storage.getAuthToken();
    if (token == null) {
      context.showErrorSnackBar("Token missing. Please log in again.");
      return;
    }

    final req = DeleteAccountRequest(pin: pin);
    final res = await _api.closeAccount(token, req);

    res.fold(
      (failure) {
        final userMsg = userFacingMessageFromFailure(failure);
        final displayMsg = sanitizeErrorMessage(userMsg);
        context.showErrorSnackBar(displayMsg);
      },
      (data) {
        if (data.success) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => TransactionSuccessful(
                title: 'Request received!',
                subTitle:
                    'Your request to close your account has been submitted, an email will be sent to you within 7 working days, thank you for using Bundlegram.',
                isCloseAccount: true,
              ),
            ),
          );
        } else {
          context.showErrorSnackBar(data.message);
        }
      },
    );
  }
}
