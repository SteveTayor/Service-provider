import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_setup_response.freezed.dart';
part 'profile_setup_response.g.dart';

@freezed
abstract class ProfileSetupResponse with _$ProfileSetupResponse {
  const factory ProfileSetupResponse({
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "data") String? data,
    @JsonKey(name: "message") String? message,
  }) = _ProfileSetupResponse;

  factory ProfileSetupResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileSetupResponseFromJson(json);
}
