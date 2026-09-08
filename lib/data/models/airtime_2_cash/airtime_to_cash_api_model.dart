import 'package:freezed_annotation/freezed_annotation.dart';

part 'airtime_to_cash_api_model.freezed.dart';
part 'airtime_to_cash_api_model.g.dart';

// ─── GET /airtime-to-cash/networks ─────────────────────────────────────────

@freezed
abstract class AirtimeNetworksResponse with _$AirtimeNetworksResponse {
  const factory AirtimeNetworksResponse({
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "data") List<AirtimeNetworkDto>? data,
    @JsonKey(name: "message") String? message,
  }) = _AirtimeNetworksResponse;

  factory AirtimeNetworksResponse.fromJson(Map<String, dynamic> json) =>
      _$AirtimeNetworksResponseFromJson(json);
}

@freezed
abstract class AirtimeNetworkDto with _$AirtimeNetworkDto {
  const factory AirtimeNetworkDto({
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "code") String? code,
    @JsonKey(name: "user_percentage") int? userPercentage,
    @JsonKey(name: "agent_percentage") int? agentPercentage,
    // The rate already resolved server-side for the calling user's role
    // (matches user_percentage in every sample seen) — use this directly
    // rather than re-deriving agent-vs-user client-side.
    @JsonKey(name: "rate") int? rate,
  }) = _AirtimeNetworkDto;

  factory AirtimeNetworkDto.fromJson(Map<String, dynamic> json) =>
      _$AirtimeNetworkDtoFromJson(json);
}

// ─── POST /airtime-to-cash/otp ──────────────────────────────────────────────

@freezed
abstract class AirtimeGenerateOtpRequest with _$AirtimeGenerateOtpRequest {
  const factory AirtimeGenerateOtpRequest({
    @JsonKey(name: "network") required String network,
    @JsonKey(name: "phone") required String phone,
  }) = _AirtimeGenerateOtpRequest;

  factory AirtimeGenerateOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$AirtimeGenerateOtpRequestFromJson(json);
}

@freezed
abstract class AirtimeGenerateOtpResponse with _$AirtimeGenerateOtpResponse {
  const factory AirtimeGenerateOtpResponse({
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "data") AirtimeCodeMessage? data,
    @JsonKey(name: "message") String? message,
  }) = _AirtimeGenerateOtpResponse;

  factory AirtimeGenerateOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$AirtimeGenerateOtpResponseFromJson(json);
}

/// Shared {code, message} shape used by the otp/check-quota `data` payloads.
@freezed
abstract class AirtimeCodeMessage with _$AirtimeCodeMessage {
  const factory AirtimeCodeMessage({
    @JsonKey(name: "code") int? code,
    @JsonKey(name: "message") String? message,
  }) = _AirtimeCodeMessage;

  factory AirtimeCodeMessage.fromJson(Map<String, dynamic> json) =>
      _$AirtimeCodeMessageFromJson(json);
}

// ─── POST /airtime-to-cash/verify ───────────────────────────────────────────

@freezed
abstract class AirtimeVerifyOtpRequest with _$AirtimeVerifyOtpRequest {
  const factory AirtimeVerifyOtpRequest({
    @JsonKey(name: "network") required String network,
    @JsonKey(name: "phone") required String phone,
    @JsonKey(name: "otp") required String otp,
  }) = _AirtimeVerifyOtpRequest;

  factory AirtimeVerifyOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$AirtimeVerifyOtpRequestFromJson(json);
}

@freezed
abstract class AirtimeVerifyOtpResponse with _$AirtimeVerifyOtpResponse {
  const factory AirtimeVerifyOtpResponse({
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "data") AirtimeSessionData? data,
    @JsonKey(name: "message") String? message,
  }) = _AirtimeVerifyOtpResponse;

  factory AirtimeVerifyOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$AirtimeVerifyOtpResponseFromJson(json);
}

@freezed
abstract class AirtimeSessionData with _$AirtimeSessionData {
  const factory AirtimeSessionData({
    @JsonKey(name: "sessionId") String? sessionId,
  }) = _AirtimeSessionData;

  factory AirtimeSessionData.fromJson(Map<String, dynamic> json) =>
      _$AirtimeSessionDataFromJson(json);
}

// ─── POST /airtime-to-cash/check-quota ──────────────────────────────────────

@freezed
abstract class AirtimeCheckQuotaRequest with _$AirtimeCheckQuotaRequest {
  const factory AirtimeCheckQuotaRequest({
    @JsonKey(name: "network") required String network,
    @JsonKey(name: "amount") required num amount,
  }) = _AirtimeCheckQuotaRequest;

  factory AirtimeCheckQuotaRequest.fromJson(Map<String, dynamic> json) =>
      _$AirtimeCheckQuotaRequestFromJson(json);
}

@freezed
abstract class AirtimeCheckQuotaResponse with _$AirtimeCheckQuotaResponse {
  const factory AirtimeCheckQuotaResponse({
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "data") AirtimeCodeMessage? data,
    @JsonKey(name: "message") String? message,
  }) = _AirtimeCheckQuotaResponse;

  factory AirtimeCheckQuotaResponse.fromJson(Map<String, dynamic> json) =>
      _$AirtimeCheckQuotaResponseFromJson(json);
}

// ─── POST /airtime-to-cash/transfer ─────────────────────────────────────────

@freezed
abstract class AirtimeTransferRequest with _$AirtimeTransferRequest {
  const factory AirtimeTransferRequest({
    @JsonKey(name: "network") required String network,
    @JsonKey(name: "phone") required String phone,
    @JsonKey(name: "amount") required num amount,
    @JsonKey(name: "pin") required String pin,
    @JsonKey(name: "sessionId") required String sessionId,
  }) = _AirtimeTransferRequest;

  factory AirtimeTransferRequest.fromJson(Map<String, dynamic> json) =>
      _$AirtimeTransferRequestFromJson(json);
}

@freezed
abstract class AirtimeTransferResponse with _$AirtimeTransferResponse {
  const factory AirtimeTransferResponse({
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "data") AirtimeTransferData? data,
    @JsonKey(name: "message") String? message,
  }) = _AirtimeTransferResponse;

  factory AirtimeTransferResponse.fromJson(Map<String, dynamic> json) =>
      _$AirtimeTransferResponseFromJson(json);
}

@freezed
abstract class AirtimeTransferData with _$AirtimeTransferData {
  const factory AirtimeTransferData({
    // 2000 = credited immediately. 4000 = accepted, processing — will be
    // credited once the network confirms. Any other/absent code is
    // treated as a failure by the repository even on HTTP 200, since this
    // API reports business-logic outcomes via `code`, not just HTTP status.
    @JsonKey(name: "code") int? code,
    @JsonKey(name: "message") String? message,
    @JsonKey(name: "reference") String? reference,
  }) = _AirtimeTransferData;

  factory AirtimeTransferData.fromJson(Map<String, dynamic> json) =>
      _$AirtimeTransferDataFromJson(json);
}
