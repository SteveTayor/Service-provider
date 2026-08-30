// To parse this JSON data, do
//
//     final UsernameResponse = UsernameResponseFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'username_response.freezed.dart';
part 'username_response.g.dart';

UsernameResponse UsernameResponseFromJson(String str) =>
    UsernameResponse.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
abstract class UsernameResponse with _$UsernameResponse {
  const factory UsernameResponse({
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "data") String? data,
    @JsonKey(name: "message") String? message,
  }) = _UsernameResponse;

  factory UsernameResponse.fromJson(Map<String, dynamic> json) =>
      _$UsernameResponseFromJson(json);
}
