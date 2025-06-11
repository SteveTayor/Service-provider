// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_receipt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionReceiptDataImpl _$$TransactionReceiptDataImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionReceiptDataImpl(
      transactionId: json['transactionId'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      type: json['type'] as String,
      amount: json['amount'] as String,
      bankName: json['bankName'] as String?,
      accountNumber: json['accountNumber'] as String?,
      status: json['status'] as String,
      description: json['description'] as String?,
      reference: json['reference'] as String?,
    );

Map<String, dynamic> _$$TransactionReceiptDataImplToJson(
        _$TransactionReceiptDataImpl instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'date': instance.date,
      'time': instance.time,
      'type': instance.type,
      'amount': instance.amount,
      'bankName': instance.bankName,
      'accountNumber': instance.accountNumber,
      'status': instance.status,
      'description': instance.description,
      'reference': instance.reference,
    };
