// To parse this JSON data, do
//
//     final getAllPromoResponse = getAllPromoResponseFromJson(jsonString);

import 'dart:convert';

// GetAllPromoResponse getAllPromoResponseFromJson(String str) =>
//     GetAllPromoResponse.fromJson(json.decode(str));

// String getAllPromoResponseToJson(GetAllPromoResponse data) =>
//     json.encode(data.toJson());

class GetAllPromoResponse {
  final String? status;
  final Data? data;
  final String? message;

  GetAllPromoResponse({
    this.status,
    this.data,
    this.message,
  });

  factory GetAllPromoResponse.fromJson(Map<String, dynamic> json) =>
      GetAllPromoResponse(
        status: json['status'] as String,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        message: json['message'] as String,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data?.toJson(),
        'message': message,
      };
}

class Data {
  final bool? isNewUser;
  final List<Promo>? promos;

  Data({
    this.isNewUser,
    this.promos,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        isNewUser: json['is_new_user'] as bool?,
        promos: (json['promos'] as List<dynamic>?)
                ?.map((x) => Promo.fromJson(x as Map<String, dynamic>))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        'is_new_user': isNewUser,
        'promos': promos == null
            ? []
            : List<dynamic>.from(promos!.map((x) => x.toJson())),
      };
}

class Promo {
  final int? id;
  final String? code;
  final String? bonusAmount;
  final int? userLimit;
  final int? redeemedCount;
  final String? eligibility;
  final bool? isActive;
  final DateTime? expiresAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Promo({
    this.id,
    this.code,
    this.bonusAmount,
    this.userLimit,
    this.redeemedCount,
    this.eligibility,
    this.isActive,
    this.expiresAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Promo.fromJson(Map<String, dynamic> json) => Promo(
        id: json['id'] as int,
        code: json['code'] as String,
        bonusAmount: json['bonus_amount'] as String,
        userLimit: json['user_limit'] as int,
        redeemedCount: json['redeemed_count'] as int,
        eligibility: json['eligibility'] as String,
        isActive: json['is_active'] as bool,
        expiresAt: json['expires_at'] == null
            ? null
            : DateTime.parse(json['expires_at'] as String),
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'bonus_amount': bonusAmount,
        'user_limit': userLimit,
        'redeemed_count': redeemedCount,
        'eligibility': eligibility,
        'is_active': isActive,
        'expires_at': expiresAt?.toIso8601String(),
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
