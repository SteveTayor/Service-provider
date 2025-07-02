class ValidateBillResponse {
  final String? status;
  final String? data;
  final String? message;

  ValidateBillResponse({
    this.status,
    this.data,
    this.message,
  });

  factory ValidateBillResponse.fromJson(Map<String, dynamic> json) =>
      ValidateBillResponse(
        status: json["status"] as String?,
        data: json["data"] as String?,
        message: json["message"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
        "message": message,
      };
}
