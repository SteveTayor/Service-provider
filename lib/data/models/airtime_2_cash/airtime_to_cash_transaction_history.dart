import 'package:freezed_annotation/freezed_annotation.dart';

part 'airtime_to_cash_transaction_history.freezed.dart';
part 'airtime_to_cash_transaction_history.g.dart';

@freezed
abstract class AirtimeTransactionHistoryResponse
    with _$AirtimeTransactionHistoryResponse {
  const factory AirtimeTransactionHistoryResponse({
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "data") List<AirtimeTransactionHistoryDto>? data,
    @JsonKey(name: "message") String? message,
  }) = _AirtimeTransactionHistoryResponse;

  factory AirtimeTransactionHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$AirtimeTransactionHistoryResponseFromJson(json);
}

@freezed
abstract class AirtimeTransactionHistoryDto
    with _$AirtimeTransactionHistoryDto {
  const AirtimeTransactionHistoryDto._();

  const factory AirtimeTransactionHistoryDto({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "amount") String? amount,
    @JsonKey(name: "cr_acc") String? crAcc,
    @JsonKey(name: "trx_from") String? trxFrom,
    @JsonKey(name: "trans_ref") String? transRef,
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "created_at") String? createdAt,
    @JsonKey(name: "sub_product") AirtimeSubProductDto? subProduct,
  }) = _AirtimeTransactionHistoryDto;

  factory AirtimeTransactionHistoryDto.fromJson(Map<String, dynamic> json) =>
      _$AirtimeTransactionHistoryDtoFromJson(json);

  double get amountValue => double.tryParse(amount ?? '') ?? 0;
  DateTime get dateTimeValue =>
      DateTime.tryParse(createdAt ?? '') ?? DateTime.now();
}

@freezed
abstract class AirtimeSubProductDto with _$AirtimeSubProductDto {
  const factory AirtimeSubProductDto({
    // e.g. "MTN", "AIRTEL" — used to derive networkId; sub_name is only
    // a display string ("Airtel Airtime to Cash").
    @JsonKey(name: "auto_sub_prod_id") String? autoSubProdId,
    @JsonKey(name: "sub_name") String? subName,
    @JsonKey(name: "user_percent") String? userPercent,
  }) = _AirtimeSubProductDto;

  factory AirtimeSubProductDto.fromJson(Map<String, dynamic> json) =>
      _$AirtimeSubProductDtoFromJson(json);
}