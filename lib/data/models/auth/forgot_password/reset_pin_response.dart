// To parse this JSON data, do
//
//     final ResetPinResponse = ResetPinResponseFromJson(jsonString);

import 'dart:convert';

ResetPinResponse resetPinResponseFromJson(String str) =>
    ResetPinResponse.fromJson(json.decode(str) as Map<String, dynamic>);

String resetPinResponseToJson(ResetPinResponse data) =>
    json.encode(data.toJson());

class ResetPinResponse {
  final String status;
  final String data;
  final String message;

  ResetPinResponse({
    required this.status,
    required this.data,
    required this.message,
  });

  factory ResetPinResponse.fromJson(Map<String, dynamic> json) =>
      ResetPinResponse(
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
