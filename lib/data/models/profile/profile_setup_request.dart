import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'profile_setup_request.freezed.dart';
part 'profile_setup_request.g.dart';

@freezed
abstract class ProfileSetupRequest with _$ProfileSetupRequest {
  const factory ProfileSetupRequest({
    @JsonKey(name: "first_name") String? firstName,
    @JsonKey(name: "last_name") String? lastName,
    @JsonKey(name: "address") String? address,
    @JsonKey(name: "date_of_birth") String? dateOfBirth,
    @JsonKey(name: "gender") String? gender,
    @JsonKey(name: "email") String? email,
  }) = _ProfileSetupRequest;

  factory ProfileSetupRequest.fromJson(Map<String, dynamic> json) =>
      _$ProfileSetupRequestFromJson(json);
}
