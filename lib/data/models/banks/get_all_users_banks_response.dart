class GetAllUserBanksResponse {
  final String? status;
  final List<UserBanksDetails>? data;
  final String? message;

  GetAllUserBanksResponse({
    this.status,
    this.data,
    this.message,
  });

  factory GetAllUserBanksResponse.fromJson(Map<String, dynamic> json) =>
      GetAllUserBanksResponse(
        status: json["status"] as String?,
        data: json["data"] == null
            ? []
            : List<UserBanksDetails>.from((json["data"] as List).map(
                (x) => UserBanksDetails.fromJson(x as Map<String, dynamic>))),
        message: json["message"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class UserBanksDetails {
  final int? id;
  final int? userId;
  final String? bankName;
  final String? accountName;
  final String? accountNumber;
  final int? primary;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserBanksDetails({
    this.id,
    this.userId,
    this.bankName,
    this.accountName,
    this.accountNumber,
    this.primary,
    this.createdAt,
    this.updatedAt,
  });

  factory UserBanksDetails.fromJson(Map<String, dynamic> json) =>
      UserBanksDetails(
        id: json["id"] as int?,
        userId: json["user_id"] as int?,
        bankName: json["bank_name"] as String?,
        accountName: json["account_name"] as String?,
        accountNumber: json["account_number"] as String?,
        primary: json["primary"] as int?,
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
