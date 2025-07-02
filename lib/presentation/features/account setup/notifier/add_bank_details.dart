// lib/presentation/features/account_setup/providers/add_bank_provider.dart

import 'dart:async';

import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/models/banks/add_bank_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:bundlegram/data/models/banks/get_all_banks_response.dart';
import 'package:bundlegram/data/models/banks/fetch_account_name_request.dart';

import 'package:go_router/go_router.dart';

final addBankProvider = ChangeNotifierProvider<AddBankProvider>((ref) {
  return AddBankProvider(ref, ref.read(apiServiceProvider));
});

class AddBankProvider extends ChangeNotifier {
  final Ref _ref;
  final ApiService _api;

  AddBankProvider(this._ref, this._api);

  final formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool get loading => _loading;

  String _selectedBankName = '';
  String? _selectedBankCode;
  final TextEditingController _acct = TextEditingController();
  String _acctName = '';
  bool _fetchingName = false;

  String get selectedBankName => _selectedBankName;
  TextEditingController get acct => _acct;
  String get acctName => _acctName;
  bool get fetchingName => _fetchingName;

  List<BankDetails> get _banks {
    final banksAsync = _ref.read(globalProvider).banks;
    if (banksAsync is AsyncData<GetAllBanksResponse?>) {
      return banksAsync.value!.data ?? [];
    }
    return [];
  }

  List<String> get bankOptions => _banks.map((d) => d.bankName ?? '').toList();

  void setBank(String? bankName) {
    _selectedBankName = bankName!;
    _selectedBankCode =
        _banks.firstWhere((d) => d.bankName == bankName).bankCode;
    notifyListeners();
  }

  Future<void> onAccountNumberChanged(String v) async {
    _acct.text = v;
    if (_selectedBankCode == null) return;
    _fetchingName = true;
    notifyListeners();
    try {
      final token = await _ref.read(secureStorageHelperProvider).getAuthToken();
      final req = FetchAccountNameRequest(
        bankCode: _selectedBankCode!,
        accountNumber: v.trim(),
      );
      final res = await _api.fetchAccountName(token!, req);
      unawaited(
        res.fold(
          (fail) async {
            final message = fail.properties.isNotEmpty
                ? fail.properties.join('\n')
                : 'Failed to fetch account name';
            _setLoading(false);
          },
          (bankData) {
            _acctName = bankData.data!.accountName!;
            _selectedBankCode = bankData.data!.bankCode;
          },
        ),
      );
    } catch (_) {
      _acctName = '';
    } finally {
      _fetchingName = false;
      notifyListeners();
    }
  }

  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    _setLoading(true);
    try {
      final token = await _ref.read(secureStorageHelperProvider).getAuthToken();
      final req = AddBankRequest(
        bankCode: _selectedBankCode.toString(),
        accountNumber: _acct.text.trim(),
        accountName: _acctName,
      );
      await _api.addBank(token!, req);
      await _ref.read(globalProvider.notifier).fetchProfile(context);
      context.go(RouteConstants.dashboard);
    } catch (e) {
      context.showErrorSnackBar(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  String? validateBank(String? v) =>
      v == null || v.isEmpty ? 'Select a bank' : null;
  String? validateAccount(String? v) => Validators.notEmpty()(v);

  void _setLoading(bool v) {
    _loading = v;
    notifyListeners();
  }
}
