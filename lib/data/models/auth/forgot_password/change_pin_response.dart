// To parse this JSON data, do
//
//     final ChangePinResponse = ChangePinResponseFromJson(jsonString);

import 'dart:convert';

ChangePinResponse changePinResponseFromJson(String str) =>
    ChangePinResponse.fromJson(json.decode(str) as Map<String, dynamic>);

String changePinResponseToJson(ChangePinResponse data) =>
    json.encode(data.toJson());

class ChangePinResponse {
  final String status;
  final String data;
  final String message;

  ChangePinResponse({
    required this.status,
    required this.data,
    required this.message,
  });

  factory ChangePinResponse.fromJson(Map<String, dynamic> json) =>
      ChangePinResponse(
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
