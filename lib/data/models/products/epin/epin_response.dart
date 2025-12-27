
import 'dart:convert';

class EpinResponse {
  final String? status;
  final String? message;
  final int? requestId;

  EpinResponse({
    this.status,
    this.message,
    this.requestId,
  });

  factory EpinResponse.fromJson(Map<String, dynamic> json) =>
      EpinResponse(
        status: json["status"] as String?,
        message: json["message"] as String?,
        requestId: json["request_id"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "request_id": requestId,
      };
}
