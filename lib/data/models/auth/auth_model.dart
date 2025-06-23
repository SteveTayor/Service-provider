import 'package:bundlegram/data/models/auth/registeration/registeration_response.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String email,
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}

@freezed
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required String email,
    required String phone,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    required String password,
    @JsonKey(name: 'password_confirm') required String passwordConfirm,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}

@freezed
class ForgotPasswordRequest with _$ForgotPasswordRequest {
  const factory ForgotPasswordRequest({
    required String email,
  }) = _ForgotPasswordRequest;

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestFromJson(json);
}

@freezed
class VerifyOtpRequest with _$VerifyOtpRequest {
  const factory VerifyOtpRequest({
    required String email,
    required String otp,
  }) = _VerifyOtpRequest;

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestFromJson(json);
}

@freezed
class NewPasswordRequest with _$NewPasswordRequest {
  const factory NewPasswordRequest({
    required String email,
    required String password,
    @JsonKey(name: 'password_confirm') required String passwordConfirm,
    required String otp,
  }) = _NewPasswordRequest;

  factory NewPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$NewPasswordRequestFromJson(json);
}

@freezed
class AddUsernameRequest with _$AddUsernameRequest {
  const factory AddUsernameRequest({
    required String username,
  }) = _AddUsernameRequest;

  factory AddUsernameRequest.fromJson(Map<String, dynamic> json) =>
      _$AddUsernameRequestFromJson(json);
}

@freezed
class CheckUsernameRequest with _$CheckUsernameRequest {
  const factory CheckUsernameRequest({
    required String username,
  }) = _CheckUsernameRequest;

  factory CheckUsernameRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckUsernameRequestFromJson(json);
}
