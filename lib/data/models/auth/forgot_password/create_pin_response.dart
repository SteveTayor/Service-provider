// To parse this JSON data, do
//
//     final CreatePinResponse = CreatePinResponseFromJson(jsonString);

import 'dart:convert';

CreatePinResponse createPinResponseFromJson(String str) =>
    CreatePinResponse.fromJson(json.decode(str) as Map<String, dynamic>);

String createPinResponseToJson(CreatePinResponse data) =>
    json.encode(data.toJson());

class CreatePinResponse {
  final String status;
  final String data;
  final String message;

  CreatePinResponse({
    required this.status,
    required this.data,
    required this.message,
  });

  factory CreatePinResponse.fromJson(Map<String, dynamic> json) =>
      CreatePinResponse(
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
