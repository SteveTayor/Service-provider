// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegisterResponseImpl _$$RegisterResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$RegisterResponseImpl(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      operations: (json['operations'] as List<dynamic>)
          .map((e) => Operation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RegisterResponseImplToJson(
        _$RegisterResponseImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'operations': instance.operations,
    };

_$OperationImpl _$$OperationImplFromJson(Map<String, dynamic> json) =>
    _$OperationImpl(
      name: json['name'] as String,
      limit: (json['limit'] as num).toInt(),
      usage: (json['usage'] as num).toInt(),
      overage: (json['overage'] as num).toInt(),
    );

Map<String, dynamic> _$$OperationImplToJson(_$OperationImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'limit': instance.limit,
      'usage': instance.usage,
      'overage': instance.overage,
    };

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      avatar: json['avatar'] as String,
      isPublic: json['isPublic'] as bool,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'fullName': instance.fullName,
      'avatar': instance.avatar,
      'isPublic': instance.isPublic,
    };

_$BaseResponseImpl _$$BaseResponseImplFromJson(Map<String, dynamic> json) =>
    _$BaseResponseImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'],
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$BaseResponseImplToJson(_$BaseResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
      'error': instance.error,
    };

_$AuthDataImpl _$$AuthDataImplFromJson(Map<String, dynamic> json) =>
    _$AuthDataImpl(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
    );

Map<String, dynamic> _$$AuthDataImplToJson(_$AuthDataImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
    };

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

_$AuthResponseImpl _$$AuthResponseImplFromJson(Map<String, dynamic> json) =>
    _$AuthResponseImpl(
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$$AuthResponseImplToJson(_$AuthResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
