// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'username_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UsernameResponse _$UsernameResponseFromJson(Map<String, dynamic> json) {
  return _UsernameResponse.fromJson(json);
}

/// @nodoc
mixin _$UsernameResponse {
  @JsonKey(name: "status")
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: "data")
  String? get data => throw _privateConstructorUsedError;
  @JsonKey(name: "message")
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this UsernameResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UsernameResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UsernameResponseCopyWith<UsernameResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsernameResponseCopyWith<$Res> {
  factory $UsernameResponseCopyWith(
          UsernameResponse value, $Res Function(UsernameResponse) then) =
      _$UsernameResponseCopyWithImpl<$Res, UsernameResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: "status") String? status,
      @JsonKey(name: "data") String? data,
      @JsonKey(name: "message") String? message});
}

/// @nodoc
class _$UsernameResponseCopyWithImpl<$Res, $Val extends UsernameResponse>
    implements $UsernameResponseCopyWith<$Res> {
  _$UsernameResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UsernameResponse
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
abstract class _$$UsernameResponseImplCopyWith<$Res>
    implements $UsernameResponseCopyWith<$Res> {
  factory _$$UsernameResponseImplCopyWith(_$UsernameResponseImpl value,
          $Res Function(_$UsernameResponseImpl) then) =
      __$$UsernameResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "status") String? status,
      @JsonKey(name: "data") String? data,
      @JsonKey(name: "message") String? message});
}

/// @nodoc
class __$$UsernameResponseImplCopyWithImpl<$Res>
    extends _$UsernameResponseCopyWithImpl<$Res, _$UsernameResponseImpl>
    implements _$$UsernameResponseImplCopyWith<$Res> {
  __$$UsernameResponseImplCopyWithImpl(_$UsernameResponseImpl _value,
      $Res Function(_$UsernameResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of UsernameResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_$UsernameResponseImpl(
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
class _$UsernameResponseImpl implements _UsernameResponse {
  const _$UsernameResponseImpl(
      {@JsonKey(name: "status") this.status,
      @JsonKey(name: "data") this.data,
      @JsonKey(name: "message") this.message});

  factory _$UsernameResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$UsernameResponseImplFromJson(json);

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
    return 'UsernameResponse(status: $status, data: $data, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsernameResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, data, message);

  /// Create a copy of UsernameResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsernameResponseImplCopyWith<_$UsernameResponseImpl> get copyWith =>
      __$$UsernameResponseImplCopyWithImpl<_$UsernameResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UsernameResponseImplToJson(
      this,
    );
  }
}

abstract class _UsernameResponse implements UsernameResponse {
  const factory _UsernameResponse(
          {@JsonKey(name: "status") final String? status,
          @JsonKey(name: "data") final String? data,
          @JsonKey(name: "message") final String? message}) =
      _$UsernameResponseImpl;

  factory _UsernameResponse.fromJson(Map<String, dynamic> json) =
      _$UsernameResponseImpl.fromJson;

  @override
  @JsonKey(name: "status")
  String? get status;
  @override
  @JsonKey(name: "data")
  String? get data;
  @override
  @JsonKey(name: "message")
  String? get message;

  /// Create a copy of UsernameResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsernameResponseImplCopyWith<_$UsernameResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
