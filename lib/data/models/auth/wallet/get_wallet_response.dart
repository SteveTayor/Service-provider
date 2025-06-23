import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'get_wallet_response.freezed.dart';
part 'get_wallet_response.g.dart';

@freezed
class GetWalletResponse with _$GetWalletResponse {
  const factory GetWalletResponse({
    @JsonKey(name: "wallet") String? wallet,
  }) = _GetWalletResponse;

  factory GetWalletResponse.fromJson(Map<String, dynamic> json) =>
      _$GetWalletResponseFromJson(json);
}
