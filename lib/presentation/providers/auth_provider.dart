// import 'dart:convert';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:bundlegram/data/models/auth/auth_model.dart';
// import 'package:bundlegram/data/repositories/auth_repository.dart';

// // part 'auth_provider.g.dart';

// // Auth state to track user authentication status and data
// class AuthState {

//   const AuthState({
//     this.isAuthenticated = false,
//     this.isLoading = false,
//     this.error,
//     this.user,
//   });
//   final bool isAuthenticated;
//   final bool isLoading;
//   final String? error;
//   final Map<String, dynamic>? user;

//   AuthState copyWith({
//     bool? isAuthenticated,
//     bool? isLoading,
//     String? error,
//     Map<String, dynamic>? user,
//   }) {
//     return AuthState(
//       isAuthenticated: isAuthenticated ?? this.isAuthenticated,
//       isLoading: isLoading ?? this.isLoading,
//       error: error ?? this.error,
//       user: user ?? this.user,
//     );
//   }
// }

// class AuthNotifier extends StateNotifier<AuthState> {
//   AuthNotifier(this.ref) : super(const AuthState());
// final Ref ref;
//   Future<void> register({
//     required String email,
//     required String phone,
//     required String firstName,
//     required String lastName,
//     required String password,
//     required String passwordConfirm,
//   }) async {
//     state = state.copyWith(isLoading: true);

//     try {
//       final repository = ref.read(authRepositoryProvider);
      
//       final request = RegisterRequest(
//         email: email,
//         phone: phone,
//         firstName: firstName,
//         lastName: lastName,
//         password: password,
//         passwordConfirm: passwordConfirm,
//       );

//       final response = await repository.register(request);
//       if (response.success && response.data != null) {
//         state = state.copyWith(
//           isAuthenticated: true,
//           isLoading: false,
//           user: response.toJson(),
//         );
//       } else {
//         throw Exception(response.message ?? 'Registration failed');
//       }
//     } catch (e) {
//       state = state.copyWith(
//         isLoading: false,
//         error: e.toString(),
//       );
//       rethrow;
//     }
//   }

//   Future<void> login({
//     required String email,
//     required String password,
//   }) async {
//     state = state.copyWith(isLoading: true);

//     try {
//       final repository = ref.read(authRepositoryProvider);
      
//       final request = LoginRequest(
//         email: email,
//         password: password,
//       );

//       final response = await repository.login(request);
//       if (response.success && response.data != null) {
//        final h=  jsonDecode(response.data.toString());
//         state = state.copyWith(
//           isAuthenticated: true,
//           isLoading: false,
//           user: {
//             'hh':h,
//           },
//         );
//       } else {
//         throw Exception(response.message ?? 'Login failed');
//       }
//     } catch (e) {
//       state = state.copyWith(
//         isLoading: false,
//         error: e.toString(),
//       );
//       rethrow;
//     }
//   }

//   Future<void> forgotPassword({
//     required String email,
//   }) async {
//     state = state.copyWith(isLoading: true);

//     try {
//       final repository = ref.read(authRepositoryProvider);
      
//       final request = ForgotPasswordRequest(email: email);

//       final response = await repository.forgotPassword(request);
//       if (!response.success) {
//         throw Exception(response.message ?? 'Failed to send reset password email');
//       }
//     } catch (e) {
//       state = state.copyWith(
//         isLoading: false,
//         error: e.toString(),
//       );
//       rethrow;
//     }
//   }

//   Future<void> verifyOtp({
//     required String email,
//     required String otp,
//   }) async {
//     state = state.copyWith(isLoading: true);

//     try {
//       final repository = ref.read(authRepositoryProvider);
      
//       final request = VerifyOtpRequest(
//         email: email,
//         otp: otp,
//       );

//       final response = await repository.verifyOtp(request);
//       if (!response.success) {
//         throw Exception(response.message ?? 'Failed to verify OTP');
//       }
//     } catch (e) {
//       state = state.copyWith(
//         isLoading: false,
//         error: e.toString(),
//       );
//       rethrow;
//     }
//   }

//   Future<void> setNewPassword({
//     required String email,
//     required String password,
//     required String passwordConfirm,
//   }) async {
//     state = state.copyWith(isLoading: true);

//     try {
//       final repository = ref.read(authRepositoryProvider);
      
//       final request = NewPasswordRequest(
//         email: email,
//         password: password,
//         passwordConfirm: passwordConfirm,
//       );

//       final response = await repository.setNewPassword(request);
//       if (!response.success) {
//         throw Exception(response.message ?? 'Failed to set new password');
//       }
//     } catch (e) {
//       state = state.copyWith(
//         isLoading: false,
//         error: e.toString(),
//       );
//       rethrow;
//     }
//   }

//   void logout() {
//     state = const AuthState();
//   }
// }

// final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
//   return AuthNotifier(ref);
// }); 