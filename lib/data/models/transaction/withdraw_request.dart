class WithdrawRequest {
  final String amount;
  final String macAddress;
  final String ipAddress;
  final String latitude;
  final String longitude;
  final String accountNumber;
  final String platform;
  final String pin;
  final String appVersion;

  WithdrawRequest({
    required this.amount,
    required this.macAddress,
    required this.ipAddress,
    required this.latitude,
    required this.longitude,
    required this.accountNumber,
    required this.platform,
    required this.pin,
    required this.appVersion,
  });

  factory WithdrawRequest.fromJson(Map<String, dynamic> json) =>
      WithdrawRequest(
        amount: json["amount"] as String,
        macAddress: json["mac_address"] as String,
        ipAddress: json["ip_address"] as String,
        latitude: json["latitude"] as String,
        longitude: json["longitude"] as String,
        accountNumber: json["account_number"] as String,
        platform: json["platform"] as String,
        pin: json["pin"] as String,
        appVersion: json["app_version"] as String,
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "mac_address": macAddress,
        "ip_address": ipAddress,
        "latitude": latitude,
        "longitude": longitude,
        "account_number": accountNumber,
        "platform": platform,
        "pin": pin,
        "app_version": appVersion,
      };
}
