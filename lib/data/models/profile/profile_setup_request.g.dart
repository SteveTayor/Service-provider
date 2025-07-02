// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_setup_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileSetupRequestImpl _$$ProfileSetupRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ProfileSetupRequestImpl(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      address: json['address'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$ProfileSetupRequestImplToJson(
        _$ProfileSetupRequestImpl instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'address': instance.address,
      'date_of_birth': instance.dateOfBirth,
      'gender': instance.gender,
      'email': instance.email,
    };
