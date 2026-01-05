import 'dart:async';

import 'package:bundlegram/core/error/error_sanitixed_users.dart';
import 'package:bundlegram/core/error/errors.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/models/profile/profile_response.dart';
import 'package:bundlegram/data/models/profile/profile_setup_request.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transaction_success_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:go_router/go_router.dart';

// final basicInfoProvider =
//     ChangeNotifierProvider.family<BasicInfoProvider, UserAction>((ref, action) {
//   return BasicInfoProvider(ref, ref.read(apiServiceProvider), action);
// });

// class BasicInfoProvider extends ChangeNotifier {
//   final Ref _ref;
//   final ApiService _api;
//   final UserAction userAction;

//   BasicInfoProvider(this._ref, this._api, this.userAction) {
//     final profile = (_ref.read(globalProvider).profile).value!.data!;

//     _lastName.text = profile.lastName ?? '';
//     _firstName.text = profile.firstName ?? '';
//     _email.text = profile.email ?? '';
//     _phone.text = profile.phone ?? '';
//     if (profile.gender != null) {
//       _gender = profile.gender.toString();
//     }
//     if (profile.address != null) {
//       _address.text = profile.address.toString();
//     }
//     if (profile.dob != null) {
//       final dt = DateTime.tryParse(profile.dob as String) ?? DateTime.now();
//       _dob.text = DateFormat('dd/MM/yyyy').format(dt);
//     }
//   }

//   final formKey = GlobalKey<FormState>();
//   bool _loading = false;
//   bool get loading => _loading;
//   DateTime _selectedDate = DateTime.now();

//   // Controllers
//   final TextEditingController _firstName = TextEditingController();
//   final TextEditingController _lastName = TextEditingController();
//   final TextEditingController _email = TextEditingController();
//   final TextEditingController _phone = TextEditingController();
//   String _gender = '';
//   final TextEditingController _address = TextEditingController();
//   final TextEditingController _dob = TextEditingController();

//   // Public getters
//   TextEditingController get firstName => _firstName;
//   TextEditingController get lastName => _lastName;
//   TextEditingController get email => _email;
//   TextEditingController get phone => _phone;
//   String get gender => _gender;
//   TextEditingController get address => _address;
//   TextEditingController get dob => _dob;

//   void setGender(String? v) {
//     _gender = v!;
//     notifyListeners();
//   }

//   /// Launches date picker and writes formatted date into _dob
//   Future<void> pickDob(BuildContext context) async {
//     final now = DateTime.now();

//     unawaited(context.showBottomSheet(
//       child: SizedBox(
//         width: double.infinity,
//         height: 350,
//         child: CupertinoTheme(
//           data: const CupertinoThemeData(
//             brightness: Brightness.light, // forces light theme
//             primaryColor: CupertinoColors.black, // forces black text
//           ),
//           child: CupertinoDatePicker(
//             backgroundColor: CupertinoColors.white,
//             mode: CupertinoDatePickerMode.date,
//             initialDateTime: _selectedDate,
//             minimumDate: DateTime(1900),
//             maximumDate: now,
//             onDateTimeChanged: (DateTime newDate) {
//               _selectedDate = newDate;
//               _dob.text = DateFormat('dd/MM/yyyy').format(newDate);
//               notifyListeners();
//             },
//           ),
//         ),
//       ),
//     ));
//   }

//   Future<void> submit(BuildContext context) async {
//     if (!formKey.currentState!.validate()) return;
//     _setLoading(true);
//     unawaited(context.showLoadingDialog(message: 'Adding Basic info...'));

//     try {
//       final parsed = DateFormat('dd/MM/yyyy').parse(_dob.text);
//       final iso = DateFormat('yyyy-MM-dd').format(parsed);
//       final token = await _ref.read(secureStorageHelperProvider).getAuthToken();

//       final req = ProfileSetupRequest(
//         firstName: _firstName.text.trim(),
//         lastName: _lastName.text.trim(),
//         address: _address.text.trim(),
//         dateOfBirth: iso,
//         gender: _gender,
//         email: _email.text.trim(),
//       );

//       final result = await _api.updateProfileInformation(token!, req);

//       result.fold(
//         (fail) {
//           final userMsg = userFacingMessageFromFailure(fail);
//           final displayMsg = sanitizeErrorMessage(userMsg);
//           context.showErrorSnackBar(displayMsg);
//         },
//         (resp) async {
//           if (resp.status == 'success') {
//             _ref.read(globalProvider.notifier).fetchProfile(context);

//             if (userAction.isCreate) {
//               // dismiss dialog before navigation
//               context.dismissDialog();
//               await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => const TransactionSuccessful(
//                     isBasicInfo: true,
//                     title: 'Basic information added!',
//                     subTitle:
//                         'The basic information you provided has been successfully added to your Bundlegram account.',
//                   ),
//                 ),
//               );
//             } else {
//               context
//                 ..dismissDialog()
//                 ..showSuccessSnackBar('Basic information updated')
//                 ..pop(); // safe pop after dialog closed
//             }
//           } else {
//             final userMsg = sanitizeErrorMessage(resp.message);
//             context.showErrorSnackBar(userMsg ?? "Failed to update profile");
//           }
//         },
//       );
//     } catch (e) {
// // Friendly UI for users
//       context.dismissDialog();
//       context.showErrorSnackBar('An error occurred. Please try again.');
//     } finally {
//       _setLoading(false);
//       // dismiss dialog ONCE at the end if still mounted
//       if (Navigator.of(context).canPop()) {
//         context.dismissDialog();
//       }
//     }
//   }

//   // Validators
//   String? validateName(String? v) => Validators.name()(v);
//   String? validatePhone(String? v) =>
//       Validators.validateNigerianPhoneNumber()(v);
//   String? validateNotEmpty(String? v) => Validators.notEmpty()(v);
//   String? validateDate(String? v) => Validators.date()(v);

//   void _setLoading(bool v) {
//     _loading = v;
//     notifyListeners();
//   }
// }
final basicInfoProvider =
    ChangeNotifierProvider.family<BasicInfoProvider, UserAction>((ref, action) {
  return BasicInfoProvider(ref, ref.read(apiServiceProvider), action);
});

class BasicInfoProvider extends ChangeNotifier {
  final Ref _ref;
  final ApiService _api;
  final UserAction userAction;

  BasicInfoProvider(this._ref, this._api, this.userAction);

  // -----------------------------
  // FORM STATE
  // -----------------------------
  final formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool get loading => _loading;

  DateTime _selectedDate = DateTime.now();
  bool _hydrated = false;

  // -----------------------------
  // CONTROLLERS
  // -----------------------------
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _dob = TextEditingController();

  String _gender = '';

  // -----------------------------
  // GETTERS
  // -----------------------------
  TextEditingController get firstName => _firstName;
  TextEditingController get lastName => _lastName;
  TextEditingController get email => _email;
  TextEditingController get phone => _phone;
  TextEditingController get address => _address;
  TextEditingController get dob => _dob;
  String get gender => _gender;

  // -----------------------------
  // SAFE PROFILE HYDRATION
  // -----------------------------
  void hydrateFromProfile(Data profile) {
    if (_hydrated) return;

    _firstName.text = profile.firstName ?? '';
    _lastName.text = profile.lastName ?? '';
    _email.text = profile.email ?? '';
    _address.text = profile.address.toString() ?? '';

    if (profile.phone != null) {
      _phone.text = _normalizePhone(profile.phone!);
    }

    if (profile.gender != null) {
      _gender = profile.gender.toString();
    }

    if (profile.dob != null) {
      final dt = DateTime.tryParse(profile.dob.toString()) ?? DateTime.now();
      _dob.text = DateFormat('dd/MM/yyyy').format(dt);
      _selectedDate = dt;
    }

    _hydrated = true;
    notifyListeners();
  }

  String _normalizePhone(String phone) {
    if (phone.startsWith('+234')) {
      phone = phone.substring(4);
    }
    if (phone.length == 11 && phone.startsWith('0')) {
      phone = phone.substring(1);
    }
    return phone;
  }

  // -----------------------------
  // UI ACTIONS
  // -----------------------------
  void setGender(String? v) {
    if (v == null) return;
    _gender = v;
    notifyListeners();
  }

  Future<void> pickDob(BuildContext context) async {
    final now = DateTime.now();

    unawaited(context.showBottomSheet(
      child: SizedBox(
        height: 350,
        child: CupertinoDatePicker(
          backgroundColor: CupertinoColors.white,
          mode: CupertinoDatePickerMode.date,
          initialDateTime: _selectedDate,
          minimumDate: DateTime(1900),
          maximumDate: now,
          onDateTimeChanged: (newDate) {
            _selectedDate = newDate;
            _dob.text = DateFormat('dd/MM/yyyy').format(newDate);
            notifyListeners();
          },
        ),
      ),
    ));
  }

  // -----------------------------
  // SUBMIT
  // -----------------------------
  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    _setLoading(true);
    unawaited(context.showLoadingDialog(message: 'Adding Basic info...'));

    try {
      final parsed = DateFormat('dd/MM/yyyy').parse(_dob.text);
      final iso = DateFormat('yyyy-MM-dd').format(parsed);
      final token = await _ref.read(secureStorageHelperProvider).getAuthToken();

      final req = ProfileSetupRequest(
        firstName: _firstName.text.trim(),
        lastName: _lastName.text.trim(),
        address: _address.text.trim(),
        dateOfBirth: iso,
        gender: _gender,
        email: _email.text.trim(),
      );

      final result = await _api.updateProfileInformation(token!, req);

      result.fold(
        (fail) {
          context.showErrorSnackBar(
            sanitizeErrorMessage(userFacingMessageFromFailure(fail)),
          );
        },
        (resp) async {
          if (resp.status == 'success') {
            _ref.read(globalProvider.notifier).fetchProfile(context);

            context.dismissDialog();

            if (userAction.isCreate) {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TransactionSuccessful(
                    isBasicInfo: true,
                    title: 'Basic information added!',
                    subTitle:
                        'The basic information you provided has been successfully added.',
                  ),
                ),
              );
            } else {
              context
                ..showSuccessSnackBar('Basic information updated')
                ..pop();
            }
          } else {
            context.showErrorSnackBar(
              sanitizeErrorMessage(resp.message),
            );
          }
        },
      );
    } catch (_) {
      context
        ..dismissDialog()
        ..showErrorSnackBar('An error occurred. Please try again.');
    } finally {
      _setLoading(false);
    }
  }

  // -----------------------------
  // VALIDATORS
  // -----------------------------
  String? validateName(String? v) => Validators.name()(v);
  String? validatePhone(String? v) =>
      Validators.validateNigerianPhoneNumber()(v);
  String? validateNotEmpty(String? v) => Validators.notEmpty()(v);
  String? validateDate(String? v) => Validators.date()(v);

  void _setLoading(bool v) {
    _loading = v;
    notifyListeners();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _phone.dispose();
    _address.dispose();
    _dob.dispose();
    super.dispose();
  }
}
