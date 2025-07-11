// To parse this JSON data, do
//
//     final NewPasswordResponse = NewPasswordResponseFromJson(jsonString);

import 'dart:convert';

NewPasswordResponse newPasswordResponseFromJson(String str) =>
    NewPasswordResponse.fromJson(json.decode(str) as Map<String, dynamic>);

String newPasswordResponseToJson(NewPasswordResponse data) =>
    json.encode(data.toJson());

class NewPasswordResponse {
  final String status;
  final String data;
  final String message;

  NewPasswordResponse({
    required this.status,
    required this.data,
    required this.message,
  });

  factory NewPasswordResponse.fromJson(Map<String, dynamic> json) =>
      NewPasswordResponse(
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
