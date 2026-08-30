// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'become_a_merchant_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BecomeAMerchantRequest _$BecomeAMerchantRequestFromJson(
  Map<String, dynamic> json,
) => _BecomeAMerchantRequest(
  macAddress: json['mac_address'] as String,
  ipAddress: json['ip_address'] as String,
  latitude: json['latitude'] as String,
  longitude: json['longitude'] as String,
  platform: json['platform'] as String,
);

Map<String, dynamic> _$BecomeAMerchantRequestToJson(
  _BecomeAMerchantRequest instance,
) => <String, dynamic>{
  'mac_address': instance.macAddress,
  'ip_address': instance.ipAddress,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'platform': instance.platform,
};
