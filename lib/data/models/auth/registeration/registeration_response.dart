// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'registeration_response.freezed.dart';
part 'registeration_response.g.dart';

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str) as Map<String, dynamic>);

String registerResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

@freezed
class RegisterResponse with _$RegisterResponse {
  const factory RegisterResponse({
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "data") RegistrationData? data,
    @JsonKey(name: "message") String? message,
  }) = _RegisterResponse;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
}

@freezed
class RegistrationData with _$RegistrationData {
  const factory RegistrationData({
    @JsonKey(name: "token") String? token,
    @JsonKey(name: "user") User? user,
  }) = _RegistrationData;

  factory RegistrationData.fromJson(Map<String, dynamic> json) =>
      _$RegistrationDataFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: "first_name") String? firstName,
    @JsonKey(name: "last_name") String? lastName,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "phone") String? phone,
    @JsonKey(name: "email") String? email,
    @JsonKey(name: "updated_at") DateTime? updatedAt,
    @JsonKey(name: "created_at") DateTime? createdAt,
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "current_session_id") String? currentSessionId,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
