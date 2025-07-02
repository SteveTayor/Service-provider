class ValidateBillRequest {
  final String number;
  final int? productEntityId;

  ValidateBillRequest({
    required this.number,
    required this.productEntityId,
  });

  factory ValidateBillRequest.fromJson(Map<String, dynamic> json) =>
      ValidateBillRequest(
        number: json["number"] as String,
        productEntityId: json["product_entity_id"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "product_entity_id": productEntityId,
      };
}
