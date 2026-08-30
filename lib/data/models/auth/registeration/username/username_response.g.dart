// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'username_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UsernameResponse _$UsernameResponseFromJson(Map<String, dynamic> json) =>
    _UsernameResponse(
      status: json['status'] as String?,
      data: json['data'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$UsernameResponseToJson(_UsernameResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
