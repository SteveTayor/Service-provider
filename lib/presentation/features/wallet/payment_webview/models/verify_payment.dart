// To parse this JSON data, do
//
//     final squadPaymentVerificationResponse = squadPaymentVerificationResponseFromJson(jsonString);

import 'dart:convert';

// SquadPaymentVerificationResponse squadPaymentVerificationResponseFromJson(
//         String str) =>
//     SquadPaymentVerificationResponse.fromJson(json.decode(str));

// String squadPaymentVerificationResponseToJson(
//         SquadPaymentVerificationResponse data) =>
//     json.encode(data.toJson());

class SquadPaymentVerificationResponse {
  final dynamic status;
  final bool? success;
  final String? message;
  final Data? data;

  SquadPaymentVerificationResponse({
    this.status,
    this.success,
    this.message,
    this.data,
  });

  factory SquadPaymentVerificationResponse.fromJson(
          Map<String, dynamic> json) =>
      SquadPaymentVerificationResponse(
        status: json["status"],
        success: json["success"] as bool,
        message: json["message"] as String,
        data: json["data"] == null
            ? null
            : Data.fromJson(json["data"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final int? transactionAmount;
  final String? transactionRef;
  final String? email;
  final String? transactionStatus;
  final String? transactionCurrencyId;
  final DateTime? createdAt;
  final String? transactionType;
  final String? merchantName;
  final String? merchantBusinessName;
  final String? gatewayTransactionRef;
  final String? merchantEmail;
  final Meta? meta;
  final double? fee;
  final int? merchantAmount;

  Data({
    this.transactionAmount,
    this.transactionRef,
    this.email,
    this.transactionStatus,
    this.transactionCurrencyId,
    this.createdAt,
    this.transactionType,
    this.merchantName,
    this.merchantBusinessName,
    this.gatewayTransactionRef,
    this.merchantEmail,
    this.meta,
    this.fee,
    this.merchantAmount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        transactionAmount: json["transaction_amount"] as int?,
        transactionRef: json["transaction_ref"]?.toString(),
        email: json["email"]?.toString(),
        transactionStatus: json["transaction_status"]?.toString(),
        transactionCurrencyId: json["transaction_currency_id"]?.toString(),
        createdAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"] as String)
            : null,
        transactionType: json["transaction_type"]?.toString(),
        merchantName: json["merchant_name"]?.toString(),
        merchantBusinessName: json["merchant_business_name"]?.toString(),
        gatewayTransactionRef: json["gateway_transaction_ref"]?.toString(),
        merchantEmail: json["merchant_email"]?.toString(),
        meta: json["meta"] != null
            ? Meta.fromJson(json["meta"] as Map<String, dynamic>)
            : null,
        fee: json["fee"] != null
            ? double.tryParse(json["fee"].toString())
            : null,
        merchantAmount: json["merchant_amount"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "transaction_amount": transactionAmount,
        "transaction_ref": transactionRef,
        "email": email,
        "transaction_status": transactionStatus,
        "transaction_currency_id": transactionCurrencyId,
        "created_at": createdAt?.toIso8601String(),
        "transaction_type": transactionType,
        "merchant_name": merchantName,
        "merchant_business_name": merchantBusinessName,
        "gateway_transaction_ref": gatewayTransactionRef,
        "merchant_email": merchantEmail,
        "meta": meta?.toJson(),
        "fee": fee,
        "merchant_amount": merchantAmount,
      };
}

class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta();

  Map<String, dynamic> toJson() => {};
}
