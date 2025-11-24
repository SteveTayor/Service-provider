import 'dart:convert';

// MarkNotificationAsReadResponse markNotificationAsReadResponseFromJson(String str) => MarkNotificationAsReadResponse.fromJson(json.decode(str));

// String markNotificationAsReadResponseToJson(MarkNotificationAsReadResponse data) => json.encode(data.toJson());

class MarkNotificationAsReadResponse {
  final String? status;
  final String? message;

  MarkNotificationAsReadResponse({this.status, this.message, a});

  factory MarkNotificationAsReadResponse.fromJson(Map<String, dynamic> json) =>
      MarkNotificationAsReadResponse(
        status: json["status"] as String,
        message: json["message"] as String,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
