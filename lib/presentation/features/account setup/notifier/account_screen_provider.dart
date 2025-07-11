// ```dart
// // lib/presentation/features/account_setup/providers/basic_info_provider.dart
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:bundlegram/core/providers/global_provider.dart';
// import 'package:bundlegram/data/models/profile/user_profile.dart';

// /// State holds editable fields for basic info
// class BasicInfoState {
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phone;
//   final String gender;
//   final String address;
//   final DateTime? dob;
//   final bool submitting;

//   BasicInfoState({
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.phone,
//     required this.gender,
//     required this.address,
//     required this.dob,
//     this.submitting = false,
//   });

//   BasicInfoState copyWith({
//     String? firstName,
//     String? lastName,
//     String? email,
//     String? phone,
//     String? gender,
//     String? address,
//     DateTime? dob,
//     bool? submitting,
//   }) => BasicInfoState(
//         firstName: firstName ?? this.firstName,
//         lastName: lastName ?? this.lastName,
//         email: email ?? this.email,
//         phone: phone ?? this.phone,
//         gender: gender ?? this.gender,
//         address: address ?? this.address,
//         dob: dob ?? this.dob,
//         submitting: submitting ?? this.submitting,
//       );
// }

// class BasicInfoNotifier extends StateNotifier<BasicInfoState> {
//   final Ref _ref;
//   BasicInfoNotifier(this._ref)
//       : super(_initialState(_ref.read(globalProvider).profile.value?.data));

//   static BasicInfoState _initialState(UserProfile? p) {
//     return BasicInfoState(
//       firstName: p?.name?.first ?? '',
//       lastName: p?.name?.last ?? '',
//       email: p?.email ?? '',
//       phone: p?.phone ?? '',
//       gender: p?.gender ?? '',
//       address: p?.address ?? '',
//       dob: p?.dob,
//     );
//   }

//   void updateFirstName(String v) => state = state.copyWith(firstName: v);
//   void updateLastName(String v)  => state = state.copyWith(lastName: v);
//   void updateEmail(String v)     => state = state.copyWith(email: v);
//   void updatePhone(String v)     => state = state.copyWith(phone: v);
//   void updateGender(String v)    => state = state.copyWith(gender: v);
//   void updateAddress(String v)   => state = state.copyWith(address: v);
//   void updateDob(DateTime v)     => state = state.copyWith(dob: v);

//   Future<void> submit() async {
//     state = state.copyWith(submitting: true);
//     // call API to update basic info
//     final token = await _ref.read(secureStorageHelperProvider).getAuthToken();
//     if (token == null) throw Exception('No auth token');
//     await _ref.read(apiServiceProvider)
//       .updateBasicInfo(token, {
//         'first_name': state.firstName,
//         'last_name': state.lastName,
//         'email': state.email,
//         'phone': state.phone,
//         'gender': state.gender,
//         'address': state.address,
//         'dob': state.dob?.toIso8601String(),
//       });
//     // on success, refresh global profile
//     await _ref.read(globalProvider.notifier).fetchProfile(context);
//     state = state.copyWith(submitting: false);
//   }
// }

// final basicInfoProvider = StateNotifierProvider<BasicInfoNotifier, BasicInfoState>(
//   (ref) => BasicInfoNotifier(ref),
// );

// ```

// ```dart
// // lib/presentation/features/account_setup/providers/link_bvn_provider.dart
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:bundlegram/core/providers/global_provider.dart';
// import 'package:bundlegram/data/models/banks/get_virtual_account_response.dart';

// class LinkBvnState {
//   final String bvn;
//   final String phone;
//   final String dob;
//   final String bank;
//   final String accountNumber;
//   final String accountName;
//   final bool fetchingName;
//   final bool submitting;

//   LinkBvnState({
//     this.bvn = '',
//     this.phone = '',
//     this.dob = '',
//     this.bank = '',
//     this.accountNumber = '',
//     this.accountName = '',
//     this.fetchingName = false,
//     this.submitting = false,
//   });

//   LinkBvnState copyWith({
//     String? bvn,
//     String? phone,
//     String? dob,
//     String? bank,
//     String? accountNumber,
//     String? accountName,
//     bool? fetchingName,
//     bool? submitting,
//   }) => LinkBvnState(
//         bvn: bvn ?? this.bvn,
//         phone: phone ?? this.phone,
//         dob: dob ?? this.dob,
//         bank: bank ?? this.bank,
//         accountNumber: accountNumber ?? this.accountNumber,
//         accountName: accountName ?? this.accountName,
//         fetchingName: fetchingName ?? this.fetchingName,
//         submitting: submitting ?? this.submitting,
//       );
// }

// class LinkBvnNotifier extends StateNotifier<LinkBvnState> {
//   final Ref _ref;
//   LinkBvnNotifier(this._ref) : super(LinkBvnState());

//   void updateBVN(String v)    => state = state.copyWith(bvn: v);
//   void updatePhone(String v)  => state = state.copyWith(phone: v);
//   void updateDob(String v)    => state = state.copyWith(dob: v);
//   void updateBank(String v)   => state = state.copyWith(bank: v);

//   Future<void> updateAccountNumber(String v) async {
//     state = state.copyWith(accountNumber: v, fetchingName: true);
//     try {
//       final token = await _ref.read(secureStorageHelperProvider).getAuthToken();
//       final nameRes = await _ref.read(apiServiceProvider)
//         .fetchAccountName(token!, state.bank, v);
//       state = state.copyWith(accountName: nameRes.name, fetchingName: false);
//     } catch (_) {
//       state = state.copyWith(fetchingName: false);
//     }
//   }

//   Future<void> submit() async {
//     state = state.copyWith(submitting: true);
//     final token = await _ref.read(secureStorageHelperProvider).getAuthToken();
//     await _ref.read(apiServiceProvider)
//       .linkBVN(token!, {
//         'bvn': state.bvn,
//         'phone': state.phone,
//         'dob': state.dob,
//         'bank': state.bank,
//         'account_number': state.accountNumber,
//       });
//     await _ref.read(globalProvider.notifier).fetchProfile(context);
//     state = state.copyWith(submitting: false);
//   }
// }

// final linkBvnProvider = StateNotifierProvider<LinkBvnNotifier, LinkBvnState>(
//   (ref) => LinkBvnNotifier(ref),
// );

// ```

// ```dart
// // lib/presentation/features/account_setup/providers/add_bank_provider.dart
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:bundlegram/core/providers/global_provider.dart';

// class AddBankState {
//   final String bank;
//   final String accountNumber;
//   final String accountName;
//   final bool fetchingName;
//   final bool submitting;

//   AddBankState({
//     this.bank = '',
//     this.accountNumber = '',
//     this.accountName = '',
//     this.fetchingName = false,
//     this.submitting = false,
//   });

//   AddBankState copyWith({
//     String? bank,
//     String? accountNumber,
//     String? accountName,
//     bool? fetchingName,
//     bool? submitting,
//   }) => AddBankState(
//         bank: bank ?? this.bank,
//         accountNumber: accountNumber ?? this.accountNumber,
//         accountName: accountName ?? this.accountName,
//         fetchingName: fetchingName ?? this.fetchingName,
//         submitting: submitting ?? this.submitting,
//       );
// }

// class AddBankNotifier extends StateNotifier<AddBankState> {
//   final Ref _ref;
//   AddBankNotifier(this._ref) : super(AddBankState());

//   void updateBank(String v) => state = state.copyWith(bank: v);

//   Future<void> updateAccountNumber(String v) async {
//     state = state.copyWith(accountNumber: v, fetchingName: true);
//     try {
//       final token = await _ref.read(secureStorageHelperProvider).getAuthToken();
//       final nameRes = await _ref.read(apiServiceProvider)
//         .fetchAccountName(token!, state.bank, v);
//       state = state.copyWith(accountName: nameRes.name, fetchingName: false);
//     } catch (_) {
//       state = state.copyWith(fetchingName: false);
//     }
//   }

//   Future<void> submit() async {
//     state = state.copyWith(submitting: true);
//     final token = await _ref.read(secureStorageHelperProvider).getAuthToken();
//     await _ref.read(apiServiceProvider)
//       .addBankDetails(token!, {
//         'bank': state.bank,
//         'account_number': state.accountNumber,
//       });
//     await _ref.read(globalProvider.notifier).fetchProfile(context);
//     state = state.copyWith(submitting: false);
//   }
// }

// final addBankProvider = StateNotifierProvider<AddBankNotifier, AddBankState>(
//   (ref) => AddBankNotifier(ref),
// );

// ```
