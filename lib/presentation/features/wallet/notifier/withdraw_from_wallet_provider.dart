import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bundlegram/core/error/error_sanitixed_users.dart';
import 'package:bundlegram/core/error/errors.dart';
import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/models/banks/get_all_users_banks_response.dart';
import 'package:bundlegram/data/models/transaction/withdraw_request.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:bundlegram/presentation/features/wallet/screen/topup_failed_screen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

final withdrawalProvider = ChangeNotifierProvider<WithdrawalProvider>(
  (ref) => WithdrawalProvider(
    ref,
    ref.read(apiServiceProvider),
    ref.read(secureStorageHelperProvider),
  ),
);

class WithdrawalProvider extends ChangeNotifier {
  final Ref _ref;
  final ApiService _api;
  final SecureStorageHelper _storage;

  WithdrawalProvider(this._ref, this._api, this._storage);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  Future<String> getIpAddress() async {
    try {
      final response =
          await http.get(Uri.parse('https://api.ipify.org?format=json'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            jsonDecode(response.body) as Map<String, dynamic>;
        return data['ip'] as String;
      }
    } catch (e) {
      log("Ip address not found");
    }
    return '0.0.0.0';
  }

  Future<String> getMacAddress() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id ?? 'unknown';
    } else {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? "Unknown";
    }
  }

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        return null;
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  List<UserBanksDetails> _userBanks = [];
  List<UserBanksDetails> get userBanks => _userBanks;

  UserBanksDetails? _selectedBank;
  UserBanksDetails? get selectedBank => _selectedBank;

  final TextEditingController _amountController = TextEditingController();
  TextEditingController get amountController => _amountController;

  String get formattedBalance {
    final wallet = _ref.read(globalProvider).walletBalance;
    final value = wallet.value?.wallet;
    return value.toCurrency();
  }

  Future<void> fetchData(BuildContext context) async {
    _setLoading(true);
    await _fetchUserBanks(context);
    _setLoading(false);
  }

  Future<void> _fetchUserBanks(BuildContext context) async {
    final banksAsync = _ref.read(globalProvider).userBanks;
    if (banksAsync is AsyncData<GetAllUserBanksResponse?>) {
      _userBanks = banksAsync.value?.data ?? [];
      _selectedBank = _userBanks.isNotEmpty ? _userBanks.first : null;
      notifyListeners();
    } else {
      final token = await _storage.getAuthToken();
      if (token == null) {
        context.showErrorSnackBar('Authentication token missing');
        return;
      }
      final result = await _api.getUserBanks(token);
      result.fold(
        (fail) {
          final userMsg = userFacingMessageFromFailure(fail);
          context.showErrorSnackBar(userMsg);
          // _setLoading(false);
          return false;
        },
        (data) {
          _userBanks = data.data ?? [];
          _selectedBank = _userBanks.isNotEmpty ? _userBanks.first : null;
          notifyListeners();
        },
      );
    }
  }

  void setSelectedBank(UserBanksDetails? bank) {
    _selectedBank = bank;
    notifyListeners();
  }

  Future<bool> validateAndPrepareWithdrawal(BuildContext context) async {
    if (_selectedBank == null) {
      print("False");
      context.showErrorSnackBar('Please select a bank account');
      return false;
    }
    if (_amountController.text.isEmpty) {
      context.showErrorSnackBar('Please enter an amount');
      return false;
    }
    final amount = double.tryParse(_amountController.text.replaceAll(',', ''));
    if (amount == null || amount <= 0) {
      context.showErrorSnackBar('Please enter a valid amount');
      return false;
    }
    final walletBalance =
        _ref.read(globalProvider).walletBalance.value?.wallet ?? '0.0';
    final wBalance = double.tryParse(walletBalance.toString()) ?? 0.0;
    if (amount > wBalance) {
      context.showErrorSnackBar('Amount exceeds wallet balance');
      return false;
    }
    if (amount < 500) {
      return false;
    }

    return true;
  }

  Future<String?> requestWithdrawal(BuildContext context, String pin) async {
    if (_selectedBank == null || _amountController.text.isEmpty) {
      context.showErrorSnackBar('Invalid withdrawal data');
      return null;
    }
    final amount = double.tryParse(_amountController.text.replaceAll(',', ''));
    if (amount == null || amount <= 0) {
      context.showErrorSnackBar('Invalid amount');
      return null;
    }
    final walletBalance =
        _ref.read(globalProvider).walletBalance.value?.wallet ?? '0.0';
    final wBalance = double.tryParse(walletBalance.toString()) ?? 0.0;
    if (amount > wBalance) {
      context.showErrorSnackBar('Amount exceeds wallet balance');
      return null;
    }

    setSubmitting(true);
    unawaited(context.showLoadingDialog());
    final token = await _storage.getAuthToken();
    if (token == null) {
      context.showErrorSnackBar('Authentication token missing');
      setSubmitting(false);
      return null;
    }
    // Fetch device details
    final ip = await getIpAddress();
    final position = await getCurrentLocation();
    final platform = Platform.isIOS ? 'ios' : 'android';
    final mac = await getMacAddress();
    final packageInfo = await PackageInfo.fromPlatform();
    final appVersion = packageInfo.version; //

    final req = WithdrawRequest(
      amount: amount.toString(),
      macAddress: mac,
      ipAddress: ip,
      latitude: position?.latitude.toString() ?? '0.0',
      longitude: position?.longitude.toString() ?? '0.0',
      accountNumber: _selectedBank!.accountNumber!,
      platform: platform,
      pin: pin,
      appVersion: appVersion,
    );

    final result = await _api.requestWithdraw(token, req);
    return result.fold(
      (fail) {
        context.dismissDialog();

        // final message = fail.properties.join('\n');
        // final displayMessage = message.toLowerCase().contains('insufficient') ||
        //         message.toLowerCase().contains('incorrect') ||
        //         message.toLowerCase().contains('pending payout')
        //     ? message
        //     : 'Failed to request withdrawal';
        final userMsg = userFacingMessageFromFailure(fail);
        final displayMsg = sanitizeErrorMessage(userMsg);
        context.showErrorSnackBar(displayMsg);
        // context.showErrorSnackBar(
        //     message.isNotEmpty ? message : 'Transaction failed');
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (ctx) => FailedResultScreen(
        //       serviceContent: 'Withdrawal',
        //       title: 'Withdrawal Failed',
        //       errorMessage: displayMessage,
        //       onRetry: () {
        //         context.pushReplacement(RouteConstants.dashboard);
        //       },
        //     ),
        //   ),
        // );
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (ctx) => FailedResultScreen(
              serviceContent: 'Withdrawal',
              title: 'Withdrawal Failed',
              errorMessage: displayMsg,
              onRetry: () => context.go(RouteConstants.dashboard),
            ),
          ),
        );

        return null;
      },
      (res) {
        context.dismissDialog();
        // ..showSuccessSnackBar('Withdrawal request submitted successfully');
        _amountController.clear();
        setSubmitting(false);
        notifyListeners();
        // Return the success message to be used in the subTitle
        return res.message ?? 'Withdrawal request successfully received';
      },
    );
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setSubmitting(bool value) {
    _isSubmitting = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}
