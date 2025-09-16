// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_wallet_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetWalletResponse _$GetWalletResponseFromJson(Map<String, dynamic> json) {
  return _GetWalletResponse.fromJson(json);
}

/// @nodoc
mixin _$GetWalletResponse {
  @JsonKey(name: "wallet")
  String? get wallet => throw _privateConstructorUsedError;
  @JsonKey(name: "promo_bonus", fromJson: _toDouble)
  double? get promoBonus => throw _privateConstructorUsedError;

  /// Serializes this GetWalletResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetWalletResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetWalletResponseCopyWith<GetWalletResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetWalletResponseCopyWith<$Res> {
  factory $GetWalletResponseCopyWith(
          GetWalletResponse value, $Res Function(GetWalletResponse) then) =
      _$GetWalletResponseCopyWithImpl<$Res, GetWalletResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: "wallet") String? wallet,
      @JsonKey(name: "promo_bonus", fromJson: _toDouble) double? promoBonus});
}

/// @nodoc
class _$GetWalletResponseCopyWithImpl<$Res, $Val extends GetWalletResponse>
    implements $GetWalletResponseCopyWith<$Res> {
  _$GetWalletResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetWalletResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wallet = freezed,
    Object? promoBonus = freezed,
  }) {
    return _then(_value.copyWith(
      wallet: freezed == wallet
          ? _value.wallet
          : wallet // ignore: cast_nullable_to_non_nullable
              as String?,
      promoBonus: freezed == promoBonus
          ? _value.promoBonus
          : promoBonus // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetWalletResponseImplCopyWith<$Res>
    implements $GetWalletResponseCopyWith<$Res> {
  factory _$$GetWalletResponseImplCopyWith(_$GetWalletResponseImpl value,
          $Res Function(_$GetWalletResponseImpl) then) =
      __$$GetWalletResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "wallet") String? wallet,
      @JsonKey(name: "promo_bonus", fromJson: _toDouble) double? promoBonus});
}

/// @nodoc
class __$$GetWalletResponseImplCopyWithImpl<$Res>
    extends _$GetWalletResponseCopyWithImpl<$Res, _$GetWalletResponseImpl>
    implements _$$GetWalletResponseImplCopyWith<$Res> {
  __$$GetWalletResponseImplCopyWithImpl(_$GetWalletResponseImpl _value,
      $Res Function(_$GetWalletResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetWalletResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wallet = freezed,
    Object? promoBonus = freezed,
  }) {
    return _then(_$GetWalletResponseImpl(
      wallet: freezed == wallet
          ? _value.wallet
          : wallet // ignore: cast_nullable_to_non_nullable
              as String?,
      promoBonus: freezed == promoBonus
          ? _value.promoBonus
          : promoBonus // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetWalletResponseImpl implements _GetWalletResponse {
  const _$GetWalletResponseImpl(
      {@JsonKey(name: "wallet") this.wallet,
      @JsonKey(name: "promo_bonus", fromJson: _toDouble) this.promoBonus});

  factory _$GetWalletResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetWalletResponseImplFromJson(json);

  @override
  @JsonKey(name: "wallet")
  final String? wallet;
  @override
  @JsonKey(name: "promo_bonus", fromJson: _toDouble)
  final double? promoBonus;

  @override
  String toString() {
    return 'GetWalletResponse(wallet: $wallet, promoBonus: $promoBonus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetWalletResponseImpl &&
            (identical(other.wallet, wallet) || other.wallet == wallet) &&
            (identical(other.promoBonus, promoBonus) ||
                other.promoBonus == promoBonus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, wallet, promoBonus);

  /// Create a copy of GetWalletResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetWalletResponseImplCopyWith<_$GetWalletResponseImpl> get copyWith =>
      __$$GetWalletResponseImplCopyWithImpl<_$GetWalletResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetWalletResponseImplToJson(
      this,
    );
  }
}

abstract class _GetWalletResponse implements GetWalletResponse {
  const factory _GetWalletResponse(
      {@JsonKey(name: "wallet") final String? wallet,
      @JsonKey(name: "promo_bonus", fromJson: _toDouble)
      final double? promoBonus}) = _$GetWalletResponseImpl;

  factory _GetWalletResponse.fromJson(Map<String, dynamic> json) =
      _$GetWalletResponseImpl.fromJson;

  @override
  @JsonKey(name: "wallet")
  String? get wallet;
  @override
  @JsonKey(name: "promo_bonus", fromJson: _toDouble)
  double? get promoBonus;

  /// Create a copy of GetWalletResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetWalletResponseImplCopyWith<_$GetWalletResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
