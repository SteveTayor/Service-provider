// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'become_a_merchant_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BecomeAMerchantRequest {

@JsonKey(name: "mac_address") String get macAddress;@JsonKey(name: "ip_address") String get ipAddress;@JsonKey(name: "latitude") String get latitude;@JsonKey(name: "longitude") String get longitude;@JsonKey(name: "platform") String get platform;
/// Create a copy of BecomeAMerchantRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BecomeAMerchantRequestCopyWith<BecomeAMerchantRequest> get copyWith => _$BecomeAMerchantRequestCopyWithImpl<BecomeAMerchantRequest>(this as BecomeAMerchantRequest, _$identity);

  /// Serializes this BecomeAMerchantRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BecomeAMerchantRequest&&(identical(other.macAddress, macAddress) || other.macAddress == macAddress)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.platform, platform) || other.platform == platform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,macAddress,ipAddress,latitude,longitude,platform);

@override
String toString() {
  return 'BecomeAMerchantRequest(macAddress: $macAddress, ipAddress: $ipAddress, latitude: $latitude, longitude: $longitude, platform: $platform)';
}


}

/// @nodoc
abstract mixin class $BecomeAMerchantRequestCopyWith<$Res>  {
  factory $BecomeAMerchantRequestCopyWith(BecomeAMerchantRequest value, $Res Function(BecomeAMerchantRequest) _then) = _$BecomeAMerchantRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "mac_address") String macAddress,@JsonKey(name: "ip_address") String ipAddress,@JsonKey(name: "latitude") String latitude,@JsonKey(name: "longitude") String longitude,@JsonKey(name: "platform") String platform
});




}
/// @nodoc
class _$BecomeAMerchantRequestCopyWithImpl<$Res>
    implements $BecomeAMerchantRequestCopyWith<$Res> {
  _$BecomeAMerchantRequestCopyWithImpl(this._self, this._then);

  final BecomeAMerchantRequest _self;
  final $Res Function(BecomeAMerchantRequest) _then;

/// Create a copy of BecomeAMerchantRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? macAddress = null,Object? ipAddress = null,Object? latitude = null,Object? longitude = null,Object? platform = null,}) {
  return _then(_self.copyWith(
macAddress: null == macAddress ? _self.macAddress : macAddress // ignore: cast_nullable_to_non_nullable
as String,ipAddress: null == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as String,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BecomeAMerchantRequest].
extension BecomeAMerchantRequestPatterns on BecomeAMerchantRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BecomeAMerchantRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BecomeAMerchantRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BecomeAMerchantRequest value)  $default,){
final _that = this;
switch (_that) {
case _BecomeAMerchantRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BecomeAMerchantRequest value)?  $default,){
final _that = this;
switch (_that) {
case _BecomeAMerchantRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "mac_address")  String macAddress, @JsonKey(name: "ip_address")  String ipAddress, @JsonKey(name: "latitude")  String latitude, @JsonKey(name: "longitude")  String longitude, @JsonKey(name: "platform")  String platform)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BecomeAMerchantRequest() when $default != null:
return $default(_that.macAddress,_that.ipAddress,_that.latitude,_that.longitude,_that.platform);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "mac_address")  String macAddress, @JsonKey(name: "ip_address")  String ipAddress, @JsonKey(name: "latitude")  String latitude, @JsonKey(name: "longitude")  String longitude, @JsonKey(name: "platform")  String platform)  $default,) {final _that = this;
switch (_that) {
case _BecomeAMerchantRequest():
return $default(_that.macAddress,_that.ipAddress,_that.latitude,_that.longitude,_that.platform);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "mac_address")  String macAddress, @JsonKey(name: "ip_address")  String ipAddress, @JsonKey(name: "latitude")  String latitude, @JsonKey(name: "longitude")  String longitude, @JsonKey(name: "platform")  String platform)?  $default,) {final _that = this;
switch (_that) {
case _BecomeAMerchantRequest() when $default != null:
return $default(_that.macAddress,_that.ipAddress,_that.latitude,_that.longitude,_that.platform);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BecomeAMerchantRequest implements BecomeAMerchantRequest {
  const _BecomeAMerchantRequest({@JsonKey(name: "mac_address") required this.macAddress, @JsonKey(name: "ip_address") required this.ipAddress, @JsonKey(name: "latitude") required this.latitude, @JsonKey(name: "longitude") required this.longitude, @JsonKey(name: "platform") required this.platform});
  factory _BecomeAMerchantRequest.fromJson(Map<String, dynamic> json) => _$BecomeAMerchantRequestFromJson(json);

@override@JsonKey(name: "mac_address") final  String macAddress;
@override@JsonKey(name: "ip_address") final  String ipAddress;
@override@JsonKey(name: "latitude") final  String latitude;
@override@JsonKey(name: "longitude") final  String longitude;
@override@JsonKey(name: "platform") final  String platform;

/// Create a copy of BecomeAMerchantRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BecomeAMerchantRequestCopyWith<_BecomeAMerchantRequest> get copyWith => __$BecomeAMerchantRequestCopyWithImpl<_BecomeAMerchantRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BecomeAMerchantRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BecomeAMerchantRequest&&(identical(other.macAddress, macAddress) || other.macAddress == macAddress)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.platform, platform) || other.platform == platform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,macAddress,ipAddress,latitude,longitude,platform);

@override
String toString() {
  return 'BecomeAMerchantRequest(macAddress: $macAddress, ipAddress: $ipAddress, latitude: $latitude, longitude: $longitude, platform: $platform)';
}


}

/// @nodoc
abstract mixin class _$BecomeAMerchantRequestCopyWith<$Res> implements $BecomeAMerchantRequestCopyWith<$Res> {
  factory _$BecomeAMerchantRequestCopyWith(_BecomeAMerchantRequest value, $Res Function(_BecomeAMerchantRequest) _then) = __$BecomeAMerchantRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "mac_address") String macAddress,@JsonKey(name: "ip_address") String ipAddress,@JsonKey(name: "latitude") String latitude,@JsonKey(name: "longitude") String longitude,@JsonKey(name: "platform") String platform
});




}
/// @nodoc
class __$BecomeAMerchantRequestCopyWithImpl<$Res>
    implements _$BecomeAMerchantRequestCopyWith<$Res> {
  __$BecomeAMerchantRequestCopyWithImpl(this._self, this._then);

  final _BecomeAMerchantRequest _self;
  final $Res Function(_BecomeAMerchantRequest) _then;

/// Create a copy of BecomeAMerchantRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? macAddress = null,Object? ipAddress = null,Object? latitude = null,Object? longitude = null,Object? platform = null,}) {
  return _then(_BecomeAMerchantRequest(
macAddress: null == macAddress ? _self.macAddress : macAddress // ignore: cast_nullable_to_non_nullable
as String,ipAddress: null == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as String,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
