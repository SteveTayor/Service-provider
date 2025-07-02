import 'package:bundlegram/data/models/products/get_sub_products_response.dart';

class GetAllUserTransactionResponse {
  final String? status;
  final List<UserTransactions>? data;
  final String? message;

  GetAllUserTransactionResponse({
    this.status,
    this.data,
    this.message,
  });

  factory GetAllUserTransactionResponse.fromJson(Map<String, dynamic> json) =>
      GetAllUserTransactionResponse(
        status: json["status"] as String,
        data: json["data"] == null
            ? []
            : (json['data'] as List<dynamic>)
                .map(
                    (e) => UserTransactions.fromJson(e as Map<String, dynamic>))
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

class UserTransactions {
  final int? id;
  final int? userId;
  final String? subProdId;
  final String? transType;
  final String? amount;
  final String? crAcc;
  final String? trxFrom;
  final double? deductAmount;
  final String? transRef;
  final String? autoRef;
  final String? token;
  final double? unit;
  final String? cardPin;
  final String? cardSerialNo;
  final String? status;
  final int? isActive;
  final String? balanceBefore;
  final String? balanceAfter;
  final String? paymentType;
  final String? channel;
  final String? platform;
  final String? macAddress;
  final String? ipAddress;
  final String? longitude;
  final String? latitude;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final SubProduct? subProduct;
  final dynamic bank;

  UserTransactions({
    this.id,
    this.userId,
    this.subProdId,
    this.transType,
    this.amount,
    this.crAcc,
    this.trxFrom,
    this.deductAmount,
    this.transRef,
    this.autoRef,
    this.token,
    this.unit,
    this.cardPin,
    this.cardSerialNo,
    this.status,
    this.isActive,
    this.balanceBefore,
    this.balanceAfter,
    this.paymentType,
    this.channel,
    this.platform,
    this.macAddress,
    this.ipAddress,
    this.longitude,
    this.latitude,
    this.createdAt,
    this.updatedAt,
    this.subProduct,
    this.bank,
  });

  factory UserTransactions.fromJson(Map<String, dynamic> json) =>
      UserTransactions(
        id: json["id"] as int?,
        userId: json["user_id"] as int?,
        subProdId: json["sub_prod_id"] as String?,
        transType: json["trans_type"] as String?,
        amount: json["amount"] as String?,
        crAcc: json["cr_acc"] as String?,
        trxFrom: json["trx_from"] as String?,
        deductAmount: json["deduct_amount"]?.toDouble() as double?,
        transRef: json["trans_ref"] as String?,
        autoRef: json["auto_ref"] as String?,
        token: json["token"] as String?,
        unit: json["unit"]?.toDouble() as double?,
        cardPin: json["cardPin"] as String?,
        cardSerialNo: json["cardSerialNo"] as String?,
        status: json["status"] as String?,
        isActive: json["is_active"] as int?,
        balanceBefore: json["balance_before"] as String?,
        balanceAfter: json["balance_after"] as String?,
        paymentType: json["payment_type"] as String?,
        channel: json["channel"] as String?,
        platform: json["platform"] as String?,
        macAddress: json["mac_address"] as String?,
        ipAddress: json["ip_address"] as String?,
        longitude: json["longitude"] as String?,
        latitude: json["latitude"] as String?,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"] as String),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"] as String),
        subProduct: json["sub_product"] == null
            ? null
            : SubProduct.fromJson(json["sub_product"] as Map<String, dynamic>),
        bank: json["bank"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "sub_prod_id": subProdId,
        "trans_type": transType,
        "amount": amount,
        "cr_acc": crAcc,
        "trx_from": trxFrom,
        "deduct_amount": deductAmount,
        "trans_ref": transRef,
        "auto_ref": autoRef,
        "token": token,
        "unit": unit,
        "cardPin": cardPin,
        "cardSerialNo": cardSerialNo,
        "status": status,
        "is_active": isActive,
        "balance_before": balanceBefore,
        "balance_after": balanceAfter,
        "payment_type": paymentType,
        "channel": channel,
        "platform": platform,
        "mac_address": macAddress,
        "ip_address": ipAddress,
        "longitude": longitude,
        "latitude": latitude,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "sub_product": subProduct?.toJson(),
        "bank": bank,
      };
}
