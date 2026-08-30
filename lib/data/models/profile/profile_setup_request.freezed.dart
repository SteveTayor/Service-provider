// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_setup_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileSetupRequest {

@JsonKey(name: "first_name") String? get firstName;@JsonKey(name: "last_name") String? get lastName;@JsonKey(name: "address") String? get address;@JsonKey(name: "date_of_birth") String? get dateOfBirth;@JsonKey(name: "gender") String? get gender;@JsonKey(name: "email") String? get email;
/// Create a copy of ProfileSetupRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileSetupRequestCopyWith<ProfileSetupRequest> get copyWith => _$ProfileSetupRequestCopyWithImpl<ProfileSetupRequest>(this as ProfileSetupRequest, _$identity);

  /// Serializes this ProfileSetupRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSetupRequest&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.address, address) || other.address == address)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,address,dateOfBirth,gender,email);

@override
String toString() {
  return 'ProfileSetupRequest(firstName: $firstName, lastName: $lastName, address: $address, dateOfBirth: $dateOfBirth, gender: $gender, email: $email)';
}


}

/// @nodoc
abstract mixin class $ProfileSetupRequestCopyWith<$Res>  {
  factory $ProfileSetupRequestCopyWith(ProfileSetupRequest value, $Res Function(ProfileSetupRequest) _then) = _$ProfileSetupRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "first_name") String? firstName,@JsonKey(name: "last_name") String? lastName,@JsonKey(name: "address") String? address,@JsonKey(name: "date_of_birth") String? dateOfBirth,@JsonKey(name: "gender") String? gender,@JsonKey(name: "email") String? email
});




}
/// @nodoc
class _$ProfileSetupRequestCopyWithImpl<$Res>
    implements $ProfileSetupRequestCopyWith<$Res> {
  _$ProfileSetupRequestCopyWithImpl(this._self, this._then);

  final ProfileSetupRequest _self;
  final $Res Function(ProfileSetupRequest) _then;

/// Create a copy of ProfileSetupRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = freezed,Object? lastName = freezed,Object? address = freezed,Object? dateOfBirth = freezed,Object? gender = freezed,Object? email = freezed,}) {
  return _then(_self.copyWith(
firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileSetupRequest].
extension ProfileSetupRequestPatterns on ProfileSetupRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileSetupRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileSetupRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileSetupRequest value)  $default,){
final _that = this;
switch (_that) {
case _ProfileSetupRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileSetupRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileSetupRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "first_name")  String? firstName, @JsonKey(name: "last_name")  String? lastName, @JsonKey(name: "address")  String? address, @JsonKey(name: "date_of_birth")  String? dateOfBirth, @JsonKey(name: "gender")  String? gender, @JsonKey(name: "email")  String? email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileSetupRequest() when $default != null:
return $default(_that.firstName,_that.lastName,_that.address,_that.dateOfBirth,_that.gender,_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "first_name")  String? firstName, @JsonKey(name: "last_name")  String? lastName, @JsonKey(name: "address")  String? address, @JsonKey(name: "date_of_birth")  String? dateOfBirth, @JsonKey(name: "gender")  String? gender, @JsonKey(name: "email")  String? email)  $default,) {final _that = this;
switch (_that) {
case _ProfileSetupRequest():
return $default(_that.firstName,_that.lastName,_that.address,_that.dateOfBirth,_that.gender,_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "first_name")  String? firstName, @JsonKey(name: "last_name")  String? lastName, @JsonKey(name: "address")  String? address, @JsonKey(name: "date_of_birth")  String? dateOfBirth, @JsonKey(name: "gender")  String? gender, @JsonKey(name: "email")  String? email)?  $default,) {final _that = this;
switch (_that) {
case _ProfileSetupRequest() when $default != null:
return $default(_that.firstName,_that.lastName,_that.address,_that.dateOfBirth,_that.gender,_that.email);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileSetupRequest implements ProfileSetupRequest {
  const _ProfileSetupRequest({@JsonKey(name: "first_name") this.firstName, @JsonKey(name: "last_name") this.lastName, @JsonKey(name: "address") this.address, @JsonKey(name: "date_of_birth") this.dateOfBirth, @JsonKey(name: "gender") this.gender, @JsonKey(name: "email") this.email});
  factory _ProfileSetupRequest.fromJson(Map<String, dynamic> json) => _$ProfileSetupRequestFromJson(json);

@override@JsonKey(name: "first_name") final  String? firstName;
@override@JsonKey(name: "last_name") final  String? lastName;
@override@JsonKey(name: "address") final  String? address;
@override@JsonKey(name: "date_of_birth") final  String? dateOfBirth;
@override@JsonKey(name: "gender") final  String? gender;
@override@JsonKey(name: "email") final  String? email;

/// Create a copy of ProfileSetupRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileSetupRequestCopyWith<_ProfileSetupRequest> get copyWith => __$ProfileSetupRequestCopyWithImpl<_ProfileSetupRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileSetupRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileSetupRequest&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.address, address) || other.address == address)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,address,dateOfBirth,gender,email);

@override
String toString() {
  return 'ProfileSetupRequest(firstName: $firstName, lastName: $lastName, address: $address, dateOfBirth: $dateOfBirth, gender: $gender, email: $email)';
}


}

/// @nodoc
abstract mixin class _$ProfileSetupRequestCopyWith<$Res> implements $ProfileSetupRequestCopyWith<$Res> {
  factory _$ProfileSetupRequestCopyWith(_ProfileSetupRequest value, $Res Function(_ProfileSetupRequest) _then) = __$ProfileSetupRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "first_name") String? firstName,@JsonKey(name: "last_name") String? lastName,@JsonKey(name: "address") String? address,@JsonKey(name: "date_of_birth") String? dateOfBirth,@JsonKey(name: "gender") String? gender,@JsonKey(name: "email") String? email
});




}
/// @nodoc
class __$ProfileSetupRequestCopyWithImpl<$Res>
    implements _$ProfileSetupRequestCopyWith<$Res> {
  __$ProfileSetupRequestCopyWithImpl(this._self, this._then);

  final _ProfileSetupRequest _self;
  final $Res Function(_ProfileSetupRequest) _then;

/// Create a copy of ProfileSetupRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = freezed,Object? lastName = freezed,Object? address = freezed,Object? dateOfBirth = freezed,Object? gender = freezed,Object? email = freezed,}) {
  return _then(_ProfileSetupRequest(
firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
