// ignore_for_file: avoid_dynamic_calls

class GetAllBanksResponse {
  final String? status;
  final List<BankDetails>? data;
  final String? message;

  GetAllBanksResponse({
    this.status,
    this.data,
    this.message,
  });

  factory GetAllBanksResponse.fromJson(Map<String, dynamic> json) =>
      GetAllBanksResponse(
        status: json["status"] as String,
        data: (json['data'] as List<dynamic>)
            .map((e) => BankDetails.fromJson(e as Map<String, dynamic>))
            .toList(),
        message: json["message"] as String,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class BankDetails {
  final String? bankCode;
  final String? bankName;
  final String? status;
  final dynamic createdAt;
  final dynamic updatedAt;

  BankDetails({
    this.bankCode,
    this.bankName,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory BankDetails.fromJson(Map<String, dynamic> json) => BankDetails(
        bankCode: json["bank_code"] as String,
        bankName: json["bank_name"] as String,
        status: json["status"] as String,
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "bank_code": bankCode,
        "bank_name": bankName,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
