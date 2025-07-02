class GetVirtualAccountsResponse {
  final String? status;
  final Data? data;
  final String? message;

  GetVirtualAccountsResponse({
    this.status,
    this.data,
    this.message,
  });

  factory GetVirtualAccountsResponse.fromJson(Map<String, dynamic> json) =>
      GetVirtualAccountsResponse(
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
  final Sterling? sterling;
  final Sterling? wema;

  Data({
    this.sterling,
    this.wema,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        sterling: json["Sterling bank"] == null
            ? null
            : Sterling.fromJson(json["Sterling bank"] as Map<String, dynamic>),
        wema: json["Wema bank"] == null
            ? null
            : Sterling.fromJson(json["Wema bank"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "Sterling bank": sterling?.toJson(),
        "Wema bank": wema?.toJson(),
      };

}

class Sterling {
  final String? accountNum;
  final String? accountName;
  final String? bankName;

  Sterling({
    this.accountNum,
    this.accountName,
    this.bankName,
  });

  factory Sterling.fromJson(Map<String, dynamic> json) => Sterling(
        accountNum: json["AccountNum"] as String?,
        accountName: json["AccountName"] as String?,
        bankName: json["BankName"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "AccountNum": accountNum,
        "AccountName": accountName,
        "BankName": bankName,
      };
}
