// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_wallet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetWalletResponse _$GetWalletResponseFromJson(Map<String, dynamic> json) =>
    _GetWalletResponse(
      wallet: json['wallet'] as String?,
      promoBonus: _toDouble(json['promo_bonus']),
    );

Map<String, dynamic> _$GetWalletResponseToJson(_GetWalletResponse instance) =>
    <String, dynamic>{
      'wallet': instance.wallet,
      'promo_bonus': instance.promoBonus,
    };
