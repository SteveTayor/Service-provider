// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginRequestImpl _$$LoginRequestImplFromJson(Map<String, dynamic> json) =>
    _$LoginRequestImpl(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$LoginRequestImplToJson(_$LoginRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

_$RegisterRequestImpl _$$RegisterRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$RegisterRequestImpl(
      email: json['email'] as String,
      phone: json['phone'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      password: json['password'] as String,
      passwordConfirm: json['password_confirm'] as String,
    );

Map<String, dynamic> _$$RegisterRequestImplToJson(
        _$RegisterRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone': instance.phone,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'password': instance.password,
      'password_confirm': instance.passwordConfirm,
    };

_$ForgotPasswordRequestImpl _$$ForgotPasswordRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ForgotPasswordRequestImpl(
      email: json['email'] as String,
    );

Map<String, dynamic> _$$ForgotPasswordRequestImplToJson(
        _$ForgotPasswordRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

_$VerifyOtpRequestImpl _$$VerifyOtpRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$VerifyOtpRequestImpl(
      email: json['email'] as String,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$$VerifyOtpRequestImplToJson(
        _$VerifyOtpRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'otp': instance.otp,
    };

_$NewPasswordRequestImpl _$$NewPasswordRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$NewPasswordRequestImpl(
      email: json['email'] as String,
      password: json['password'] as String,
      passwordConfirm: json['password_confirm'] as String,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$$NewPasswordRequestImplToJson(
        _$NewPasswordRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'password_confirm': instance.passwordConfirm,
      'otp': instance.otp,
    };

_$AddUsernameRequestImpl _$$AddUsernameRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$AddUsernameRequestImpl(
      username: json['username'] as String,
    );

Map<String, dynamic> _$$AddUsernameRequestImplToJson(
        _$AddUsernameRequestImpl instance) =>
    <String, dynamic>{
      'username': instance.username,
    };

_$CheckUsernameRequestImpl _$$CheckUsernameRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CheckUsernameRequestImpl(
      username: json['username'] as String,
    );

Map<String, dynamic> _$$CheckUsernameRequestImplToJson(
        _$CheckUsernameRequestImpl instance) =>
    <String, dynamic>{
      'username': instance.username,
    };
