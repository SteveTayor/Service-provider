// To parse this JSON data, do
//
//     final registerRequest = registerRequestFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'registeration_request.freezed.dart';
part 'registeration_request.g.dart';

RegisterRequest registerRequestFromJson(String str) =>
    RegisterRequest.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
abstract class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    @JsonKey(name: "email") String? email,
    @JsonKey(name: "phone") String? phone,
    @JsonKey(name: "first_name") String? firstName,
    @JsonKey(name: "last_name") String? lastName,
    @JsonKey(name: "password") String? password,
    @JsonKey(name: "password_confirm") String? passwordConfirm,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}
