import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bundlegram/core/error/failures.dart';
import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_formatter.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/models/auth/wallet/get_wallet_response.dart';
import 'package:bundlegram/data/models/banks/get_all_users_banks_response.dart';
import 'package:bundlegram/data/models/transaction/withdraw_request.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:bundlegram/presentation/features/wallet/screen/topup_failed_screen.dart';
import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

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
    final androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id ?? 'unknown';
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
    return CurrencyFormatter.format(value);
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
          context.showErrorSnackBar(fail.properties.isNotEmpty
              ? fail.properties.join('\n')
              : 'Failed to fetch user banks');
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
        _ref.read(globalProvider).walletBalance.value?.wallet ?? 0.0;
    final wBalance = double.tryParse(walletBalance.toString());
    if (amount > wBalance!) {
      context.showErrorSnackBar('Amount exceeds wallet balance');
      return false;
    }
    return true;
  }

  Future<bool> requestWithdrawal(BuildContext context, String pin) async {
    if (_selectedBank == null || _amountController.text.isEmpty) {
      context.showErrorSnackBar('Invalid withdrawal data');
      return false;
    }
    final amount = double.tryParse(_amountController.text.replaceAll(',', ''));
    if (amount == null || amount <= 0) {
      context.showErrorSnackBar('Invalid amount');
      return false;
    }
    final walletBalance =
        _ref.read(globalProvider).walletBalance.value?.wallet ?? 0.0;
    final wBalance = double.tryParse(walletBalance.toString());
    if (amount > wBalance!) {
      context.showErrorSnackBar('Amount exceeds wallet balance');
      return false;
    }

    _setSubmitting(true);
    unawaited(context.showLoadingDialog());
    final token = await _storage.getAuthToken();
    if (token == null) {
      context.showErrorSnackBar('Authentication token missing');
      _setSubmitting(false);
      return false;
    }
    // Fetch device details
    final ip = await getIpAddress();
    final position = await getCurrentLocation();
    final platform = Platform.isIOS ? 'ios' : 'android';
    final mac = await getMacAddress();

    final req = WithdrawRequest(
      amount: amount.toString(),
      macAddress: mac,
      ipAddress: ip,
      latitude: position?.latitude.toString() ?? '0.0',
      longitude: position?.longitude.toString() ?? '0.0',
      accountNumber: _selectedBank!.accountNumber!,
      platform: platform,
      pin: pin,
    );

    final result = await _api.requestWithdraw(token, req);
    return result.fold(
      (fail) {
        context.dismissDialog();

        final message = fail.properties.join('\n');
        final displayMessage = message.toLowerCase().contains('insufficient') ||
                message.toLowerCase().contains('incorrect pin')
            ? message
            : 'Failed to request withdrawal';
        context.showErrorSnackBar(
            message.isNotEmpty ? message : 'Transaction failed');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) => FailedResultScreen(
              serviceContent: 'Withdrawal',
              errorMessage: displayMessage,
              onRetry: () {
                context.pushReplacement(RouteConstants.dashboard);
              },
            ),
          ),
        );
        return false;
      },
      (_) {
        context
          ..dismissDialog()
          ..showSuccessSnackBar('Withdrawal request submitted successfully');
        _setSubmitting(false);
        return true;
      },
    );
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setSubmitting(bool value) {
    _isSubmitting = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}
