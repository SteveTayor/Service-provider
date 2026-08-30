// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registeration_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    _RegisterRequest(
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      password: json['password'] as String?,
      passwordConfirm: json['password_confirm'] as String?,
    );

Map<String, dynamic> _$RegisterRequestToJson(_RegisterRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone': instance.phone,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'password': instance.password,
      'password_confirm': instance.passwordConfirm,
    };
