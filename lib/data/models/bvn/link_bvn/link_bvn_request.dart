class LinkBvnRequest {
  final String bvn;
  final String phoneNumber;
  final String dateOfBirth;
  final String bankCode;
  final String accountNumber;
  final String accountName;

  LinkBvnRequest({
    required this.bvn,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.bankCode,
    required this.accountNumber,
    required this.accountName,
  });

  factory LinkBvnRequest.fromJson(Map<String, dynamic> json) => LinkBvnRequest(
        bvn: json["bvn"] as String,
        phoneNumber: json["phone_number"] as String,
        dateOfBirth: json["date_of_birth"] as String,
        bankCode: json["bank_code"] as String,
        accountNumber: json["account_number"] as String,
        accountName: json["account_name"] as String,
      );

  Map<String, dynamic> toJson() => {
        "bvn": bvn,
        "phone_number": phoneNumber,
        "date_of_birth": dateOfBirth,
        "bank_code": bankCode,
        "account_number": accountNumber,
        "account_name": accountName,
      };
}
