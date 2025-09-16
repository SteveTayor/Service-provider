import 'dart:convert';

class RedeemAPromoRequest {
  final String? code;

  RedeemAPromoRequest({
    this.code,
  });

  factory RedeemAPromoRequest.fromJson(Map<String, dynamic> json) =>
      RedeemAPromoRequest(
        code: json["code"] as String,
      );

  Map<String, dynamic> toJson() => {
        "code": code,
      };
}
