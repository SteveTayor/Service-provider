import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_receipt_model.freezed.dart';
part 'transaction_receipt_model.g.dart';

@freezed
class TransactionReceiptData with _$TransactionReceiptData {
  const factory TransactionReceiptData({
    required String transactionId,
    required String date,
    required String time,
    required String type,
    required String amount,
    String? bankName,
    String? accountNumber,
    required String status,
    String? description,
    String? reference,
  }) = _TransactionReceiptData;

  factory TransactionReceiptData.fromJson(Map<String, dynamic> json) =>
      _$TransactionReceiptDataFromJson(json);
}
