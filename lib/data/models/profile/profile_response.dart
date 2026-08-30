import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'profile_response.freezed.dart';
part 'profile_response.g.dart';

@freezed
abstract class ProfileResponse with _$ProfileResponse {
  const factory ProfileResponse({
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "data") Data? data,
    @JsonKey(name: "message") String? message,
  }) = _ProfileResponse;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);
}

@freezed
abstract class Data with _$Data {
  const factory Data({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "first_name") String? firstName,
    @JsonKey(name: "last_name") String? lastName,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "username") String? username,
    @JsonKey(name: "email") String? email,
    @JsonKey(name: "phone") String? phone,
    @JsonKey(name: "user_type") String? userType,
    @JsonKey(name: "email_verified_at") dynamic emailVerifiedAt,
    @JsonKey(name: "pin") dynamic pin,
    @JsonKey(name: "address") dynamic address,
    @JsonKey(name: "otp") dynamic otp,
    @JsonKey(name: "gender") dynamic gender,
    @JsonKey(name: "dob") dynamic dob,
    @JsonKey(name: "bvn") dynamic bvn,
    @JsonKey(name: "nin") dynamic nin,
    @JsonKey(name: "bank_name") dynamic bankName,
    @JsonKey(name: "account_number") dynamic accountNumber,
    @JsonKey(name: "account_name") dynamic accountName,
    @JsonKey(name: "v_account_num_1") dynamic vAccountNum1,
    @JsonKey(name: "v_account_name_1") dynamic vAccountName1,
    @JsonKey(name: "v_account_bank_1") dynamic vAccountBank1,
    @JsonKey(name: "v_account_num_2") dynamic vAccountNum2,
    @JsonKey(name: "v_account_num_3") dynamic vAccountNum3,
    @JsonKey(name: "v_account_name_2") dynamic vAccountName2,
    @JsonKey(name: "v_account_name_3") dynamic vAccountName3,
    @JsonKey(name: "v_account_bank_2") dynamic vAccountBank2,
    @JsonKey(name: "v_account_bank_3") dynamic vAccountBank3,
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "current_session_id") String? currentSessionId,
    @JsonKey(name: "transaction_session_id") dynamic transactionSessionId,
    @JsonKey(name: "created_at") DateTime? createdAt,
    @JsonKey(name: "updated_at") DateTime? updatedAt,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
