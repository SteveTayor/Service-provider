// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEntity {

 String get email; String get phone; String get firstName; String get lastName; String? get token; bool get isAuthenticated;
/// Create a copy of AuthEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthEntityCopyWith<AuthEntity> get copyWith => _$AuthEntityCopyWithImpl<AuthEntity>(this as AuthEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEntity&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.token, token) || other.token == token)&&(identical(other.isAuthenticated, isAuthenticated) || other.isAuthenticated == isAuthenticated));
}


@override
int get hashCode => Object.hash(runtimeType,email,phone,firstName,lastName,token,isAuthenticated);

@override
String toString() {
  return 'AuthEntity(email: $email, phone: $phone, firstName: $firstName, lastName: $lastName, token: $token, isAuthenticated: $isAuthenticated)';
}


}

/// @nodoc
abstract mixin class $AuthEntityCopyWith<$Res>  {
  factory $AuthEntityCopyWith(AuthEntity value, $Res Function(AuthEntity) _then) = _$AuthEntityCopyWithImpl;
@useResult
$Res call({
 String email, String phone, String firstName, String lastName, String? token, bool isAuthenticated
});




}
/// @nodoc
class _$AuthEntityCopyWithImpl<$Res>
    implements $AuthEntityCopyWith<$Res> {
  _$AuthEntityCopyWithImpl(this._self, this._then);

  final AuthEntity _self;
  final $Res Function(AuthEntity) _then;

/// Create a copy of AuthEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? phone = null,Object? firstName = null,Object? lastName = null,Object? token = freezed,Object? isAuthenticated = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,isAuthenticated: null == isAuthenticated ? _self.isAuthenticated : isAuthenticated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthEntity].
extension AuthEntityPatterns on AuthEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthEntity value)  $default,){
final _that = this;
switch (_that) {
case _AuthEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AuthEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String phone,  String firstName,  String lastName,  String? token,  bool isAuthenticated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthEntity() when $default != null:
return $default(_that.email,_that.phone,_that.firstName,_that.lastName,_that.token,_that.isAuthenticated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String phone,  String firstName,  String lastName,  String? token,  bool isAuthenticated)  $default,) {final _that = this;
switch (_that) {
case _AuthEntity():
return $default(_that.email,_that.phone,_that.firstName,_that.lastName,_that.token,_that.isAuthenticated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String phone,  String firstName,  String lastName,  String? token,  bool isAuthenticated)?  $default,) {final _that = this;
switch (_that) {
case _AuthEntity() when $default != null:
return $default(_that.email,_that.phone,_that.firstName,_that.lastName,_that.token,_that.isAuthenticated);case _:
  return null;

}
}

}

/// @nodoc


class _AuthEntity extends AuthEntity {
  const _AuthEntity({required this.email, required this.phone, required this.firstName, required this.lastName, this.token, this.isAuthenticated = false}): super._();
  

@override final  String email;
@override final  String phone;
@override final  String firstName;
@override final  String lastName;
@override final  String? token;
@override@JsonKey() final  bool isAuthenticated;

/// Create a copy of AuthEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthEntityCopyWith<_AuthEntity> get copyWith => __$AuthEntityCopyWithImpl<_AuthEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthEntity&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.token, token) || other.token == token)&&(identical(other.isAuthenticated, isAuthenticated) || other.isAuthenticated == isAuthenticated));
}


@override
int get hashCode => Object.hash(runtimeType,email,phone,firstName,lastName,token,isAuthenticated);

@override
String toString() {
  return 'AuthEntity(email: $email, phone: $phone, firstName: $firstName, lastName: $lastName, token: $token, isAuthenticated: $isAuthenticated)';
}


}

/// @nodoc
abstract mixin class _$AuthEntityCopyWith<$Res> implements $AuthEntityCopyWith<$Res> {
  factory _$AuthEntityCopyWith(_AuthEntity value, $Res Function(_AuthEntity) _then) = __$AuthEntityCopyWithImpl;
@override @useResult
$Res call({
 String email, String phone, String firstName, String lastName, String? token, bool isAuthenticated
});




}
/// @nodoc
class __$AuthEntityCopyWithImpl<$Res>
    implements _$AuthEntityCopyWith<$Res> {
  __$AuthEntityCopyWithImpl(this._self, this._then);

  final _AuthEntity _self;
  final $Res Function(_AuthEntity) _then;

/// Create a copy of AuthEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? phone = null,Object? firstName = null,Object? lastName = null,Object? token = freezed,Object? isAuthenticated = null,}) {
  return _then(_AuthEntity(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,isAuthenticated: null == isAuthenticated ? _self.isAuthenticated : isAuthenticated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
