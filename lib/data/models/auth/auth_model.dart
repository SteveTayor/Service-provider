import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
class RegisterResponse with _$RegisterResponse {
  const factory RegisterResponse({
    @JsonKey(name: "user") required User user,
    @JsonKey(name: "operations") required List<Operation> operations,
  }) = _RegisterResponse;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
}

@freezed
class Operation with _$Operation {
  const factory Operation({
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "limit") required int limit,
    @JsonKey(name: "usage") required int usage,
    @JsonKey(name: "overage") required int overage,
  }) = _Operation;

  factory Operation.fromJson(Map<String, dynamic> json) =>
      _$OperationFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "username") required String username,
    @JsonKey(name: "email") required String email,
    @JsonKey(name: "fullName") required String fullName,
    @JsonKey(name: "avatar") required String avatar,
    @JsonKey(name: "isPublic") required bool isPublic,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class BaseResponse with _$BaseResponse {
  const factory BaseResponse({
    required bool success,
    required String message,
    dynamic data,
    String? error,
  }) = _BaseResponse;

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);
}

@freezed
class AuthData with _$AuthData {
  const factory AuthData({
    required User user,
    required String token,
  }) = _AuthData;

  factory AuthData.fromJson(Map<String, dynamic> json) =>
      _$AuthDataFromJson(json);
}

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

@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required bool success,
    String? message,
    dynamic data,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}
