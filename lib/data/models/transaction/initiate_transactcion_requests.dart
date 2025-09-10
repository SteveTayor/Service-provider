class InitiateTransactionRequest {
  final String? amount;
  final String? macAddress;
  final String? ipAddress;
  final String? latitude;
  final String? longitude;
  final String? crAcc;
  final String? platform;
  final int? subProdId;
  final String? serviceId;
  final String? pin;
  final String? name;
  final String? appVersion;

  InitiateTransactionRequest({
    this.amount,
    this.macAddress,
    this.ipAddress,
    this.latitude,
    this.longitude,
    this.crAcc,
    this.platform,
    this.subProdId,
    this.serviceId,
    this.pin,
    this.name,
    this.appVersion,
  });

  factory InitiateTransactionRequest.fromJson(Map<String, dynamic> json) =>
      InitiateTransactionRequest(
        amount: json['amount'] as String,
        macAddress: json['mac_address'] as String,
        ipAddress: json['ip_address'] as String,
        latitude: json['latitude'] as String,
        longitude: json['longitude'] as String,
        crAcc: json['cr_acc'] as String, //empty if epin
        platform: json['platform'] as String,
        subProdId: json['sub_prod_id'] as int,
        serviceId: json['service_id'] as String,
        pin: json['pin'] as String,
        name: json['name'] as String,
        appVersion: json['app_version'] as String,
      );

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'mac_address': macAddress,
        'ip_address': ipAddress,
        'latitude': latitude,
        'longitude': longitude,
        'cr_acc': crAcc,
        'platform': platform,
        'sub_prod_id': subProdId,
        'service_id': serviceId,
        'pin': pin,
        'name': name,
        'app_version': appVersion
      };
}
