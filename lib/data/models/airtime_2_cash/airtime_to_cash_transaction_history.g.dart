// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airtime_to_cash_transaction_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AirtimeTransactionHistoryResponse _$AirtimeTransactionHistoryResponseFromJson(
  Map<String, dynamic> json,
) => _AirtimeTransactionHistoryResponse(
  status: json['status'] as String?,
  data: (json['data'] as List<dynamic>?)
      ?.map(
        (e) => AirtimeTransactionHistoryDto.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$AirtimeTransactionHistoryResponseToJson(
  _AirtimeTransactionHistoryResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'data': instance.data,
  'message': instance.message,
};

_AirtimeTransactionHistoryDto _$AirtimeTransactionHistoryDtoFromJson(
  Map<String, dynamic> json,
) => _AirtimeTransactionHistoryDto(
  id: (json['id'] as num?)?.toInt(),
  amount: json['amount'] as String?,
  crAcc: json['cr_acc'] as String?,
  trxFrom: json['trx_from'] as String?,
  transRef: json['trans_ref'] as String?,
  status: json['status'] as String?,
  createdAt: json['created_at'] as String?,
  subProduct: json['sub_product'] == null
      ? null
      : AirtimeSubProductDto.fromJson(
          json['sub_product'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$AirtimeTransactionHistoryDtoToJson(
  _AirtimeTransactionHistoryDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'amount': instance.amount,
  'cr_acc': instance.crAcc,
  'trx_from': instance.trxFrom,
  'trans_ref': instance.transRef,
  'status': instance.status,
  'created_at': instance.createdAt,
  'sub_product': instance.subProduct,
};

_AirtimeSubProductDto _$AirtimeSubProductDtoFromJson(
  Map<String, dynamic> json,
) => _AirtimeSubProductDto(
  autoSubProdId: json['auto_sub_prod_id'] as String?,
  subName: json['sub_name'] as String?,
  userPercent: json['user_percent'] as String?,
);

Map<String, dynamic> _$AirtimeSubProductDtoToJson(
  _AirtimeSubProductDto instance,
) => <String, dynamic>{
  'auto_sub_prod_id': instance.autoSubProdId,
  'sub_name': instance.subName,
  'user_percent': instance.userPercent,
};
