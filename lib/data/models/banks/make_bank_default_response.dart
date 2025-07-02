class MakeBankDefaultResponse {
  final String? status;
  final Data? data;
  final String? message;

  MakeBankDefaultResponse({
    this.status,
    this.data,
    this.message,
  });

  factory MakeBankDefaultResponse.fromJson(Map<String, dynamic> json) =>
      MakeBankDefaultResponse(
        status: json["status"] as String?,
        data: json["data"] == null
            ? null
            : Data.fromJson(json["data"] as Map<String, dynamic>),
        message: json["message"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  final int? id;
  final int? userId;
  final String? bankName;
  final String? accountName;
  final String? accountNumber;
  final bool? primary;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Data({
    this.id,
    this.userId,
    this.bankName,
    this.accountName,
    this.accountNumber,
    this.primary,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] as int?,
        userId: json["user_id"] as int?,
        bankName: json["bank_name"] as String?,
        accountName: json["account_name"] as String?,
        accountNumber: json["account_number"] as String?,
        primary: json["primary"] as bool?,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"] as String),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"] as String),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "bank_name": bankName,
        "account_name": accountName,
        "account_number": accountNumber,
        "primary": primary,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
