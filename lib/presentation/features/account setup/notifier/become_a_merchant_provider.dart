import 'dart:async';
import 'dart:io';

import 'package:bundlegram/core/error/error_sanitixed_users.dart';
import 'package:bundlegram/core/error/errors.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_formatter.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/models/base/base_response.dart';
import 'package:bundlegram/data/models/become_a_merchant/become_a_merchant_request.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:bundlegram/core/error/failures.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/widgets/error_popup_widget.dart';
import 'package:bundlegram/presentation/features/biometric/providers/biometric_service.dart';
import 'package:bundlegram/presentation/features/dashboard/provider/dashboard_provider.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transaction_success_widget.dart';
import 'package:bundlegram/presentation/features/wallet/screen/enterpin_screen.dart';
import 'package:bundlegram/presentation/features/wallet/screen/topup_failed_screen.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:network_info_plus/network_info_plus.dart';

import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

final becomeAgentProvider = ChangeNotifierProvider<BecomeAgentProvider>((ref) {
  return BecomeAgentProvider(ref, ref.read(apiServiceProvider));
});

class BecomeAgentProvider extends ChangeNotifier {
  final Ref _ref;
  final ApiService _api;
  static const double requiredAmount = 10000.0;

  BecomeAgentProvider(this._ref, this._api);

  bool _loading = false;
  bool get loading => _loading;

  void _setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  Future<void> checkAndInitiatePayment(BuildContext context) async {
    _setLoading(true);
    unawaited(context.showLoadingDialog(message: 'Initiating payment...'));
    try {
      final globalState = _ref.read(globalProvider);
      final walletBalanceAsync = globalState.walletBalance;
      final rawValue = walletBalanceAsync.value?.wallet ?? '0';
      final parsedBalance =
          double.tryParse(rawValue.replaceAll(',', '')) ?? 0.0;

      if (parsedBalance < requiredAmount) {
        context.dismissDialog();
        unawaited(Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) => FailedResultScreen(
              title: "Transaction Failed",
              serviceContent: "transaction",
              errorMessage:
                  'Your wallet balance (${parsedBalance.toCurrency()}) is less than the required ₦10,000.00. Please fund your wallet.',
              onRetry: () {
                context.pushReplacement(RouteConstants.dashboard);
              },
            ),
          ),
        ));
        // unawaited(context.showPopUp(
        //   ErrorPopup(
        //     title: 'Insufficient Funds',
        //     message:
        //         'Your wallet balance (${parsedBalance.toCurrency()}) is less than the required ₦10,000.00. Please fund your wallet.',
        //     onOkay: () {
        //       context.go(RouteConstants.dashboard); // Route to dashboard
        //     },
        //   ),
        // ));
        _setLoading(false);
        return;
      }
      final globalUserProvider = _ref.watch(globalProvider).profile;
      final profileProv = globalUserProvider.value?.data;
      if (profileProv?.userType == "agent") {
        _setLoading(false);
        context
          ..showErrorSnackBar('You are already a Bundlegram agent')
          ..go(RouteConstants.dashboard); // Route to dashboard

        return;
      }
      // Biometric verification
      final biometricService = _ref.read(biometricServiceProvider);
      final isBiometricEnabled =
          await biometricService.isBiometricTransactionEnabled;

      if (isBiometricEnabled) {
        final didAuth = await biometricService.authenticate(
          type: BiometricAuthType.transaction,
        );

        if (didAuth) {
          final email =
              await _ref.read(secureStorageHelperProvider).getRememberedEmail();
          if (email == null) {
            debugPrint("No stored account found, please login again");
            context.dismissDialog();
            return;
          }

          final storedPin =
              await _ref.read(secureStorageHelperProvider).getPin(email);
          if (storedPin == null) {
            debugPrint("No stored PIN found, please set up your PIN");
            context.dismissDialog();
            return;
          }

          // merchant registration directly with stored PIN
          context.dismissDialog();
          await _processMerchantRegistration(context, storedPin);
          _setLoading(false);
          return;
        } else {
          context.showErrorSnackBar("Biometric authentication failed");
        }
      }

      // ❌ If not biometric or failed → fallback to EnterPinScreen

      // If balance is sufficient, navigate to EnterPinScreen
      context.pop(); // Close the bottom sheet
      unawaited(Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EnterPinScreen(
            onVerified: (pin) => _processMerchantRegistration(context, pin),
          ),
        ),
      ));
      context.dismissDialog();
      _setLoading(false);
    } catch (e) {
      context.showErrorSnackBar('An error occurred: $e');
      _setLoading(false);
    }
  }

  Future<void> _processMerchantRegistration(
      BuildContext context, String pin) async {
    _setLoading(true);
    unawaited(context.showLoadingDialog(
        message: 'Processing \nMerchant Registration...'));
    try {
      final token = await _ref.read(secureStorageHelperProvider).getAuthToken();
      if (token == null) {
        context.showErrorSnackBar('Missing token');
        _setLoading(false);
        return;
      }

      final macAddress = await _getMacAddress();
      final ipAddress = await _getIpAddress();
      final position = await _getCurrentPosition();
      final platform = await _getPlatform();
      final packageInfo = await PackageInfo.fromPlatform();
      final appVersion = packageInfo.version;

      final req = BecomeAMerchantRequest(
        macAddress: macAddress,
        ipAddress: ipAddress,
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
        platform: platform,
        // appVersion: appVersion,
      );

      final result = await _api.becomeMerchant(token, req);
      _setLoading(false);

      result.fold(
        (Failure fail) {
          context.dismissDialog();
          final userMsg = userFacingMessageFromFailure(fail);
          final displayMsg = sanitizeErrorMessage(userMsg);
          context.showErrorSnackBar(displayMsg);
        },
        (BaseResponse resp) {
          if (resp.success) {
            context
                .showSuccessSnackBar(resp.message ?? 'Upgraded successfully');
            _ref.read(globalProvider.notifier).fetchProfile(context);
            context.dismissDialog();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TransactionSuccessful(
                  title: 'Congratulations!',
                  subTitle: 'You are now officially a Bundlegram agent.',
                ),
              ),
            );
          } else {
            context.dismissDialog();
            final userMsg = sanitizeErrorMessage(resp.message);
            context.showErrorSnackBar(userMsg);
          }
        },
      );
    } catch (e) {
      debugPrint('Error in merchant registration: $e');
      context.dismissDialog();

      context.showErrorSnackBar('An error occurred:');
      _setLoading(false);
    }
  }

  Future<String> _getMacAddress() async {
    final info = NetworkInfo();
    return await info.getWifiBSSID() ?? 'unknown_mac';
  }

  Future<String> _getIpAddress() async {
    final info = NetworkInfo();
    return await info.getWifiIP() ?? 'unknown_ip';
  }

  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<String> _getPlatform() async {
    if (Platform.isAndroid) return "android";
    //     final androidInfo = await deviceInfoPlugin.androidInfo;
    // final androidId = androidInfo.id; // or .androidId in older versions
    // print("Android ID: $androidId");
    if (Platform.isIOS) return "ios";
    //   final iosInfo = await deviceInfoPlugin.iosInfo;
    // final identifier = iosInfo.identifierForVendor;
    // print("iOS ID: $identifier");
    return "unknown";
  }
}
