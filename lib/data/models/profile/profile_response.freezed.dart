// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) {
  return _ProfileResponse.fromJson(json);
}

/// @nodoc
mixin _$ProfileResponse {
  @JsonKey(name: "status")
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: "data")
  Data? get data => throw _privateConstructorUsedError;
  @JsonKey(name: "message")
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this ProfileResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileResponseCopyWith<ProfileResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileResponseCopyWith<$Res> {
  factory $ProfileResponseCopyWith(
          ProfileResponse value, $Res Function(ProfileResponse) then) =
      _$ProfileResponseCopyWithImpl<$Res, ProfileResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: "status") String? status,
      @JsonKey(name: "data") Data? data,
      @JsonKey(name: "message") String? message});

  $DataCopyWith<$Res>? get data;
}

/// @nodoc
class _$ProfileResponseCopyWithImpl<$Res, $Val extends ProfileResponse>
    implements $ProfileResponseCopyWith<$Res> {
  _$ProfileResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Data?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of ProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $DataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProfileResponseImplCopyWith<$Res>
    implements $ProfileResponseCopyWith<$Res> {
  factory _$$ProfileResponseImplCopyWith(_$ProfileResponseImpl value,
          $Res Function(_$ProfileResponseImpl) then) =
      __$$ProfileResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "status") String? status,
      @JsonKey(name: "data") Data? data,
      @JsonKey(name: "message") String? message});

  @override
  $DataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$ProfileResponseImplCopyWithImpl<$Res>
    extends _$ProfileResponseCopyWithImpl<$Res, _$ProfileResponseImpl>
    implements _$$ProfileResponseImplCopyWith<$Res> {
  __$$ProfileResponseImplCopyWithImpl(
      _$ProfileResponseImpl _value, $Res Function(_$ProfileResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_$ProfileResponseImpl(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Data?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileResponseImpl implements _ProfileResponse {
  const _$ProfileResponseImpl(
      {@JsonKey(name: "status") this.status,
      @JsonKey(name: "data") this.data,
      @JsonKey(name: "message") this.message});

  factory _$ProfileResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileResponseImplFromJson(json);

  @override
  @JsonKey(name: "status")
  final String? status;
  @override
  @JsonKey(name: "data")
  final Data? data;
  @override
  @JsonKey(name: "message")
  final String? message;

  @override
  String toString() {
    return 'ProfileResponse(status: $status, data: $data, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, data, message);

  /// Create a copy of ProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileResponseImplCopyWith<_$ProfileResponseImpl> get copyWith =>
      __$$ProfileResponseImplCopyWithImpl<_$ProfileResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileResponseImplToJson(
      this,
    );
  }
}

abstract class _ProfileResponse implements ProfileResponse {
  const factory _ProfileResponse(
      {@JsonKey(name: "status") final String? status,
      @JsonKey(name: "data") final Data? data,
      @JsonKey(name: "message") final String? message}) = _$ProfileResponseImpl;

  factory _ProfileResponse.fromJson(Map<String, dynamic> json) =
      _$ProfileResponseImpl.fromJson;

  @override
  @JsonKey(name: "status")
  String? get status;
  @override
  @JsonKey(name: "data")
  Data? get data;
  @override
  @JsonKey(name: "message")
  String? get message;

  /// Create a copy of ProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileResponseImplCopyWith<_$ProfileResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Data _$DataFromJson(Map<String, dynamic> json) {
  return _Data.fromJson(json);
}

/// @nodoc
mixin _$Data {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "first_name")
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: "last_name")
  String? get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: "username")
  String? get username => throw _privateConstructorUsedError;
  @JsonKey(name: "email")
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: "phone")
  String? get phone => throw _privateConstructorUsedError;
  @JsonKey(name: "user_type")
  String? get userType => throw _privateConstructorUsedError;
  @JsonKey(name: "email_verified_at")
  dynamic get emailVerifiedAt => throw _privateConstructorUsedError;
  @JsonKey(name: "pin")
  dynamic get pin => throw _privateConstructorUsedError;
  @JsonKey(name: "address")
  dynamic get address => throw _privateConstructorUsedError;
  @JsonKey(name: "otp")
  dynamic get otp => throw _privateConstructorUsedError;
  @JsonKey(name: "gender")
  dynamic get gender => throw _privateConstructorUsedError;
  @JsonKey(name: "dob")
  dynamic get dob => throw _privateConstructorUsedError;
  @JsonKey(name: "bvn")
  dynamic get bvn => throw _privateConstructorUsedError;
  @JsonKey(name: "nin")
  dynamic get nin => throw _privateConstructorUsedError;
  @JsonKey(name: "bank_name")
  dynamic get bankName => throw _privateConstructorUsedError;
  @JsonKey(name: "account_number")
  dynamic get accountNumber => throw _privateConstructorUsedError;
  @JsonKey(name: "account_name")
  dynamic get accountName => throw _privateConstructorUsedError;
  @JsonKey(name: "v_account_num_1")
  dynamic get vAccountNum1 => throw _privateConstructorUsedError;
  @JsonKey(name: "v_account_name_1")
  dynamic get vAccountName1 => throw _privateConstructorUsedError;
  @JsonKey(name: "v_account_bank_1")
  dynamic get vAccountBank1 => throw _privateConstructorUsedError;
  @JsonKey(name: "v_account_num_2")
  dynamic get vAccountNum2 => throw _privateConstructorUsedError;
  @JsonKey(name: "v_account_num_3")
  dynamic get vAccountNum3 => throw _privateConstructorUsedError;
  @JsonKey(name: "v_account_name_2")
  dynamic get vAccountName2 => throw _privateConstructorUsedError;
  @JsonKey(name: "v_account_name_3")
  dynamic get vAccountName3 => throw _privateConstructorUsedError;
  @JsonKey(name: "v_account_bank_2")
  dynamic get vAccountBank2 => throw _privateConstructorUsedError;
  @JsonKey(name: "v_account_bank_3")
  dynamic get vAccountBank3 => throw _privateConstructorUsedError;
  @JsonKey(name: "status")
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: "current_session_id")
  String? get currentSessionId => throw _privateConstructorUsedError;
  @JsonKey(name: "transaction_session_id")
  dynamic get transactionSessionId => throw _privateConstructorUsedError;
  @JsonKey(name: "created_at")
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "updated_at")
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Data to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Data
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DataCopyWith<Data> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataCopyWith<$Res> {
  factory $DataCopyWith(Data value, $Res Function(Data) then) =
      _$DataCopyWithImpl<$Res, Data>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "first_name") String? firstName,
      @JsonKey(name: "last_name") String? lastName,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "username") String? username,
      @JsonKey(name: "email") String? email,
      @JsonKey(name: "phone") String? phone,
      @JsonKey(name: "user_type") String? userType,
      @JsonKey(name: "email_verified_at") dynamic emailVerifiedAt,
      @JsonKey(name: "pin") dynamic pin,
      @JsonKey(name: "address") dynamic address,
      @JsonKey(name: "otp") dynamic otp,
      @JsonKey(name: "gender") dynamic gender,
      @JsonKey(name: "dob") dynamic dob,
      @JsonKey(name: "bvn") dynamic bvn,
      @JsonKey(name: "nin") dynamic nin,
      @JsonKey(name: "bank_name") dynamic bankName,
      @JsonKey(name: "account_number") dynamic accountNumber,
      @JsonKey(name: "account_name") dynamic accountName,
      @JsonKey(name: "v_account_num_1") dynamic vAccountNum1,
      @JsonKey(name: "v_account_name_1") dynamic vAccountName1,
      @JsonKey(name: "v_account_bank_1") dynamic vAccountBank1,
      @JsonKey(name: "v_account_num_2") dynamic vAccountNum2,
      @JsonKey(name: "v_account_num_3") dynamic vAccountNum3,
      @JsonKey(name: "v_account_name_2") dynamic vAccountName2,
      @JsonKey(name: "v_account_name_3") dynamic vAccountName3,
      @JsonKey(name: "v_account_bank_2") dynamic vAccountBank2,
      @JsonKey(name: "v_account_bank_3") dynamic vAccountBank3,
      @JsonKey(name: "status") String? status,
      @JsonKey(name: "current_session_id") String? currentSessionId,
      @JsonKey(name: "transaction_session_id") dynamic transactionSessionId,
      @JsonKey(name: "created_at") DateTime? createdAt,
      @JsonKey(name: "updated_at") DateTime? updatedAt});
}

/// @nodoc
class _$DataCopyWithImpl<$Res, $Val extends Data>
    implements $DataCopyWith<$Res> {
  _$DataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Data
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? name = freezed,
    Object? username = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? userType = freezed,
    Object? emailVerifiedAt = freezed,
    Object? pin = freezed,
    Object? address = freezed,
    Object? otp = freezed,
    Object? gender = freezed,
    Object? dob = freezed,
    Object? bvn = freezed,
    Object? nin = freezed,
    Object? bankName = freezed,
    Object? accountNumber = freezed,
    Object? accountName = freezed,
    Object? vAccountNum1 = freezed,
    Object? vAccountName1 = freezed,
    Object? vAccountBank1 = freezed,
    Object? vAccountNum2 = freezed,
    Object? vAccountNum3 = freezed,
    Object? vAccountName2 = freezed,
    Object? vAccountName3 = freezed,
    Object? vAccountBank2 = freezed,
    Object? vAccountBank3 = freezed,
    Object? status = freezed,
    Object? currentSessionId = freezed,
    Object? transactionSessionId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
      emailVerifiedAt: freezed == emailVerifiedAt
          ? _value.emailVerifiedAt
          : emailVerifiedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      pin: freezed == pin
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as dynamic,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as dynamic,
      otp: freezed == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as dynamic,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as dynamic,
      dob: freezed == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as dynamic,
      bvn: freezed == bvn
          ? _value.bvn
          : bvn // ignore: cast_nullable_to_non_nullable
              as dynamic,
      nin: freezed == nin
          ? _value.nin
          : nin // ignore: cast_nullable_to_non_nullable
              as dynamic,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      accountNumber: freezed == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as dynamic,
      accountName: freezed == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      vAccountNum1: freezed == vAccountNum1
          ? _value.vAccountNum1
          : vAccountNum1 // ignore: cast_nullable_to_non_nullable
              as dynamic,
      vAccountName1: freezed == vAccountName1
          ? _value.vAccountName1
          : vAccountName1 // ignore: cast_nullable_to_non_nullable
              as dynamic,
      vAccountBank1: freezed == vAccountBank1
          ? _value.vAccountBank1
          : vAccountBank1 // ignore: cast_nullable_to_non_nullable
              as dynamic,
      vAccountNum2: freezed == vAccountNum2
          ? _value.vAccountNum2
          : vAccountNum2 // ignore: cast_nullable_to_non_nullable
              as dynamic,
      vAccountNum3: freezed == vAccountNum3
          ? _value.vAccountNum3
          : vAccountNum3 // ignore: cast_nullable_to_non_nullable
              as dynamic,
      vAccountName2: freezed == vAccountName2
          ? _value.vAccountName2
          : vAccountName2 // ignore: cast_nullable_to_non_nullable
              as dynamic,
      vAccountName3: freezed == vAccountName3
          ? _value.vAccountName3
          : vAccountName3 // ignore: cast_nullable_to_non_nullable
              as dynamic,
      vAccountBank2: freezed == vAccountBank2
          ? _value.vAccountBank2
          : vAccountBank2 // ignore: cast_nullable_to_non_nullable
              as dynamic,
      vAccountBank3: freezed == vAccountBank3
          ? _value.vAccountBank3
          : vAccountBank3 // ignore: cast_nullable_to_non_nullable
              as dynamic,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      currentSessionId: freezed == currentSessionId
          ? _value.currentSessionId
          : currentSessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionSessionId: freezed == transactionSessionId
          ? _value.transactionSessionId
          : transactionSessionId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataImplCopyWith<$Res> implements $DataCopyWith<$Res> {
  factory _$$DataImplCopyWith(
          _$DataImpl value, $Res Function(_$DataImpl) then) =
      __$$DataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "first_name") String? firstName,
      @JsonKey(name: "last_name") String? lastName,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "username") String? username,
      @JsonKey(name: "email") String? email,
      @JsonKey(name: "phone") String? phone,
      @JsonKey(name: "user_type") String? userType,
      @JsonKey(name: "email_verified_at") dynamic emailVerifiedAt,
      @JsonKey(name: "pin") dynamic pin,
      @JsonKey(name: "address") dynamic address,
      @JsonKey(name: "otp") dynamic otp,
      @JsonKey(name: "gender") dynamic gender,
      @JsonKey(name: "dob") dynamic dob,
      @JsonKey(name: "bvn") dynamic bvn,
      @JsonKey(name: "nin") dynamic nin,
      @JsonKey(name: "bank_name") dynamic bankName,
      @JsonKey(name: "account_number") dynamic accountNumber,
      @JsonKey(name: "account_name") dynamic accountName,
      @JsonKey(name: "v_account_num_1") dynamic vAccountNum1,
      @JsonKey(name: "v_account_name_1") dynamic vAccountName1,
      @JsonKey(name: "v_account_bank_1") dynamic vAccountBank1,
      @JsonKey(name: "v_account_num_2") dynamic vAccountNum2,
      @JsonKey(name: "v_account_num_3") dynamic vAccountNum3,
      @JsonKey(name: "v_account_name_2") dynamic vAccountName2,
      @JsonKey(name: "v_account_name_3") dynamic vAccountName3,
      @JsonKey(name: "v_account_bank_2") dynamic vAccountBank2,
      @JsonKey(name: "v_account_bank_3") dynamic vAccountBank3,
      @JsonKey(name: "status") String? status,
      @JsonKey(name: "current_session_id") String? currentSessionId,
      @JsonKey(name: "transaction_session_id") dynamic transactionSessionId,
      @JsonKey(name: "created_at") DateTime? createdAt,
      @JsonKey(name: "updated_at") DateTime? updatedAt});
}

/// @nodoc
class __$$DataImplCopyWithImpl<$Res>
    extends _$DataCopyWithImpl<$Res, _$DataImpl>
    implements _$$DataImplCopyWith<$Res> {
  __$$DataImplCopyWithImpl(_$DataImpl _value, $Res Function(_$DataImpl) _then)
      : super(_value, _then);

  /// Create a copy of Data
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? name = freezed,
    Object? username = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? userType = freezed,
    Object? emailVerifiedAt = freezed,
    Object? pin = freezed,
    Object? address = freezed,
    Object? otp = freezed,
    Object? gender = freezed,
    Object? dob = freezed,
    Object? bvn = freezed,
    Object? nin = freezed,
    Object? bankName = freezed,
    Object? accountNumber = freezed,
    Object? accountName = freezed,
    Object? vAccountNum1 = freezed,
    Object? vAccountName1 = freezed,
    Object? vAccountBank1 = freezed,
    Object? vAccountNum2 = freezed,
    Object? vAccountNum3 = freezed,
    Object? vAccountName2 = freezed,
    Object? vAccountName3 = freezed,
    Object? vAccountBank2 = freezed,
    Object? vAccountBank3 = freezed,
    Object? status = freezed,
    Object? currentSessionId = freezed,
    Object? transactionSessionId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$DataImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
      emailVerifiedAt: freezed == emailVerifiedAt
          ? _value.emailVerifiedAt
          : emailVerifiedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      pin: freezed == pin
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as dynamic,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as dynamic,
      otp: freezed == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as dynamic,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as dynamic,
      dob: freezed == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as dynamic,
      bvn: freezed == bvn
          ? _value.bvn
          : bvn // ignore: cast_nullable_to_non_nullable
              as dynamic,
      nin: freezed == nin
          ? _value.nin
          : nin // ignore: cast_nullable_to_non_nullable
              as dynamic,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      accountNumber: freezed == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as dynamic,
      accountName: freezed == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      vAccountNum1: freezed == vAccountNum1
          ? _value.vAccountNum1
          : vAccountNum1 // ignore: cast_nullable_to_non_nullable
              as dynamic,
      vAccountName1: freezed == vAccountName1
          ? _value.vAccountName1
          : vAccountName1 // ignore: cast_nullable_to_non_nullable
              as dynamic,
      vAccountBank1: freezed == vAccountBank1
          ? _value.vAccountBank1
          : vAccountBank1 // ignore: cast_nullable_to_non_nullable
              as dynamic,
      vAccountNum2: freezed == vAccountNum2
          ? _value.vAccountNum2
          : vAccountNum2 // ignore: cast_nullable_to_non_nullable
              as dynamic,
      vAccountNum3: freezed == vAccountNum3
          ? _value.vAccountNum3
          : vAccountNum3 // ignore: cast_nullable_to_non_nullable
              as dynamic,
      vAccountName2: freezed == vAccountName2
          ? _value.vAccountName2
          : vAccountName2 // ignore: cast_nullable_to_non_nullable
              as dynamic,
      vAccountName3: freezed == vAccountName3
          ? _value.vAccountName3
          : vAccountName3 // ignore: cast_nullable_to_non_nullable
              as dynamic,
      vAccountBank2: freezed == vAccountBank2
          ? _value.vAccountBank2
          : vAccountBank2 // ignore: cast_nullable_to_non_nullable
              as dynamic,
      vAccountBank3: freezed == vAccountBank3
          ? _value.vAccountBank3
          : vAccountBank3 // ignore: cast_nullable_to_non_nullable
              as dynamic,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      currentSessionId: freezed == currentSessionId
          ? _value.currentSessionId
          : currentSessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionSessionId: freezed == transactionSessionId
          ? _value.transactionSessionId
          : transactionSessionId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DataImpl implements _Data {
  const _$DataImpl(
      {@JsonKey(name: "id") this.id,
      @JsonKey(name: "first_name") this.firstName,
      @JsonKey(name: "last_name") this.lastName,
      @JsonKey(name: "name") this.name,
      @JsonKey(name: "username") this.username,
      @JsonKey(name: "email") this.email,
      @JsonKey(name: "phone") this.phone,
      @JsonKey(name: "user_type") this.userType,
      @JsonKey(name: "email_verified_at") this.emailVerifiedAt,
      @JsonKey(name: "pin") this.pin,
      @JsonKey(name: "address") this.address,
      @JsonKey(name: "otp") this.otp,
      @JsonKey(name: "gender") this.gender,
      @JsonKey(name: "dob") this.dob,
      @JsonKey(name: "bvn") this.bvn,
      @JsonKey(name: "nin") this.nin,
      @JsonKey(name: "bank_name") this.bankName,
      @JsonKey(name: "account_number") this.accountNumber,
      @JsonKey(name: "account_name") this.accountName,
      @JsonKey(name: "v_account_num_1") this.vAccountNum1,
      @JsonKey(name: "v_account_name_1") this.vAccountName1,
      @JsonKey(name: "v_account_bank_1") this.vAccountBank1,
      @JsonKey(name: "v_account_num_2") this.vAccountNum2,
      @JsonKey(name: "v_account_num_3") this.vAccountNum3,
      @JsonKey(name: "v_account_name_2") this.vAccountName2,
      @JsonKey(name: "v_account_name_3") this.vAccountName3,
      @JsonKey(name: "v_account_bank_2") this.vAccountBank2,
      @JsonKey(name: "v_account_bank_3") this.vAccountBank3,
      @JsonKey(name: "status") this.status,
      @JsonKey(name: "current_session_id") this.currentSessionId,
      @JsonKey(name: "transaction_session_id") this.transactionSessionId,
      @JsonKey(name: "created_at") this.createdAt,
      @JsonKey(name: "updated_at") this.updatedAt});

  factory _$DataImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int? id;
  @override
  @JsonKey(name: "first_name")
  final String? firstName;
  @override
  @JsonKey(name: "last_name")
  final String? lastName;
  @override
  @JsonKey(name: "name")
  final String? name;
  @override
  @JsonKey(name: "username")
  final String? username;
  @override
  @JsonKey(name: "email")
  final String? email;
  @override
  @JsonKey(name: "phone")
  final String? phone;
  @override
  @JsonKey(name: "user_type")
  final String? userType;
  @override
  @JsonKey(name: "email_verified_at")
  final dynamic emailVerifiedAt;
  @override
  @JsonKey(name: "pin")
  final dynamic pin;
  @override
  @JsonKey(name: "address")
  final dynamic address;
  @override
  @JsonKey(name: "otp")
  final dynamic otp;
  @override
  @JsonKey(name: "gender")
  final dynamic gender;
  @override
  @JsonKey(name: "dob")
  final dynamic dob;
  @override
  @JsonKey(name: "bvn")
  final dynamic bvn;
  @override
  @JsonKey(name: "nin")
  final dynamic nin;
  @override
  @JsonKey(name: "bank_name")
  final dynamic bankName;
  @override
  @JsonKey(name: "account_number")
  final dynamic accountNumber;
  @override
  @JsonKey(name: "account_name")
  final dynamic accountName;
  @override
  @JsonKey(name: "v_account_num_1")
  final dynamic vAccountNum1;
  @override
  @JsonKey(name: "v_account_name_1")
  final dynamic vAccountName1;
  @override
  @JsonKey(name: "v_account_bank_1")
  final dynamic vAccountBank1;
  @override
  @JsonKey(name: "v_account_num_2")
  final dynamic vAccountNum2;
  @override
  @JsonKey(name: "v_account_num_3")
  final dynamic vAccountNum3;
  @override
  @JsonKey(name: "v_account_name_2")
  final dynamic vAccountName2;
  @override
  @JsonKey(name: "v_account_name_3")
  final dynamic vAccountName3;
  @override
  @JsonKey(name: "v_account_bank_2")
  final dynamic vAccountBank2;
  @override
  @JsonKey(name: "v_account_bank_3")
  final dynamic vAccountBank3;
  @override
  @JsonKey(name: "status")
  final String? status;
  @override
  @JsonKey(name: "current_session_id")
  final String? currentSessionId;
  @override
  @JsonKey(name: "transaction_session_id")
  final dynamic transactionSessionId;
  @override
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @override
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Data(id: $id, firstName: $firstName, lastName: $lastName, name: $name, username: $username, email: $email, phone: $phone, userType: $userType, emailVerifiedAt: $emailVerifiedAt, pin: $pin, address: $address, otp: $otp, gender: $gender, dob: $dob, bvn: $bvn, nin: $nin, bankName: $bankName, accountNumber: $accountNumber, accountName: $accountName, vAccountNum1: $vAccountNum1, vAccountName1: $vAccountName1, vAccountBank1: $vAccountBank1, vAccountNum2: $vAccountNum2, vAccountNum3: $vAccountNum3, vAccountName2: $vAccountName2, vAccountName3: $vAccountName3, vAccountBank2: $vAccountBank2, vAccountBank3: $vAccountBank3, status: $status, currentSessionId: $currentSessionId, transactionSessionId: $transactionSessionId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            const DeepCollectionEquality()
                .equals(other.emailVerifiedAt, emailVerifiedAt) &&
            const DeepCollectionEquality().equals(other.pin, pin) &&
            const DeepCollectionEquality().equals(other.address, address) &&
            const DeepCollectionEquality().equals(other.otp, otp) &&
            const DeepCollectionEquality().equals(other.gender, gender) &&
            const DeepCollectionEquality().equals(other.dob, dob) &&
            const DeepCollectionEquality().equals(other.bvn, bvn) &&
            const DeepCollectionEquality().equals(other.nin, nin) &&
            const DeepCollectionEquality().equals(other.bankName, bankName) &&
            const DeepCollectionEquality()
                .equals(other.accountNumber, accountNumber) &&
            const DeepCollectionEquality()
                .equals(other.accountName, accountName) &&
            const DeepCollectionEquality()
                .equals(other.vAccountNum1, vAccountNum1) &&
            const DeepCollectionEquality()
                .equals(other.vAccountName1, vAccountName1) &&
            const DeepCollectionEquality()
                .equals(other.vAccountBank1, vAccountBank1) &&
            const DeepCollectionEquality()
                .equals(other.vAccountNum2, vAccountNum2) &&
            const DeepCollectionEquality()
                .equals(other.vAccountNum3, vAccountNum3) &&
            const DeepCollectionEquality()
                .equals(other.vAccountName2, vAccountName2) &&
            const DeepCollectionEquality()
                .equals(other.vAccountName3, vAccountName3) &&
            const DeepCollectionEquality()
                .equals(other.vAccountBank2, vAccountBank2) &&
            const DeepCollectionEquality()
                .equals(other.vAccountBank3, vAccountBank3) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.currentSessionId, currentSessionId) ||
                other.currentSessionId == currentSessionId) &&
            const DeepCollectionEquality()
                .equals(other.transactionSessionId, transactionSessionId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        firstName,
        lastName,
        name,
        username,
        email,
        phone,
        userType,
        const DeepCollectionEquality().hash(emailVerifiedAt),
        const DeepCollectionEquality().hash(pin),
        const DeepCollectionEquality().hash(address),
        const DeepCollectionEquality().hash(otp),
        const DeepCollectionEquality().hash(gender),
        const DeepCollectionEquality().hash(dob),
        const DeepCollectionEquality().hash(bvn),
        const DeepCollectionEquality().hash(nin),
        const DeepCollectionEquality().hash(bankName),
        const DeepCollectionEquality().hash(accountNumber),
        const DeepCollectionEquality().hash(accountName),
        const DeepCollectionEquality().hash(vAccountNum1),
        const DeepCollectionEquality().hash(vAccountName1),
        const DeepCollectionEquality().hash(vAccountBank1),
        const DeepCollectionEquality().hash(vAccountNum2),
        const DeepCollectionEquality().hash(vAccountNum3),
        const DeepCollectionEquality().hash(vAccountName2),
        const DeepCollectionEquality().hash(vAccountName3),
        const DeepCollectionEquality().hash(vAccountBank2),
        const DeepCollectionEquality().hash(vAccountBank3),
        status,
        currentSessionId,
        const DeepCollectionEquality().hash(transactionSessionId),
        createdAt,
        updatedAt
      ]);

  /// Create a copy of Data
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DataImplCopyWith<_$DataImpl> get copyWith =>
      __$$DataImplCopyWithImpl<_$DataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataImplToJson(
      this,
    );
  }
}

abstract class _Data implements Data {
  const factory _Data(
      {@JsonKey(name: "id") final int? id,
      @JsonKey(name: "first_name") final String? firstName,
      @JsonKey(name: "last_name") final String? lastName,
      @JsonKey(name: "name") final String? name,
      @JsonKey(name: "username") final String? username,
      @JsonKey(name: "email") final String? email,
      @JsonKey(name: "phone") final String? phone,
      @JsonKey(name: "user_type") final String? userType,
      @JsonKey(name: "email_verified_at") final dynamic emailVerifiedAt,
      @JsonKey(name: "pin") final dynamic pin,
      @JsonKey(name: "address") final dynamic address,
      @JsonKey(name: "otp") final dynamic otp,
      @JsonKey(name: "gender") final dynamic gender,
      @JsonKey(name: "dob") final dynamic dob,
      @JsonKey(name: "bvn") final dynamic bvn,
      @JsonKey(name: "nin") final dynamic nin,
      @JsonKey(name: "bank_name") final dynamic bankName,
      @JsonKey(name: "account_number") final dynamic accountNumber,
      @JsonKey(name: "account_name") final dynamic accountName,
      @JsonKey(name: "v_account_num_1") final dynamic vAccountNum1,
      @JsonKey(name: "v_account_name_1") final dynamic vAccountName1,
      @JsonKey(name: "v_account_bank_1") final dynamic vAccountBank1,
      @JsonKey(name: "v_account_num_2") final dynamic vAccountNum2,
      @JsonKey(name: "v_account_num_3") final dynamic vAccountNum3,
      @JsonKey(name: "v_account_name_2") final dynamic vAccountName2,
      @JsonKey(name: "v_account_name_3") final dynamic vAccountName3,
      @JsonKey(name: "v_account_bank_2") final dynamic vAccountBank2,
      @JsonKey(name: "v_account_bank_3") final dynamic vAccountBank3,
      @JsonKey(name: "status") final String? status,
      @JsonKey(name: "current_session_id") final String? currentSessionId,
      @JsonKey(name: "transaction_session_id")
      final dynamic transactionSessionId,
      @JsonKey(name: "created_at") final DateTime? createdAt,
      @JsonKey(name: "updated_at") final DateTime? updatedAt}) = _$DataImpl;

  factory _Data.fromJson(Map<String, dynamic> json) = _$DataImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @override
  @JsonKey(name: "first_name")
  String? get firstName;
  @override
  @JsonKey(name: "last_name")
  String? get lastName;
  @override
  @JsonKey(name: "name")
  String? get name;
  @override
  @JsonKey(name: "username")
  String? get username;
  @override
  @JsonKey(name: "email")
  String? get email;
  @override
  @JsonKey(name: "phone")
  String? get phone;
  @override
  @JsonKey(name: "user_type")
  String? get userType;
  @override
  @JsonKey(name: "email_verified_at")
  dynamic get emailVerifiedAt;
  @override
  @JsonKey(name: "pin")
  dynamic get pin;
  @override
  @JsonKey(name: "address")
  dynamic get address;
  @override
  @JsonKey(name: "otp")
  dynamic get otp;
  @override
  @JsonKey(name: "gender")
  dynamic get gender;
  @override
  @JsonKey(name: "dob")
  dynamic get dob;
  @override
  @JsonKey(name: "bvn")
  dynamic get bvn;
  @override
  @JsonKey(name: "nin")
  dynamic get nin;
  @override
  @JsonKey(name: "bank_name")
  dynamic get bankName;
  @override
  @JsonKey(name: "account_number")
  dynamic get accountNumber;
  @override
  @JsonKey(name: "account_name")
  dynamic get accountName;
  @override
  @JsonKey(name: "v_account_num_1")
  dynamic get vAccountNum1;
  @override
  @JsonKey(name: "v_account_name_1")
  dynamic get vAccountName1;
  @override
  @JsonKey(name: "v_account_bank_1")
  dynamic get vAccountBank1;
  @override
  @JsonKey(name: "v_account_num_2")
  dynamic get vAccountNum2;
  @override
  @JsonKey(name: "v_account_num_3")
  dynamic get vAccountNum3;
  @override
  @JsonKey(name: "v_account_name_2")
  dynamic get vAccountName2;
  @override
  @JsonKey(name: "v_account_name_3")
  dynamic get vAccountName3;
  @override
  @JsonKey(name: "v_account_bank_2")
  dynamic get vAccountBank2;
  @override
  @JsonKey(name: "v_account_bank_3")
  dynamic get vAccountBank3;
  @override
  @JsonKey(name: "status")
  String? get status;
  @override
  @JsonKey(name: "current_session_id")
  String? get currentSessionId;
  @override
  @JsonKey(name: "transaction_session_id")
  dynamic get transactionSessionId;
  @override
  @JsonKey(name: "created_at")
  DateTime? get createdAt;
  @override
  @JsonKey(name: "updated_at")
  DateTime? get updatedAt;

  /// Create a copy of Data
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DataImplCopyWith<_$DataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
