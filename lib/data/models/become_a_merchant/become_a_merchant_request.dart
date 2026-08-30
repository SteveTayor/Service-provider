// To parse this JSON data, do
//
//     final becomeAMerchantRequest = becomeAMerchantRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'become_a_merchant_request.freezed.dart';
part 'become_a_merchant_request.g.dart';

@freezed
abstract class BecomeAMerchantRequest with _$BecomeAMerchantRequest {
  const factory BecomeAMerchantRequest({
    @JsonKey(name: "mac_address") required String macAddress,
    @JsonKey(name: "ip_address") required String ipAddress,
    @JsonKey(name: "latitude") required String latitude,
    @JsonKey(name: "longitude") required String longitude,
    @JsonKey(name: "platform") required String platform,
  }) = _BecomeAMerchantRequest;

  factory BecomeAMerchantRequest.fromJson(Map<String, dynamic> json) =>
      _$BecomeAMerchantRequestFromJson(json);
}
