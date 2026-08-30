import 'package:bundlegram/core/error/error_sanitixed_users.dart';
import 'package:bundlegram/core/error/errors.dart';
import 'package:bundlegram/core/error/failures.dart';
import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_formatter.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/models/auth/wallet/get_wallet_response.dart';
import 'package:bundlegram/data/models/banks/get_all_users_banks_response.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final withdrawalAccountProvider =
    ChangeNotifierProvider<WithdrawalAccountProvider>(
  (ref) => WithdrawalAccountProvider(
    ref,
    ref.read(apiServiceProvider),
    ref.read(secureStorageHelperProvider),
  ),
);

class WithdrawalAccountProvider extends ChangeNotifier {
  final Ref _ref;
  final ApiService _api;
  final SecureStorageHelper _storage;

  WithdrawalAccountProvider(this._ref, this._api, this._storage);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isDeleting = false;
  bool get isDeleting => _isDeleting;

  String? _userName;
  String? get userName => _userName;

  List<UserBanksDetails?> _userBanks = [];
  List<UserBanksDetails?> get userBanks => _userBanks;

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
      _userName = _userBanks.isNotEmpty ? _userBanks.first?.accountName : null;
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
          _setLoading(false);
          return false;
        },
        (data) {
          _userBanks = data.data ?? [];
          _userName =
              _userBanks.isNotEmpty ? _userBanks.first?.accountName : null;
          notifyListeners();
        },
      );
    }
  }

  Future<bool> deleteBank(BuildContext context, int? bankId) async {
    _setDeleting(true);
    final token = await _storage.getAuthToken();
    if (token == null) {
      context.showErrorSnackBar('Authentication token missing');
      _setDeleting(false);
      return false;
    }

    final result = await _api.deleteBank(token, bankId!);
    return result.fold(
      (fail) {
        final userMsg = userFacingMessageFromFailure(fail);
        context.showErrorSnackBar(userMsg);

        _setDeleting(false);
        return false;
      },
      (resp) {
        if (resp.status == 'success') {
          context
              .showSuccessSnackBar(resp.message ?? 'Bank deleted successfully');
          _userBanks = _userBanks.where((bank) => bank?.id != bankId).toList();
          _userName =
              _userBanks.isNotEmpty ? _userBanks.first?.accountName : null;
          notifyListeners();
          _ref
              .read(globalProvider.notifier)
              .fetchUserBanks(context); // Refresh global state
          _setDeleting(false);
          return true;
        } else {
          final userMsg = sanitizeErrorMessage(resp.message);
          context.showErrorSnackBar(userMsg);
          _setDeleting(false);
          return false;
        }
      },
    );
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setDeleting(bool value) {
    _isDeleting = value;
    notifyListeners();
  }
}

