// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_setup_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileSetupResponse _$ProfileSetupResponseFromJson(
  Map<String, dynamic> json,
) => _ProfileSetupResponse(
  status: json['status'] as String?,
  data: json['data'] as String?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$ProfileSetupResponseToJson(
  _ProfileSetupResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'data': instance.data,
  'message': instance.message,
};
