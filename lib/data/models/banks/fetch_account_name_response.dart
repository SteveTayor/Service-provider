class FetchAccountNameResponse {
  final String? status;
  final Data? data;
  final String? message;

  FetchAccountNameResponse({
    this.status,
    this.data,
    this.message,
  });

  factory FetchAccountNameResponse.fromJson(Map<String, dynamic> json) =>
      FetchAccountNameResponse(
        status: json["status"] as String,
        data: json["data"] == null
            ? null
            : Data.fromJson(json["data"] as Map<String, dynamic>),
        message: json["message"] as String,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  final String? accountNumber;
  final String? accountName;
  final String? bankCode;

  Data({
    this.accountNumber,
    this.accountName,
    this.bankCode,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accountNumber: json["accountNumber"] as String?,
        accountName: json["accountName"] as String?,
        bankCode: json["bankCode"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "accountNumber": accountNumber,
        "accountName": accountName,
        "bankCode": bankCode,
      };
}
