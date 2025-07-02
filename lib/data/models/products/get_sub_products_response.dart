import 'package:bundlegram/data/models/products/get_all_products_response.dart';

class GetAllSubProductsResponse {
  final String? status;
  final List<SubProduct>? data;
  final String? message;

  GetAllSubProductsResponse({
    this.status,
    this.data,
    this.message,
  });

  factory GetAllSubProductsResponse.fromJson(Map<String, dynamic> json) =>
      GetAllSubProductsResponse(
        status: json["status"] as String?,
        data: json["data"] == null
            ? []
            : (json['data'] as List<dynamic>)
                .map((e) => SubProduct.fromJson(e as Map<String, dynamic>))
                .toList(),
        message: json["message"] as String,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class SubProduct {
  final int? id;
  final int? productEntityId;
  final String? subName;
  final String? subPrice;
  final String? userPercent;
  final String? optionalParam;
  final dynamic dataId;
  final String? dataType;
  final double? dataSize;
  final dynamic planId;
  final String? autoSubProdId;
  final dynamic addonCode;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Product? product;

  SubProduct({
    this.id,
    this.productEntityId,
    this.subName,
    this.subPrice,
    this.userPercent,
    this.optionalParam,
    this.dataId,
    this.dataType,
    this.dataSize,
    this.planId,
    this.autoSubProdId,
    this.addonCode,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory SubProduct.fromJson(Map<String, dynamic> json) => SubProduct(
        id: json["id"] != null ? json["id"] as int : null,
        productEntityId: json["product_entity_id"] != null
            ? json["product_entity_id"] as int
            : null,
        subName: json["sub_name"] != null ? json["sub_name"] as String : null,
        subPrice:
            json["sub_price"] != null ? json["sub_price"] as String : null,
        userPercent: json["user_percent"] != null
            ? json["user_percent"] as String
            : null,
        optionalParam: json["optional_param"] != null
            ? json["optional_param"] as String
            : null,
        dataId: json["data_id"],
        dataType: json["data_type"] as String?,
        dataSize: json["data_size"]?.toDouble() as double?,
        planId: json["plan_id"],
        autoSubProdId: json["auto_sub_prod_id"] as String?,
        addonCode: json["addon_code"],
        status: json["status"] as String?,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"] as String),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"] as String),
        product: json["product"] == null
            ? null
            : Product.fromJson(json["product"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_entity_id": productEntityId,
        "sub_name": subName,
        "sub_price": subPrice,
        "user_percent": userPercent,
        "optional_param": optionalParam,
        "data_id": dataId,
        "data_type": dataType,
        "data_size": dataSize,
        "plan_id": planId,
        "auto_sub_prod_id": autoSubProdId,
        "addon_code": addonCode,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product": product?.toJson(),
      };
}
