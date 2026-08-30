import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'get_wallet_response.freezed.dart';
part 'get_wallet_response.g.dart';

@freezed
abstract class GetWalletResponse with _$GetWalletResponse {
  const factory GetWalletResponse({
    @JsonKey(name: "wallet") String? wallet,
    @JsonKey(name: "promo_bonus", fromJson: _toDouble) double? promoBonus,
  }) = _GetWalletResponse;

  factory GetWalletResponse.fromJson(Map<String, dynamic> json) =>
      _$GetWalletResponseFromJson(json);
}

double _toDouble(Object? value) {
  if (value == null) return 0.0;
  return double.tryParse(value.toString()) ?? 0.0;
}
