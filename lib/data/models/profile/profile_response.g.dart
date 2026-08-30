// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    _ProfileResponse(
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ProfileResponseToJson(_ProfileResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };

_Data _$DataFromJson(Map<String, dynamic> json) => _Data(
  id: (json['id'] as num?)?.toInt(),
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  name: json['name'] as String?,
  username: json['username'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  userType: json['user_type'] as String?,
  emailVerifiedAt: json['email_verified_at'],
  pin: json['pin'],
  address: json['address'],
  otp: json['otp'],
  gender: json['gender'],
  dob: json['dob'],
  bvn: json['bvn'],
  nin: json['nin'],
  bankName: json['bank_name'],
  accountNumber: json['account_number'],
  accountName: json['account_name'],
  vAccountNum1: json['v_account_num_1'],
  vAccountName1: json['v_account_name_1'],
  vAccountBank1: json['v_account_bank_1'],
  vAccountNum2: json['v_account_num_2'],
  vAccountNum3: json['v_account_num_3'],
  vAccountName2: json['v_account_name_2'],
  vAccountName3: json['v_account_name_3'],
  vAccountBank2: json['v_account_bank_2'],
  vAccountBank3: json['v_account_bank_3'],
  status: json['status'] as String?,
  currentSessionId: json['current_session_id'] as String?,
  transactionSessionId: json['transaction_session_id'],
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$DataToJson(_Data instance) => <String, dynamic>{
  'id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'name': instance.name,
  'username': instance.username,
  'email': instance.email,
  'phone': instance.phone,
  'user_type': instance.userType,
  'email_verified_at': instance.emailVerifiedAt,
  'pin': instance.pin,
  'address': instance.address,
  'otp': instance.otp,
  'gender': instance.gender,
  'dob': instance.dob,
  'bvn': instance.bvn,
  'nin': instance.nin,
  'bank_name': instance.bankName,
  'account_number': instance.accountNumber,
  'account_name': instance.accountName,
  'v_account_num_1': instance.vAccountNum1,
  'v_account_name_1': instance.vAccountName1,
  'v_account_bank_1': instance.vAccountBank1,
  'v_account_num_2': instance.vAccountNum2,
  'v_account_num_3': instance.vAccountNum3,
  'v_account_name_2': instance.vAccountName2,
  'v_account_name_3': instance.vAccountName3,
  'v_account_bank_2': instance.vAccountBank2,
  'v_account_bank_3': instance.vAccountBank3,
  'status': instance.status,
  'current_session_id': instance.currentSessionId,
  'transaction_session_id': instance.transactionSessionId,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};
