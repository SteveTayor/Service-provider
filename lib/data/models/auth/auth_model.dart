import 'package:bundlegram/data/models/auth/registeration/registeration_response.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
abstract class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String email,
    required String password,
    @JsonKey(name: 'device_token') String? deviceToken,
    @JsonKey(name: 'fcm_token') String? fcmToken,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}

@freezed
abstract class RegisterRequest with _$RegisterRequest {
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
abstract class ForgotPasswordRequest with _$ForgotPasswordRequest {
  const factory ForgotPasswordRequest({required String email}) =
      _ForgotPasswordRequest;

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestFromJson(json);
}

@freezed
abstract class VerifyOtpRequest with _$VerifyOtpRequest {
  const factory VerifyOtpRequest({required String email, required String otp}) =
      _VerifyOtpRequest;

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestFromJson(json);
}

@freezed
abstract class VerifyEmailRequest with _$VerifyEmailRequest {
  const factory VerifyEmailRequest({required String otp}) = _VerifyEmailRequest;
  factory VerifyEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailRequestFromJson(json);
}

@freezed
abstract class DeleteAccountRequest with _$DeleteAccountRequest {
  const factory DeleteAccountRequest({required String pin}) =
      _DeleteAccountRequest;
  factory DeleteAccountRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteAccountRequestFromJson(json);
}

@freezed
abstract class NewPasswordRequest with _$NewPasswordRequest {
  const factory NewPasswordRequest({
    required String email,
    required String password,
    @JsonKey(name: 'password_confirm') required String passwordConfirm,
  }) = _NewPasswordRequest;

  factory NewPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$NewPasswordRequestFromJson(json);
}

@freezed
abstract class AddUsernameRequest with _$AddUsernameRequest {
  const factory AddUsernameRequest({required String username}) =
      _AddUsernameRequest;

  factory AddUsernameRequest.fromJson(Map<String, dynamic> json) =>
      _$AddUsernameRequestFromJson(json);
}

@freezed
abstract class CheckUsernameRequest with _$CheckUsernameRequest {
  const factory CheckUsernameRequest({required String username}) =
      _CheckUsernameRequest;

  factory CheckUsernameRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckUsernameRequestFromJson(json);
}

@freezed
abstract class ChangePinRequest with _$ChangePinRequest {
  const factory ChangePinRequest({
    @JsonKey(name: "oldPin") required String oldPin,
    @JsonKey(name: "newPin") required String newPin,
  }) = _ChangePinRequest;

  factory ChangePinRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePinRequestFromJson(json);
}

@freezed
abstract class ResetPinRequest with _$ResetPinRequest {
  const factory ResetPinRequest({
    @JsonKey(name: "password") required String password,
  }) = _ResetPinRequest;

  factory ResetPinRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPinRequestFromJson(json);
}

@freezed
abstract class CreatePinRequest with _$CreatePinRequest {
  const factory CreatePinRequest({
    @JsonKey(name: "pin") required String pin,
    @JsonKey(name: "pin_confirmation") required String pinConfirmation,
  }) = _CreatePinRequest;

  factory CreatePinRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePinRequestFromJson(json);
}

@freezed
abstract class VerifyPinRequest with _$VerifyPinRequest {
  const factory VerifyPinRequest({@JsonKey(name: "pin") required String pin}) =
      _VerifyPinRequest;

  factory VerifyPinRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyPinRequestFromJson(json);
}

@freezed
abstract class ChangePasswordRequest with _$ChangePasswordRequest {
  const factory ChangePasswordRequest({
    @JsonKey(name: "oldPassword") required String oldPassword,
    @JsonKey(name: "newPassword") required String newPassword,
  }) = _ChangePasswordRequest;

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);
}
