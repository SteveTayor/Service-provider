// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'become_a_merchant_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BecomeAMerchantRequest _$BecomeAMerchantRequestFromJson(
    Map<String, dynamic> json) {
  return _BecomeAMerchantRequest.fromJson(json);
}

/// @nodoc
mixin _$BecomeAMerchantRequest {
  @JsonKey(name: "mac_address")
  String get macAddress => throw _privateConstructorUsedError;
  @JsonKey(name: "ip_address")
  String get ipAddress => throw _privateConstructorUsedError;
  @JsonKey(name: "latitude")
  String get latitude => throw _privateConstructorUsedError;
  @JsonKey(name: "longitude")
  String get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: "platform")
  String get platform => throw _privateConstructorUsedError;

  /// Serializes this BecomeAMerchantRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BecomeAMerchantRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BecomeAMerchantRequestCopyWith<BecomeAMerchantRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BecomeAMerchantRequestCopyWith<$Res> {
  factory $BecomeAMerchantRequestCopyWith(BecomeAMerchantRequest value,
          $Res Function(BecomeAMerchantRequest) then) =
      _$BecomeAMerchantRequestCopyWithImpl<$Res, BecomeAMerchantRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: "mac_address") String macAddress,
      @JsonKey(name: "ip_address") String ipAddress,
      @JsonKey(name: "latitude") String latitude,
      @JsonKey(name: "longitude") String longitude,
      @JsonKey(name: "platform") String platform});
}

/// @nodoc
class _$BecomeAMerchantRequestCopyWithImpl<$Res,
        $Val extends BecomeAMerchantRequest>
    implements $BecomeAMerchantRequestCopyWith<$Res> {
  _$BecomeAMerchantRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BecomeAMerchantRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? macAddress = null,
    Object? ipAddress = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? platform = null,
  }) {
    return _then(_value.copyWith(
      macAddress: null == macAddress
          ? _value.macAddress
          : macAddress // ignore: cast_nullable_to_non_nullable
              as String,
      ipAddress: null == ipAddress
          ? _value.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BecomeAMerchantRequestImplCopyWith<$Res>
    implements $BecomeAMerchantRequestCopyWith<$Res> {
  factory _$$BecomeAMerchantRequestImplCopyWith(
          _$BecomeAMerchantRequestImpl value,
          $Res Function(_$BecomeAMerchantRequestImpl) then) =
      __$$BecomeAMerchantRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "mac_address") String macAddress,
      @JsonKey(name: "ip_address") String ipAddress,
      @JsonKey(name: "latitude") String latitude,
      @JsonKey(name: "longitude") String longitude,
      @JsonKey(name: "platform") String platform});
}

/// @nodoc
class __$$BecomeAMerchantRequestImplCopyWithImpl<$Res>
    extends _$BecomeAMerchantRequestCopyWithImpl<$Res,
        _$BecomeAMerchantRequestImpl>
    implements _$$BecomeAMerchantRequestImplCopyWith<$Res> {
  __$$BecomeAMerchantRequestImplCopyWithImpl(
      _$BecomeAMerchantRequestImpl _value,
      $Res Function(_$BecomeAMerchantRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of BecomeAMerchantRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? macAddress = null,
    Object? ipAddress = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? platform = null,
  }) {
    return _then(_$BecomeAMerchantRequestImpl(
      macAddress: null == macAddress
          ? _value.macAddress
          : macAddress // ignore: cast_nullable_to_non_nullable
              as String,
      ipAddress: null == ipAddress
          ? _value.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BecomeAMerchantRequestImpl implements _BecomeAMerchantRequest {
  const _$BecomeAMerchantRequestImpl(
      {@JsonKey(name: "mac_address") required this.macAddress,
      @JsonKey(name: "ip_address") required this.ipAddress,
      @JsonKey(name: "latitude") required this.latitude,
      @JsonKey(name: "longitude") required this.longitude,
      @JsonKey(name: "platform") required this.platform});

  factory _$BecomeAMerchantRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$BecomeAMerchantRequestImplFromJson(json);

  @override
  @JsonKey(name: "mac_address")
  final String macAddress;
  @override
  @JsonKey(name: "ip_address")
  final String ipAddress;
  @override
  @JsonKey(name: "latitude")
  final String latitude;
  @override
  @JsonKey(name: "longitude")
  final String longitude;
  @override
  @JsonKey(name: "platform")
  final String platform;

  @override
  String toString() {
    return 'BecomeAMerchantRequest(macAddress: $macAddress, ipAddress: $ipAddress, latitude: $latitude, longitude: $longitude, platform: $platform)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BecomeAMerchantRequestImpl &&
            (identical(other.macAddress, macAddress) ||
                other.macAddress == macAddress) &&
            (identical(other.ipAddress, ipAddress) ||
                other.ipAddress == ipAddress) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.platform, platform) ||
                other.platform == platform));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, macAddress, ipAddress, latitude, longitude, platform);

  /// Create a copy of BecomeAMerchantRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BecomeAMerchantRequestImplCopyWith<_$BecomeAMerchantRequestImpl>
      get copyWith => __$$BecomeAMerchantRequestImplCopyWithImpl<
          _$BecomeAMerchantRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BecomeAMerchantRequestImplToJson(
      this,
    );
  }
}

abstract class _BecomeAMerchantRequest implements BecomeAMerchantRequest {
  const factory _BecomeAMerchantRequest(
          {@JsonKey(name: "mac_address") required final String macAddress,
          @JsonKey(name: "ip_address") required final String ipAddress,
          @JsonKey(name: "latitude") required final String latitude,
          @JsonKey(name: "longitude") required final String longitude,
          @JsonKey(name: "platform") required final String platform}) =
      _$BecomeAMerchantRequestImpl;

  factory _BecomeAMerchantRequest.fromJson(Map<String, dynamic> json) =
      _$BecomeAMerchantRequestImpl.fromJson;

  @override
  @JsonKey(name: "mac_address")
  String get macAddress;
  @override
  @JsonKey(name: "ip_address")
  String get ipAddress;
  @override
  @JsonKey(name: "latitude")
  String get latitude;
  @override
  @JsonKey(name: "longitude")
  String get longitude;
  @override
  @JsonKey(name: "platform")
  String get platform;

  /// Create a copy of BecomeAMerchantRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BecomeAMerchantRequestImplCopyWith<_$BecomeAMerchantRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
