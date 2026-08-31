// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileResponse {

@JsonKey(name: "status") String? get status;@JsonKey(name: "data") Data? get data;@JsonKey(name: "message") String? get message;
/// Create a copy of ProfileResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileResponseCopyWith<ProfileResponse> get copyWith => _$ProfileResponseCopyWithImpl<ProfileResponse>(this as ProfileResponse, _$identity);

  /// Serializes this ProfileResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.data, data) || other.data == data)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,data,message);

@override
String toString() {
  return 'ProfileResponse(status: $status, data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class $ProfileResponseCopyWith<$Res>  {
  factory $ProfileResponseCopyWith(ProfileResponse value, $Res Function(ProfileResponse) _then) = _$ProfileResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "status") String? status,@JsonKey(name: "data") Data? data,@JsonKey(name: "message") String? message
});


$DataCopyWith<$Res>? get data;

}
/// @nodoc
class _$ProfileResponseCopyWithImpl<$Res>
    implements $ProfileResponseCopyWith<$Res> {
  _$ProfileResponseCopyWithImpl(this._self, this._then);

  final ProfileResponse _self;
  final $Res Function(ProfileResponse) _then;

/// Create a copy of ProfileResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? data = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $DataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfileResponse].
extension ProfileResponsePatterns on ProfileResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileResponse value)  $default,){
final _that = this;
switch (_that) {
case _ProfileResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  Data? data, @JsonKey(name: "message")  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileResponse() when $default != null:
return $default(_that.status,_that.data,_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  Data? data, @JsonKey(name: "message")  String? message)  $default,) {final _that = this;
switch (_that) {
case _ProfileResponse():
return $default(_that.status,_that.data,_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  Data? data, @JsonKey(name: "message")  String? message)?  $default,) {final _that = this;
switch (_that) {
case _ProfileResponse() when $default != null:
return $default(_that.status,_that.data,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileResponse implements ProfileResponse {
  const _ProfileResponse({@JsonKey(name: "status") this.status, @JsonKey(name: "data") this.data, @JsonKey(name: "message") this.message});
  factory _ProfileResponse.fromJson(Map<String, dynamic> json) => _$ProfileResponseFromJson(json);

@override@JsonKey(name: "status") final  String? status;
@override@JsonKey(name: "data") final  Data? data;
@override@JsonKey(name: "message") final  String? message;

/// Create a copy of ProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileResponseCopyWith<_ProfileResponse> get copyWith => __$ProfileResponseCopyWithImpl<_ProfileResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.data, data) || other.data == data)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,data,message);

@override
String toString() {
  return 'ProfileResponse(status: $status, data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ProfileResponseCopyWith<$Res> implements $ProfileResponseCopyWith<$Res> {
  factory _$ProfileResponseCopyWith(_ProfileResponse value, $Res Function(_ProfileResponse) _then) = __$ProfileResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "status") String? status,@JsonKey(name: "data") Data? data,@JsonKey(name: "message") String? message
});


@override $DataCopyWith<$Res>? get data;

}
/// @nodoc
class __$ProfileResponseCopyWithImpl<$Res>
    implements _$ProfileResponseCopyWith<$Res> {
  __$ProfileResponseCopyWithImpl(this._self, this._then);

  final _ProfileResponse _self;
  final $Res Function(_ProfileResponse) _then;

/// Create a copy of ProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? data = freezed,Object? message = freezed,}) {
  return _then(_ProfileResponse(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $DataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$Data {

@JsonKey(name: "id") int? get id;@JsonKey(name: "first_name") String? get firstName;@JsonKey(name: "last_name") String? get lastName;@JsonKey(name: "name") String? get name;@JsonKey(name: "username") String? get username;@JsonKey(name: "email") String? get email;@JsonKey(name: "phone") String? get phone;@JsonKey(name: "user_type") String? get userType;@JsonKey(name: "email_verified_at") dynamic get emailVerifiedAt;@JsonKey(name: "pin") dynamic get pin;@JsonKey(name: "address") dynamic get address;@JsonKey(name: "otp") dynamic get otp;@JsonKey(name: "gender") dynamic get gender;@JsonKey(name: "dob") dynamic get dob;@JsonKey(name: "bvn") dynamic get bvn;@JsonKey(name: "has_pin") dynamic get hasPin;@JsonKey(name: "nin") dynamic get nin;@JsonKey(name: "bank_name") dynamic get bankName;@JsonKey(name: "account_number") dynamic get accountNumber;@JsonKey(name: "account_name") dynamic get accountName;@JsonKey(name: "v_account_num_1") dynamic get vAccountNum1;@JsonKey(name: "v_account_name_1") dynamic get vAccountName1;@JsonKey(name: "v_account_bank_1") dynamic get vAccountBank1;@JsonKey(name: "v_account_num_2") dynamic get vAccountNum2;@JsonKey(name: "v_account_num_3") dynamic get vAccountNum3;@JsonKey(name: "v_account_name_2") dynamic get vAccountName2;@JsonKey(name: "v_account_name_3") dynamic get vAccountName3;@JsonKey(name: "v_account_bank_2") dynamic get vAccountBank2;@JsonKey(name: "v_account_bank_3") dynamic get vAccountBank3;@JsonKey(name: "status") String? get status;@JsonKey(name: "current_session_id") String? get currentSessionId;@JsonKey(name: "transaction_session_id") dynamic get transactionSessionId;@JsonKey(name: "created_at") DateTime? get createdAt;@JsonKey(name: "updated_at") DateTime? get updatedAt;
/// Create a copy of Data
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DataCopyWith<Data> get copyWith => _$DataCopyWithImpl<Data>(this as Data, _$identity);

  /// Serializes this Data to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Data&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.name, name) || other.name == name)&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.userType, userType) || other.userType == userType)&&const DeepCollectionEquality().equals(other.emailVerifiedAt, emailVerifiedAt)&&const DeepCollectionEquality().equals(other.pin, pin)&&const DeepCollectionEquality().equals(other.address, address)&&const DeepCollectionEquality().equals(other.otp, otp)&&const DeepCollectionEquality().equals(other.gender, gender)&&const DeepCollectionEquality().equals(other.dob, dob)&&const DeepCollectionEquality().equals(other.bvn, bvn)&&const DeepCollectionEquality().equals(other.hasPin, hasPin)&&const DeepCollectionEquality().equals(other.nin, nin)&&const DeepCollectionEquality().equals(other.bankName, bankName)&&const DeepCollectionEquality().equals(other.accountNumber, accountNumber)&&const DeepCollectionEquality().equals(other.accountName, accountName)&&const DeepCollectionEquality().equals(other.vAccountNum1, vAccountNum1)&&const DeepCollectionEquality().equals(other.vAccountName1, vAccountName1)&&const DeepCollectionEquality().equals(other.vAccountBank1, vAccountBank1)&&const DeepCollectionEquality().equals(other.vAccountNum2, vAccountNum2)&&const DeepCollectionEquality().equals(other.vAccountNum3, vAccountNum3)&&const DeepCollectionEquality().equals(other.vAccountName2, vAccountName2)&&const DeepCollectionEquality().equals(other.vAccountName3, vAccountName3)&&const DeepCollectionEquality().equals(other.vAccountBank2, vAccountBank2)&&const DeepCollectionEquality().equals(other.vAccountBank3, vAccountBank3)&&(identical(other.status, status) || other.status == status)&&(identical(other.currentSessionId, currentSessionId) || other.currentSessionId == currentSessionId)&&const DeepCollectionEquality().equals(other.transactionSessionId, transactionSessionId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,firstName,lastName,name,username,email,phone,userType,const DeepCollectionEquality().hash(emailVerifiedAt),const DeepCollectionEquality().hash(pin),const DeepCollectionEquality().hash(address),const DeepCollectionEquality().hash(otp),const DeepCollectionEquality().hash(gender),const DeepCollectionEquality().hash(dob),const DeepCollectionEquality().hash(bvn),const DeepCollectionEquality().hash(hasPin),const DeepCollectionEquality().hash(nin),const DeepCollectionEquality().hash(bankName),const DeepCollectionEquality().hash(accountNumber),const DeepCollectionEquality().hash(accountName),const DeepCollectionEquality().hash(vAccountNum1),const DeepCollectionEquality().hash(vAccountName1),const DeepCollectionEquality().hash(vAccountBank1),const DeepCollectionEquality().hash(vAccountNum2),const DeepCollectionEquality().hash(vAccountNum3),const DeepCollectionEquality().hash(vAccountName2),const DeepCollectionEquality().hash(vAccountName3),const DeepCollectionEquality().hash(vAccountBank2),const DeepCollectionEquality().hash(vAccountBank3),status,currentSessionId,const DeepCollectionEquality().hash(transactionSessionId),createdAt,updatedAt]);

@override
String toString() {
  return 'Data(id: $id, firstName: $firstName, lastName: $lastName, name: $name, username: $username, email: $email, phone: $phone, userType: $userType, emailVerifiedAt: $emailVerifiedAt, pin: $pin, address: $address, otp: $otp, gender: $gender, dob: $dob, bvn: $bvn, hasPin: $hasPin, nin: $nin, bankName: $bankName, accountNumber: $accountNumber, accountName: $accountName, vAccountNum1: $vAccountNum1, vAccountName1: $vAccountName1, vAccountBank1: $vAccountBank1, vAccountNum2: $vAccountNum2, vAccountNum3: $vAccountNum3, vAccountName2: $vAccountName2, vAccountName3: $vAccountName3, vAccountBank2: $vAccountBank2, vAccountBank3: $vAccountBank3, status: $status, currentSessionId: $currentSessionId, transactionSessionId: $transactionSessionId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DataCopyWith<$Res>  {
  factory $DataCopyWith(Data value, $Res Function(Data) _then) = _$DataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "id") int? id,@JsonKey(name: "first_name") String? firstName,@JsonKey(name: "last_name") String? lastName,@JsonKey(name: "name") String? name,@JsonKey(name: "username") String? username,@JsonKey(name: "email") String? email,@JsonKey(name: "phone") String? phone,@JsonKey(name: "user_type") String? userType,@JsonKey(name: "email_verified_at") dynamic emailVerifiedAt,@JsonKey(name: "pin") dynamic pin,@JsonKey(name: "address") dynamic address,@JsonKey(name: "otp") dynamic otp,@JsonKey(name: "gender") dynamic gender,@JsonKey(name: "dob") dynamic dob,@JsonKey(name: "bvn") dynamic bvn,@JsonKey(name: "has_pin") dynamic hasPin,@JsonKey(name: "nin") dynamic nin,@JsonKey(name: "bank_name") dynamic bankName,@JsonKey(name: "account_number") dynamic accountNumber,@JsonKey(name: "account_name") dynamic accountName,@JsonKey(name: "v_account_num_1") dynamic vAccountNum1,@JsonKey(name: "v_account_name_1") dynamic vAccountName1,@JsonKey(name: "v_account_bank_1") dynamic vAccountBank1,@JsonKey(name: "v_account_num_2") dynamic vAccountNum2,@JsonKey(name: "v_account_num_3") dynamic vAccountNum3,@JsonKey(name: "v_account_name_2") dynamic vAccountName2,@JsonKey(name: "v_account_name_3") dynamic vAccountName3,@JsonKey(name: "v_account_bank_2") dynamic vAccountBank2,@JsonKey(name: "v_account_bank_3") dynamic vAccountBank3,@JsonKey(name: "status") String? status,@JsonKey(name: "current_session_id") String? currentSessionId,@JsonKey(name: "transaction_session_id") dynamic transactionSessionId,@JsonKey(name: "created_at") DateTime? createdAt,@JsonKey(name: "updated_at") DateTime? updatedAt
});




}
/// @nodoc
class _$DataCopyWithImpl<$Res>
    implements $DataCopyWith<$Res> {
  _$DataCopyWithImpl(this._self, this._then);

  final Data _self;
  final $Res Function(Data) _then;

/// Create a copy of Data
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? name = freezed,Object? username = freezed,Object? email = freezed,Object? phone = freezed,Object? userType = freezed,Object? emailVerifiedAt = freezed,Object? pin = freezed,Object? address = freezed,Object? otp = freezed,Object? gender = freezed,Object? dob = freezed,Object? bvn = freezed,Object? hasPin = freezed,Object? nin = freezed,Object? bankName = freezed,Object? accountNumber = freezed,Object? accountName = freezed,Object? vAccountNum1 = freezed,Object? vAccountName1 = freezed,Object? vAccountBank1 = freezed,Object? vAccountNum2 = freezed,Object? vAccountNum3 = freezed,Object? vAccountName2 = freezed,Object? vAccountName3 = freezed,Object? vAccountBank2 = freezed,Object? vAccountBank3 = freezed,Object? status = freezed,Object? currentSessionId = freezed,Object? transactionSessionId = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,userType: freezed == userType ? _self.userType : userType // ignore: cast_nullable_to_non_nullable
as String?,emailVerifiedAt: freezed == emailVerifiedAt ? _self.emailVerifiedAt : emailVerifiedAt // ignore: cast_nullable_to_non_nullable
as dynamic,pin: freezed == pin ? _self.pin : pin // ignore: cast_nullable_to_non_nullable
as dynamic,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as dynamic,otp: freezed == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as dynamic,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as dynamic,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as dynamic,bvn: freezed == bvn ? _self.bvn : bvn // ignore: cast_nullable_to_non_nullable
as dynamic,hasPin: freezed == hasPin ? _self.hasPin : hasPin // ignore: cast_nullable_to_non_nullable
as dynamic,nin: freezed == nin ? _self.nin : nin // ignore: cast_nullable_to_non_nullable
as dynamic,bankName: freezed == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as dynamic,accountNumber: freezed == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as dynamic,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as dynamic,vAccountNum1: freezed == vAccountNum1 ? _self.vAccountNum1 : vAccountNum1 // ignore: cast_nullable_to_non_nullable
as dynamic,vAccountName1: freezed == vAccountName1 ? _self.vAccountName1 : vAccountName1 // ignore: cast_nullable_to_non_nullable
as dynamic,vAccountBank1: freezed == vAccountBank1 ? _self.vAccountBank1 : vAccountBank1 // ignore: cast_nullable_to_non_nullable
as dynamic,vAccountNum2: freezed == vAccountNum2 ? _self.vAccountNum2 : vAccountNum2 // ignore: cast_nullable_to_non_nullable
as dynamic,vAccountNum3: freezed == vAccountNum3 ? _self.vAccountNum3 : vAccountNum3 // ignore: cast_nullable_to_non_nullable
as dynamic,vAccountName2: freezed == vAccountName2 ? _self.vAccountName2 : vAccountName2 // ignore: cast_nullable_to_non_nullable
as dynamic,vAccountName3: freezed == vAccountName3 ? _self.vAccountName3 : vAccountName3 // ignore: cast_nullable_to_non_nullable
as dynamic,vAccountBank2: freezed == vAccountBank2 ? _self.vAccountBank2 : vAccountBank2 // ignore: cast_nullable_to_non_nullable
as dynamic,vAccountBank3: freezed == vAccountBank3 ? _self.vAccountBank3 : vAccountBank3 // ignore: cast_nullable_to_non_nullable
as dynamic,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,currentSessionId: freezed == currentSessionId ? _self.currentSessionId : currentSessionId // ignore: cast_nullable_to_non_nullable
as String?,transactionSessionId: freezed == transactionSessionId ? _self.transactionSessionId : transactionSessionId // ignore: cast_nullable_to_non_nullable
as dynamic,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Data].
extension DataPatterns on Data {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Data value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Data() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Data value)  $default,){
final _that = this;
switch (_that) {
case _Data():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Data value)?  $default,){
final _that = this;
switch (_that) {
case _Data() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "id")  int? id, @JsonKey(name: "first_name")  String? firstName, @JsonKey(name: "last_name")  String? lastName, @JsonKey(name: "name")  String? name, @JsonKey(name: "username")  String? username, @JsonKey(name: "email")  String? email, @JsonKey(name: "phone")  String? phone, @JsonKey(name: "user_type")  String? userType, @JsonKey(name: "email_verified_at")  dynamic emailVerifiedAt, @JsonKey(name: "pin")  dynamic pin, @JsonKey(name: "address")  dynamic address, @JsonKey(name: "otp")  dynamic otp, @JsonKey(name: "gender")  dynamic gender, @JsonKey(name: "dob")  dynamic dob, @JsonKey(name: "bvn")  dynamic bvn, @JsonKey(name: "has_pin")  dynamic hasPin, @JsonKey(name: "nin")  dynamic nin, @JsonKey(name: "bank_name")  dynamic bankName, @JsonKey(name: "account_number")  dynamic accountNumber, @JsonKey(name: "account_name")  dynamic accountName, @JsonKey(name: "v_account_num_1")  dynamic vAccountNum1, @JsonKey(name: "v_account_name_1")  dynamic vAccountName1, @JsonKey(name: "v_account_bank_1")  dynamic vAccountBank1, @JsonKey(name: "v_account_num_2")  dynamic vAccountNum2, @JsonKey(name: "v_account_num_3")  dynamic vAccountNum3, @JsonKey(name: "v_account_name_2")  dynamic vAccountName2, @JsonKey(name: "v_account_name_3")  dynamic vAccountName3, @JsonKey(name: "v_account_bank_2")  dynamic vAccountBank2, @JsonKey(name: "v_account_bank_3")  dynamic vAccountBank3, @JsonKey(name: "status")  String? status, @JsonKey(name: "current_session_id")  String? currentSessionId, @JsonKey(name: "transaction_session_id")  dynamic transactionSessionId, @JsonKey(name: "created_at")  DateTime? createdAt, @JsonKey(name: "updated_at")  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Data() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.name,_that.username,_that.email,_that.phone,_that.userType,_that.emailVerifiedAt,_that.pin,_that.address,_that.otp,_that.gender,_that.dob,_that.bvn,_that.hasPin,_that.nin,_that.bankName,_that.accountNumber,_that.accountName,_that.vAccountNum1,_that.vAccountName1,_that.vAccountBank1,_that.vAccountNum2,_that.vAccountNum3,_that.vAccountName2,_that.vAccountName3,_that.vAccountBank2,_that.vAccountBank3,_that.status,_that.currentSessionId,_that.transactionSessionId,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "id")  int? id, @JsonKey(name: "first_name")  String? firstName, @JsonKey(name: "last_name")  String? lastName, @JsonKey(name: "name")  String? name, @JsonKey(name: "username")  String? username, @JsonKey(name: "email")  String? email, @JsonKey(name: "phone")  String? phone, @JsonKey(name: "user_type")  String? userType, @JsonKey(name: "email_verified_at")  dynamic emailVerifiedAt, @JsonKey(name: "pin")  dynamic pin, @JsonKey(name: "address")  dynamic address, @JsonKey(name: "otp")  dynamic otp, @JsonKey(name: "gender")  dynamic gender, @JsonKey(name: "dob")  dynamic dob, @JsonKey(name: "bvn")  dynamic bvn, @JsonKey(name: "has_pin")  dynamic hasPin, @JsonKey(name: "nin")  dynamic nin, @JsonKey(name: "bank_name")  dynamic bankName, @JsonKey(name: "account_number")  dynamic accountNumber, @JsonKey(name: "account_name")  dynamic accountName, @JsonKey(name: "v_account_num_1")  dynamic vAccountNum1, @JsonKey(name: "v_account_name_1")  dynamic vAccountName1, @JsonKey(name: "v_account_bank_1")  dynamic vAccountBank1, @JsonKey(name: "v_account_num_2")  dynamic vAccountNum2, @JsonKey(name: "v_account_num_3")  dynamic vAccountNum3, @JsonKey(name: "v_account_name_2")  dynamic vAccountName2, @JsonKey(name: "v_account_name_3")  dynamic vAccountName3, @JsonKey(name: "v_account_bank_2")  dynamic vAccountBank2, @JsonKey(name: "v_account_bank_3")  dynamic vAccountBank3, @JsonKey(name: "status")  String? status, @JsonKey(name: "current_session_id")  String? currentSessionId, @JsonKey(name: "transaction_session_id")  dynamic transactionSessionId, @JsonKey(name: "created_at")  DateTime? createdAt, @JsonKey(name: "updated_at")  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Data():
return $default(_that.id,_that.firstName,_that.lastName,_that.name,_that.username,_that.email,_that.phone,_that.userType,_that.emailVerifiedAt,_that.pin,_that.address,_that.otp,_that.gender,_that.dob,_that.bvn,_that.hasPin,_that.nin,_that.bankName,_that.accountNumber,_that.accountName,_that.vAccountNum1,_that.vAccountName1,_that.vAccountBank1,_that.vAccountNum2,_that.vAccountNum3,_that.vAccountName2,_that.vAccountName3,_that.vAccountBank2,_that.vAccountBank3,_that.status,_that.currentSessionId,_that.transactionSessionId,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "id")  int? id, @JsonKey(name: "first_name")  String? firstName, @JsonKey(name: "last_name")  String? lastName, @JsonKey(name: "name")  String? name, @JsonKey(name: "username")  String? username, @JsonKey(name: "email")  String? email, @JsonKey(name: "phone")  String? phone, @JsonKey(name: "user_type")  String? userType, @JsonKey(name: "email_verified_at")  dynamic emailVerifiedAt, @JsonKey(name: "pin")  dynamic pin, @JsonKey(name: "address")  dynamic address, @JsonKey(name: "otp")  dynamic otp, @JsonKey(name: "gender")  dynamic gender, @JsonKey(name: "dob")  dynamic dob, @JsonKey(name: "bvn")  dynamic bvn, @JsonKey(name: "has_pin")  dynamic hasPin, @JsonKey(name: "nin")  dynamic nin, @JsonKey(name: "bank_name")  dynamic bankName, @JsonKey(name: "account_number")  dynamic accountNumber, @JsonKey(name: "account_name")  dynamic accountName, @JsonKey(name: "v_account_num_1")  dynamic vAccountNum1, @JsonKey(name: "v_account_name_1")  dynamic vAccountName1, @JsonKey(name: "v_account_bank_1")  dynamic vAccountBank1, @JsonKey(name: "v_account_num_2")  dynamic vAccountNum2, @JsonKey(name: "v_account_num_3")  dynamic vAccountNum3, @JsonKey(name: "v_account_name_2")  dynamic vAccountName2, @JsonKey(name: "v_account_name_3")  dynamic vAccountName3, @JsonKey(name: "v_account_bank_2")  dynamic vAccountBank2, @JsonKey(name: "v_account_bank_3")  dynamic vAccountBank3, @JsonKey(name: "status")  String? status, @JsonKey(name: "current_session_id")  String? currentSessionId, @JsonKey(name: "transaction_session_id")  dynamic transactionSessionId, @JsonKey(name: "created_at")  DateTime? createdAt, @JsonKey(name: "updated_at")  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Data() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.name,_that.username,_that.email,_that.phone,_that.userType,_that.emailVerifiedAt,_that.pin,_that.address,_that.otp,_that.gender,_that.dob,_that.bvn,_that.hasPin,_that.nin,_that.bankName,_that.accountNumber,_that.accountName,_that.vAccountNum1,_that.vAccountName1,_that.vAccountBank1,_that.vAccountNum2,_that.vAccountNum3,_that.vAccountName2,_that.vAccountName3,_that.vAccountBank2,_that.vAccountBank3,_that.status,_that.currentSessionId,_that.transactionSessionId,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Data implements Data {
  const _Data({@JsonKey(name: "id") this.id, @JsonKey(name: "first_name") this.firstName, @JsonKey(name: "last_name") this.lastName, @JsonKey(name: "name") this.name, @JsonKey(name: "username") this.username, @JsonKey(name: "email") this.email, @JsonKey(name: "phone") this.phone, @JsonKey(name: "user_type") this.userType, @JsonKey(name: "email_verified_at") this.emailVerifiedAt, @JsonKey(name: "pin") this.pin, @JsonKey(name: "address") this.address, @JsonKey(name: "otp") this.otp, @JsonKey(name: "gender") this.gender, @JsonKey(name: "dob") this.dob, @JsonKey(name: "bvn") this.bvn, @JsonKey(name: "has_pin") this.hasPin, @JsonKey(name: "nin") this.nin, @JsonKey(name: "bank_name") this.bankName, @JsonKey(name: "account_number") this.accountNumber, @JsonKey(name: "account_name") this.accountName, @JsonKey(name: "v_account_num_1") this.vAccountNum1, @JsonKey(name: "v_account_name_1") this.vAccountName1, @JsonKey(name: "v_account_bank_1") this.vAccountBank1, @JsonKey(name: "v_account_num_2") this.vAccountNum2, @JsonKey(name: "v_account_num_3") this.vAccountNum3, @JsonKey(name: "v_account_name_2") this.vAccountName2, @JsonKey(name: "v_account_name_3") this.vAccountName3, @JsonKey(name: "v_account_bank_2") this.vAccountBank2, @JsonKey(name: "v_account_bank_3") this.vAccountBank3, @JsonKey(name: "status") this.status, @JsonKey(name: "current_session_id") this.currentSessionId, @JsonKey(name: "transaction_session_id") this.transactionSessionId, @JsonKey(name: "created_at") this.createdAt, @JsonKey(name: "updated_at") this.updatedAt});
  factory _Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

@override@JsonKey(name: "id") final  int? id;
@override@JsonKey(name: "first_name") final  String? firstName;
@override@JsonKey(name: "last_name") final  String? lastName;
@override@JsonKey(name: "name") final  String? name;
@override@JsonKey(name: "username") final  String? username;
@override@JsonKey(name: "email") final  String? email;
@override@JsonKey(name: "phone") final  String? phone;
@override@JsonKey(name: "user_type") final  String? userType;
@override@JsonKey(name: "email_verified_at") final  dynamic emailVerifiedAt;
@override@JsonKey(name: "pin") final  dynamic pin;
@override@JsonKey(name: "address") final  dynamic address;
@override@JsonKey(name: "otp") final  dynamic otp;
@override@JsonKey(name: "gender") final  dynamic gender;
@override@JsonKey(name: "dob") final  dynamic dob;
@override@JsonKey(name: "bvn") final  dynamic bvn;
@override@JsonKey(name: "has_pin") final  dynamic hasPin;
@override@JsonKey(name: "nin") final  dynamic nin;
@override@JsonKey(name: "bank_name") final  dynamic bankName;
@override@JsonKey(name: "account_number") final  dynamic accountNumber;
@override@JsonKey(name: "account_name") final  dynamic accountName;
@override@JsonKey(name: "v_account_num_1") final  dynamic vAccountNum1;
@override@JsonKey(name: "v_account_name_1") final  dynamic vAccountName1;
@override@JsonKey(name: "v_account_bank_1") final  dynamic vAccountBank1;
@override@JsonKey(name: "v_account_num_2") final  dynamic vAccountNum2;
@override@JsonKey(name: "v_account_num_3") final  dynamic vAccountNum3;
@override@JsonKey(name: "v_account_name_2") final  dynamic vAccountName2;
@override@JsonKey(name: "v_account_name_3") final  dynamic vAccountName3;
@override@JsonKey(name: "v_account_bank_2") final  dynamic vAccountBank2;
@override@JsonKey(name: "v_account_bank_3") final  dynamic vAccountBank3;
@override@JsonKey(name: "status") final  String? status;
@override@JsonKey(name: "current_session_id") final  String? currentSessionId;
@override@JsonKey(name: "transaction_session_id") final  dynamic transactionSessionId;
@override@JsonKey(name: "created_at") final  DateTime? createdAt;
@override@JsonKey(name: "updated_at") final  DateTime? updatedAt;

/// Create a copy of Data
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DataCopyWith<_Data> get copyWith => __$DataCopyWithImpl<_Data>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Data&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.name, name) || other.name == name)&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.userType, userType) || other.userType == userType)&&const DeepCollectionEquality().equals(other.emailVerifiedAt, emailVerifiedAt)&&const DeepCollectionEquality().equals(other.pin, pin)&&const DeepCollectionEquality().equals(other.address, address)&&const DeepCollectionEquality().equals(other.otp, otp)&&const DeepCollectionEquality().equals(other.gender, gender)&&const DeepCollectionEquality().equals(other.dob, dob)&&const DeepCollectionEquality().equals(other.bvn, bvn)&&const DeepCollectionEquality().equals(other.hasPin, hasPin)&&const DeepCollectionEquality().equals(other.nin, nin)&&const DeepCollectionEquality().equals(other.bankName, bankName)&&const DeepCollectionEquality().equals(other.accountNumber, accountNumber)&&const DeepCollectionEquality().equals(other.accountName, accountName)&&const DeepCollectionEquality().equals(other.vAccountNum1, vAccountNum1)&&const DeepCollectionEquality().equals(other.vAccountName1, vAccountName1)&&const DeepCollectionEquality().equals(other.vAccountBank1, vAccountBank1)&&const DeepCollectionEquality().equals(other.vAccountNum2, vAccountNum2)&&const DeepCollectionEquality().equals(other.vAccountNum3, vAccountNum3)&&const DeepCollectionEquality().equals(other.vAccountName2, vAccountName2)&&const DeepCollectionEquality().equals(other.vAccountName3, vAccountName3)&&const DeepCollectionEquality().equals(other.vAccountBank2, vAccountBank2)&&const DeepCollectionEquality().equals(other.vAccountBank3, vAccountBank3)&&(identical(other.status, status) || other.status == status)&&(identical(other.currentSessionId, currentSessionId) || other.currentSessionId == currentSessionId)&&const DeepCollectionEquality().equals(other.transactionSessionId, transactionSessionId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,firstName,lastName,name,username,email,phone,userType,const DeepCollectionEquality().hash(emailVerifiedAt),const DeepCollectionEquality().hash(pin),const DeepCollectionEquality().hash(address),const DeepCollectionEquality().hash(otp),const DeepCollectionEquality().hash(gender),const DeepCollectionEquality().hash(dob),const DeepCollectionEquality().hash(bvn),const DeepCollectionEquality().hash(hasPin),const DeepCollectionEquality().hash(nin),const DeepCollectionEquality().hash(bankName),const DeepCollectionEquality().hash(accountNumber),const DeepCollectionEquality().hash(accountName),const DeepCollectionEquality().hash(vAccountNum1),const DeepCollectionEquality().hash(vAccountName1),const DeepCollectionEquality().hash(vAccountBank1),const DeepCollectionEquality().hash(vAccountNum2),const DeepCollectionEquality().hash(vAccountNum3),const DeepCollectionEquality().hash(vAccountName2),const DeepCollectionEquality().hash(vAccountName3),const DeepCollectionEquality().hash(vAccountBank2),const DeepCollectionEquality().hash(vAccountBank3),status,currentSessionId,const DeepCollectionEquality().hash(transactionSessionId),createdAt,updatedAt]);

@override
String toString() {
  return 'Data(id: $id, firstName: $firstName, lastName: $lastName, name: $name, username: $username, email: $email, phone: $phone, userType: $userType, emailVerifiedAt: $emailVerifiedAt, pin: $pin, address: $address, otp: $otp, gender: $gender, dob: $dob, bvn: $bvn, hasPin: $hasPin, nin: $nin, bankName: $bankName, accountNumber: $accountNumber, accountName: $accountName, vAccountNum1: $vAccountNum1, vAccountName1: $vAccountName1, vAccountBank1: $vAccountBank1, vAccountNum2: $vAccountNum2, vAccountNum3: $vAccountNum3, vAccountName2: $vAccountName2, vAccountName3: $vAccountName3, vAccountBank2: $vAccountBank2, vAccountBank3: $vAccountBank3, status: $status, currentSessionId: $currentSessionId, transactionSessionId: $transactionSessionId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DataCopyWith<$Res> implements $DataCopyWith<$Res> {
  factory _$DataCopyWith(_Data value, $Res Function(_Data) _then) = __$DataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "id") int? id,@JsonKey(name: "first_name") String? firstName,@JsonKey(name: "last_name") String? lastName,@JsonKey(name: "name") String? name,@JsonKey(name: "username") String? username,@JsonKey(name: "email") String? email,@JsonKey(name: "phone") String? phone,@JsonKey(name: "user_type") String? userType,@JsonKey(name: "email_verified_at") dynamic emailVerifiedAt,@JsonKey(name: "pin") dynamic pin,@JsonKey(name: "address") dynamic address,@JsonKey(name: "otp") dynamic otp,@JsonKey(name: "gender") dynamic gender,@JsonKey(name: "dob") dynamic dob,@JsonKey(name: "bvn") dynamic bvn,@JsonKey(name: "has_pin") dynamic hasPin,@JsonKey(name: "nin") dynamic nin,@JsonKey(name: "bank_name") dynamic bankName,@JsonKey(name: "account_number") dynamic accountNumber,@JsonKey(name: "account_name") dynamic accountName,@JsonKey(name: "v_account_num_1") dynamic vAccountNum1,@JsonKey(name: "v_account_name_1") dynamic vAccountName1,@JsonKey(name: "v_account_bank_1") dynamic vAccountBank1,@JsonKey(name: "v_account_num_2") dynamic vAccountNum2,@JsonKey(name: "v_account_num_3") dynamic vAccountNum3,@JsonKey(name: "v_account_name_2") dynamic vAccountName2,@JsonKey(name: "v_account_name_3") dynamic vAccountName3,@JsonKey(name: "v_account_bank_2") dynamic vAccountBank2,@JsonKey(name: "v_account_bank_3") dynamic vAccountBank3,@JsonKey(name: "status") String? status,@JsonKey(name: "current_session_id") String? currentSessionId,@JsonKey(name: "transaction_session_id") dynamic transactionSessionId,@JsonKey(name: "created_at") DateTime? createdAt,@JsonKey(name: "updated_at") DateTime? updatedAt
});




}
/// @nodoc
class __$DataCopyWithImpl<$Res>
    implements _$DataCopyWith<$Res> {
  __$DataCopyWithImpl(this._self, this._then);

  final _Data _self;
  final $Res Function(_Data) _then;

/// Create a copy of Data
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? name = freezed,Object? username = freezed,Object? email = freezed,Object? phone = freezed,Object? userType = freezed,Object? emailVerifiedAt = freezed,Object? pin = freezed,Object? address = freezed,Object? otp = freezed,Object? gender = freezed,Object? dob = freezed,Object? bvn = freezed,Object? hasPin = freezed,Object? nin = freezed,Object? bankName = freezed,Object? accountNumber = freezed,Object? accountName = freezed,Object? vAccountNum1 = freezed,Object? vAccountName1 = freezed,Object? vAccountBank1 = freezed,Object? vAccountNum2 = freezed,Object? vAccountNum3 = freezed,Object? vAccountName2 = freezed,Object? vAccountName3 = freezed,Object? vAccountBank2 = freezed,Object? vAccountBank3 = freezed,Object? status = freezed,Object? currentSessionId = freezed,Object? transactionSessionId = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Data(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,userType: freezed == userType ? _self.userType : userType // ignore: cast_nullable_to_non_nullable
as String?,emailVerifiedAt: freezed == emailVerifiedAt ? _self.emailVerifiedAt : emailVerifiedAt // ignore: cast_nullable_to_non_nullable
as dynamic,pin: freezed == pin ? _self.pin : pin // ignore: cast_nullable_to_non_nullable
as dynamic,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as dynamic,otp: freezed == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as dynamic,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as dynamic,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as dynamic,bvn: freezed == bvn ? _self.bvn : bvn // ignore: cast_nullable_to_non_nullable
as dynamic,hasPin: freezed == hasPin ? _self.hasPin : hasPin // ignore: cast_nullable_to_non_nullable
as dynamic,nin: freezed == nin ? _self.nin : nin // ignore: cast_nullable_to_non_nullable
as dynamic,bankName: freezed == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as dynamic,accountNumber: freezed == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as dynamic,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as dynamic,vAccountNum1: freezed == vAccountNum1 ? _self.vAccountNum1 : vAccountNum1 // ignore: cast_nullable_to_non_nullable
as dynamic,vAccountName1: freezed == vAccountName1 ? _self.vAccountName1 : vAccountName1 // ignore: cast_nullable_to_non_nullable
as dynamic,vAccountBank1: freezed == vAccountBank1 ? _self.vAccountBank1 : vAccountBank1 // ignore: cast_nullable_to_non_nullable
as dynamic,vAccountNum2: freezed == vAccountNum2 ? _self.vAccountNum2 : vAccountNum2 // ignore: cast_nullable_to_non_nullable
as dynamic,vAccountNum3: freezed == vAccountNum3 ? _self.vAccountNum3 : vAccountNum3 // ignore: cast_nullable_to_non_nullable
as dynamic,vAccountName2: freezed == vAccountName2 ? _self.vAccountName2 : vAccountName2 // ignore: cast_nullable_to_non_nullable
as dynamic,vAccountName3: freezed == vAccountName3 ? _self.vAccountName3 : vAccountName3 // ignore: cast_nullable_to_non_nullable
as dynamic,vAccountBank2: freezed == vAccountBank2 ? _self.vAccountBank2 : vAccountBank2 // ignore: cast_nullable_to_non_nullable
as dynamic,vAccountBank3: freezed == vAccountBank3 ? _self.vAccountBank3 : vAccountBank3 // ignore: cast_nullable_to_non_nullable
as dynamic,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,currentSessionId: freezed == currentSessionId ? _self.currentSessionId : currentSessionId // ignore: cast_nullable_to_non_nullable
as String?,transactionSessionId: freezed == transactionSessionId ? _self.transactionSessionId : transactionSessionId // ignore: cast_nullable_to_non_nullable
as dynamic,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
