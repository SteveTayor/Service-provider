// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'airtime_to_cash_transaction_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AirtimeTransactionHistoryResponse {

@JsonKey(name: "status") String? get status;@JsonKey(name: "data") List<AirtimeTransactionHistoryDto>? get data;@JsonKey(name: "message") String? get message;
/// Create a copy of AirtimeTransactionHistoryResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AirtimeTransactionHistoryResponseCopyWith<AirtimeTransactionHistoryResponse> get copyWith => _$AirtimeTransactionHistoryResponseCopyWithImpl<AirtimeTransactionHistoryResponse>(this as AirtimeTransactionHistoryResponse, _$identity);

  /// Serializes this AirtimeTransactionHistoryResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AirtimeTransactionHistoryResponse&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(data),message);

@override
String toString() {
  return 'AirtimeTransactionHistoryResponse(status: $status, data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class $AirtimeTransactionHistoryResponseCopyWith<$Res>  {
  factory $AirtimeTransactionHistoryResponseCopyWith(AirtimeTransactionHistoryResponse value, $Res Function(AirtimeTransactionHistoryResponse) _then) = _$AirtimeTransactionHistoryResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "status") String? status,@JsonKey(name: "data") List<AirtimeTransactionHistoryDto>? data,@JsonKey(name: "message") String? message
});




}
/// @nodoc
class _$AirtimeTransactionHistoryResponseCopyWithImpl<$Res>
    implements $AirtimeTransactionHistoryResponseCopyWith<$Res> {
  _$AirtimeTransactionHistoryResponseCopyWithImpl(this._self, this._then);

  final AirtimeTransactionHistoryResponse _self;
  final $Res Function(AirtimeTransactionHistoryResponse) _then;

/// Create a copy of AirtimeTransactionHistoryResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? data = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<AirtimeTransactionHistoryDto>?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AirtimeTransactionHistoryResponse].
extension AirtimeTransactionHistoryResponsePatterns on AirtimeTransactionHistoryResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AirtimeTransactionHistoryResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AirtimeTransactionHistoryResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AirtimeTransactionHistoryResponse value)  $default,){
final _that = this;
switch (_that) {
case _AirtimeTransactionHistoryResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AirtimeTransactionHistoryResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AirtimeTransactionHistoryResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  List<AirtimeTransactionHistoryDto>? data, @JsonKey(name: "message")  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AirtimeTransactionHistoryResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  List<AirtimeTransactionHistoryDto>? data, @JsonKey(name: "message")  String? message)  $default,) {final _that = this;
switch (_that) {
case _AirtimeTransactionHistoryResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  List<AirtimeTransactionHistoryDto>? data, @JsonKey(name: "message")  String? message)?  $default,) {final _that = this;
switch (_that) {
case _AirtimeTransactionHistoryResponse() when $default != null:
return $default(_that.status,_that.data,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AirtimeTransactionHistoryResponse implements AirtimeTransactionHistoryResponse {
  const _AirtimeTransactionHistoryResponse({@JsonKey(name: "status") this.status, @JsonKey(name: "data") final  List<AirtimeTransactionHistoryDto>? data, @JsonKey(name: "message") this.message}): _data = data;
  factory _AirtimeTransactionHistoryResponse.fromJson(Map<String, dynamic> json) => _$AirtimeTransactionHistoryResponseFromJson(json);

@override@JsonKey(name: "status") final  String? status;
 final  List<AirtimeTransactionHistoryDto>? _data;
@override@JsonKey(name: "data") List<AirtimeTransactionHistoryDto>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: "message") final  String? message;

/// Create a copy of AirtimeTransactionHistoryResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AirtimeTransactionHistoryResponseCopyWith<_AirtimeTransactionHistoryResponse> get copyWith => __$AirtimeTransactionHistoryResponseCopyWithImpl<_AirtimeTransactionHistoryResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AirtimeTransactionHistoryResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AirtimeTransactionHistoryResponse&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_data),message);

@override
String toString() {
  return 'AirtimeTransactionHistoryResponse(status: $status, data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class _$AirtimeTransactionHistoryResponseCopyWith<$Res> implements $AirtimeTransactionHistoryResponseCopyWith<$Res> {
  factory _$AirtimeTransactionHistoryResponseCopyWith(_AirtimeTransactionHistoryResponse value, $Res Function(_AirtimeTransactionHistoryResponse) _then) = __$AirtimeTransactionHistoryResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "status") String? status,@JsonKey(name: "data") List<AirtimeTransactionHistoryDto>? data,@JsonKey(name: "message") String? message
});




}
/// @nodoc
class __$AirtimeTransactionHistoryResponseCopyWithImpl<$Res>
    implements _$AirtimeTransactionHistoryResponseCopyWith<$Res> {
  __$AirtimeTransactionHistoryResponseCopyWithImpl(this._self, this._then);

  final _AirtimeTransactionHistoryResponse _self;
  final $Res Function(_AirtimeTransactionHistoryResponse) _then;

/// Create a copy of AirtimeTransactionHistoryResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? data = freezed,Object? message = freezed,}) {
  return _then(_AirtimeTransactionHistoryResponse(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<AirtimeTransactionHistoryDto>?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AirtimeTransactionHistoryDto {

@JsonKey(name: "id") int? get id;@JsonKey(name: "amount") String? get amount;@JsonKey(name: "cr_acc") String? get crAcc;@JsonKey(name: "trx_from") String? get trxFrom;@JsonKey(name: "trans_ref") String? get transRef;@JsonKey(name: "status") String? get status;@JsonKey(name: "created_at") String? get createdAt;@JsonKey(name: "sub_product") AirtimeSubProductDto? get subProduct;
/// Create a copy of AirtimeTransactionHistoryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AirtimeTransactionHistoryDtoCopyWith<AirtimeTransactionHistoryDto> get copyWith => _$AirtimeTransactionHistoryDtoCopyWithImpl<AirtimeTransactionHistoryDto>(this as AirtimeTransactionHistoryDto, _$identity);

  /// Serializes this AirtimeTransactionHistoryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AirtimeTransactionHistoryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.crAcc, crAcc) || other.crAcc == crAcc)&&(identical(other.trxFrom, trxFrom) || other.trxFrom == trxFrom)&&(identical(other.transRef, transRef) || other.transRef == transRef)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.subProduct, subProduct) || other.subProduct == subProduct));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,amount,crAcc,trxFrom,transRef,status,createdAt,subProduct);

@override
String toString() {
  return 'AirtimeTransactionHistoryDto(id: $id, amount: $amount, crAcc: $crAcc, trxFrom: $trxFrom, transRef: $transRef, status: $status, createdAt: $createdAt, subProduct: $subProduct)';
}


}

/// @nodoc
abstract mixin class $AirtimeTransactionHistoryDtoCopyWith<$Res>  {
  factory $AirtimeTransactionHistoryDtoCopyWith(AirtimeTransactionHistoryDto value, $Res Function(AirtimeTransactionHistoryDto) _then) = _$AirtimeTransactionHistoryDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "id") int? id,@JsonKey(name: "amount") String? amount,@JsonKey(name: "cr_acc") String? crAcc,@JsonKey(name: "trx_from") String? trxFrom,@JsonKey(name: "trans_ref") String? transRef,@JsonKey(name: "status") String? status,@JsonKey(name: "created_at") String? createdAt,@JsonKey(name: "sub_product") AirtimeSubProductDto? subProduct
});


$AirtimeSubProductDtoCopyWith<$Res>? get subProduct;

}
/// @nodoc
class _$AirtimeTransactionHistoryDtoCopyWithImpl<$Res>
    implements $AirtimeTransactionHistoryDtoCopyWith<$Res> {
  _$AirtimeTransactionHistoryDtoCopyWithImpl(this._self, this._then);

  final AirtimeTransactionHistoryDto _self;
  final $Res Function(AirtimeTransactionHistoryDto) _then;

/// Create a copy of AirtimeTransactionHistoryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? amount = freezed,Object? crAcc = freezed,Object? trxFrom = freezed,Object? transRef = freezed,Object? status = freezed,Object? createdAt = freezed,Object? subProduct = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String?,crAcc: freezed == crAcc ? _self.crAcc : crAcc // ignore: cast_nullable_to_non_nullable
as String?,trxFrom: freezed == trxFrom ? _self.trxFrom : trxFrom // ignore: cast_nullable_to_non_nullable
as String?,transRef: freezed == transRef ? _self.transRef : transRef // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,subProduct: freezed == subProduct ? _self.subProduct : subProduct // ignore: cast_nullable_to_non_nullable
as AirtimeSubProductDto?,
  ));
}
/// Create a copy of AirtimeTransactionHistoryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AirtimeSubProductDtoCopyWith<$Res>? get subProduct {
    if (_self.subProduct == null) {
    return null;
  }

  return $AirtimeSubProductDtoCopyWith<$Res>(_self.subProduct!, (value) {
    return _then(_self.copyWith(subProduct: value));
  });
}
}


/// Adds pattern-matching-related methods to [AirtimeTransactionHistoryDto].
extension AirtimeTransactionHistoryDtoPatterns on AirtimeTransactionHistoryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AirtimeTransactionHistoryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AirtimeTransactionHistoryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AirtimeTransactionHistoryDto value)  $default,){
final _that = this;
switch (_that) {
case _AirtimeTransactionHistoryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AirtimeTransactionHistoryDto value)?  $default,){
final _that = this;
switch (_that) {
case _AirtimeTransactionHistoryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "id")  int? id, @JsonKey(name: "amount")  String? amount, @JsonKey(name: "cr_acc")  String? crAcc, @JsonKey(name: "trx_from")  String? trxFrom, @JsonKey(name: "trans_ref")  String? transRef, @JsonKey(name: "status")  String? status, @JsonKey(name: "created_at")  String? createdAt, @JsonKey(name: "sub_product")  AirtimeSubProductDto? subProduct)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AirtimeTransactionHistoryDto() when $default != null:
return $default(_that.id,_that.amount,_that.crAcc,_that.trxFrom,_that.transRef,_that.status,_that.createdAt,_that.subProduct);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "id")  int? id, @JsonKey(name: "amount")  String? amount, @JsonKey(name: "cr_acc")  String? crAcc, @JsonKey(name: "trx_from")  String? trxFrom, @JsonKey(name: "trans_ref")  String? transRef, @JsonKey(name: "status")  String? status, @JsonKey(name: "created_at")  String? createdAt, @JsonKey(name: "sub_product")  AirtimeSubProductDto? subProduct)  $default,) {final _that = this;
switch (_that) {
case _AirtimeTransactionHistoryDto():
return $default(_that.id,_that.amount,_that.crAcc,_that.trxFrom,_that.transRef,_that.status,_that.createdAt,_that.subProduct);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "id")  int? id, @JsonKey(name: "amount")  String? amount, @JsonKey(name: "cr_acc")  String? crAcc, @JsonKey(name: "trx_from")  String? trxFrom, @JsonKey(name: "trans_ref")  String? transRef, @JsonKey(name: "status")  String? status, @JsonKey(name: "created_at")  String? createdAt, @JsonKey(name: "sub_product")  AirtimeSubProductDto? subProduct)?  $default,) {final _that = this;
switch (_that) {
case _AirtimeTransactionHistoryDto() when $default != null:
return $default(_that.id,_that.amount,_that.crAcc,_that.trxFrom,_that.transRef,_that.status,_that.createdAt,_that.subProduct);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AirtimeTransactionHistoryDto extends AirtimeTransactionHistoryDto {
  const _AirtimeTransactionHistoryDto({@JsonKey(name: "id") this.id, @JsonKey(name: "amount") this.amount, @JsonKey(name: "cr_acc") this.crAcc, @JsonKey(name: "trx_from") this.trxFrom, @JsonKey(name: "trans_ref") this.transRef, @JsonKey(name: "status") this.status, @JsonKey(name: "created_at") this.createdAt, @JsonKey(name: "sub_product") this.subProduct}): super._();
  factory _AirtimeTransactionHistoryDto.fromJson(Map<String, dynamic> json) => _$AirtimeTransactionHistoryDtoFromJson(json);

@override@JsonKey(name: "id") final  int? id;
@override@JsonKey(name: "amount") final  String? amount;
@override@JsonKey(name: "cr_acc") final  String? crAcc;
@override@JsonKey(name: "trx_from") final  String? trxFrom;
@override@JsonKey(name: "trans_ref") final  String? transRef;
@override@JsonKey(name: "status") final  String? status;
@override@JsonKey(name: "created_at") final  String? createdAt;
@override@JsonKey(name: "sub_product") final  AirtimeSubProductDto? subProduct;

/// Create a copy of AirtimeTransactionHistoryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AirtimeTransactionHistoryDtoCopyWith<_AirtimeTransactionHistoryDto> get copyWith => __$AirtimeTransactionHistoryDtoCopyWithImpl<_AirtimeTransactionHistoryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AirtimeTransactionHistoryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AirtimeTransactionHistoryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.crAcc, crAcc) || other.crAcc == crAcc)&&(identical(other.trxFrom, trxFrom) || other.trxFrom == trxFrom)&&(identical(other.transRef, transRef) || other.transRef == transRef)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.subProduct, subProduct) || other.subProduct == subProduct));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,amount,crAcc,trxFrom,transRef,status,createdAt,subProduct);

@override
String toString() {
  return 'AirtimeTransactionHistoryDto(id: $id, amount: $amount, crAcc: $crAcc, trxFrom: $trxFrom, transRef: $transRef, status: $status, createdAt: $createdAt, subProduct: $subProduct)';
}


}

/// @nodoc
abstract mixin class _$AirtimeTransactionHistoryDtoCopyWith<$Res> implements $AirtimeTransactionHistoryDtoCopyWith<$Res> {
  factory _$AirtimeTransactionHistoryDtoCopyWith(_AirtimeTransactionHistoryDto value, $Res Function(_AirtimeTransactionHistoryDto) _then) = __$AirtimeTransactionHistoryDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "id") int? id,@JsonKey(name: "amount") String? amount,@JsonKey(name: "cr_acc") String? crAcc,@JsonKey(name: "trx_from") String? trxFrom,@JsonKey(name: "trans_ref") String? transRef,@JsonKey(name: "status") String? status,@JsonKey(name: "created_at") String? createdAt,@JsonKey(name: "sub_product") AirtimeSubProductDto? subProduct
});


@override $AirtimeSubProductDtoCopyWith<$Res>? get subProduct;

}
/// @nodoc
class __$AirtimeTransactionHistoryDtoCopyWithImpl<$Res>
    implements _$AirtimeTransactionHistoryDtoCopyWith<$Res> {
  __$AirtimeTransactionHistoryDtoCopyWithImpl(this._self, this._then);

  final _AirtimeTransactionHistoryDto _self;
  final $Res Function(_AirtimeTransactionHistoryDto) _then;

/// Create a copy of AirtimeTransactionHistoryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? amount = freezed,Object? crAcc = freezed,Object? trxFrom = freezed,Object? transRef = freezed,Object? status = freezed,Object? createdAt = freezed,Object? subProduct = freezed,}) {
  return _then(_AirtimeTransactionHistoryDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String?,crAcc: freezed == crAcc ? _self.crAcc : crAcc // ignore: cast_nullable_to_non_nullable
as String?,trxFrom: freezed == trxFrom ? _self.trxFrom : trxFrom // ignore: cast_nullable_to_non_nullable
as String?,transRef: freezed == transRef ? _self.transRef : transRef // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,subProduct: freezed == subProduct ? _self.subProduct : subProduct // ignore: cast_nullable_to_non_nullable
as AirtimeSubProductDto?,
  ));
}

/// Create a copy of AirtimeTransactionHistoryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AirtimeSubProductDtoCopyWith<$Res>? get subProduct {
    if (_self.subProduct == null) {
    return null;
  }

  return $AirtimeSubProductDtoCopyWith<$Res>(_self.subProduct!, (value) {
    return _then(_self.copyWith(subProduct: value));
  });
}
}


/// @nodoc
mixin _$AirtimeSubProductDto {

// e.g. "MTN", "AIRTEL" — used to derive networkId; sub_name is only
// a display string ("Airtel Airtime to Cash").
@JsonKey(name: "auto_sub_prod_id") String? get autoSubProdId;@JsonKey(name: "sub_name") String? get subName;@JsonKey(name: "user_percent") String? get userPercent;
/// Create a copy of AirtimeSubProductDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AirtimeSubProductDtoCopyWith<AirtimeSubProductDto> get copyWith => _$AirtimeSubProductDtoCopyWithImpl<AirtimeSubProductDto>(this as AirtimeSubProductDto, _$identity);

  /// Serializes this AirtimeSubProductDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AirtimeSubProductDto&&(identical(other.autoSubProdId, autoSubProdId) || other.autoSubProdId == autoSubProdId)&&(identical(other.subName, subName) || other.subName == subName)&&(identical(other.userPercent, userPercent) || other.userPercent == userPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,autoSubProdId,subName,userPercent);

@override
String toString() {
  return 'AirtimeSubProductDto(autoSubProdId: $autoSubProdId, subName: $subName, userPercent: $userPercent)';
}


}

/// @nodoc
abstract mixin class $AirtimeSubProductDtoCopyWith<$Res>  {
  factory $AirtimeSubProductDtoCopyWith(AirtimeSubProductDto value, $Res Function(AirtimeSubProductDto) _then) = _$AirtimeSubProductDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "auto_sub_prod_id") String? autoSubProdId,@JsonKey(name: "sub_name") String? subName,@JsonKey(name: "user_percent") String? userPercent
});




}
/// @nodoc
class _$AirtimeSubProductDtoCopyWithImpl<$Res>
    implements $AirtimeSubProductDtoCopyWith<$Res> {
  _$AirtimeSubProductDtoCopyWithImpl(this._self, this._then);

  final AirtimeSubProductDto _self;
  final $Res Function(AirtimeSubProductDto) _then;

/// Create a copy of AirtimeSubProductDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? autoSubProdId = freezed,Object? subName = freezed,Object? userPercent = freezed,}) {
  return _then(_self.copyWith(
autoSubProdId: freezed == autoSubProdId ? _self.autoSubProdId : autoSubProdId // ignore: cast_nullable_to_non_nullable
as String?,subName: freezed == subName ? _self.subName : subName // ignore: cast_nullable_to_non_nullable
as String?,userPercent: freezed == userPercent ? _self.userPercent : userPercent // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AirtimeSubProductDto].
extension AirtimeSubProductDtoPatterns on AirtimeSubProductDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AirtimeSubProductDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AirtimeSubProductDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AirtimeSubProductDto value)  $default,){
final _that = this;
switch (_that) {
case _AirtimeSubProductDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AirtimeSubProductDto value)?  $default,){
final _that = this;
switch (_that) {
case _AirtimeSubProductDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "auto_sub_prod_id")  String? autoSubProdId, @JsonKey(name: "sub_name")  String? subName, @JsonKey(name: "user_percent")  String? userPercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AirtimeSubProductDto() when $default != null:
return $default(_that.autoSubProdId,_that.subName,_that.userPercent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "auto_sub_prod_id")  String? autoSubProdId, @JsonKey(name: "sub_name")  String? subName, @JsonKey(name: "user_percent")  String? userPercent)  $default,) {final _that = this;
switch (_that) {
case _AirtimeSubProductDto():
return $default(_that.autoSubProdId,_that.subName,_that.userPercent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "auto_sub_prod_id")  String? autoSubProdId, @JsonKey(name: "sub_name")  String? subName, @JsonKey(name: "user_percent")  String? userPercent)?  $default,) {final _that = this;
switch (_that) {
case _AirtimeSubProductDto() when $default != null:
return $default(_that.autoSubProdId,_that.subName,_that.userPercent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AirtimeSubProductDto implements AirtimeSubProductDto {
  const _AirtimeSubProductDto({@JsonKey(name: "auto_sub_prod_id") this.autoSubProdId, @JsonKey(name: "sub_name") this.subName, @JsonKey(name: "user_percent") this.userPercent});
  factory _AirtimeSubProductDto.fromJson(Map<String, dynamic> json) => _$AirtimeSubProductDtoFromJson(json);

// e.g. "MTN", "AIRTEL" — used to derive networkId; sub_name is only
// a display string ("Airtel Airtime to Cash").
@override@JsonKey(name: "auto_sub_prod_id") final  String? autoSubProdId;
@override@JsonKey(name: "sub_name") final  String? subName;
@override@JsonKey(name: "user_percent") final  String? userPercent;

/// Create a copy of AirtimeSubProductDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AirtimeSubProductDtoCopyWith<_AirtimeSubProductDto> get copyWith => __$AirtimeSubProductDtoCopyWithImpl<_AirtimeSubProductDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AirtimeSubProductDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AirtimeSubProductDto&&(identical(other.autoSubProdId, autoSubProdId) || other.autoSubProdId == autoSubProdId)&&(identical(other.subName, subName) || other.subName == subName)&&(identical(other.userPercent, userPercent) || other.userPercent == userPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,autoSubProdId,subName,userPercent);

@override
String toString() {
  return 'AirtimeSubProductDto(autoSubProdId: $autoSubProdId, subName: $subName, userPercent: $userPercent)';
}


}

/// @nodoc
abstract mixin class _$AirtimeSubProductDtoCopyWith<$Res> implements $AirtimeSubProductDtoCopyWith<$Res> {
  factory _$AirtimeSubProductDtoCopyWith(_AirtimeSubProductDto value, $Res Function(_AirtimeSubProductDto) _then) = __$AirtimeSubProductDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "auto_sub_prod_id") String? autoSubProdId,@JsonKey(name: "sub_name") String? subName,@JsonKey(name: "user_percent") String? userPercent
});




}
/// @nodoc
class __$AirtimeSubProductDtoCopyWithImpl<$Res>
    implements _$AirtimeSubProductDtoCopyWith<$Res> {
  __$AirtimeSubProductDtoCopyWithImpl(this._self, this._then);

  final _AirtimeSubProductDto _self;
  final $Res Function(_AirtimeSubProductDto) _then;

/// Create a copy of AirtimeSubProductDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? autoSubProdId = freezed,Object? subName = freezed,Object? userPercent = freezed,}) {
  return _then(_AirtimeSubProductDto(
autoSubProdId: freezed == autoSubProdId ? _self.autoSubProdId : autoSubProdId // ignore: cast_nullable_to_non_nullable
as String?,subName: freezed == subName ? _self.subName : subName // ignore: cast_nullable_to_non_nullable
as String?,userPercent: freezed == userPercent ? _self.userPercent : userPercent // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
