// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_setup_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProfileSetupResponse _$ProfileSetupResponseFromJson(Map<String, dynamic> json) {
  return _ProfileSetupResponse.fromJson(json);
}

/// @nodoc
mixin _$ProfileSetupResponse {
  @JsonKey(name: "status")
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: "data")
  String? get data => throw _privateConstructorUsedError;
  @JsonKey(name: "message")
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this ProfileSetupResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileSetupResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileSetupResponseCopyWith<ProfileSetupResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileSetupResponseCopyWith<$Res> {
  factory $ProfileSetupResponseCopyWith(ProfileSetupResponse value,
          $Res Function(ProfileSetupResponse) then) =
      _$ProfileSetupResponseCopyWithImpl<$Res, ProfileSetupResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: "status") String? status,
      @JsonKey(name: "data") String? data,
      @JsonKey(name: "message") String? message});
}

/// @nodoc
class _$ProfileSetupResponseCopyWithImpl<$Res,
        $Val extends ProfileSetupResponse>
    implements $ProfileSetupResponseCopyWith<$Res> {
  _$ProfileSetupResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileSetupResponse
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
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileSetupResponseImplCopyWith<$Res>
    implements $ProfileSetupResponseCopyWith<$Res> {
  factory _$$ProfileSetupResponseImplCopyWith(_$ProfileSetupResponseImpl value,
          $Res Function(_$ProfileSetupResponseImpl) then) =
      __$$ProfileSetupResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "status") String? status,
      @JsonKey(name: "data") String? data,
      @JsonKey(name: "message") String? message});
}

/// @nodoc
class __$$ProfileSetupResponseImplCopyWithImpl<$Res>
    extends _$ProfileSetupResponseCopyWithImpl<$Res, _$ProfileSetupResponseImpl>
    implements _$$ProfileSetupResponseImplCopyWith<$Res> {
  __$$ProfileSetupResponseImplCopyWithImpl(_$ProfileSetupResponseImpl _value,
      $Res Function(_$ProfileSetupResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileSetupResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_$ProfileSetupResponseImpl(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileSetupResponseImpl implements _ProfileSetupResponse {
  const _$ProfileSetupResponseImpl(
      {@JsonKey(name: "status") this.status,
      @JsonKey(name: "data") this.data,
      @JsonKey(name: "message") this.message});

  factory _$ProfileSetupResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileSetupResponseImplFromJson(json);

  @override
  @JsonKey(name: "status")
  final String? status;
  @override
  @JsonKey(name: "data")
  final String? data;
  @override
  @JsonKey(name: "message")
  final String? message;

  @override
  String toString() {
    return 'ProfileSetupResponse(status: $status, data: $data, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileSetupResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, data, message);

  /// Create a copy of ProfileSetupResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileSetupResponseImplCopyWith<_$ProfileSetupResponseImpl>
      get copyWith =>
          __$$ProfileSetupResponseImplCopyWithImpl<_$ProfileSetupResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileSetupResponseImplToJson(
      this,
    );
  }
}

abstract class _ProfileSetupResponse implements ProfileSetupResponse {
  const factory _ProfileSetupResponse(
          {@JsonKey(name: "status") final String? status,
          @JsonKey(name: "data") final String? data,
          @JsonKey(name: "message") final String? message}) =
      _$ProfileSetupResponseImpl;

  factory _ProfileSetupResponse.fromJson(Map<String, dynamic> json) =
      _$ProfileSetupResponseImpl.fromJson;

  @override
  @JsonKey(name: "status")
  String? get status;
  @override
  @JsonKey(name: "data")
  String? get data;
  @override
  @JsonKey(name: "message")
  String? get message;

  /// Create a copy of ProfileSetupResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileSetupResponseImplCopyWith<_$ProfileSetupResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
