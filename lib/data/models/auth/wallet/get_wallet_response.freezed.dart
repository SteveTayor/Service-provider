// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_wallet_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetWalletResponse {

@JsonKey(name: "wallet") String? get wallet;@JsonKey(name: "promo_bonus", fromJson: _toDouble) double? get promoBonus;
/// Create a copy of GetWalletResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetWalletResponseCopyWith<GetWalletResponse> get copyWith => _$GetWalletResponseCopyWithImpl<GetWalletResponse>(this as GetWalletResponse, _$identity);

  /// Serializes this GetWalletResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetWalletResponse&&(identical(other.wallet, wallet) || other.wallet == wallet)&&(identical(other.promoBonus, promoBonus) || other.promoBonus == promoBonus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wallet,promoBonus);

@override
String toString() {
  return 'GetWalletResponse(wallet: $wallet, promoBonus: $promoBonus)';
}


}

/// @nodoc
abstract mixin class $GetWalletResponseCopyWith<$Res>  {
  factory $GetWalletResponseCopyWith(GetWalletResponse value, $Res Function(GetWalletResponse) _then) = _$GetWalletResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "wallet") String? wallet,@JsonKey(name: "promo_bonus", fromJson: _toDouble) double? promoBonus
});




}
/// @nodoc
class _$GetWalletResponseCopyWithImpl<$Res>
    implements $GetWalletResponseCopyWith<$Res> {
  _$GetWalletResponseCopyWithImpl(this._self, this._then);

  final GetWalletResponse _self;
  final $Res Function(GetWalletResponse) _then;

/// Create a copy of GetWalletResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? wallet = freezed,Object? promoBonus = freezed,}) {
  return _then(_self.copyWith(
wallet: freezed == wallet ? _self.wallet : wallet // ignore: cast_nullable_to_non_nullable
as String?,promoBonus: freezed == promoBonus ? _self.promoBonus : promoBonus // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [GetWalletResponse].
extension GetWalletResponsePatterns on GetWalletResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetWalletResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetWalletResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetWalletResponse value)  $default,){
final _that = this;
switch (_that) {
case _GetWalletResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetWalletResponse value)?  $default,){
final _that = this;
switch (_that) {
case _GetWalletResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "wallet")  String? wallet, @JsonKey(name: "promo_bonus", fromJson: _toDouble)  double? promoBonus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetWalletResponse() when $default != null:
return $default(_that.wallet,_that.promoBonus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "wallet")  String? wallet, @JsonKey(name: "promo_bonus", fromJson: _toDouble)  double? promoBonus)  $default,) {final _that = this;
switch (_that) {
case _GetWalletResponse():
return $default(_that.wallet,_that.promoBonus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "wallet")  String? wallet, @JsonKey(name: "promo_bonus", fromJson: _toDouble)  double? promoBonus)?  $default,) {final _that = this;
switch (_that) {
case _GetWalletResponse() when $default != null:
return $default(_that.wallet,_that.promoBonus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetWalletResponse implements GetWalletResponse {
  const _GetWalletResponse({@JsonKey(name: "wallet") this.wallet, @JsonKey(name: "promo_bonus", fromJson: _toDouble) this.promoBonus});
  factory _GetWalletResponse.fromJson(Map<String, dynamic> json) => _$GetWalletResponseFromJson(json);

@override@JsonKey(name: "wallet") final  String? wallet;
@override@JsonKey(name: "promo_bonus", fromJson: _toDouble) final  double? promoBonus;

/// Create a copy of GetWalletResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetWalletResponseCopyWith<_GetWalletResponse> get copyWith => __$GetWalletResponseCopyWithImpl<_GetWalletResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetWalletResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetWalletResponse&&(identical(other.wallet, wallet) || other.wallet == wallet)&&(identical(other.promoBonus, promoBonus) || other.promoBonus == promoBonus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wallet,promoBonus);

@override
String toString() {
  return 'GetWalletResponse(wallet: $wallet, promoBonus: $promoBonus)';
}


}

/// @nodoc
abstract mixin class _$GetWalletResponseCopyWith<$Res> implements $GetWalletResponseCopyWith<$Res> {
  factory _$GetWalletResponseCopyWith(_GetWalletResponse value, $Res Function(_GetWalletResponse) _then) = __$GetWalletResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "wallet") String? wallet,@JsonKey(name: "promo_bonus", fromJson: _toDouble) double? promoBonus
});




}
/// @nodoc
class __$GetWalletResponseCopyWithImpl<$Res>
    implements _$GetWalletResponseCopyWith<$Res> {
  __$GetWalletResponseCopyWithImpl(this._self, this._then);

  final _GetWalletResponse _self;
  final $Res Function(_GetWalletResponse) _then;

/// Create a copy of GetWalletResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? wallet = freezed,Object? promoBonus = freezed,}) {
  return _then(_GetWalletResponse(
wallet: freezed == wallet ? _self.wallet : wallet // ignore: cast_nullable_to_non_nullable
as String?,promoBonus: freezed == promoBonus ? _self.promoBonus : promoBonus // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
