// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginRequestImpl _$$LoginRequestImplFromJson(Map<String, dynamic> json) =>
    _$LoginRequestImpl(
      email: json['email'] as String,
      password: json['password'] as String,
      deviceToken: json['device_token'] as String?,
      fcmToken: json['fcm_token'] as String?,
    );

Map<String, dynamic> _$$LoginRequestImplToJson(_$LoginRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'device_token': instance.deviceToken,
      'fcm_token': instance.fcmToken,
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

_$VerifyEmailRequestImpl _$$VerifyEmailRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$VerifyEmailRequestImpl(
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$$VerifyEmailRequestImplToJson(
        _$VerifyEmailRequestImpl instance) =>
    <String, dynamic>{
      'otp': instance.otp,
    };

_$DeleteAccountRequestImpl _$$DeleteAccountRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$DeleteAccountRequestImpl(
      pin: json['pin'] as String,
    );

Map<String, dynamic> _$$DeleteAccountRequestImplToJson(
        _$DeleteAccountRequestImpl instance) =>
    <String, dynamic>{
      'pin': instance.pin,
    };

_$NewPasswordRequestImpl _$$NewPasswordRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$NewPasswordRequestImpl(
      email: json['email'] as String,
      password: json['password'] as String,
      passwordConfirm: json['password_confirm'] as String,
    );

Map<String, dynamic> _$$NewPasswordRequestImplToJson(
        _$NewPasswordRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'password_confirm': instance.passwordConfirm,
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

_$ChangePinRequestImpl _$$ChangePinRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ChangePinRequestImpl(
      oldPin: json['oldPin'] as String,
      newPin: json['newPin'] as String,
    );

Map<String, dynamic> _$$ChangePinRequestImplToJson(
        _$ChangePinRequestImpl instance) =>
    <String, dynamic>{
      'oldPin': instance.oldPin,
      'newPin': instance.newPin,
    };

_$ResetPinRequestImpl _$$ResetPinRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ResetPinRequestImpl(
      password: json['password'] as String,
    );

Map<String, dynamic> _$$ResetPinRequestImplToJson(
        _$ResetPinRequestImpl instance) =>
    <String, dynamic>{
      'password': instance.password,
    };

_$CreatePinRequestImpl _$$CreatePinRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreatePinRequestImpl(
      pin: json['pin'] as String,
      pinConfirmation: json['pin_confirmation'] as String,
    );

Map<String, dynamic> _$$CreatePinRequestImplToJson(
        _$CreatePinRequestImpl instance) =>
    <String, dynamic>{
      'pin': instance.pin,
      'pin_confirmation': instance.pinConfirmation,
    };

_$VerifyPinRequestImpl _$$VerifyPinRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$VerifyPinRequestImpl(
      pin: json['pin'] as String,
    );

Map<String, dynamic> _$$VerifyPinRequestImplToJson(
        _$VerifyPinRequestImpl instance) =>
    <String, dynamic>{
      'pin': instance.pin,
    };

_$ChangePasswordRequestImpl _$$ChangePasswordRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ChangePasswordRequestImpl(
      oldPassword: json['oldPassword'] as String,
      newPassword: json['newPassword'] as String,
    );

Map<String, dynamic> _$$ChangePasswordRequestImplToJson(
        _$ChangePasswordRequestImpl instance) =>
    <String, dynamic>{
      'oldPassword': instance.oldPassword,
      'newPassword': instance.newPassword,
    };
