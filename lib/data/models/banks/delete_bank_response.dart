class DeleteBankResponse {
  final String? status;
  final String? data;
  final String? message;

  DeleteBankResponse({
    this.status,
    this.data,
    this.message,
  });

  factory DeleteBankResponse.fromJson(Map<String, dynamic> json) =>
      DeleteBankResponse(
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
