class ValidateBillRequest {
  final String number;
  final int? productEntityId;
  final String? serviceType;

  ValidateBillRequest({
    required this.number,
    required this.productEntityId,
    required this.serviceType,
  });

  factory ValidateBillRequest.fromJson(Map<String, dynamic> json) =>
      ValidateBillRequest(
        number: json["number"] as String,
        productEntityId: json["product_entity_id"] as int?,
        serviceType: json["type"] as String,
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "product_entity_id": productEntityId,
        "type": serviceType,
      };
}
