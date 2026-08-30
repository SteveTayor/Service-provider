// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_setup_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileSetupResponse {

@JsonKey(name: "status") String? get status;@JsonKey(name: "data") String? get data;@JsonKey(name: "message") String? get message;
/// Create a copy of ProfileSetupResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileSetupResponseCopyWith<ProfileSetupResponse> get copyWith => _$ProfileSetupResponseCopyWithImpl<ProfileSetupResponse>(this as ProfileSetupResponse, _$identity);

  /// Serializes this ProfileSetupResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSetupResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.data, data) || other.data == data)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,data,message);

@override
String toString() {
  return 'ProfileSetupResponse(status: $status, data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class $ProfileSetupResponseCopyWith<$Res>  {
  factory $ProfileSetupResponseCopyWith(ProfileSetupResponse value, $Res Function(ProfileSetupResponse) _then) = _$ProfileSetupResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "status") String? status,@JsonKey(name: "data") String? data,@JsonKey(name: "message") String? message
});




}
/// @nodoc
class _$ProfileSetupResponseCopyWithImpl<$Res>
    implements $ProfileSetupResponseCopyWith<$Res> {
  _$ProfileSetupResponseCopyWithImpl(this._self, this._then);

  final ProfileSetupResponse _self;
  final $Res Function(ProfileSetupResponse) _then;

/// Create a copy of ProfileSetupResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? data = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileSetupResponse].
extension ProfileSetupResponsePatterns on ProfileSetupResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileSetupResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileSetupResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileSetupResponse value)  $default,){
final _that = this;
switch (_that) {
case _ProfileSetupResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileSetupResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileSetupResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  String? data, @JsonKey(name: "message")  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileSetupResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  String? data, @JsonKey(name: "message")  String? message)  $default,) {final _that = this;
switch (_that) {
case _ProfileSetupResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  String? data, @JsonKey(name: "message")  String? message)?  $default,) {final _that = this;
switch (_that) {
case _ProfileSetupResponse() when $default != null:
return $default(_that.status,_that.data,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileSetupResponse implements ProfileSetupResponse {
  const _ProfileSetupResponse({@JsonKey(name: "status") this.status, @JsonKey(name: "data") this.data, @JsonKey(name: "message") this.message});
  factory _ProfileSetupResponse.fromJson(Map<String, dynamic> json) => _$ProfileSetupResponseFromJson(json);

@override@JsonKey(name: "status") final  String? status;
@override@JsonKey(name: "data") final  String? data;
@override@JsonKey(name: "message") final  String? message;

/// Create a copy of ProfileSetupResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileSetupResponseCopyWith<_ProfileSetupResponse> get copyWith => __$ProfileSetupResponseCopyWithImpl<_ProfileSetupResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileSetupResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileSetupResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.data, data) || other.data == data)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,data,message);

@override
String toString() {
  return 'ProfileSetupResponse(status: $status, data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ProfileSetupResponseCopyWith<$Res> implements $ProfileSetupResponseCopyWith<$Res> {
  factory _$ProfileSetupResponseCopyWith(_ProfileSetupResponse value, $Res Function(_ProfileSetupResponse) _then) = __$ProfileSetupResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "status") String? status,@JsonKey(name: "data") String? data,@JsonKey(name: "message") String? message
});




}
/// @nodoc
class __$ProfileSetupResponseCopyWithImpl<$Res>
    implements _$ProfileSetupResponseCopyWith<$Res> {
  __$ProfileSetupResponseCopyWithImpl(this._self, this._then);

  final _ProfileSetupResponse _self;
  final $Res Function(_ProfileSetupResponse) _then;

/// Create a copy of ProfileSetupResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? data = freezed,Object? message = freezed,}) {
  return _then(_ProfileSetupResponse(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
