// lib/presentation/features/account_setup/providers/link_bvn_provider.dart
import 'dart:async';

import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/models/banks/fetch_account_name_request.dart';
import 'package:bundlegram/data/models/banks/get_all_banks_response.dart';
import 'package:bundlegram/data/models/bvn/link_bvn/link_bvn_request.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transaction_success_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:go_router/go_router.dart';

final linkBvnProvider = ChangeNotifierProvider<LinkBvnProvider>((ref) {
  return LinkBvnProvider(ref, ref.read(apiServiceProvider));
});

class LinkBvnProvider extends ChangeNotifier {
  final Ref _ref;
  final ApiService _api;

  LinkBvnProvider(this._ref, this._api);

  final formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool get loading => _loading;

  final TextEditingController _bvn = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  String _selectedBankName = '';
  String? _selectedBankCode;
  final TextEditingController _acct = TextEditingController();
  String _acctName = '';
  bool _fetchingName = false;

  // Expose controllers & fields
  TextEditingController get bvn => _bvn;
  TextEditingController get phone => _phone;
  TextEditingController get dob => _dob;
  String get selectedBankName => _selectedBankName;
  TextEditingController get acct => _acct;
  String get acctName => _acctName;
  bool get fetchingName => _fetchingName;

  /// Bank list from globalProvider
  List<BankDetails> get _banks {
    final banksAsync = _ref.read(globalProvider).banks;
    if (banksAsync is AsyncData<GetAllBanksResponse?>) {
      return banksAsync.value!.data ?? [];
    }
    return [];
  }

  /// Dropdown options
  List<String> get bankOptions => _banks.map((d) => d.bankName ?? '').toList();

  /// When user selects a bank from dropdown
  void setBank(String? bankName) {
    _selectedBankName = bankName!;
    _selectedBankCode =
        _banks.firstWhere((d) => d.bankName == bankName).bankCode;
    notifyListeners();
  }

  /// Launch date picker for BVN DOB
  Future<void> pickDob(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      _dob.text = DateFormat('dd/MM/yyyy').format(picked);
      notifyListeners();
    }
  }

  /// Fetch account name when account number changes
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
            fail.properties.isNotEmpty
                ? fail.properties.join('\n')
                : 'Failed to fetch account name';
            _setLoading(false);
          },
          (bankData) {
            _acctName = bankData.data!.accountName!;
            _selectedBankCode = bankData.data!.bankCode;
            return null;
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

  /// Submit linked BVN + bank details
  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    _setLoading(true);
    try {
      final token = await _ref.read(secureStorageHelperProvider).getAuthToken();
      final req = LinkBvnRequest(
        bvn: _bvn.text.trim(),
        phoneNumber: _phone.text.trim(),
        dateOfBirth: DateFormat('yyyy-MM-dd')
            .format(DateFormat('dd/MM/yyyy').parse(_dob.text)),
        bankCode: _selectedBankCode.toString(),
        accountNumber: _acct.text.trim(),
        accountName: _acctName,
      );
      await _api.linkBvn(token!, req);
      await _ref.read(globalProvider.notifier).fetchProfile(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const TransactionSuccessful(
            title: 'BVN Linked!',
            subTitle:
                'Your BVN has been successfully linked to your account. We will notify you once verified.',
          ),
        ),
      );
    } catch (e) {
      context.showErrorSnackBar(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Validators
  String? validateBVN(String? v) => Validators.notEmpty()(v);
  String? validatePhone(String? v) =>
      Validators.validateNigerianPhoneNumber()(v);
  String? validateDate(String? v) => Validators.date()(v);
  String? validateBank(String? v) =>
      v == null || v.isEmpty ? 'Select a bank' : null;
  String? validateAccount(String? v) => Validators.notEmpty()(v);

  void _setLoading(bool v) {
    _loading = v;
    notifyListeners();
  }
}
