import 'dart:async';

import 'package:bundlegram/core/error/error_sanitixed_users.dart';
import 'package:bundlegram/core/error/errors.dart';
import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/models/auth/auth_model.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final lockScreenServiceProvider = Provider<LockScreenService>((ref) {
  final api = ref.read(apiServiceProvider);
  final storage = ref.read(secureStorageHelperProvider);
  return LockScreenService(api, storage, ref);
});

class LockScreenService {
  final ApiService _api;
  final SecureStorageHelper _storage;
  final Ref _ref;

  LockScreenService(this._api, this._storage, this._ref);

  Future<void> performLogin(
      String email, String password, BuildContext context) async {
    // read saved device info
    final deviceInfo = await _storage.getDeviceInfo();
    String deviceToken = deviceInfo['macAddress'] ?? 'unknown';
    String? fcmToken;

//  a fresh FCM token if Firebase is available; otherwise fallback to storage.
    try {
      if (Firebase.apps.isNotEmpty) {
        final freshToken = await FirebaseMessaging.instance.getToken();
        if (freshToken != null && freshToken.isNotEmpty) {
          fcmToken = freshToken;
          // persist for future reads
          deviceToken = fcmToken;

          await _storage.saveFcmToken(freshToken);
        } else {
          fcmToken = await _storage.getFcmToken();
          deviceToken = await _storage
              .getFcmToken()
              .then((value) => value ?? deviceToken);
        }
      } else {
        // F use cached token if available
        fcmToken = await _storage.getFcmToken();
      }
    } catch (e, st) {
      debugPrint('Failed to fetch FCM token in lock login: $e\n$st');
      fcmToken = await _storage.getFcmToken();
      deviceToken = fcmToken!;
    }

// request with device and fcm tokens
    final request = LoginRequest(
      email: email.trim(),
      password: password.trim(),
      deviceToken: deviceToken,
      fcmToken: fcmToken,
    );
    //final request = LoginRequest(
    //   email: email.trim(),
    //   password: password.trim(),
    // );

    unawaited(context.showLoadingDialog(message: 'Logging in...'));

    final loginResult = await _api.login(request);

    await loginResult.fold(
      (fail) async {
        context.dismissDialog();
        FocusScope.of(context).unfocus();

        await Future.delayed(const Duration(milliseconds: 100));
        final userMsg = userFacingMessageFromFailure(fail);
        final displayMsg = sanitizeErrorMessage(userMsg);
        context.showErrorSnackBar(displayMsg);
      },
      (loginData) async {
        final token = loginData.data?.token;
        if (token == null) {
          context
            ..dismissDialog()
            ..showErrorSnackBar('Token missing in response');

          return;
        }

        await _storage.setAuthToken(token);

        // Fetch profile
        final profileRes = await _api.getProfile(token);
        if (profileRes.isLeft()) {
          context.dismissDialog();
          // ..showErrorSnackBar("Failed to fetch profile");

          return;
        }

        // Fetch banks
        final bankRes = await _api.getAllBanks(token);
        if (bankRes.isLeft()) {
          context
            ..dismissDialog()
            ..showErrorSnackBar("Failed to fetch banks");
          return;
        }

        // Fetch wallet
        final walletRes = await _api.getWallet(token);
        if (walletRes.isLeft()) {
          context.showErrorSnackBar("Failed to fetch wallet");
          return;
        }

        // Fetch transactions
        await _ref
            .read(globalProvider.notifier)
            .fetchUsersTransactions(context);
        await _ref
            .read(globalProvider.notifier)
            .fetchEpinTransactionRequests(context);

        context
          ..dismissDialog()
          ..go(RouteConstants.dashboard);
      },
    );
  }
}
