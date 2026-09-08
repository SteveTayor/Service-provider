// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airtime_to_cash_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AirtimeNetworksResponse _$AirtimeNetworksResponseFromJson(
  Map<String, dynamic> json,
) => _AirtimeNetworksResponse(
  status: json['status'] as String?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => AirtimeNetworkDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$AirtimeNetworksResponseToJson(
  _AirtimeNetworksResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'data': instance.data,
  'message': instance.message,
};

_AirtimeNetworkDto _$AirtimeNetworkDtoFromJson(Map<String, dynamic> json) =>
    _AirtimeNetworkDto(
      name: json['name'] as String?,
      code: json['code'] as String?,
      userPercentage: (json['user_percentage'] as num?)?.toInt(),
      agentPercentage: (json['agent_percentage'] as num?)?.toInt(),
      rate: (json['rate'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AirtimeNetworkDtoToJson(_AirtimeNetworkDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'user_percentage': instance.userPercentage,
      'agent_percentage': instance.agentPercentage,
      'rate': instance.rate,
    };

_AirtimeGenerateOtpRequest _$AirtimeGenerateOtpRequestFromJson(
  Map<String, dynamic> json,
) => _AirtimeGenerateOtpRequest(
  network: json['network'] as String,
  phone: json['phone'] as String,
);

Map<String, dynamic> _$AirtimeGenerateOtpRequestToJson(
  _AirtimeGenerateOtpRequest instance,
) => <String, dynamic>{'network': instance.network, 'phone': instance.phone};

_AirtimeGenerateOtpResponse _$AirtimeGenerateOtpResponseFromJson(
  Map<String, dynamic> json,
) => _AirtimeGenerateOtpResponse(
  status: json['status'] as String?,
  data: json['data'] == null
      ? null
      : AirtimeCodeMessage.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String?,
);

Map<String, dynamic> _$AirtimeGenerateOtpResponseToJson(
  _AirtimeGenerateOtpResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'data': instance.data,
  'message': instance.message,
};

_AirtimeCodeMessage _$AirtimeCodeMessageFromJson(Map<String, dynamic> json) =>
    _AirtimeCodeMessage(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AirtimeCodeMessageToJson(_AirtimeCodeMessage instance) =>
    <String, dynamic>{'code': instance.code, 'message': instance.message};

_AirtimeVerifyOtpRequest _$AirtimeVerifyOtpRequestFromJson(
  Map<String, dynamic> json,
) => _AirtimeVerifyOtpRequest(
  network: json['network'] as String,
  phone: json['phone'] as String,
  otp: json['otp'] as String,
);

Map<String, dynamic> _$AirtimeVerifyOtpRequestToJson(
  _AirtimeVerifyOtpRequest instance,
) => <String, dynamic>{
  'network': instance.network,
  'phone': instance.phone,
  'otp': instance.otp,
};

_AirtimeVerifyOtpResponse _$AirtimeVerifyOtpResponseFromJson(
  Map<String, dynamic> json,
) => _AirtimeVerifyOtpResponse(
  status: json['status'] as String?,
  data: json['data'] == null
      ? null
      : AirtimeSessionData.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String?,
);

Map<String, dynamic> _$AirtimeVerifyOtpResponseToJson(
  _AirtimeVerifyOtpResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'data': instance.data,
  'message': instance.message,
};

_AirtimeSessionData _$AirtimeSessionDataFromJson(Map<String, dynamic> json) =>
    _AirtimeSessionData(sessionId: json['sessionId'] as String?);

Map<String, dynamic> _$AirtimeSessionDataToJson(_AirtimeSessionData instance) =>
    <String, dynamic>{'sessionId': instance.sessionId};

_AirtimeCheckQuotaRequest _$AirtimeCheckQuotaRequestFromJson(
  Map<String, dynamic> json,
) => _AirtimeCheckQuotaRequest(
  network: json['network'] as String,
  amount: json['amount'] as num,
);

Map<String, dynamic> _$AirtimeCheckQuotaRequestToJson(
  _AirtimeCheckQuotaRequest instance,
) => <String, dynamic>{'network': instance.network, 'amount': instance.amount};

_AirtimeCheckQuotaResponse _$AirtimeCheckQuotaResponseFromJson(
  Map<String, dynamic> json,
) => _AirtimeCheckQuotaResponse(
  status: json['status'] as String?,
  data: json['data'] == null
      ? null
      : AirtimeCodeMessage.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String?,
);

Map<String, dynamic> _$AirtimeCheckQuotaResponseToJson(
  _AirtimeCheckQuotaResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'data': instance.data,
  'message': instance.message,
};

_AirtimeTransferRequest _$AirtimeTransferRequestFromJson(
  Map<String, dynamic> json,
) => _AirtimeTransferRequest(
  network: json['network'] as String,
  phone: json['phone'] as String,
  amount: json['amount'] as num,
  pin: json['pin'] as String,
  sessionId: json['sessionId'] as String,
);

Map<String, dynamic> _$AirtimeTransferRequestToJson(
  _AirtimeTransferRequest instance,
) => <String, dynamic>{
  'network': instance.network,
  'phone': instance.phone,
  'amount': instance.amount,
  'pin': instance.pin,
  'sessionId': instance.sessionId,
};

_AirtimeTransferResponse _$AirtimeTransferResponseFromJson(
  Map<String, dynamic> json,
) => _AirtimeTransferResponse(
  status: json['status'] as String?,
  data: json['data'] == null
      ? null
      : AirtimeTransferData.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String?,
);

Map<String, dynamic> _$AirtimeTransferResponseToJson(
  _AirtimeTransferResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'data': instance.data,
  'message': instance.message,
};

_AirtimeTransferData _$AirtimeTransferDataFromJson(Map<String, dynamic> json) =>
    _AirtimeTransferData(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      reference: json['reference'] as String?,
    );

Map<String, dynamic> _$AirtimeTransferDataToJson(
  _AirtimeTransferData instance,
) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
  'reference': instance.reference,
};
