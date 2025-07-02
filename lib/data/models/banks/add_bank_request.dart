class AddBankRequest {
  final String bankCode;
  final String accountNumber;
  final String accountName;

  AddBankRequest({
    required this.bankCode,
    required this.accountNumber,
    required this.accountName,
  });

  factory AddBankRequest.fromJson(Map<String, dynamic> json) => AddBankRequest(
        bankCode: json["bank_code"] as String,
        accountNumber: json["account_number"] as String,
        accountName: json["account_name"] as String,
      );

  Map<String, dynamic> toJson() => {
        "bank_code": bankCode,
        "account_number": accountNumber,
        "account_name": accountName,
      };
}
