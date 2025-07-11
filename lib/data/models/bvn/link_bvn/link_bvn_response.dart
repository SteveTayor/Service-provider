class LinkBvnResponse {
  final String? status;
  final bool? data;
  final String? message;

  LinkBvnResponse({
    required this.status,
    required this.data,
    required this.message,
  });

  factory LinkBvnResponse.fromJson(Map<String, dynamic> json) =>
      LinkBvnResponse(
        status: json["status"] as String?,
        data: json["data"] as bool?,
        message: json["message"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
        "message": message,
      };
}
