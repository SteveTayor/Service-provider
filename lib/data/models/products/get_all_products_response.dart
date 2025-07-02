class GetAllProductsResponse {
  final String? status;
  final List<Product>? data;
  final String? message;

  GetAllProductsResponse({
    this.status,
    this.data,
    this.message,
  });

  factory GetAllProductsResponse.fromJson(Map<String, dynamic> json) =>
      GetAllProductsResponse(
        status: json["status"] as String?,
        data: json["data"] == null
            ? []
            : (json['data'] as List<dynamic>)
                .map((e) => Product.fromJson(e as Map<String, dynamic>))
                .toList(),
        message: json["message"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Product {
  final int? id;
  final String? type;
  final String? productName;
  final String? productDescription;
  final String? productIcon;
  final String? serviceId;
  final String? network;
  final String? instruct1;
  final String? instruct2;
  final String? maxAmount;
  final String? minAmount;
  final String? userPercentage;
  final String? autoProdId;
  final String? autoType;
  final String? status;
  final dynamic createdAt;
  final dynamic updatedAt;
  final String? transDesc;

  Product({
    this.id,
    this.type,
    this.productName,
    this.productDescription,
    this.productIcon,
    this.serviceId,
    this.network,
    this.instruct1,
    this.instruct2,
    this.maxAmount,
    this.minAmount,
    this.userPercentage,
    this.autoProdId,
    this.autoType,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.transDesc,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] as int?,
        type: json["type"] as String?,
        productName: json["product_name"] as String?,
        productDescription: json["product_description"] as String?,
        productIcon: json["product_icon"] as String?,
        serviceId: json["service_id"] as String?,
        network: json["network"] as String?,
        instruct1: json["instruct_1"] as String?,
        instruct2: json["instruct_2"] as String?,
        maxAmount: json["max_amount"] as String?,
        minAmount: json["min_amount"] as String?,
        userPercentage: json["user_percentage"] as String?,
        autoProdId: json["auto_prod_id"] as String?,
        autoType: json["auto_type"] as String?,
        status: json["status"] as String?,
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        transDesc: json["trans_desc"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "product_name": productName,
        "product_description": productDescription,
        "product_icon": productIcon,
        "service_id": serviceId,
        "network": network,
        "instruct_1": instruct1,
        "instruct_2": instruct2,
        "max_amount": maxAmount,
        "min_amount": minAmount,
        "user_percentage": userPercentage,
        "auto_prod_id": autoProdId,
        "auto_type": autoType,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "trans_desc": transDesc,
      };
}
