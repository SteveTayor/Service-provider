// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) =>
    _LoginRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      deviceToken: json['device_token'] as String?,
      fcmToken: json['fcm_token'] as String?,
    );

Map<String, dynamic> _$LoginRequestToJson(_LoginRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'device_token': instance.deviceToken,
      'fcm_token': instance.fcmToken,
    };

_RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    _RegisterRequest(
      email: json['email'] as String,
      phone: json['phone'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      password: json['password'] as String,
      passwordConfirm: json['password_confirm'] as String,
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

_ForgotPasswordRequest _$ForgotPasswordRequestFromJson(
  Map<String, dynamic> json,
) => _ForgotPasswordRequest(email: json['email'] as String);

Map<String, dynamic> _$ForgotPasswordRequestToJson(
  _ForgotPasswordRequest instance,
) => <String, dynamic>{'email': instance.email};

_VerifyOtpRequest _$VerifyOtpRequestFromJson(Map<String, dynamic> json) =>
    _VerifyOtpRequest(
      email: json['email'] as String,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$VerifyOtpRequestToJson(_VerifyOtpRequest instance) =>
    <String, dynamic>{'email': instance.email, 'otp': instance.otp};

_VerifyEmailRequest _$VerifyEmailRequestFromJson(Map<String, dynamic> json) =>
    _VerifyEmailRequest(otp: json['otp'] as String);

Map<String, dynamic> _$VerifyEmailRequestToJson(_VerifyEmailRequest instance) =>
    <String, dynamic>{'otp': instance.otp};

_DeleteAccountRequest _$DeleteAccountRequestFromJson(
  Map<String, dynamic> json,
) => _DeleteAccountRequest(pin: json['pin'] as String);

Map<String, dynamic> _$DeleteAccountRequestToJson(
  _DeleteAccountRequest instance,
) => <String, dynamic>{'pin': instance.pin};

_NewPasswordRequest _$NewPasswordRequestFromJson(Map<String, dynamic> json) =>
    _NewPasswordRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      passwordConfirm: json['password_confirm'] as String,
    );

Map<String, dynamic> _$NewPasswordRequestToJson(_NewPasswordRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'password_confirm': instance.passwordConfirm,
    };

_AddUsernameRequest _$AddUsernameRequestFromJson(Map<String, dynamic> json) =>
    _AddUsernameRequest(username: json['username'] as String);

Map<String, dynamic> _$AddUsernameRequestToJson(_AddUsernameRequest instance) =>
    <String, dynamic>{'username': instance.username};

_CheckUsernameRequest _$CheckUsernameRequestFromJson(
  Map<String, dynamic> json,
) => _CheckUsernameRequest(username: json['username'] as String);

Map<String, dynamic> _$CheckUsernameRequestToJson(
  _CheckUsernameRequest instance,
) => <String, dynamic>{'username': instance.username};

_ChangePinRequest _$ChangePinRequestFromJson(Map<String, dynamic> json) =>
    _ChangePinRequest(
      oldPin: json['oldPin'] as String,
      newPin: json['newPin'] as String,
    );

Map<String, dynamic> _$ChangePinRequestToJson(_ChangePinRequest instance) =>
    <String, dynamic>{'oldPin': instance.oldPin, 'newPin': instance.newPin};

_ResetPinRequest _$ResetPinRequestFromJson(Map<String, dynamic> json) =>
    _ResetPinRequest(password: json['password'] as String);

Map<String, dynamic> _$ResetPinRequestToJson(_ResetPinRequest instance) =>
    <String, dynamic>{'password': instance.password};

_CreatePinRequest _$CreatePinRequestFromJson(Map<String, dynamic> json) =>
    _CreatePinRequest(
      pin: json['pin'] as String,
      pinConfirmation: json['pin_confirmation'] as String,
    );

Map<String, dynamic> _$CreatePinRequestToJson(_CreatePinRequest instance) =>
    <String, dynamic>{
      'pin': instance.pin,
      'pin_confirmation': instance.pinConfirmation,
    };

_VerifyPinRequest _$VerifyPinRequestFromJson(Map<String, dynamic> json) =>
    _VerifyPinRequest(pin: json['pin'] as String);

Map<String, dynamic> _$VerifyPinRequestToJson(_VerifyPinRequest instance) =>
    <String, dynamic>{'pin': instance.pin};

_ChangePasswordRequest _$ChangePasswordRequestFromJson(
  Map<String, dynamic> json,
) => _ChangePasswordRequest(
  oldPassword: json['oldPassword'] as String,
  newPassword: json['newPassword'] as String,
);

Map<String, dynamic> _$ChangePasswordRequestToJson(
  _ChangePasswordRequest instance,
) => <String, dynamic>{
  'oldPassword': instance.oldPassword,
  'newPassword': instance.newPassword,
};
