// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registeration_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    _RegisterResponse(
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : RegistrationData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$RegisterResponseToJson(_RegisterResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };

_RegistrationData _$RegistrationDataFromJson(Map<String, dynamic> json) =>
    _RegistrationData(
      token: json['token'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegistrationDataToJson(_RegistrationData instance) =>
    <String, dynamic>{'token': instance.token, 'user': instance.user};

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  name: json['name'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  id: (json['id'] as num?)?.toInt(),
  currentSessionId: json['current_session_id'] as String?,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'name': instance.name,
  'phone': instance.phone,
  'email': instance.email,
  'updated_at': instance.updatedAt?.toIso8601String(),
  'created_at': instance.createdAt?.toIso8601String(),
  'id': instance.id,
  'current_session_id': instance.currentSessionId,
};
