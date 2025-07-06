import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_receipt_model.freezed.dart';
part 'transaction_receipt_model.g.dart';

@freezed
class TransactionReceiptData with _$TransactionReceiptData {
  const factory TransactionReceiptData({
    required String? transactionId,
    required String? date,
    required String? time,
    required String? type,
    required String? amount,
    String? bankName,
    String? accountNumber,
    required String status,
    String? description,
    String? reference,
    String? beneficiary, // e.g., phone number for airtime
    String? provider, // e.g., MTN, Startimes, Eko PHCN
    String? meterType, // e.g., Prepaid/Postpaid for electricity
    String? meterNumber, // e.g., electricity meter number
    String? smartCardNumber, // e.g., for cable TV
    String? package, // e.g., Startimes Plus WEB ACCESS
    String? userBalance, // e.g., user's balance after transaction
    String? paymentMethod, // e.g., Wallet, Bank Transfer
    String? agentName, // e.g., for bulk e-PIN
    String? agentEmail, // e.g., for bulk e-PIN
    String? agentPhoneNumber, // e.g., for bulk e-PIN
    String? businessName, // e.g., for bulk e-PIN
    String? network, // e.g., MTN, Glo for bulk e-PIN or data
    String? quantity, // e.g., for bulk e-PIN
    String? subProduct, // e.g., for education transactions
    String? dataBundle, // e.g., 100MB 1 Day for data purchase
    String? phoneNumber, // e.g., for data purchase
  }) = _TransactionReceiptData;

  factory TransactionReceiptData.fromJson(Map<String, dynamic> json) =>
      _$TransactionReceiptDataFromJson(json);
}
