class FetchAccountNameRequest {
  final String accountNumber;
  final String bankCode;

  FetchAccountNameRequest({
    required this.accountNumber,
    required this.bankCode,
  });

  factory FetchAccountNameRequest.fromJson(Map<String, dynamic> json) =>
      FetchAccountNameRequest(
        accountNumber: json["account_number"] as String,
        bankCode: json["bank_code"] as String,
      );

  Map<String, dynamic> toJson() => {
        "account_number": accountNumber,
        "bank_code": bankCode,
      };
}
