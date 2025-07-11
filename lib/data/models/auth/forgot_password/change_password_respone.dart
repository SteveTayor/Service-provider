// To parse this JSON data, do
//
//     final ChangePasswordResponse = ChangePasswordResponseFromJson(jsonString);

import 'dart:convert';

ChangePasswordResponse changePasswordResponseFromJson(String str) =>
    ChangePasswordResponse.fromJson(json.decode(str) as Map<String, dynamic>);

String changePasswordResponseToJson(ChangePasswordResponse data) =>
    json.encode(data.toJson());

class ChangePasswordResponse {
  final String status;
  final String data;
  final String message;

  ChangePasswordResponse({
    required this.status,
    required this.data,
    required this.message,
  });

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      ChangePasswordResponse(
        status: json["status"] as String,
        data: json["data"] as String,
        message: json["message"] as String,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
        "message": message,
      };
}
