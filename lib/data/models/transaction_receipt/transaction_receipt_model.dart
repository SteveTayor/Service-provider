import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_receipt_model.freezed.dart';
part 'transaction_receipt_model.g.dart';

// Represents the data structure for a transaction receipt
@freezed
class TransactionReceiptData with _$TransactionReceiptData {
  const factory TransactionReceiptData({
    required String? transactionId, // Unique identifier for the transaction
    required String? date, // Date of the transaction
    required String? time, // Time of the transaction
    required String?
        type, // Type of transaction (e.g., Mobile data, Top-up, Airtime)
    required String? amount, // Transaction amount
    String? bankName, // Name of the bank (if applicable)
    String?
        accountNumber, // Account number or name (e.g., used as account name for withdrawal)
    required String
        status, // Status of the transaction (e.g., Successful, Failed)
    String? description, // Additional description of the transaction
    String? reference, // Reference number for the transaction
    String? beneficiary, // Beneficiary details (e.g., phone number for airtime)
    String? provider, // Service provider (e.g., MTN, Startimes)
    String? meterType, // Meter type (e.g., Prepaid/Postpaid for electricity)
    String? meterNumber, // Meter number (e.g., for electricity)
    String? smartCardNumber, // Smart card number (e.g., for cable TV)
    String? package, // Package details (e.g., Startimes Plus)
    String? userBalance, // User's balance after the transaction
    String? paymentMethod, // Payment method (e.g., Wallet, Monnify)
    String? agentName, // Agent name (e.g., for bulk e-PIN)
    String? agentEmail, // Agent email (e.g., for bulk e-PIN)
    String? agentPhoneNumber, // Agent phone number (e.g., for bulk e-PIN)
    String? businessName, // Business name (e.g., for bulk e-PIN)
    String? network, // Network provider (e.g., MTN, Glo)
    String? quantity, // Quantity (e.g., for bulk e-PIN)
    String? subProduct, // Sub-product details
    String? dataBundle, // Data bundle details (e.g., 100MB 1 Day)
    String? phoneNumber, // Phone number (e.g., for data or airtime)
    String? balanceBefore, // User's balance before the transaction
  }) = _TransactionReceiptData;

  factory TransactionReceiptData.fromJson(Map<String, dynamic> json) =>
      _$TransactionReceiptDataFromJson(json);
}
