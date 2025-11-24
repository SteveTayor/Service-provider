// lib/presentation/features/account_setup/providers/link_bvn_provider.dart
import 'dart:async';
import 'dart:developer';

import 'package:bundlegram/core/error/error_sanitixed_users.dart';
import 'package:bundlegram/core/error/errors.dart';
import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/models/banks/fetch_account_name_request.dart';
import 'package:bundlegram/data/models/banks/get_all_banks_response.dart';
import 'package:bundlegram/data/models/bvn/link_bvn/link_bvn_request.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transaction_success_widget.dart';
import 'package:flutter/foundation.dart';
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
  DateTime? _selectedDob; // store the picked DOB
  DateTime? get selectedDob => _selectedDob;

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
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            datePickerTheme: DatePickerThemeData(
              // Customize the selected date appearance
              dayStyle: Theme.of(context).textTheme.bodySmall,
              weekdayStyle: Theme.of(context).textTheme.bodySmall,
              yearStyle: Theme.of(context).textTheme.bodySmall,
              headerHeadlineStyle: Theme.of(context).textTheme.bodySmall,
              headerHelpStyle: Theme.of(context).textTheme.bodySmall,

              // Customize selected day colors
              dayForegroundColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.white; // Text color when selected
                  }
                  return null; // Use default color for unselected days
                },
              ),
              dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return Theme.of(context)
                        .primaryColor
                        .withOpacity(0.7); // Semi-transparent background
                  }
                  return null; // Use default background for unselected days
                },
              ),

              // Add border to selected day to make it more visible
              dayOverlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return Theme.of(context).primaryColor.withOpacity(0.1);
                  }
                  return null;
                },
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      _selectedDob = picked;
      _dob.text = DateFormat('dd/MM/yyyy').format(picked);
      notifyListeners();
    }
  }

  String _formatDobForBackend() {
    // If user picked a date using the picker, use that directly
    if (_selectedDob != null) {
      return DateFormat('yyyy-MM-dd').format(_selectedDob!);
    }

    // Try multiple manual input formats
    final possibleFormats = ['dd/MM/yyyy', 'yyyy-MM-dd', 'dd-MM-yyyy'];
    DateTime? parsed;
    for (var f in possibleFormats) {
      try {
        parsed = DateFormat(f).parseStrict(_dob.text.trim());
        break;
      } catch (_) {
        // ignore and try next
      }
    }

    // Fallback to ISO parse
    if (parsed == null) {
      try {
        parsed = DateTime.parse(_dob.text.trim());
      } catch (_) {
        parsed = null;
      }
    }

    if (parsed == null) {
      throw FormatException('Invalid date format for DOB: "${_dob.text}"');
    }

    return DateFormat('yyyy-MM-dd').format(parsed);
  }

  /// Fetch account name when account number changes
  Future<void> onAccountNumberChanged(String v) async {
    _acct.text = v;
    if (v.trim().length != 10 && _selectedBankCode == null) return;
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
            final userMsg = userFacingMessageFromFailure(fail);
            debugPrint(userMsg);
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
    unawaited(context.showLoadingDialog(message: 'Submitting Bvn details...'));
    try {
      final token = await _ref.read(secureStorageHelperProvider).getAuthToken();
      final req = LinkBvnRequest(
        bvn: _bvn.text.trim(),
        phoneNumber: _phone.text.trim(),
        // dateOfBirth: DateFormat('yyyy-MM-dd')
        //     .format(DateFormat('dd/MM/yyyy').parse(_dob.text)),
        dateOfBirth: _formatDobForBackend(),
        bankCode: _selectedBankCode.toString(),
        accountNumber: _acct.text.trim(),
        accountName: _acctName,
      );
      final result = await _api.linkBvn(token!, req);
      result.fold(
        (fail) {
          context.dismissDialog();
          final userMsg = userFacingMessageFromFailure(fail);
          context.showErrorSnackBar(userMsg);
          _setLoading(false);
          return false;
        },
        (resp) {
          if (resp.status == 'success') {
            _ref.read(globalProvider.notifier).fetchProfile(context);
            context.dismissDialog();
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
            _setLoading(false);
            return true;
          } else {
            // final userMsg = sanitizeErrorMessage(resp.message);
            // context.showErrorSnackBar(userMsg);
            context.dismissDialog();
            context.showErrorSnackBar(resp.message ?? 'Failed to link BVN');
            _setLoading(false);
            return false;
          }
        },
      );
    } catch (e, stack) {
      final msg = kDebugMode
          ? sanitizeErrorMessage(e)
          : 'An error occurred. Please try again.';

      log('submit() error: $e', stackTrace: stack, name: 'submit');
      // Optionally: Sentry.captureException(e, stackTrace: stack);

      // Friendly UI for users
      context
        ..dismissDialog()
        ..showErrorSnackBar(msg);
    } finally {
      context.dismissDialog();
      _setLoading(false);
    }
  }

  // Validators
  String? validateBVN(String? v) => Validators.notEmpty()(v);
  String? validatePhone(String? v) => Validators.validateNGNPhoneNumber()(v);
  String? validateDate(String? v) => Validators.date()(v);
  String? validateBank(String? v) =>
      v == null || v.isEmpty ? 'Select a bank' : null;
  String? validateAccount(String? v) {
    if (v == null || v.isEmpty) return 'Account number is required';
    if (v.length != 10) return 'Account number must be 10 digits';
    return null;
  }

  void _setLoading(bool v) {
    _loading = v;
    notifyListeners();
  }
}
