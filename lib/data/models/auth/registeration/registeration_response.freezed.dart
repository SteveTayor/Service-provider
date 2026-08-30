// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registeration_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegisterResponse {

@JsonKey(name: "status") String? get status;@JsonKey(name: "data") RegistrationData? get data;@JsonKey(name: "message") String? get message;
/// Create a copy of RegisterResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterResponseCopyWith<RegisterResponse> get copyWith => _$RegisterResponseCopyWithImpl<RegisterResponse>(this as RegisterResponse, _$identity);

  /// Serializes this RegisterResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.data, data) || other.data == data)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,data,message);

@override
String toString() {
  return 'RegisterResponse(status: $status, data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class $RegisterResponseCopyWith<$Res>  {
  factory $RegisterResponseCopyWith(RegisterResponse value, $Res Function(RegisterResponse) _then) = _$RegisterResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "status") String? status,@JsonKey(name: "data") RegistrationData? data,@JsonKey(name: "message") String? message
});


$RegistrationDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$RegisterResponseCopyWithImpl<$Res>
    implements $RegisterResponseCopyWith<$Res> {
  _$RegisterResponseCopyWithImpl(this._self, this._then);

  final RegisterResponse _self;
  final $Res Function(RegisterResponse) _then;

/// Create a copy of RegisterResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? data = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RegistrationData?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of RegisterResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegistrationDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $RegistrationDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [RegisterResponse].
extension RegisterResponsePatterns on RegisterResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterResponse value)  $default,){
final _that = this;
switch (_that) {
case _RegisterResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterResponse value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  RegistrationData? data, @JsonKey(name: "message")  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  RegistrationData? data, @JsonKey(name: "message")  String? message)  $default,) {final _that = this;
switch (_that) {
case _RegisterResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  RegistrationData? data, @JsonKey(name: "message")  String? message)?  $default,) {final _that = this;
switch (_that) {
case _RegisterResponse() when $default != null:
return $default(_that.status,_that.data,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegisterResponse implements RegisterResponse {
  const _RegisterResponse({@JsonKey(name: "status") this.status, @JsonKey(name: "data") this.data, @JsonKey(name: "message") this.message});
  factory _RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);

@override@JsonKey(name: "status") final  String? status;
@override@JsonKey(name: "data") final  RegistrationData? data;
@override@JsonKey(name: "message") final  String? message;

/// Create a copy of RegisterResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterResponseCopyWith<_RegisterResponse> get copyWith => __$RegisterResponseCopyWithImpl<_RegisterResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegisterResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.data, data) || other.data == data)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,data,message);

@override
String toString() {
  return 'RegisterResponse(status: $status, data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class _$RegisterResponseCopyWith<$Res> implements $RegisterResponseCopyWith<$Res> {
  factory _$RegisterResponseCopyWith(_RegisterResponse value, $Res Function(_RegisterResponse) _then) = __$RegisterResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "status") String? status,@JsonKey(name: "data") RegistrationData? data,@JsonKey(name: "message") String? message
});


@override $RegistrationDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$RegisterResponseCopyWithImpl<$Res>
    implements _$RegisterResponseCopyWith<$Res> {
  __$RegisterResponseCopyWithImpl(this._self, this._then);

  final _RegisterResponse _self;
  final $Res Function(_RegisterResponse) _then;

/// Create a copy of RegisterResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? data = freezed,Object? message = freezed,}) {
  return _then(_RegisterResponse(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RegistrationData?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of RegisterResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegistrationDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $RegistrationDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$RegistrationData {

@JsonKey(name: "token") String? get token;@JsonKey(name: "user") User? get user;
/// Create a copy of RegistrationData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegistrationDataCopyWith<RegistrationData> get copyWith => _$RegistrationDataCopyWithImpl<RegistrationData>(this as RegistrationData, _$identity);

  /// Serializes this RegistrationData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegistrationData&&(identical(other.token, token) || other.token == token)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,user);

@override
String toString() {
  return 'RegistrationData(token: $token, user: $user)';
}


}

/// @nodoc
abstract mixin class $RegistrationDataCopyWith<$Res>  {
  factory $RegistrationDataCopyWith(RegistrationData value, $Res Function(RegistrationData) _then) = _$RegistrationDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "token") String? token,@JsonKey(name: "user") User? user
});


$UserCopyWith<$Res>? get user;

}
/// @nodoc
class _$RegistrationDataCopyWithImpl<$Res>
    implements $RegistrationDataCopyWith<$Res> {
  _$RegistrationDataCopyWithImpl(this._self, this._then);

  final RegistrationData _self;
  final $Res Function(RegistrationData) _then;

/// Create a copy of RegistrationData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = freezed,Object? user = freezed,}) {
  return _then(_self.copyWith(
token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,
  ));
}
/// Create a copy of RegistrationData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [RegistrationData].
extension RegistrationDataPatterns on RegistrationData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegistrationData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegistrationData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegistrationData value)  $default,){
final _that = this;
switch (_that) {
case _RegistrationData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegistrationData value)?  $default,){
final _that = this;
switch (_that) {
case _RegistrationData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "token")  String? token, @JsonKey(name: "user")  User? user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegistrationData() when $default != null:
return $default(_that.token,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "token")  String? token, @JsonKey(name: "user")  User? user)  $default,) {final _that = this;
switch (_that) {
case _RegistrationData():
return $default(_that.token,_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "token")  String? token, @JsonKey(name: "user")  User? user)?  $default,) {final _that = this;
switch (_that) {
case _RegistrationData() when $default != null:
return $default(_that.token,_that.user);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegistrationData implements RegistrationData {
  const _RegistrationData({@JsonKey(name: "token") this.token, @JsonKey(name: "user") this.user});
  factory _RegistrationData.fromJson(Map<String, dynamic> json) => _$RegistrationDataFromJson(json);

@override@JsonKey(name: "token") final  String? token;
@override@JsonKey(name: "user") final  User? user;

/// Create a copy of RegistrationData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegistrationDataCopyWith<_RegistrationData> get copyWith => __$RegistrationDataCopyWithImpl<_RegistrationData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegistrationDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegistrationData&&(identical(other.token, token) || other.token == token)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,user);

@override
String toString() {
  return 'RegistrationData(token: $token, user: $user)';
}


}

/// @nodoc
abstract mixin class _$RegistrationDataCopyWith<$Res> implements $RegistrationDataCopyWith<$Res> {
  factory _$RegistrationDataCopyWith(_RegistrationData value, $Res Function(_RegistrationData) _then) = __$RegistrationDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "token") String? token,@JsonKey(name: "user") User? user
});


@override $UserCopyWith<$Res>? get user;

}
/// @nodoc
class __$RegistrationDataCopyWithImpl<$Res>
    implements _$RegistrationDataCopyWith<$Res> {
  __$RegistrationDataCopyWithImpl(this._self, this._then);

  final _RegistrationData _self;
  final $Res Function(_RegistrationData) _then;

/// Create a copy of RegistrationData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = freezed,Object? user = freezed,}) {
  return _then(_RegistrationData(
token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,
  ));
}

/// Create a copy of RegistrationData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$User {

@JsonKey(name: "first_name") String? get firstName;@JsonKey(name: "last_name") String? get lastName;@JsonKey(name: "name") String? get name;@JsonKey(name: "phone") String? get phone;@JsonKey(name: "email") String? get email;@JsonKey(name: "updated_at") DateTime? get updatedAt;@JsonKey(name: "created_at") DateTime? get createdAt;@JsonKey(name: "id") int? get id;@JsonKey(name: "current_session_id") String? get currentSessionId;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.id, id) || other.id == id)&&(identical(other.currentSessionId, currentSessionId) || other.currentSessionId == currentSessionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,name,phone,email,updatedAt,createdAt,id,currentSessionId);

@override
String toString() {
  return 'User(firstName: $firstName, lastName: $lastName, name: $name, phone: $phone, email: $email, updatedAt: $updatedAt, createdAt: $createdAt, id: $id, currentSessionId: $currentSessionId)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "first_name") String? firstName,@JsonKey(name: "last_name") String? lastName,@JsonKey(name: "name") String? name,@JsonKey(name: "phone") String? phone,@JsonKey(name: "email") String? email,@JsonKey(name: "updated_at") DateTime? updatedAt,@JsonKey(name: "created_at") DateTime? createdAt,@JsonKey(name: "id") int? id,@JsonKey(name: "current_session_id") String? currentSessionId
});




}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = freezed,Object? lastName = freezed,Object? name = freezed,Object? phone = freezed,Object? email = freezed,Object? updatedAt = freezed,Object? createdAt = freezed,Object? id = freezed,Object? currentSessionId = freezed,}) {
  return _then(_self.copyWith(
firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,currentSessionId: freezed == currentSessionId ? _self.currentSessionId : currentSessionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [User].
extension UserPatterns on User {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _User value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _User() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _User value)  $default,){
final _that = this;
switch (_that) {
case _User():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _User value)?  $default,){
final _that = this;
switch (_that) {
case _User() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "first_name")  String? firstName, @JsonKey(name: "last_name")  String? lastName, @JsonKey(name: "name")  String? name, @JsonKey(name: "phone")  String? phone, @JsonKey(name: "email")  String? email, @JsonKey(name: "updated_at")  DateTime? updatedAt, @JsonKey(name: "created_at")  DateTime? createdAt, @JsonKey(name: "id")  int? id, @JsonKey(name: "current_session_id")  String? currentSessionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.firstName,_that.lastName,_that.name,_that.phone,_that.email,_that.updatedAt,_that.createdAt,_that.id,_that.currentSessionId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "first_name")  String? firstName, @JsonKey(name: "last_name")  String? lastName, @JsonKey(name: "name")  String? name, @JsonKey(name: "phone")  String? phone, @JsonKey(name: "email")  String? email, @JsonKey(name: "updated_at")  DateTime? updatedAt, @JsonKey(name: "created_at")  DateTime? createdAt, @JsonKey(name: "id")  int? id, @JsonKey(name: "current_session_id")  String? currentSessionId)  $default,) {final _that = this;
switch (_that) {
case _User():
return $default(_that.firstName,_that.lastName,_that.name,_that.phone,_that.email,_that.updatedAt,_that.createdAt,_that.id,_that.currentSessionId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "first_name")  String? firstName, @JsonKey(name: "last_name")  String? lastName, @JsonKey(name: "name")  String? name, @JsonKey(name: "phone")  String? phone, @JsonKey(name: "email")  String? email, @JsonKey(name: "updated_at")  DateTime? updatedAt, @JsonKey(name: "created_at")  DateTime? createdAt, @JsonKey(name: "id")  int? id, @JsonKey(name: "current_session_id")  String? currentSessionId)?  $default,) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.firstName,_that.lastName,_that.name,_that.phone,_that.email,_that.updatedAt,_that.createdAt,_that.id,_that.currentSessionId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _User implements User {
  const _User({@JsonKey(name: "first_name") this.firstName, @JsonKey(name: "last_name") this.lastName, @JsonKey(name: "name") this.name, @JsonKey(name: "phone") this.phone, @JsonKey(name: "email") this.email, @JsonKey(name: "updated_at") this.updatedAt, @JsonKey(name: "created_at") this.createdAt, @JsonKey(name: "id") this.id, @JsonKey(name: "current_session_id") this.currentSessionId});
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

@override@JsonKey(name: "first_name") final  String? firstName;
@override@JsonKey(name: "last_name") final  String? lastName;
@override@JsonKey(name: "name") final  String? name;
@override@JsonKey(name: "phone") final  String? phone;
@override@JsonKey(name: "email") final  String? email;
@override@JsonKey(name: "updated_at") final  DateTime? updatedAt;
@override@JsonKey(name: "created_at") final  DateTime? createdAt;
@override@JsonKey(name: "id") final  int? id;
@override@JsonKey(name: "current_session_id") final  String? currentSessionId;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.id, id) || other.id == id)&&(identical(other.currentSessionId, currentSessionId) || other.currentSessionId == currentSessionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,name,phone,email,updatedAt,createdAt,id,currentSessionId);

@override
String toString() {
  return 'User(firstName: $firstName, lastName: $lastName, name: $name, phone: $phone, email: $email, updatedAt: $updatedAt, createdAt: $createdAt, id: $id, currentSessionId: $currentSessionId)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "first_name") String? firstName,@JsonKey(name: "last_name") String? lastName,@JsonKey(name: "name") String? name,@JsonKey(name: "phone") String? phone,@JsonKey(name: "email") String? email,@JsonKey(name: "updated_at") DateTime? updatedAt,@JsonKey(name: "created_at") DateTime? createdAt,@JsonKey(name: "id") int? id,@JsonKey(name: "current_session_id") String? currentSessionId
});




}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = freezed,Object? lastName = freezed,Object? name = freezed,Object? phone = freezed,Object? email = freezed,Object? updatedAt = freezed,Object? createdAt = freezed,Object? id = freezed,Object? currentSessionId = freezed,}) {
  return _then(_User(
firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,currentSessionId: freezed == currentSessionId ? _self.currentSessionId : currentSessionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
