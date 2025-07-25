// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_receipt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionReceiptDataImpl _$$TransactionReceiptDataImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionReceiptDataImpl(
      transactionId: json['transactionId'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      type: json['type'] as String?,
      amount: json['amount'] as String?,
      bankName: json['bankName'] as String?,
      accountNumber: json['accountNumber'] as String?,
      status: json['status'] as String,
      description: json['description'] as String?,
      reference: json['reference'] as String?,
      beneficiary: json['beneficiary'] as String?,
      provider: json['provider'] as String?,
      meterType: json['meterType'] as String?,
      meterNumber: json['meterNumber'] as String?,
      smartCardNumber: json['smartCardNumber'] as String?,
      package: json['package'] as String?,
      userBalance: json['userBalance'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      agentName: json['agentName'] as String?,
      agentEmail: json['agentEmail'] as String?,
      agentPhoneNumber: json['agentPhoneNumber'] as String?,
      businessName: json['businessName'] as String?,
      network: json['network'] as String?,
      quantity: json['quantity'] as String?,
      subProduct: json['subProduct'] as String?,
      dataBundle: json['dataBundle'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      balanceBefore: json['balanceBefore'] as String?,
      token: json['token'] as String?,
      units: json['units'] as String?,
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
      'beneficiary': instance.beneficiary,
      'provider': instance.provider,
      'meterType': instance.meterType,
      'meterNumber': instance.meterNumber,
      'smartCardNumber': instance.smartCardNumber,
      'package': instance.package,
      'userBalance': instance.userBalance,
      'paymentMethod': instance.paymentMethod,
      'agentName': instance.agentName,
      'agentEmail': instance.agentEmail,
      'agentPhoneNumber': instance.agentPhoneNumber,
      'businessName': instance.businessName,
      'network': instance.network,
      'quantity': instance.quantity,
      'subProduct': instance.subProduct,
      'dataBundle': instance.dataBundle,
      'phoneNumber': instance.phoneNumber,
      'balanceBefore': instance.balanceBefore,
      'token': instance.token,
      'units': instance.units,
    };
