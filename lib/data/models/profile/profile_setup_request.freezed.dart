// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_setup_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProfileSetupRequest _$ProfileSetupRequestFromJson(Map<String, dynamic> json) {
  return _ProfileSetupRequest.fromJson(json);
}

/// @nodoc
mixin _$ProfileSetupRequest {
  @JsonKey(name: "first_name")
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: "last_name")
  String? get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: "address")
  String? get address => throw _privateConstructorUsedError;
  @JsonKey(name: "date_of_birth")
  String? get dateOfBirth => throw _privateConstructorUsedError;
  @JsonKey(name: "gender")
  String? get gender => throw _privateConstructorUsedError;

  /// Serializes this ProfileSetupRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileSetupRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileSetupRequestCopyWith<ProfileSetupRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileSetupRequestCopyWith<$Res> {
  factory $ProfileSetupRequestCopyWith(
          ProfileSetupRequest value, $Res Function(ProfileSetupRequest) then) =
      _$ProfileSetupRequestCopyWithImpl<$Res, ProfileSetupRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: "first_name") String? firstName,
      @JsonKey(name: "last_name") String? lastName,
      @JsonKey(name: "address") String? address,
      @JsonKey(name: "date_of_birth") String? dateOfBirth,
      @JsonKey(name: "gender") String? gender});
}

/// @nodoc
class _$ProfileSetupRequestCopyWithImpl<$Res, $Val extends ProfileSetupRequest>
    implements $ProfileSetupRequestCopyWith<$Res> {
  _$ProfileSetupRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileSetupRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? address = freezed,
    Object? dateOfBirth = freezed,
    Object? gender = freezed,
  }) {
    return _then(_value.copyWith(
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileSetupRequestImplCopyWith<$Res>
    implements $ProfileSetupRequestCopyWith<$Res> {
  factory _$$ProfileSetupRequestImplCopyWith(_$ProfileSetupRequestImpl value,
          $Res Function(_$ProfileSetupRequestImpl) then) =
      __$$ProfileSetupRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "first_name") String? firstName,
      @JsonKey(name: "last_name") String? lastName,
      @JsonKey(name: "address") String? address,
      @JsonKey(name: "date_of_birth") String? dateOfBirth,
      @JsonKey(name: "gender") String? gender});
}

/// @nodoc
class __$$ProfileSetupRequestImplCopyWithImpl<$Res>
    extends _$ProfileSetupRequestCopyWithImpl<$Res, _$ProfileSetupRequestImpl>
    implements _$$ProfileSetupRequestImplCopyWith<$Res> {
  __$$ProfileSetupRequestImplCopyWithImpl(_$ProfileSetupRequestImpl _value,
      $Res Function(_$ProfileSetupRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileSetupRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? address = freezed,
    Object? dateOfBirth = freezed,
    Object? gender = freezed,
  }) {
    return _then(_$ProfileSetupRequestImpl(
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileSetupRequestImpl implements _ProfileSetupRequest {
  const _$ProfileSetupRequestImpl(
      {@JsonKey(name: "first_name") this.firstName,
      @JsonKey(name: "last_name") this.lastName,
      @JsonKey(name: "address") this.address,
      @JsonKey(name: "date_of_birth") this.dateOfBirth,
      @JsonKey(name: "gender") this.gender});

  factory _$ProfileSetupRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileSetupRequestImplFromJson(json);

  @override
  @JsonKey(name: "first_name")
  final String? firstName;
  @override
  @JsonKey(name: "last_name")
  final String? lastName;
  @override
  @JsonKey(name: "address")
  final String? address;
  @override
  @JsonKey(name: "date_of_birth")
  final String? dateOfBirth;
  @override
  @JsonKey(name: "gender")
  final String? gender;

  @override
  String toString() {
    return 'ProfileSetupRequest(firstName: $firstName, lastName: $lastName, address: $address, dateOfBirth: $dateOfBirth, gender: $gender)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileSetupRequestImpl &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.gender, gender) || other.gender == gender));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, firstName, lastName, address, dateOfBirth, gender);

  /// Create a copy of ProfileSetupRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileSetupRequestImplCopyWith<_$ProfileSetupRequestImpl> get copyWith =>
      __$$ProfileSetupRequestImplCopyWithImpl<_$ProfileSetupRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileSetupRequestImplToJson(
      this,
    );
  }
}

abstract class _ProfileSetupRequest implements ProfileSetupRequest {
  const factory _ProfileSetupRequest(
          {@JsonKey(name: "first_name") final String? firstName,
          @JsonKey(name: "last_name") final String? lastName,
          @JsonKey(name: "address") final String? address,
          @JsonKey(name: "date_of_birth") final String? dateOfBirth,
          @JsonKey(name: "gender") final String? gender}) =
      _$ProfileSetupRequestImpl;

  factory _ProfileSetupRequest.fromJson(Map<String, dynamic> json) =
      _$ProfileSetupRequestImpl.fromJson;

  @override
  @JsonKey(name: "first_name")
  String? get firstName;
  @override
  @JsonKey(name: "last_name")
  String? get lastName;
  @override
  @JsonKey(name: "address")
  String? get address;
  @override
  @JsonKey(name: "date_of_birth")
  String? get dateOfBirth;
  @override
  @JsonKey(name: "gender")
  String? get gender;

  /// Create a copy of ProfileSetupRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileSetupRequestImplCopyWith<_$ProfileSetupRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
