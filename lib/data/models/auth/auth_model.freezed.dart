// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginRequest implements DiagnosticableTreeMixin {

 String get email; String get password;@JsonKey(name: 'device_token') String? get deviceToken;@JsonKey(name: 'fcm_token') String? get fcmToken;
/// Create a copy of LoginRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginRequestCopyWith<LoginRequest> get copyWith => _$LoginRequestCopyWithImpl<LoginRequest>(this as LoginRequest, _$identity);

  /// Serializes this LoginRequest to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LoginRequest'))
    ..add(DiagnosticsProperty('email', email))..add(DiagnosticsProperty('password', password))..add(DiagnosticsProperty('deviceToken', deviceToken))..add(DiagnosticsProperty('fcmToken', fcmToken));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.deviceToken, deviceToken) || other.deviceToken == deviceToken)&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password,deviceToken,fcmToken);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LoginRequest(email: $email, password: $password, deviceToken: $deviceToken, fcmToken: $fcmToken)';
}


}

/// @nodoc
abstract mixin class $LoginRequestCopyWith<$Res>  {
  factory $LoginRequestCopyWith(LoginRequest value, $Res Function(LoginRequest) _then) = _$LoginRequestCopyWithImpl;
@useResult
$Res call({
 String email, String password,@JsonKey(name: 'device_token') String? deviceToken,@JsonKey(name: 'fcm_token') String? fcmToken
});




}
/// @nodoc
class _$LoginRequestCopyWithImpl<$Res>
    implements $LoginRequestCopyWith<$Res> {
  _$LoginRequestCopyWithImpl(this._self, this._then);

  final LoginRequest _self;
  final $Res Function(LoginRequest) _then;

/// Create a copy of LoginRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,Object? deviceToken = freezed,Object? fcmToken = freezed,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,deviceToken: freezed == deviceToken ? _self.deviceToken : deviceToken // ignore: cast_nullable_to_non_nullable
as String?,fcmToken: freezed == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginRequest].
extension LoginRequestPatterns on LoginRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginRequest value)  $default,){
final _that = this;
switch (_that) {
case _LoginRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginRequest value)?  $default,){
final _that = this;
switch (_that) {
case _LoginRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String password, @JsonKey(name: 'device_token')  String? deviceToken, @JsonKey(name: 'fcm_token')  String? fcmToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginRequest() when $default != null:
return $default(_that.email,_that.password,_that.deviceToken,_that.fcmToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String password, @JsonKey(name: 'device_token')  String? deviceToken, @JsonKey(name: 'fcm_token')  String? fcmToken)  $default,) {final _that = this;
switch (_that) {
case _LoginRequest():
return $default(_that.email,_that.password,_that.deviceToken,_that.fcmToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String password, @JsonKey(name: 'device_token')  String? deviceToken, @JsonKey(name: 'fcm_token')  String? fcmToken)?  $default,) {final _that = this;
switch (_that) {
case _LoginRequest() when $default != null:
return $default(_that.email,_that.password,_that.deviceToken,_that.fcmToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginRequest with DiagnosticableTreeMixin implements LoginRequest {
  const _LoginRequest({required this.email, required this.password, @JsonKey(name: 'device_token') this.deviceToken, @JsonKey(name: 'fcm_token') this.fcmToken});
  factory _LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

@override final  String email;
@override final  String password;
@override@JsonKey(name: 'device_token') final  String? deviceToken;
@override@JsonKey(name: 'fcm_token') final  String? fcmToken;

/// Create a copy of LoginRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginRequestCopyWith<_LoginRequest> get copyWith => __$LoginRequestCopyWithImpl<_LoginRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginRequestToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LoginRequest'))
    ..add(DiagnosticsProperty('email', email))..add(DiagnosticsProperty('password', password))..add(DiagnosticsProperty('deviceToken', deviceToken))..add(DiagnosticsProperty('fcmToken', fcmToken));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.deviceToken, deviceToken) || other.deviceToken == deviceToken)&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password,deviceToken,fcmToken);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LoginRequest(email: $email, password: $password, deviceToken: $deviceToken, fcmToken: $fcmToken)';
}


}

/// @nodoc
abstract mixin class _$LoginRequestCopyWith<$Res> implements $LoginRequestCopyWith<$Res> {
  factory _$LoginRequestCopyWith(_LoginRequest value, $Res Function(_LoginRequest) _then) = __$LoginRequestCopyWithImpl;
@override @useResult
$Res call({
 String email, String password,@JsonKey(name: 'device_token') String? deviceToken,@JsonKey(name: 'fcm_token') String? fcmToken
});




}
/// @nodoc
class __$LoginRequestCopyWithImpl<$Res>
    implements _$LoginRequestCopyWith<$Res> {
  __$LoginRequestCopyWithImpl(this._self, this._then);

  final _LoginRequest _self;
  final $Res Function(_LoginRequest) _then;

/// Create a copy of LoginRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? deviceToken = freezed,Object? fcmToken = freezed,}) {
  return _then(_LoginRequest(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,deviceToken: freezed == deviceToken ? _self.deviceToken : deviceToken // ignore: cast_nullable_to_non_nullable
as String?,fcmToken: freezed == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RegisterRequest implements DiagnosticableTreeMixin {

 String get email; String get phone;@JsonKey(name: 'first_name') String get firstName;@JsonKey(name: 'last_name') String get lastName; String get password;@JsonKey(name: 'password_confirm') String get passwordConfirm;
/// Create a copy of RegisterRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterRequestCopyWith<RegisterRequest> get copyWith => _$RegisterRequestCopyWithImpl<RegisterRequest>(this as RegisterRequest, _$identity);

  /// Serializes this RegisterRequest to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'RegisterRequest'))
    ..add(DiagnosticsProperty('email', email))..add(DiagnosticsProperty('phone', phone))..add(DiagnosticsProperty('firstName', firstName))..add(DiagnosticsProperty('lastName', lastName))..add(DiagnosticsProperty('password', password))..add(DiagnosticsProperty('passwordConfirm', passwordConfirm));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.password, password) || other.password == password)&&(identical(other.passwordConfirm, passwordConfirm) || other.passwordConfirm == passwordConfirm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,phone,firstName,lastName,password,passwordConfirm);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'RegisterRequest(email: $email, phone: $phone, firstName: $firstName, lastName: $lastName, password: $password, passwordConfirm: $passwordConfirm)';
}


}

/// @nodoc
abstract mixin class $RegisterRequestCopyWith<$Res>  {
  factory $RegisterRequestCopyWith(RegisterRequest value, $Res Function(RegisterRequest) _then) = _$RegisterRequestCopyWithImpl;
@useResult
$Res call({
 String email, String phone,@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String lastName, String password,@JsonKey(name: 'password_confirm') String passwordConfirm
});




}
/// @nodoc
class _$RegisterRequestCopyWithImpl<$Res>
    implements $RegisterRequestCopyWith<$Res> {
  _$RegisterRequestCopyWithImpl(this._self, this._then);

  final RegisterRequest _self;
  final $Res Function(RegisterRequest) _then;

/// Create a copy of RegisterRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? phone = null,Object? firstName = null,Object? lastName = null,Object? password = null,Object? passwordConfirm = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,passwordConfirm: null == passwordConfirm ? _self.passwordConfirm : passwordConfirm // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisterRequest].
extension RegisterRequestPatterns on RegisterRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterRequest value)  $default,){
final _that = this;
switch (_that) {
case _RegisterRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterRequest value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String phone, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName,  String password, @JsonKey(name: 'password_confirm')  String passwordConfirm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterRequest() when $default != null:
return $default(_that.email,_that.phone,_that.firstName,_that.lastName,_that.password,_that.passwordConfirm);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String phone, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName,  String password, @JsonKey(name: 'password_confirm')  String passwordConfirm)  $default,) {final _that = this;
switch (_that) {
case _RegisterRequest():
return $default(_that.email,_that.phone,_that.firstName,_that.lastName,_that.password,_that.passwordConfirm);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String phone, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName,  String password, @JsonKey(name: 'password_confirm')  String passwordConfirm)?  $default,) {final _that = this;
switch (_that) {
case _RegisterRequest() when $default != null:
return $default(_that.email,_that.phone,_that.firstName,_that.lastName,_that.password,_that.passwordConfirm);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegisterRequest with DiagnosticableTreeMixin implements RegisterRequest {
  const _RegisterRequest({required this.email, required this.phone, @JsonKey(name: 'first_name') required this.firstName, @JsonKey(name: 'last_name') required this.lastName, required this.password, @JsonKey(name: 'password_confirm') required this.passwordConfirm});
  factory _RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);

@override final  String email;
@override final  String phone;
@override@JsonKey(name: 'first_name') final  String firstName;
@override@JsonKey(name: 'last_name') final  String lastName;
@override final  String password;
@override@JsonKey(name: 'password_confirm') final  String passwordConfirm;

/// Create a copy of RegisterRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterRequestCopyWith<_RegisterRequest> get copyWith => __$RegisterRequestCopyWithImpl<_RegisterRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegisterRequestToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'RegisterRequest'))
    ..add(DiagnosticsProperty('email', email))..add(DiagnosticsProperty('phone', phone))..add(DiagnosticsProperty('firstName', firstName))..add(DiagnosticsProperty('lastName', lastName))..add(DiagnosticsProperty('password', password))..add(DiagnosticsProperty('passwordConfirm', passwordConfirm));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.password, password) || other.password == password)&&(identical(other.passwordConfirm, passwordConfirm) || other.passwordConfirm == passwordConfirm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,phone,firstName,lastName,password,passwordConfirm);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'RegisterRequest(email: $email, phone: $phone, firstName: $firstName, lastName: $lastName, password: $password, passwordConfirm: $passwordConfirm)';
}


}

/// @nodoc
abstract mixin class _$RegisterRequestCopyWith<$Res> implements $RegisterRequestCopyWith<$Res> {
  factory _$RegisterRequestCopyWith(_RegisterRequest value, $Res Function(_RegisterRequest) _then) = __$RegisterRequestCopyWithImpl;
@override @useResult
$Res call({
 String email, String phone,@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String lastName, String password,@JsonKey(name: 'password_confirm') String passwordConfirm
});




}
/// @nodoc
class __$RegisterRequestCopyWithImpl<$Res>
    implements _$RegisterRequestCopyWith<$Res> {
  __$RegisterRequestCopyWithImpl(this._self, this._then);

  final _RegisterRequest _self;
  final $Res Function(_RegisterRequest) _then;

/// Create a copy of RegisterRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? phone = null,Object? firstName = null,Object? lastName = null,Object? password = null,Object? passwordConfirm = null,}) {
  return _then(_RegisterRequest(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,passwordConfirm: null == passwordConfirm ? _self.passwordConfirm : passwordConfirm // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ForgotPasswordRequest implements DiagnosticableTreeMixin {

 String get email;
/// Create a copy of ForgotPasswordRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForgotPasswordRequestCopyWith<ForgotPasswordRequest> get copyWith => _$ForgotPasswordRequestCopyWithImpl<ForgotPasswordRequest>(this as ForgotPasswordRequest, _$identity);

  /// Serializes this ForgotPasswordRequest to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ForgotPasswordRequest'))
    ..add(DiagnosticsProperty('email', email));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordRequest&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ForgotPasswordRequest(email: $email)';
}


}

/// @nodoc
abstract mixin class $ForgotPasswordRequestCopyWith<$Res>  {
  factory $ForgotPasswordRequestCopyWith(ForgotPasswordRequest value, $Res Function(ForgotPasswordRequest) _then) = _$ForgotPasswordRequestCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$ForgotPasswordRequestCopyWithImpl<$Res>
    implements $ForgotPasswordRequestCopyWith<$Res> {
  _$ForgotPasswordRequestCopyWithImpl(this._self, this._then);

  final ForgotPasswordRequest _self;
  final $Res Function(ForgotPasswordRequest) _then;

/// Create a copy of ForgotPasswordRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ForgotPasswordRequest].
extension ForgotPasswordRequestPatterns on ForgotPasswordRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ForgotPasswordRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ForgotPasswordRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ForgotPasswordRequest value)  $default,){
final _that = this;
switch (_that) {
case _ForgotPasswordRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ForgotPasswordRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ForgotPasswordRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ForgotPasswordRequest() when $default != null:
return $default(_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email)  $default,) {final _that = this;
switch (_that) {
case _ForgotPasswordRequest():
return $default(_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email)?  $default,) {final _that = this;
switch (_that) {
case _ForgotPasswordRequest() when $default != null:
return $default(_that.email);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ForgotPasswordRequest with DiagnosticableTreeMixin implements ForgotPasswordRequest {
  const _ForgotPasswordRequest({required this.email});
  factory _ForgotPasswordRequest.fromJson(Map<String, dynamic> json) => _$ForgotPasswordRequestFromJson(json);

@override final  String email;

/// Create a copy of ForgotPasswordRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForgotPasswordRequestCopyWith<_ForgotPasswordRequest> get copyWith => __$ForgotPasswordRequestCopyWithImpl<_ForgotPasswordRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ForgotPasswordRequestToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ForgotPasswordRequest'))
    ..add(DiagnosticsProperty('email', email));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForgotPasswordRequest&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ForgotPasswordRequest(email: $email)';
}


}

/// @nodoc
abstract mixin class _$ForgotPasswordRequestCopyWith<$Res> implements $ForgotPasswordRequestCopyWith<$Res> {
  factory _$ForgotPasswordRequestCopyWith(_ForgotPasswordRequest value, $Res Function(_ForgotPasswordRequest) _then) = __$ForgotPasswordRequestCopyWithImpl;
@override @useResult
$Res call({
 String email
});




}
/// @nodoc
class __$ForgotPasswordRequestCopyWithImpl<$Res>
    implements _$ForgotPasswordRequestCopyWith<$Res> {
  __$ForgotPasswordRequestCopyWithImpl(this._self, this._then);

  final _ForgotPasswordRequest _self;
  final $Res Function(_ForgotPasswordRequest) _then;

/// Create a copy of ForgotPasswordRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_ForgotPasswordRequest(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$VerifyOtpRequest implements DiagnosticableTreeMixin {

 String get email; String get otp;
/// Create a copy of VerifyOtpRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyOtpRequestCopyWith<VerifyOtpRequest> get copyWith => _$VerifyOtpRequestCopyWithImpl<VerifyOtpRequest>(this as VerifyOtpRequest, _$identity);

  /// Serializes this VerifyOtpRequest to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'VerifyOtpRequest'))
    ..add(DiagnosticsProperty('email', email))..add(DiagnosticsProperty('otp', otp));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.otp, otp) || other.otp == otp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,otp);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'VerifyOtpRequest(email: $email, otp: $otp)';
}


}

/// @nodoc
abstract mixin class $VerifyOtpRequestCopyWith<$Res>  {
  factory $VerifyOtpRequestCopyWith(VerifyOtpRequest value, $Res Function(VerifyOtpRequest) _then) = _$VerifyOtpRequestCopyWithImpl;
@useResult
$Res call({
 String email, String otp
});




}
/// @nodoc
class _$VerifyOtpRequestCopyWithImpl<$Res>
    implements $VerifyOtpRequestCopyWith<$Res> {
  _$VerifyOtpRequestCopyWithImpl(this._self, this._then);

  final VerifyOtpRequest _self;
  final $Res Function(VerifyOtpRequest) _then;

/// Create a copy of VerifyOtpRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? otp = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyOtpRequest].
extension VerifyOtpRequestPatterns on VerifyOtpRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyOtpRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyOtpRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyOtpRequest value)  $default,){
final _that = this;
switch (_that) {
case _VerifyOtpRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyOtpRequest value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyOtpRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String otp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyOtpRequest() when $default != null:
return $default(_that.email,_that.otp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String otp)  $default,) {final _that = this;
switch (_that) {
case _VerifyOtpRequest():
return $default(_that.email,_that.otp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String otp)?  $default,) {final _that = this;
switch (_that) {
case _VerifyOtpRequest() when $default != null:
return $default(_that.email,_that.otp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyOtpRequest with DiagnosticableTreeMixin implements VerifyOtpRequest {
  const _VerifyOtpRequest({required this.email, required this.otp});
  factory _VerifyOtpRequest.fromJson(Map<String, dynamic> json) => _$VerifyOtpRequestFromJson(json);

@override final  String email;
@override final  String otp;

/// Create a copy of VerifyOtpRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyOtpRequestCopyWith<_VerifyOtpRequest> get copyWith => __$VerifyOtpRequestCopyWithImpl<_VerifyOtpRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyOtpRequestToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'VerifyOtpRequest'))
    ..add(DiagnosticsProperty('email', email))..add(DiagnosticsProperty('otp', otp));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyOtpRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.otp, otp) || other.otp == otp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,otp);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'VerifyOtpRequest(email: $email, otp: $otp)';
}


}

/// @nodoc
abstract mixin class _$VerifyOtpRequestCopyWith<$Res> implements $VerifyOtpRequestCopyWith<$Res> {
  factory _$VerifyOtpRequestCopyWith(_VerifyOtpRequest value, $Res Function(_VerifyOtpRequest) _then) = __$VerifyOtpRequestCopyWithImpl;
@override @useResult
$Res call({
 String email, String otp
});




}
/// @nodoc
class __$VerifyOtpRequestCopyWithImpl<$Res>
    implements _$VerifyOtpRequestCopyWith<$Res> {
  __$VerifyOtpRequestCopyWithImpl(this._self, this._then);

  final _VerifyOtpRequest _self;
  final $Res Function(_VerifyOtpRequest) _then;

/// Create a copy of VerifyOtpRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? otp = null,}) {
  return _then(_VerifyOtpRequest(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$VerifyEmailRequest implements DiagnosticableTreeMixin {

 String get otp;
/// Create a copy of VerifyEmailRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyEmailRequestCopyWith<VerifyEmailRequest> get copyWith => _$VerifyEmailRequestCopyWithImpl<VerifyEmailRequest>(this as VerifyEmailRequest, _$identity);

  /// Serializes this VerifyEmailRequest to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'VerifyEmailRequest'))
    ..add(DiagnosticsProperty('otp', otp));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyEmailRequest&&(identical(other.otp, otp) || other.otp == otp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,otp);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'VerifyEmailRequest(otp: $otp)';
}


}

/// @nodoc
abstract mixin class $VerifyEmailRequestCopyWith<$Res>  {
  factory $VerifyEmailRequestCopyWith(VerifyEmailRequest value, $Res Function(VerifyEmailRequest) _then) = _$VerifyEmailRequestCopyWithImpl;
@useResult
$Res call({
 String otp
});




}
/// @nodoc
class _$VerifyEmailRequestCopyWithImpl<$Res>
    implements $VerifyEmailRequestCopyWith<$Res> {
  _$VerifyEmailRequestCopyWithImpl(this._self, this._then);

  final VerifyEmailRequest _self;
  final $Res Function(VerifyEmailRequest) _then;

/// Create a copy of VerifyEmailRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? otp = null,}) {
  return _then(_self.copyWith(
otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyEmailRequest].
extension VerifyEmailRequestPatterns on VerifyEmailRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyEmailRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyEmailRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyEmailRequest value)  $default,){
final _that = this;
switch (_that) {
case _VerifyEmailRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyEmailRequest value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyEmailRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String otp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyEmailRequest() when $default != null:
return $default(_that.otp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String otp)  $default,) {final _that = this;
switch (_that) {
case _VerifyEmailRequest():
return $default(_that.otp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String otp)?  $default,) {final _that = this;
switch (_that) {
case _VerifyEmailRequest() when $default != null:
return $default(_that.otp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyEmailRequest with DiagnosticableTreeMixin implements VerifyEmailRequest {
  const _VerifyEmailRequest({required this.otp});
  factory _VerifyEmailRequest.fromJson(Map<String, dynamic> json) => _$VerifyEmailRequestFromJson(json);

@override final  String otp;

/// Create a copy of VerifyEmailRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyEmailRequestCopyWith<_VerifyEmailRequest> get copyWith => __$VerifyEmailRequestCopyWithImpl<_VerifyEmailRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyEmailRequestToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'VerifyEmailRequest'))
    ..add(DiagnosticsProperty('otp', otp));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyEmailRequest&&(identical(other.otp, otp) || other.otp == otp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,otp);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'VerifyEmailRequest(otp: $otp)';
}


}

/// @nodoc
abstract mixin class _$VerifyEmailRequestCopyWith<$Res> implements $VerifyEmailRequestCopyWith<$Res> {
  factory _$VerifyEmailRequestCopyWith(_VerifyEmailRequest value, $Res Function(_VerifyEmailRequest) _then) = __$VerifyEmailRequestCopyWithImpl;
@override @useResult
$Res call({
 String otp
});




}
/// @nodoc
class __$VerifyEmailRequestCopyWithImpl<$Res>
    implements _$VerifyEmailRequestCopyWith<$Res> {
  __$VerifyEmailRequestCopyWithImpl(this._self, this._then);

  final _VerifyEmailRequest _self;
  final $Res Function(_VerifyEmailRequest) _then;

/// Create a copy of VerifyEmailRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? otp = null,}) {
  return _then(_VerifyEmailRequest(
otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DeleteAccountRequest implements DiagnosticableTreeMixin {

 String get pin;
/// Create a copy of DeleteAccountRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteAccountRequestCopyWith<DeleteAccountRequest> get copyWith => _$DeleteAccountRequestCopyWithImpl<DeleteAccountRequest>(this as DeleteAccountRequest, _$identity);

  /// Serializes this DeleteAccountRequest to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DeleteAccountRequest'))
    ..add(DiagnosticsProperty('pin', pin));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteAccountRequest&&(identical(other.pin, pin) || other.pin == pin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pin);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DeleteAccountRequest(pin: $pin)';
}


}

/// @nodoc
abstract mixin class $DeleteAccountRequestCopyWith<$Res>  {
  factory $DeleteAccountRequestCopyWith(DeleteAccountRequest value, $Res Function(DeleteAccountRequest) _then) = _$DeleteAccountRequestCopyWithImpl;
@useResult
$Res call({
 String pin
});




}
/// @nodoc
class _$DeleteAccountRequestCopyWithImpl<$Res>
    implements $DeleteAccountRequestCopyWith<$Res> {
  _$DeleteAccountRequestCopyWithImpl(this._self, this._then);

  final DeleteAccountRequest _self;
  final $Res Function(DeleteAccountRequest) _then;

/// Create a copy of DeleteAccountRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pin = null,}) {
  return _then(_self.copyWith(
pin: null == pin ? _self.pin : pin // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DeleteAccountRequest].
extension DeleteAccountRequestPatterns on DeleteAccountRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeleteAccountRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeleteAccountRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeleteAccountRequest value)  $default,){
final _that = this;
switch (_that) {
case _DeleteAccountRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeleteAccountRequest value)?  $default,){
final _that = this;
switch (_that) {
case _DeleteAccountRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String pin)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeleteAccountRequest() when $default != null:
return $default(_that.pin);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String pin)  $default,) {final _that = this;
switch (_that) {
case _DeleteAccountRequest():
return $default(_that.pin);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String pin)?  $default,) {final _that = this;
switch (_that) {
case _DeleteAccountRequest() when $default != null:
return $default(_that.pin);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeleteAccountRequest with DiagnosticableTreeMixin implements DeleteAccountRequest {
  const _DeleteAccountRequest({required this.pin});
  factory _DeleteAccountRequest.fromJson(Map<String, dynamic> json) => _$DeleteAccountRequestFromJson(json);

@override final  String pin;

/// Create a copy of DeleteAccountRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteAccountRequestCopyWith<_DeleteAccountRequest> get copyWith => __$DeleteAccountRequestCopyWithImpl<_DeleteAccountRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeleteAccountRequestToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DeleteAccountRequest'))
    ..add(DiagnosticsProperty('pin', pin));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteAccountRequest&&(identical(other.pin, pin) || other.pin == pin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pin);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DeleteAccountRequest(pin: $pin)';
}


}

/// @nodoc
abstract mixin class _$DeleteAccountRequestCopyWith<$Res> implements $DeleteAccountRequestCopyWith<$Res> {
  factory _$DeleteAccountRequestCopyWith(_DeleteAccountRequest value, $Res Function(_DeleteAccountRequest) _then) = __$DeleteAccountRequestCopyWithImpl;
@override @useResult
$Res call({
 String pin
});




}
/// @nodoc
class __$DeleteAccountRequestCopyWithImpl<$Res>
    implements _$DeleteAccountRequestCopyWith<$Res> {
  __$DeleteAccountRequestCopyWithImpl(this._self, this._then);

  final _DeleteAccountRequest _self;
  final $Res Function(_DeleteAccountRequest) _then;

/// Create a copy of DeleteAccountRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pin = null,}) {
  return _then(_DeleteAccountRequest(
pin: null == pin ? _self.pin : pin // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$NewPasswordRequest implements DiagnosticableTreeMixin {

 String get email; String get password;@JsonKey(name: 'password_confirm') String get passwordConfirm;
/// Create a copy of NewPasswordRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewPasswordRequestCopyWith<NewPasswordRequest> get copyWith => _$NewPasswordRequestCopyWithImpl<NewPasswordRequest>(this as NewPasswordRequest, _$identity);

  /// Serializes this NewPasswordRequest to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'NewPasswordRequest'))
    ..add(DiagnosticsProperty('email', email))..add(DiagnosticsProperty('password', password))..add(DiagnosticsProperty('passwordConfirm', passwordConfirm));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewPasswordRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.passwordConfirm, passwordConfirm) || other.passwordConfirm == passwordConfirm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password,passwordConfirm);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'NewPasswordRequest(email: $email, password: $password, passwordConfirm: $passwordConfirm)';
}


}

/// @nodoc
abstract mixin class $NewPasswordRequestCopyWith<$Res>  {
  factory $NewPasswordRequestCopyWith(NewPasswordRequest value, $Res Function(NewPasswordRequest) _then) = _$NewPasswordRequestCopyWithImpl;
@useResult
$Res call({
 String email, String password,@JsonKey(name: 'password_confirm') String passwordConfirm
});




}
/// @nodoc
class _$NewPasswordRequestCopyWithImpl<$Res>
    implements $NewPasswordRequestCopyWith<$Res> {
  _$NewPasswordRequestCopyWithImpl(this._self, this._then);

  final NewPasswordRequest _self;
  final $Res Function(NewPasswordRequest) _then;

/// Create a copy of NewPasswordRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,Object? passwordConfirm = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,passwordConfirm: null == passwordConfirm ? _self.passwordConfirm : passwordConfirm // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NewPasswordRequest].
extension NewPasswordRequestPatterns on NewPasswordRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewPasswordRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewPasswordRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewPasswordRequest value)  $default,){
final _that = this;
switch (_that) {
case _NewPasswordRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewPasswordRequest value)?  $default,){
final _that = this;
switch (_that) {
case _NewPasswordRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String password, @JsonKey(name: 'password_confirm')  String passwordConfirm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewPasswordRequest() when $default != null:
return $default(_that.email,_that.password,_that.passwordConfirm);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String password, @JsonKey(name: 'password_confirm')  String passwordConfirm)  $default,) {final _that = this;
switch (_that) {
case _NewPasswordRequest():
return $default(_that.email,_that.password,_that.passwordConfirm);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String password, @JsonKey(name: 'password_confirm')  String passwordConfirm)?  $default,) {final _that = this;
switch (_that) {
case _NewPasswordRequest() when $default != null:
return $default(_that.email,_that.password,_that.passwordConfirm);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NewPasswordRequest with DiagnosticableTreeMixin implements NewPasswordRequest {
  const _NewPasswordRequest({required this.email, required this.password, @JsonKey(name: 'password_confirm') required this.passwordConfirm});
  factory _NewPasswordRequest.fromJson(Map<String, dynamic> json) => _$NewPasswordRequestFromJson(json);

@override final  String email;
@override final  String password;
@override@JsonKey(name: 'password_confirm') final  String passwordConfirm;

/// Create a copy of NewPasswordRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewPasswordRequestCopyWith<_NewPasswordRequest> get copyWith => __$NewPasswordRequestCopyWithImpl<_NewPasswordRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NewPasswordRequestToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'NewPasswordRequest'))
    ..add(DiagnosticsProperty('email', email))..add(DiagnosticsProperty('password', password))..add(DiagnosticsProperty('passwordConfirm', passwordConfirm));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewPasswordRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.passwordConfirm, passwordConfirm) || other.passwordConfirm == passwordConfirm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password,passwordConfirm);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'NewPasswordRequest(email: $email, password: $password, passwordConfirm: $passwordConfirm)';
}


}

/// @nodoc
abstract mixin class _$NewPasswordRequestCopyWith<$Res> implements $NewPasswordRequestCopyWith<$Res> {
  factory _$NewPasswordRequestCopyWith(_NewPasswordRequest value, $Res Function(_NewPasswordRequest) _then) = __$NewPasswordRequestCopyWithImpl;
@override @useResult
$Res call({
 String email, String password,@JsonKey(name: 'password_confirm') String passwordConfirm
});




}
/// @nodoc
class __$NewPasswordRequestCopyWithImpl<$Res>
    implements _$NewPasswordRequestCopyWith<$Res> {
  __$NewPasswordRequestCopyWithImpl(this._self, this._then);

  final _NewPasswordRequest _self;
  final $Res Function(_NewPasswordRequest) _then;

/// Create a copy of NewPasswordRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? passwordConfirm = null,}) {
  return _then(_NewPasswordRequest(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,passwordConfirm: null == passwordConfirm ? _self.passwordConfirm : passwordConfirm // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AddUsernameRequest implements DiagnosticableTreeMixin {

 String get username;
/// Create a copy of AddUsernameRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddUsernameRequestCopyWith<AddUsernameRequest> get copyWith => _$AddUsernameRequestCopyWithImpl<AddUsernameRequest>(this as AddUsernameRequest, _$identity);

  /// Serializes this AddUsernameRequest to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AddUsernameRequest'))
    ..add(DiagnosticsProperty('username', username));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddUsernameRequest&&(identical(other.username, username) || other.username == username));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AddUsernameRequest(username: $username)';
}


}

/// @nodoc
abstract mixin class $AddUsernameRequestCopyWith<$Res>  {
  factory $AddUsernameRequestCopyWith(AddUsernameRequest value, $Res Function(AddUsernameRequest) _then) = _$AddUsernameRequestCopyWithImpl;
@useResult
$Res call({
 String username
});




}
/// @nodoc
class _$AddUsernameRequestCopyWithImpl<$Res>
    implements $AddUsernameRequestCopyWith<$Res> {
  _$AddUsernameRequestCopyWithImpl(this._self, this._then);

  final AddUsernameRequest _self;
  final $Res Function(AddUsernameRequest) _then;

/// Create a copy of AddUsernameRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,}) {
  return _then(_self.copyWith(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AddUsernameRequest].
extension AddUsernameRequestPatterns on AddUsernameRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddUsernameRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddUsernameRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddUsernameRequest value)  $default,){
final _that = this;
switch (_that) {
case _AddUsernameRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddUsernameRequest value)?  $default,){
final _that = this;
switch (_that) {
case _AddUsernameRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String username)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddUsernameRequest() when $default != null:
return $default(_that.username);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String username)  $default,) {final _that = this;
switch (_that) {
case _AddUsernameRequest():
return $default(_that.username);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String username)?  $default,) {final _that = this;
switch (_that) {
case _AddUsernameRequest() when $default != null:
return $default(_that.username);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AddUsernameRequest with DiagnosticableTreeMixin implements AddUsernameRequest {
  const _AddUsernameRequest({required this.username});
  factory _AddUsernameRequest.fromJson(Map<String, dynamic> json) => _$AddUsernameRequestFromJson(json);

@override final  String username;

/// Create a copy of AddUsernameRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddUsernameRequestCopyWith<_AddUsernameRequest> get copyWith => __$AddUsernameRequestCopyWithImpl<_AddUsernameRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddUsernameRequestToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AddUsernameRequest'))
    ..add(DiagnosticsProperty('username', username));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddUsernameRequest&&(identical(other.username, username) || other.username == username));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AddUsernameRequest(username: $username)';
}


}

/// @nodoc
abstract mixin class _$AddUsernameRequestCopyWith<$Res> implements $AddUsernameRequestCopyWith<$Res> {
  factory _$AddUsernameRequestCopyWith(_AddUsernameRequest value, $Res Function(_AddUsernameRequest) _then) = __$AddUsernameRequestCopyWithImpl;
@override @useResult
$Res call({
 String username
});




}
/// @nodoc
class __$AddUsernameRequestCopyWithImpl<$Res>
    implements _$AddUsernameRequestCopyWith<$Res> {
  __$AddUsernameRequestCopyWithImpl(this._self, this._then);

  final _AddUsernameRequest _self;
  final $Res Function(_AddUsernameRequest) _then;

/// Create a copy of AddUsernameRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,}) {
  return _then(_AddUsernameRequest(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CheckUsernameRequest implements DiagnosticableTreeMixin {

 String get username;
/// Create a copy of CheckUsernameRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckUsernameRequestCopyWith<CheckUsernameRequest> get copyWith => _$CheckUsernameRequestCopyWithImpl<CheckUsernameRequest>(this as CheckUsernameRequest, _$identity);

  /// Serializes this CheckUsernameRequest to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CheckUsernameRequest'))
    ..add(DiagnosticsProperty('username', username));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckUsernameRequest&&(identical(other.username, username) || other.username == username));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CheckUsernameRequest(username: $username)';
}


}

/// @nodoc
abstract mixin class $CheckUsernameRequestCopyWith<$Res>  {
  factory $CheckUsernameRequestCopyWith(CheckUsernameRequest value, $Res Function(CheckUsernameRequest) _then) = _$CheckUsernameRequestCopyWithImpl;
@useResult
$Res call({
 String username
});




}
/// @nodoc
class _$CheckUsernameRequestCopyWithImpl<$Res>
    implements $CheckUsernameRequestCopyWith<$Res> {
  _$CheckUsernameRequestCopyWithImpl(this._self, this._then);

  final CheckUsernameRequest _self;
  final $Res Function(CheckUsernameRequest) _then;

/// Create a copy of CheckUsernameRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,}) {
  return _then(_self.copyWith(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckUsernameRequest].
extension CheckUsernameRequestPatterns on CheckUsernameRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckUsernameRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckUsernameRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckUsernameRequest value)  $default,){
final _that = this;
switch (_that) {
case _CheckUsernameRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckUsernameRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CheckUsernameRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String username)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckUsernameRequest() when $default != null:
return $default(_that.username);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String username)  $default,) {final _that = this;
switch (_that) {
case _CheckUsernameRequest():
return $default(_that.username);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String username)?  $default,) {final _that = this;
switch (_that) {
case _CheckUsernameRequest() when $default != null:
return $default(_that.username);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckUsernameRequest with DiagnosticableTreeMixin implements CheckUsernameRequest {
  const _CheckUsernameRequest({required this.username});
  factory _CheckUsernameRequest.fromJson(Map<String, dynamic> json) => _$CheckUsernameRequestFromJson(json);

@override final  String username;

/// Create a copy of CheckUsernameRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckUsernameRequestCopyWith<_CheckUsernameRequest> get copyWith => __$CheckUsernameRequestCopyWithImpl<_CheckUsernameRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckUsernameRequestToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CheckUsernameRequest'))
    ..add(DiagnosticsProperty('username', username));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckUsernameRequest&&(identical(other.username, username) || other.username == username));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CheckUsernameRequest(username: $username)';
}


}

/// @nodoc
abstract mixin class _$CheckUsernameRequestCopyWith<$Res> implements $CheckUsernameRequestCopyWith<$Res> {
  factory _$CheckUsernameRequestCopyWith(_CheckUsernameRequest value, $Res Function(_CheckUsernameRequest) _then) = __$CheckUsernameRequestCopyWithImpl;
@override @useResult
$Res call({
 String username
});




}
/// @nodoc
class __$CheckUsernameRequestCopyWithImpl<$Res>
    implements _$CheckUsernameRequestCopyWith<$Res> {
  __$CheckUsernameRequestCopyWithImpl(this._self, this._then);

  final _CheckUsernameRequest _self;
  final $Res Function(_CheckUsernameRequest) _then;

/// Create a copy of CheckUsernameRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,}) {
  return _then(_CheckUsernameRequest(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ChangePinRequest implements DiagnosticableTreeMixin {

@JsonKey(name: "oldPin") String get oldPin;@JsonKey(name: "newPin") String get newPin;
/// Create a copy of ChangePinRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangePinRequestCopyWith<ChangePinRequest> get copyWith => _$ChangePinRequestCopyWithImpl<ChangePinRequest>(this as ChangePinRequest, _$identity);

  /// Serializes this ChangePinRequest to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ChangePinRequest'))
    ..add(DiagnosticsProperty('oldPin', oldPin))..add(DiagnosticsProperty('newPin', newPin));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangePinRequest&&(identical(other.oldPin, oldPin) || other.oldPin == oldPin)&&(identical(other.newPin, newPin) || other.newPin == newPin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,oldPin,newPin);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ChangePinRequest(oldPin: $oldPin, newPin: $newPin)';
}


}

/// @nodoc
abstract mixin class $ChangePinRequestCopyWith<$Res>  {
  factory $ChangePinRequestCopyWith(ChangePinRequest value, $Res Function(ChangePinRequest) _then) = _$ChangePinRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "oldPin") String oldPin,@JsonKey(name: "newPin") String newPin
});




}
/// @nodoc
class _$ChangePinRequestCopyWithImpl<$Res>
    implements $ChangePinRequestCopyWith<$Res> {
  _$ChangePinRequestCopyWithImpl(this._self, this._then);

  final ChangePinRequest _self;
  final $Res Function(ChangePinRequest) _then;

/// Create a copy of ChangePinRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? oldPin = null,Object? newPin = null,}) {
  return _then(_self.copyWith(
oldPin: null == oldPin ? _self.oldPin : oldPin // ignore: cast_nullable_to_non_nullable
as String,newPin: null == newPin ? _self.newPin : newPin // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChangePinRequest].
extension ChangePinRequestPatterns on ChangePinRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChangePinRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangePinRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChangePinRequest value)  $default,){
final _that = this;
switch (_that) {
case _ChangePinRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChangePinRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ChangePinRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "oldPin")  String oldPin, @JsonKey(name: "newPin")  String newPin)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChangePinRequest() when $default != null:
return $default(_that.oldPin,_that.newPin);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "oldPin")  String oldPin, @JsonKey(name: "newPin")  String newPin)  $default,) {final _that = this;
switch (_that) {
case _ChangePinRequest():
return $default(_that.oldPin,_that.newPin);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "oldPin")  String oldPin, @JsonKey(name: "newPin")  String newPin)?  $default,) {final _that = this;
switch (_that) {
case _ChangePinRequest() when $default != null:
return $default(_that.oldPin,_that.newPin);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChangePinRequest with DiagnosticableTreeMixin implements ChangePinRequest {
  const _ChangePinRequest({@JsonKey(name: "oldPin") required this.oldPin, @JsonKey(name: "newPin") required this.newPin});
  factory _ChangePinRequest.fromJson(Map<String, dynamic> json) => _$ChangePinRequestFromJson(json);

@override@JsonKey(name: "oldPin") final  String oldPin;
@override@JsonKey(name: "newPin") final  String newPin;

/// Create a copy of ChangePinRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangePinRequestCopyWith<_ChangePinRequest> get copyWith => __$ChangePinRequestCopyWithImpl<_ChangePinRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChangePinRequestToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ChangePinRequest'))
    ..add(DiagnosticsProperty('oldPin', oldPin))..add(DiagnosticsProperty('newPin', newPin));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangePinRequest&&(identical(other.oldPin, oldPin) || other.oldPin == oldPin)&&(identical(other.newPin, newPin) || other.newPin == newPin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,oldPin,newPin);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ChangePinRequest(oldPin: $oldPin, newPin: $newPin)';
}


}

/// @nodoc
abstract mixin class _$ChangePinRequestCopyWith<$Res> implements $ChangePinRequestCopyWith<$Res> {
  factory _$ChangePinRequestCopyWith(_ChangePinRequest value, $Res Function(_ChangePinRequest) _then) = __$ChangePinRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "oldPin") String oldPin,@JsonKey(name: "newPin") String newPin
});




}
/// @nodoc
class __$ChangePinRequestCopyWithImpl<$Res>
    implements _$ChangePinRequestCopyWith<$Res> {
  __$ChangePinRequestCopyWithImpl(this._self, this._then);

  final _ChangePinRequest _self;
  final $Res Function(_ChangePinRequest) _then;

/// Create a copy of ChangePinRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? oldPin = null,Object? newPin = null,}) {
  return _then(_ChangePinRequest(
oldPin: null == oldPin ? _self.oldPin : oldPin // ignore: cast_nullable_to_non_nullable
as String,newPin: null == newPin ? _self.newPin : newPin // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ResetPinRequest implements DiagnosticableTreeMixin {

@JsonKey(name: "password") String get password;
/// Create a copy of ResetPinRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPinRequestCopyWith<ResetPinRequest> get copyWith => _$ResetPinRequestCopyWithImpl<ResetPinRequest>(this as ResetPinRequest, _$identity);

  /// Serializes this ResetPinRequest to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ResetPinRequest'))
    ..add(DiagnosticsProperty('password', password));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPinRequest&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,password);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ResetPinRequest(password: $password)';
}


}

/// @nodoc
abstract mixin class $ResetPinRequestCopyWith<$Res>  {
  factory $ResetPinRequestCopyWith(ResetPinRequest value, $Res Function(ResetPinRequest) _then) = _$ResetPinRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "password") String password
});




}
/// @nodoc
class _$ResetPinRequestCopyWithImpl<$Res>
    implements $ResetPinRequestCopyWith<$Res> {
  _$ResetPinRequestCopyWithImpl(this._self, this._then);

  final ResetPinRequest _self;
  final $Res Function(ResetPinRequest) _then;

/// Create a copy of ResetPinRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? password = null,}) {
  return _then(_self.copyWith(
password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ResetPinRequest].
extension ResetPinRequestPatterns on ResetPinRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResetPinRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResetPinRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResetPinRequest value)  $default,){
final _that = this;
switch (_that) {
case _ResetPinRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResetPinRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ResetPinRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "password")  String password)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResetPinRequest() when $default != null:
return $default(_that.password);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "password")  String password)  $default,) {final _that = this;
switch (_that) {
case _ResetPinRequest():
return $default(_that.password);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "password")  String password)?  $default,) {final _that = this;
switch (_that) {
case _ResetPinRequest() when $default != null:
return $default(_that.password);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResetPinRequest with DiagnosticableTreeMixin implements ResetPinRequest {
  const _ResetPinRequest({@JsonKey(name: "password") required this.password});
  factory _ResetPinRequest.fromJson(Map<String, dynamic> json) => _$ResetPinRequestFromJson(json);

@override@JsonKey(name: "password") final  String password;

/// Create a copy of ResetPinRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResetPinRequestCopyWith<_ResetPinRequest> get copyWith => __$ResetPinRequestCopyWithImpl<_ResetPinRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResetPinRequestToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ResetPinRequest'))
    ..add(DiagnosticsProperty('password', password));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetPinRequest&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,password);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ResetPinRequest(password: $password)';
}


}

/// @nodoc
abstract mixin class _$ResetPinRequestCopyWith<$Res> implements $ResetPinRequestCopyWith<$Res> {
  factory _$ResetPinRequestCopyWith(_ResetPinRequest value, $Res Function(_ResetPinRequest) _then) = __$ResetPinRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "password") String password
});




}
/// @nodoc
class __$ResetPinRequestCopyWithImpl<$Res>
    implements _$ResetPinRequestCopyWith<$Res> {
  __$ResetPinRequestCopyWithImpl(this._self, this._then);

  final _ResetPinRequest _self;
  final $Res Function(_ResetPinRequest) _then;

/// Create a copy of ResetPinRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? password = null,}) {
  return _then(_ResetPinRequest(
password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CreatePinRequest implements DiagnosticableTreeMixin {

@JsonKey(name: "pin") String get pin;@JsonKey(name: "pin_confirmation") String get pinConfirmation;
/// Create a copy of CreatePinRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePinRequestCopyWith<CreatePinRequest> get copyWith => _$CreatePinRequestCopyWithImpl<CreatePinRequest>(this as CreatePinRequest, _$identity);

  /// Serializes this CreatePinRequest to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CreatePinRequest'))
    ..add(DiagnosticsProperty('pin', pin))..add(DiagnosticsProperty('pinConfirmation', pinConfirmation));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePinRequest&&(identical(other.pin, pin) || other.pin == pin)&&(identical(other.pinConfirmation, pinConfirmation) || other.pinConfirmation == pinConfirmation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pin,pinConfirmation);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CreatePinRequest(pin: $pin, pinConfirmation: $pinConfirmation)';
}


}

/// @nodoc
abstract mixin class $CreatePinRequestCopyWith<$Res>  {
  factory $CreatePinRequestCopyWith(CreatePinRequest value, $Res Function(CreatePinRequest) _then) = _$CreatePinRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "pin") String pin,@JsonKey(name: "pin_confirmation") String pinConfirmation
});




}
/// @nodoc
class _$CreatePinRequestCopyWithImpl<$Res>
    implements $CreatePinRequestCopyWith<$Res> {
  _$CreatePinRequestCopyWithImpl(this._self, this._then);

  final CreatePinRequest _self;
  final $Res Function(CreatePinRequest) _then;

/// Create a copy of CreatePinRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pin = null,Object? pinConfirmation = null,}) {
  return _then(_self.copyWith(
pin: null == pin ? _self.pin : pin // ignore: cast_nullable_to_non_nullable
as String,pinConfirmation: null == pinConfirmation ? _self.pinConfirmation : pinConfirmation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatePinRequest].
extension CreatePinRequestPatterns on CreatePinRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatePinRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatePinRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatePinRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreatePinRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatePinRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreatePinRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "pin")  String pin, @JsonKey(name: "pin_confirmation")  String pinConfirmation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatePinRequest() when $default != null:
return $default(_that.pin,_that.pinConfirmation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "pin")  String pin, @JsonKey(name: "pin_confirmation")  String pinConfirmation)  $default,) {final _that = this;
switch (_that) {
case _CreatePinRequest():
return $default(_that.pin,_that.pinConfirmation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "pin")  String pin, @JsonKey(name: "pin_confirmation")  String pinConfirmation)?  $default,) {final _that = this;
switch (_that) {
case _CreatePinRequest() when $default != null:
return $default(_that.pin,_that.pinConfirmation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatePinRequest with DiagnosticableTreeMixin implements CreatePinRequest {
  const _CreatePinRequest({@JsonKey(name: "pin") required this.pin, @JsonKey(name: "pin_confirmation") required this.pinConfirmation});
  factory _CreatePinRequest.fromJson(Map<String, dynamic> json) => _$CreatePinRequestFromJson(json);

@override@JsonKey(name: "pin") final  String pin;
@override@JsonKey(name: "pin_confirmation") final  String pinConfirmation;

/// Create a copy of CreatePinRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatePinRequestCopyWith<_CreatePinRequest> get copyWith => __$CreatePinRequestCopyWithImpl<_CreatePinRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatePinRequestToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CreatePinRequest'))
    ..add(DiagnosticsProperty('pin', pin))..add(DiagnosticsProperty('pinConfirmation', pinConfirmation));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePinRequest&&(identical(other.pin, pin) || other.pin == pin)&&(identical(other.pinConfirmation, pinConfirmation) || other.pinConfirmation == pinConfirmation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pin,pinConfirmation);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CreatePinRequest(pin: $pin, pinConfirmation: $pinConfirmation)';
}


}

/// @nodoc
abstract mixin class _$CreatePinRequestCopyWith<$Res> implements $CreatePinRequestCopyWith<$Res> {
  factory _$CreatePinRequestCopyWith(_CreatePinRequest value, $Res Function(_CreatePinRequest) _then) = __$CreatePinRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "pin") String pin,@JsonKey(name: "pin_confirmation") String pinConfirmation
});




}
/// @nodoc
class __$CreatePinRequestCopyWithImpl<$Res>
    implements _$CreatePinRequestCopyWith<$Res> {
  __$CreatePinRequestCopyWithImpl(this._self, this._then);

  final _CreatePinRequest _self;
  final $Res Function(_CreatePinRequest) _then;

/// Create a copy of CreatePinRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pin = null,Object? pinConfirmation = null,}) {
  return _then(_CreatePinRequest(
pin: null == pin ? _self.pin : pin // ignore: cast_nullable_to_non_nullable
as String,pinConfirmation: null == pinConfirmation ? _self.pinConfirmation : pinConfirmation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$VerifyPinRequest implements DiagnosticableTreeMixin {

@JsonKey(name: "pin") String get pin;
/// Create a copy of VerifyPinRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyPinRequestCopyWith<VerifyPinRequest> get copyWith => _$VerifyPinRequestCopyWithImpl<VerifyPinRequest>(this as VerifyPinRequest, _$identity);

  /// Serializes this VerifyPinRequest to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'VerifyPinRequest'))
    ..add(DiagnosticsProperty('pin', pin));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyPinRequest&&(identical(other.pin, pin) || other.pin == pin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pin);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'VerifyPinRequest(pin: $pin)';
}


}

/// @nodoc
abstract mixin class $VerifyPinRequestCopyWith<$Res>  {
  factory $VerifyPinRequestCopyWith(VerifyPinRequest value, $Res Function(VerifyPinRequest) _then) = _$VerifyPinRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "pin") String pin
});




}
/// @nodoc
class _$VerifyPinRequestCopyWithImpl<$Res>
    implements $VerifyPinRequestCopyWith<$Res> {
  _$VerifyPinRequestCopyWithImpl(this._self, this._then);

  final VerifyPinRequest _self;
  final $Res Function(VerifyPinRequest) _then;

/// Create a copy of VerifyPinRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pin = null,}) {
  return _then(_self.copyWith(
pin: null == pin ? _self.pin : pin // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyPinRequest].
extension VerifyPinRequestPatterns on VerifyPinRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyPinRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyPinRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyPinRequest value)  $default,){
final _that = this;
switch (_that) {
case _VerifyPinRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyPinRequest value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyPinRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "pin")  String pin)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyPinRequest() when $default != null:
return $default(_that.pin);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "pin")  String pin)  $default,) {final _that = this;
switch (_that) {
case _VerifyPinRequest():
return $default(_that.pin);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "pin")  String pin)?  $default,) {final _that = this;
switch (_that) {
case _VerifyPinRequest() when $default != null:
return $default(_that.pin);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyPinRequest with DiagnosticableTreeMixin implements VerifyPinRequest {
  const _VerifyPinRequest({@JsonKey(name: "pin") required this.pin});
  factory _VerifyPinRequest.fromJson(Map<String, dynamic> json) => _$VerifyPinRequestFromJson(json);

@override@JsonKey(name: "pin") final  String pin;

/// Create a copy of VerifyPinRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyPinRequestCopyWith<_VerifyPinRequest> get copyWith => __$VerifyPinRequestCopyWithImpl<_VerifyPinRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyPinRequestToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'VerifyPinRequest'))
    ..add(DiagnosticsProperty('pin', pin));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyPinRequest&&(identical(other.pin, pin) || other.pin == pin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pin);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'VerifyPinRequest(pin: $pin)';
}


}

/// @nodoc
abstract mixin class _$VerifyPinRequestCopyWith<$Res> implements $VerifyPinRequestCopyWith<$Res> {
  factory _$VerifyPinRequestCopyWith(_VerifyPinRequest value, $Res Function(_VerifyPinRequest) _then) = __$VerifyPinRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "pin") String pin
});




}
/// @nodoc
class __$VerifyPinRequestCopyWithImpl<$Res>
    implements _$VerifyPinRequestCopyWith<$Res> {
  __$VerifyPinRequestCopyWithImpl(this._self, this._then);

  final _VerifyPinRequest _self;
  final $Res Function(_VerifyPinRequest) _then;

/// Create a copy of VerifyPinRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pin = null,}) {
  return _then(_VerifyPinRequest(
pin: null == pin ? _self.pin : pin // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ChangePasswordRequest implements DiagnosticableTreeMixin {

@JsonKey(name: "oldPassword") String get oldPassword;@JsonKey(name: "newPassword") String get newPassword;
/// Create a copy of ChangePasswordRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangePasswordRequestCopyWith<ChangePasswordRequest> get copyWith => _$ChangePasswordRequestCopyWithImpl<ChangePasswordRequest>(this as ChangePasswordRequest, _$identity);

  /// Serializes this ChangePasswordRequest to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ChangePasswordRequest'))
    ..add(DiagnosticsProperty('oldPassword', oldPassword))..add(DiagnosticsProperty('newPassword', newPassword));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangePasswordRequest&&(identical(other.oldPassword, oldPassword) || other.oldPassword == oldPassword)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,oldPassword,newPassword);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ChangePasswordRequest(oldPassword: $oldPassword, newPassword: $newPassword)';
}


}

/// @nodoc
abstract mixin class $ChangePasswordRequestCopyWith<$Res>  {
  factory $ChangePasswordRequestCopyWith(ChangePasswordRequest value, $Res Function(ChangePasswordRequest) _then) = _$ChangePasswordRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "oldPassword") String oldPassword,@JsonKey(name: "newPassword") String newPassword
});




}
/// @nodoc
class _$ChangePasswordRequestCopyWithImpl<$Res>
    implements $ChangePasswordRequestCopyWith<$Res> {
  _$ChangePasswordRequestCopyWithImpl(this._self, this._then);

  final ChangePasswordRequest _self;
  final $Res Function(ChangePasswordRequest) _then;

/// Create a copy of ChangePasswordRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? oldPassword = null,Object? newPassword = null,}) {
  return _then(_self.copyWith(
oldPassword: null == oldPassword ? _self.oldPassword : oldPassword // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChangePasswordRequest].
extension ChangePasswordRequestPatterns on ChangePasswordRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChangePasswordRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangePasswordRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChangePasswordRequest value)  $default,){
final _that = this;
switch (_that) {
case _ChangePasswordRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChangePasswordRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ChangePasswordRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "oldPassword")  String oldPassword, @JsonKey(name: "newPassword")  String newPassword)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChangePasswordRequest() when $default != null:
return $default(_that.oldPassword,_that.newPassword);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "oldPassword")  String oldPassword, @JsonKey(name: "newPassword")  String newPassword)  $default,) {final _that = this;
switch (_that) {
case _ChangePasswordRequest():
return $default(_that.oldPassword,_that.newPassword);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "oldPassword")  String oldPassword, @JsonKey(name: "newPassword")  String newPassword)?  $default,) {final _that = this;
switch (_that) {
case _ChangePasswordRequest() when $default != null:
return $default(_that.oldPassword,_that.newPassword);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChangePasswordRequest with DiagnosticableTreeMixin implements ChangePasswordRequest {
  const _ChangePasswordRequest({@JsonKey(name: "oldPassword") required this.oldPassword, @JsonKey(name: "newPassword") required this.newPassword});
  factory _ChangePasswordRequest.fromJson(Map<String, dynamic> json) => _$ChangePasswordRequestFromJson(json);

@override@JsonKey(name: "oldPassword") final  String oldPassword;
@override@JsonKey(name: "newPassword") final  String newPassword;

/// Create a copy of ChangePasswordRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangePasswordRequestCopyWith<_ChangePasswordRequest> get copyWith => __$ChangePasswordRequestCopyWithImpl<_ChangePasswordRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChangePasswordRequestToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ChangePasswordRequest'))
    ..add(DiagnosticsProperty('oldPassword', oldPassword))..add(DiagnosticsProperty('newPassword', newPassword));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangePasswordRequest&&(identical(other.oldPassword, oldPassword) || other.oldPassword == oldPassword)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,oldPassword,newPassword);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ChangePasswordRequest(oldPassword: $oldPassword, newPassword: $newPassword)';
}


}

/// @nodoc
abstract mixin class _$ChangePasswordRequestCopyWith<$Res> implements $ChangePasswordRequestCopyWith<$Res> {
  factory _$ChangePasswordRequestCopyWith(_ChangePasswordRequest value, $Res Function(_ChangePasswordRequest) _then) = __$ChangePasswordRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "oldPassword") String oldPassword,@JsonKey(name: "newPassword") String newPassword
});




}
/// @nodoc
class __$ChangePasswordRequestCopyWithImpl<$Res>
    implements _$ChangePasswordRequestCopyWith<$Res> {
  __$ChangePasswordRequestCopyWithImpl(this._self, this._then);

  final _ChangePasswordRequest _self;
  final $Res Function(_ChangePasswordRequest) _then;

/// Create a copy of ChangePasswordRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? oldPassword = null,Object? newPassword = null,}) {
  return _then(_ChangePasswordRequest(
oldPassword: null == oldPassword ? _self.oldPassword : oldPassword // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
