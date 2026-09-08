// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'airtime_to_cash_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AirtimeNetworksResponse {

@JsonKey(name: "status") String? get status;@JsonKey(name: "data") List<AirtimeNetworkDto>? get data;@JsonKey(name: "message") String? get message;
/// Create a copy of AirtimeNetworksResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AirtimeNetworksResponseCopyWith<AirtimeNetworksResponse> get copyWith => _$AirtimeNetworksResponseCopyWithImpl<AirtimeNetworksResponse>(this as AirtimeNetworksResponse, _$identity);

  /// Serializes this AirtimeNetworksResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AirtimeNetworksResponse&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(data),message);

@override
String toString() {
  return 'AirtimeNetworksResponse(status: $status, data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class $AirtimeNetworksResponseCopyWith<$Res>  {
  factory $AirtimeNetworksResponseCopyWith(AirtimeNetworksResponse value, $Res Function(AirtimeNetworksResponse) _then) = _$AirtimeNetworksResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "status") String? status,@JsonKey(name: "data") List<AirtimeNetworkDto>? data,@JsonKey(name: "message") String? message
});




}
/// @nodoc
class _$AirtimeNetworksResponseCopyWithImpl<$Res>
    implements $AirtimeNetworksResponseCopyWith<$Res> {
  _$AirtimeNetworksResponseCopyWithImpl(this._self, this._then);

  final AirtimeNetworksResponse _self;
  final $Res Function(AirtimeNetworksResponse) _then;

/// Create a copy of AirtimeNetworksResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? data = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<AirtimeNetworkDto>?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AirtimeNetworksResponse].
extension AirtimeNetworksResponsePatterns on AirtimeNetworksResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AirtimeNetworksResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AirtimeNetworksResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AirtimeNetworksResponse value)  $default,){
final _that = this;
switch (_that) {
case _AirtimeNetworksResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AirtimeNetworksResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AirtimeNetworksResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  List<AirtimeNetworkDto>? data, @JsonKey(name: "message")  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AirtimeNetworksResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  List<AirtimeNetworkDto>? data, @JsonKey(name: "message")  String? message)  $default,) {final _that = this;
switch (_that) {
case _AirtimeNetworksResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  List<AirtimeNetworkDto>? data, @JsonKey(name: "message")  String? message)?  $default,) {final _that = this;
switch (_that) {
case _AirtimeNetworksResponse() when $default != null:
return $default(_that.status,_that.data,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AirtimeNetworksResponse implements AirtimeNetworksResponse {
  const _AirtimeNetworksResponse({@JsonKey(name: "status") this.status, @JsonKey(name: "data") final  List<AirtimeNetworkDto>? data, @JsonKey(name: "message") this.message}): _data = data;
  factory _AirtimeNetworksResponse.fromJson(Map<String, dynamic> json) => _$AirtimeNetworksResponseFromJson(json);

@override@JsonKey(name: "status") final  String? status;
 final  List<AirtimeNetworkDto>? _data;
@override@JsonKey(name: "data") List<AirtimeNetworkDto>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: "message") final  String? message;

/// Create a copy of AirtimeNetworksResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AirtimeNetworksResponseCopyWith<_AirtimeNetworksResponse> get copyWith => __$AirtimeNetworksResponseCopyWithImpl<_AirtimeNetworksResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AirtimeNetworksResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AirtimeNetworksResponse&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_data),message);

@override
String toString() {
  return 'AirtimeNetworksResponse(status: $status, data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class _$AirtimeNetworksResponseCopyWith<$Res> implements $AirtimeNetworksResponseCopyWith<$Res> {
  factory _$AirtimeNetworksResponseCopyWith(_AirtimeNetworksResponse value, $Res Function(_AirtimeNetworksResponse) _then) = __$AirtimeNetworksResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "status") String? status,@JsonKey(name: "data") List<AirtimeNetworkDto>? data,@JsonKey(name: "message") String? message
});




}
/// @nodoc
class __$AirtimeNetworksResponseCopyWithImpl<$Res>
    implements _$AirtimeNetworksResponseCopyWith<$Res> {
  __$AirtimeNetworksResponseCopyWithImpl(this._self, this._then);

  final _AirtimeNetworksResponse _self;
  final $Res Function(_AirtimeNetworksResponse) _then;

/// Create a copy of AirtimeNetworksResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? data = freezed,Object? message = freezed,}) {
  return _then(_AirtimeNetworksResponse(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<AirtimeNetworkDto>?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AirtimeNetworkDto {

@JsonKey(name: "name") String? get name;@JsonKey(name: "code") String? get code;@JsonKey(name: "user_percentage") int? get userPercentage;@JsonKey(name: "agent_percentage") int? get agentPercentage;// The rate already resolved server-side for the calling user's role
// (matches user_percentage in every sample seen) — use this directly
// rather than re-deriving agent-vs-user client-side.
@JsonKey(name: "rate") int? get rate;
/// Create a copy of AirtimeNetworkDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AirtimeNetworkDtoCopyWith<AirtimeNetworkDto> get copyWith => _$AirtimeNetworkDtoCopyWithImpl<AirtimeNetworkDto>(this as AirtimeNetworkDto, _$identity);

  /// Serializes this AirtimeNetworkDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AirtimeNetworkDto&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.userPercentage, userPercentage) || other.userPercentage == userPercentage)&&(identical(other.agentPercentage, agentPercentage) || other.agentPercentage == agentPercentage)&&(identical(other.rate, rate) || other.rate == rate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,code,userPercentage,agentPercentage,rate);

@override
String toString() {
  return 'AirtimeNetworkDto(name: $name, code: $code, userPercentage: $userPercentage, agentPercentage: $agentPercentage, rate: $rate)';
}


}

/// @nodoc
abstract mixin class $AirtimeNetworkDtoCopyWith<$Res>  {
  factory $AirtimeNetworkDtoCopyWith(AirtimeNetworkDto value, $Res Function(AirtimeNetworkDto) _then) = _$AirtimeNetworkDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "name") String? name,@JsonKey(name: "code") String? code,@JsonKey(name: "user_percentage") int? userPercentage,@JsonKey(name: "agent_percentage") int? agentPercentage,@JsonKey(name: "rate") int? rate
});




}
/// @nodoc
class _$AirtimeNetworkDtoCopyWithImpl<$Res>
    implements $AirtimeNetworkDtoCopyWith<$Res> {
  _$AirtimeNetworkDtoCopyWithImpl(this._self, this._then);

  final AirtimeNetworkDto _self;
  final $Res Function(AirtimeNetworkDto) _then;

/// Create a copy of AirtimeNetworkDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? code = freezed,Object? userPercentage = freezed,Object? agentPercentage = freezed,Object? rate = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,userPercentage: freezed == userPercentage ? _self.userPercentage : userPercentage // ignore: cast_nullable_to_non_nullable
as int?,agentPercentage: freezed == agentPercentage ? _self.agentPercentage : agentPercentage // ignore: cast_nullable_to_non_nullable
as int?,rate: freezed == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [AirtimeNetworkDto].
extension AirtimeNetworkDtoPatterns on AirtimeNetworkDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AirtimeNetworkDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AirtimeNetworkDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AirtimeNetworkDto value)  $default,){
final _that = this;
switch (_that) {
case _AirtimeNetworkDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AirtimeNetworkDto value)?  $default,){
final _that = this;
switch (_that) {
case _AirtimeNetworkDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "name")  String? name, @JsonKey(name: "code")  String? code, @JsonKey(name: "user_percentage")  int? userPercentage, @JsonKey(name: "agent_percentage")  int? agentPercentage, @JsonKey(name: "rate")  int? rate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AirtimeNetworkDto() when $default != null:
return $default(_that.name,_that.code,_that.userPercentage,_that.agentPercentage,_that.rate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "name")  String? name, @JsonKey(name: "code")  String? code, @JsonKey(name: "user_percentage")  int? userPercentage, @JsonKey(name: "agent_percentage")  int? agentPercentage, @JsonKey(name: "rate")  int? rate)  $default,) {final _that = this;
switch (_that) {
case _AirtimeNetworkDto():
return $default(_that.name,_that.code,_that.userPercentage,_that.agentPercentage,_that.rate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "name")  String? name, @JsonKey(name: "code")  String? code, @JsonKey(name: "user_percentage")  int? userPercentage, @JsonKey(name: "agent_percentage")  int? agentPercentage, @JsonKey(name: "rate")  int? rate)?  $default,) {final _that = this;
switch (_that) {
case _AirtimeNetworkDto() when $default != null:
return $default(_that.name,_that.code,_that.userPercentage,_that.agentPercentage,_that.rate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AirtimeNetworkDto implements AirtimeNetworkDto {
  const _AirtimeNetworkDto({@JsonKey(name: "name") this.name, @JsonKey(name: "code") this.code, @JsonKey(name: "user_percentage") this.userPercentage, @JsonKey(name: "agent_percentage") this.agentPercentage, @JsonKey(name: "rate") this.rate});
  factory _AirtimeNetworkDto.fromJson(Map<String, dynamic> json) => _$AirtimeNetworkDtoFromJson(json);

@override@JsonKey(name: "name") final  String? name;
@override@JsonKey(name: "code") final  String? code;
@override@JsonKey(name: "user_percentage") final  int? userPercentage;
@override@JsonKey(name: "agent_percentage") final  int? agentPercentage;
// The rate already resolved server-side for the calling user's role
// (matches user_percentage in every sample seen) — use this directly
// rather than re-deriving agent-vs-user client-side.
@override@JsonKey(name: "rate") final  int? rate;

/// Create a copy of AirtimeNetworkDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AirtimeNetworkDtoCopyWith<_AirtimeNetworkDto> get copyWith => __$AirtimeNetworkDtoCopyWithImpl<_AirtimeNetworkDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AirtimeNetworkDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AirtimeNetworkDto&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.userPercentage, userPercentage) || other.userPercentage == userPercentage)&&(identical(other.agentPercentage, agentPercentage) || other.agentPercentage == agentPercentage)&&(identical(other.rate, rate) || other.rate == rate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,code,userPercentage,agentPercentage,rate);

@override
String toString() {
  return 'AirtimeNetworkDto(name: $name, code: $code, userPercentage: $userPercentage, agentPercentage: $agentPercentage, rate: $rate)';
}


}

/// @nodoc
abstract mixin class _$AirtimeNetworkDtoCopyWith<$Res> implements $AirtimeNetworkDtoCopyWith<$Res> {
  factory _$AirtimeNetworkDtoCopyWith(_AirtimeNetworkDto value, $Res Function(_AirtimeNetworkDto) _then) = __$AirtimeNetworkDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "name") String? name,@JsonKey(name: "code") String? code,@JsonKey(name: "user_percentage") int? userPercentage,@JsonKey(name: "agent_percentage") int? agentPercentage,@JsonKey(name: "rate") int? rate
});




}
/// @nodoc
class __$AirtimeNetworkDtoCopyWithImpl<$Res>
    implements _$AirtimeNetworkDtoCopyWith<$Res> {
  __$AirtimeNetworkDtoCopyWithImpl(this._self, this._then);

  final _AirtimeNetworkDto _self;
  final $Res Function(_AirtimeNetworkDto) _then;

/// Create a copy of AirtimeNetworkDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? code = freezed,Object? userPercentage = freezed,Object? agentPercentage = freezed,Object? rate = freezed,}) {
  return _then(_AirtimeNetworkDto(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,userPercentage: freezed == userPercentage ? _self.userPercentage : userPercentage // ignore: cast_nullable_to_non_nullable
as int?,agentPercentage: freezed == agentPercentage ? _self.agentPercentage : agentPercentage // ignore: cast_nullable_to_non_nullable
as int?,rate: freezed == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$AirtimeGenerateOtpRequest {

@JsonKey(name: "network") String get network;@JsonKey(name: "phone") String get phone;
/// Create a copy of AirtimeGenerateOtpRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AirtimeGenerateOtpRequestCopyWith<AirtimeGenerateOtpRequest> get copyWith => _$AirtimeGenerateOtpRequestCopyWithImpl<AirtimeGenerateOtpRequest>(this as AirtimeGenerateOtpRequest, _$identity);

  /// Serializes this AirtimeGenerateOtpRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AirtimeGenerateOtpRequest&&(identical(other.network, network) || other.network == network)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,network,phone);

@override
String toString() {
  return 'AirtimeGenerateOtpRequest(network: $network, phone: $phone)';
}


}

/// @nodoc
abstract mixin class $AirtimeGenerateOtpRequestCopyWith<$Res>  {
  factory $AirtimeGenerateOtpRequestCopyWith(AirtimeGenerateOtpRequest value, $Res Function(AirtimeGenerateOtpRequest) _then) = _$AirtimeGenerateOtpRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "network") String network,@JsonKey(name: "phone") String phone
});




}
/// @nodoc
class _$AirtimeGenerateOtpRequestCopyWithImpl<$Res>
    implements $AirtimeGenerateOtpRequestCopyWith<$Res> {
  _$AirtimeGenerateOtpRequestCopyWithImpl(this._self, this._then);

  final AirtimeGenerateOtpRequest _self;
  final $Res Function(AirtimeGenerateOtpRequest) _then;

/// Create a copy of AirtimeGenerateOtpRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? network = null,Object? phone = null,}) {
  return _then(_self.copyWith(
network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AirtimeGenerateOtpRequest].
extension AirtimeGenerateOtpRequestPatterns on AirtimeGenerateOtpRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AirtimeGenerateOtpRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AirtimeGenerateOtpRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AirtimeGenerateOtpRequest value)  $default,){
final _that = this;
switch (_that) {
case _AirtimeGenerateOtpRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AirtimeGenerateOtpRequest value)?  $default,){
final _that = this;
switch (_that) {
case _AirtimeGenerateOtpRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "network")  String network, @JsonKey(name: "phone")  String phone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AirtimeGenerateOtpRequest() when $default != null:
return $default(_that.network,_that.phone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "network")  String network, @JsonKey(name: "phone")  String phone)  $default,) {final _that = this;
switch (_that) {
case _AirtimeGenerateOtpRequest():
return $default(_that.network,_that.phone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "network")  String network, @JsonKey(name: "phone")  String phone)?  $default,) {final _that = this;
switch (_that) {
case _AirtimeGenerateOtpRequest() when $default != null:
return $default(_that.network,_that.phone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AirtimeGenerateOtpRequest implements AirtimeGenerateOtpRequest {
  const _AirtimeGenerateOtpRequest({@JsonKey(name: "network") required this.network, @JsonKey(name: "phone") required this.phone});
  factory _AirtimeGenerateOtpRequest.fromJson(Map<String, dynamic> json) => _$AirtimeGenerateOtpRequestFromJson(json);

@override@JsonKey(name: "network") final  String network;
@override@JsonKey(name: "phone") final  String phone;

/// Create a copy of AirtimeGenerateOtpRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AirtimeGenerateOtpRequestCopyWith<_AirtimeGenerateOtpRequest> get copyWith => __$AirtimeGenerateOtpRequestCopyWithImpl<_AirtimeGenerateOtpRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AirtimeGenerateOtpRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AirtimeGenerateOtpRequest&&(identical(other.network, network) || other.network == network)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,network,phone);

@override
String toString() {
  return 'AirtimeGenerateOtpRequest(network: $network, phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$AirtimeGenerateOtpRequestCopyWith<$Res> implements $AirtimeGenerateOtpRequestCopyWith<$Res> {
  factory _$AirtimeGenerateOtpRequestCopyWith(_AirtimeGenerateOtpRequest value, $Res Function(_AirtimeGenerateOtpRequest) _then) = __$AirtimeGenerateOtpRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "network") String network,@JsonKey(name: "phone") String phone
});




}
/// @nodoc
class __$AirtimeGenerateOtpRequestCopyWithImpl<$Res>
    implements _$AirtimeGenerateOtpRequestCopyWith<$Res> {
  __$AirtimeGenerateOtpRequestCopyWithImpl(this._self, this._then);

  final _AirtimeGenerateOtpRequest _self;
  final $Res Function(_AirtimeGenerateOtpRequest) _then;

/// Create a copy of AirtimeGenerateOtpRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? network = null,Object? phone = null,}) {
  return _then(_AirtimeGenerateOtpRequest(
network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AirtimeGenerateOtpResponse {

@JsonKey(name: "status") String? get status;@JsonKey(name: "data") AirtimeCodeMessage? get data;@JsonKey(name: "message") String? get message;
/// Create a copy of AirtimeGenerateOtpResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AirtimeGenerateOtpResponseCopyWith<AirtimeGenerateOtpResponse> get copyWith => _$AirtimeGenerateOtpResponseCopyWithImpl<AirtimeGenerateOtpResponse>(this as AirtimeGenerateOtpResponse, _$identity);

  /// Serializes this AirtimeGenerateOtpResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AirtimeGenerateOtpResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.data, data) || other.data == data)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,data,message);

@override
String toString() {
  return 'AirtimeGenerateOtpResponse(status: $status, data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class $AirtimeGenerateOtpResponseCopyWith<$Res>  {
  factory $AirtimeGenerateOtpResponseCopyWith(AirtimeGenerateOtpResponse value, $Res Function(AirtimeGenerateOtpResponse) _then) = _$AirtimeGenerateOtpResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "status") String? status,@JsonKey(name: "data") AirtimeCodeMessage? data,@JsonKey(name: "message") String? message
});


$AirtimeCodeMessageCopyWith<$Res>? get data;

}
/// @nodoc
class _$AirtimeGenerateOtpResponseCopyWithImpl<$Res>
    implements $AirtimeGenerateOtpResponseCopyWith<$Res> {
  _$AirtimeGenerateOtpResponseCopyWithImpl(this._self, this._then);

  final AirtimeGenerateOtpResponse _self;
  final $Res Function(AirtimeGenerateOtpResponse) _then;

/// Create a copy of AirtimeGenerateOtpResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? data = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AirtimeCodeMessage?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AirtimeGenerateOtpResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AirtimeCodeMessageCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $AirtimeCodeMessageCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [AirtimeGenerateOtpResponse].
extension AirtimeGenerateOtpResponsePatterns on AirtimeGenerateOtpResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AirtimeGenerateOtpResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AirtimeGenerateOtpResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AirtimeGenerateOtpResponse value)  $default,){
final _that = this;
switch (_that) {
case _AirtimeGenerateOtpResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AirtimeGenerateOtpResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AirtimeGenerateOtpResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  AirtimeCodeMessage? data, @JsonKey(name: "message")  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AirtimeGenerateOtpResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  AirtimeCodeMessage? data, @JsonKey(name: "message")  String? message)  $default,) {final _that = this;
switch (_that) {
case _AirtimeGenerateOtpResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  AirtimeCodeMessage? data, @JsonKey(name: "message")  String? message)?  $default,) {final _that = this;
switch (_that) {
case _AirtimeGenerateOtpResponse() when $default != null:
return $default(_that.status,_that.data,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AirtimeGenerateOtpResponse implements AirtimeGenerateOtpResponse {
  const _AirtimeGenerateOtpResponse({@JsonKey(name: "status") this.status, @JsonKey(name: "data") this.data, @JsonKey(name: "message") this.message});
  factory _AirtimeGenerateOtpResponse.fromJson(Map<String, dynamic> json) => _$AirtimeGenerateOtpResponseFromJson(json);

@override@JsonKey(name: "status") final  String? status;
@override@JsonKey(name: "data") final  AirtimeCodeMessage? data;
@override@JsonKey(name: "message") final  String? message;

/// Create a copy of AirtimeGenerateOtpResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AirtimeGenerateOtpResponseCopyWith<_AirtimeGenerateOtpResponse> get copyWith => __$AirtimeGenerateOtpResponseCopyWithImpl<_AirtimeGenerateOtpResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AirtimeGenerateOtpResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AirtimeGenerateOtpResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.data, data) || other.data == data)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,data,message);

@override
String toString() {
  return 'AirtimeGenerateOtpResponse(status: $status, data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class _$AirtimeGenerateOtpResponseCopyWith<$Res> implements $AirtimeGenerateOtpResponseCopyWith<$Res> {
  factory _$AirtimeGenerateOtpResponseCopyWith(_AirtimeGenerateOtpResponse value, $Res Function(_AirtimeGenerateOtpResponse) _then) = __$AirtimeGenerateOtpResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "status") String? status,@JsonKey(name: "data") AirtimeCodeMessage? data,@JsonKey(name: "message") String? message
});


@override $AirtimeCodeMessageCopyWith<$Res>? get data;

}
/// @nodoc
class __$AirtimeGenerateOtpResponseCopyWithImpl<$Res>
    implements _$AirtimeGenerateOtpResponseCopyWith<$Res> {
  __$AirtimeGenerateOtpResponseCopyWithImpl(this._self, this._then);

  final _AirtimeGenerateOtpResponse _self;
  final $Res Function(_AirtimeGenerateOtpResponse) _then;

/// Create a copy of AirtimeGenerateOtpResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? data = freezed,Object? message = freezed,}) {
  return _then(_AirtimeGenerateOtpResponse(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AirtimeCodeMessage?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AirtimeGenerateOtpResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AirtimeCodeMessageCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $AirtimeCodeMessageCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$AirtimeCodeMessage {

@JsonKey(name: "code") int? get code;@JsonKey(name: "message") String? get message;
/// Create a copy of AirtimeCodeMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AirtimeCodeMessageCopyWith<AirtimeCodeMessage> get copyWith => _$AirtimeCodeMessageCopyWithImpl<AirtimeCodeMessage>(this as AirtimeCodeMessage, _$identity);

  /// Serializes this AirtimeCodeMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AirtimeCodeMessage&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'AirtimeCodeMessage(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $AirtimeCodeMessageCopyWith<$Res>  {
  factory $AirtimeCodeMessageCopyWith(AirtimeCodeMessage value, $Res Function(AirtimeCodeMessage) _then) = _$AirtimeCodeMessageCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "code") int? code,@JsonKey(name: "message") String? message
});




}
/// @nodoc
class _$AirtimeCodeMessageCopyWithImpl<$Res>
    implements $AirtimeCodeMessageCopyWith<$Res> {
  _$AirtimeCodeMessageCopyWithImpl(this._self, this._then);

  final AirtimeCodeMessage _self;
  final $Res Function(AirtimeCodeMessage) _then;

/// Create a copy of AirtimeCodeMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AirtimeCodeMessage].
extension AirtimeCodeMessagePatterns on AirtimeCodeMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AirtimeCodeMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AirtimeCodeMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AirtimeCodeMessage value)  $default,){
final _that = this;
switch (_that) {
case _AirtimeCodeMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AirtimeCodeMessage value)?  $default,){
final _that = this;
switch (_that) {
case _AirtimeCodeMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "code")  int? code, @JsonKey(name: "message")  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AirtimeCodeMessage() when $default != null:
return $default(_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "code")  int? code, @JsonKey(name: "message")  String? message)  $default,) {final _that = this;
switch (_that) {
case _AirtimeCodeMessage():
return $default(_that.code,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "code")  int? code, @JsonKey(name: "message")  String? message)?  $default,) {final _that = this;
switch (_that) {
case _AirtimeCodeMessage() when $default != null:
return $default(_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AirtimeCodeMessage implements AirtimeCodeMessage {
  const _AirtimeCodeMessage({@JsonKey(name: "code") this.code, @JsonKey(name: "message") this.message});
  factory _AirtimeCodeMessage.fromJson(Map<String, dynamic> json) => _$AirtimeCodeMessageFromJson(json);

@override@JsonKey(name: "code") final  int? code;
@override@JsonKey(name: "message") final  String? message;

/// Create a copy of AirtimeCodeMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AirtimeCodeMessageCopyWith<_AirtimeCodeMessage> get copyWith => __$AirtimeCodeMessageCopyWithImpl<_AirtimeCodeMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AirtimeCodeMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AirtimeCodeMessage&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'AirtimeCodeMessage(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$AirtimeCodeMessageCopyWith<$Res> implements $AirtimeCodeMessageCopyWith<$Res> {
  factory _$AirtimeCodeMessageCopyWith(_AirtimeCodeMessage value, $Res Function(_AirtimeCodeMessage) _then) = __$AirtimeCodeMessageCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "code") int? code,@JsonKey(name: "message") String? message
});




}
/// @nodoc
class __$AirtimeCodeMessageCopyWithImpl<$Res>
    implements _$AirtimeCodeMessageCopyWith<$Res> {
  __$AirtimeCodeMessageCopyWithImpl(this._self, this._then);

  final _AirtimeCodeMessage _self;
  final $Res Function(_AirtimeCodeMessage) _then;

/// Create a copy of AirtimeCodeMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? message = freezed,}) {
  return _then(_AirtimeCodeMessage(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AirtimeVerifyOtpRequest {

@JsonKey(name: "network") String get network;@JsonKey(name: "phone") String get phone;@JsonKey(name: "otp") String get otp;
/// Create a copy of AirtimeVerifyOtpRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AirtimeVerifyOtpRequestCopyWith<AirtimeVerifyOtpRequest> get copyWith => _$AirtimeVerifyOtpRequestCopyWithImpl<AirtimeVerifyOtpRequest>(this as AirtimeVerifyOtpRequest, _$identity);

  /// Serializes this AirtimeVerifyOtpRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AirtimeVerifyOtpRequest&&(identical(other.network, network) || other.network == network)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.otp, otp) || other.otp == otp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,network,phone,otp);

@override
String toString() {
  return 'AirtimeVerifyOtpRequest(network: $network, phone: $phone, otp: $otp)';
}


}

/// @nodoc
abstract mixin class $AirtimeVerifyOtpRequestCopyWith<$Res>  {
  factory $AirtimeVerifyOtpRequestCopyWith(AirtimeVerifyOtpRequest value, $Res Function(AirtimeVerifyOtpRequest) _then) = _$AirtimeVerifyOtpRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "network") String network,@JsonKey(name: "phone") String phone,@JsonKey(name: "otp") String otp
});




}
/// @nodoc
class _$AirtimeVerifyOtpRequestCopyWithImpl<$Res>
    implements $AirtimeVerifyOtpRequestCopyWith<$Res> {
  _$AirtimeVerifyOtpRequestCopyWithImpl(this._self, this._then);

  final AirtimeVerifyOtpRequest _self;
  final $Res Function(AirtimeVerifyOtpRequest) _then;

/// Create a copy of AirtimeVerifyOtpRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? network = null,Object? phone = null,Object? otp = null,}) {
  return _then(_self.copyWith(
network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AirtimeVerifyOtpRequest].
extension AirtimeVerifyOtpRequestPatterns on AirtimeVerifyOtpRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AirtimeVerifyOtpRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AirtimeVerifyOtpRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AirtimeVerifyOtpRequest value)  $default,){
final _that = this;
switch (_that) {
case _AirtimeVerifyOtpRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AirtimeVerifyOtpRequest value)?  $default,){
final _that = this;
switch (_that) {
case _AirtimeVerifyOtpRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "network")  String network, @JsonKey(name: "phone")  String phone, @JsonKey(name: "otp")  String otp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AirtimeVerifyOtpRequest() when $default != null:
return $default(_that.network,_that.phone,_that.otp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "network")  String network, @JsonKey(name: "phone")  String phone, @JsonKey(name: "otp")  String otp)  $default,) {final _that = this;
switch (_that) {
case _AirtimeVerifyOtpRequest():
return $default(_that.network,_that.phone,_that.otp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "network")  String network, @JsonKey(name: "phone")  String phone, @JsonKey(name: "otp")  String otp)?  $default,) {final _that = this;
switch (_that) {
case _AirtimeVerifyOtpRequest() when $default != null:
return $default(_that.network,_that.phone,_that.otp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AirtimeVerifyOtpRequest implements AirtimeVerifyOtpRequest {
  const _AirtimeVerifyOtpRequest({@JsonKey(name: "network") required this.network, @JsonKey(name: "phone") required this.phone, @JsonKey(name: "otp") required this.otp});
  factory _AirtimeVerifyOtpRequest.fromJson(Map<String, dynamic> json) => _$AirtimeVerifyOtpRequestFromJson(json);

@override@JsonKey(name: "network") final  String network;
@override@JsonKey(name: "phone") final  String phone;
@override@JsonKey(name: "otp") final  String otp;

/// Create a copy of AirtimeVerifyOtpRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AirtimeVerifyOtpRequestCopyWith<_AirtimeVerifyOtpRequest> get copyWith => __$AirtimeVerifyOtpRequestCopyWithImpl<_AirtimeVerifyOtpRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AirtimeVerifyOtpRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AirtimeVerifyOtpRequest&&(identical(other.network, network) || other.network == network)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.otp, otp) || other.otp == otp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,network,phone,otp);

@override
String toString() {
  return 'AirtimeVerifyOtpRequest(network: $network, phone: $phone, otp: $otp)';
}


}

/// @nodoc
abstract mixin class _$AirtimeVerifyOtpRequestCopyWith<$Res> implements $AirtimeVerifyOtpRequestCopyWith<$Res> {
  factory _$AirtimeVerifyOtpRequestCopyWith(_AirtimeVerifyOtpRequest value, $Res Function(_AirtimeVerifyOtpRequest) _then) = __$AirtimeVerifyOtpRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "network") String network,@JsonKey(name: "phone") String phone,@JsonKey(name: "otp") String otp
});




}
/// @nodoc
class __$AirtimeVerifyOtpRequestCopyWithImpl<$Res>
    implements _$AirtimeVerifyOtpRequestCopyWith<$Res> {
  __$AirtimeVerifyOtpRequestCopyWithImpl(this._self, this._then);

  final _AirtimeVerifyOtpRequest _self;
  final $Res Function(_AirtimeVerifyOtpRequest) _then;

/// Create a copy of AirtimeVerifyOtpRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? network = null,Object? phone = null,Object? otp = null,}) {
  return _then(_AirtimeVerifyOtpRequest(
network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AirtimeVerifyOtpResponse {

@JsonKey(name: "status") String? get status;@JsonKey(name: "data") AirtimeSessionData? get data;@JsonKey(name: "message") String? get message;
/// Create a copy of AirtimeVerifyOtpResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AirtimeVerifyOtpResponseCopyWith<AirtimeVerifyOtpResponse> get copyWith => _$AirtimeVerifyOtpResponseCopyWithImpl<AirtimeVerifyOtpResponse>(this as AirtimeVerifyOtpResponse, _$identity);

  /// Serializes this AirtimeVerifyOtpResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AirtimeVerifyOtpResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.data, data) || other.data == data)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,data,message);

@override
String toString() {
  return 'AirtimeVerifyOtpResponse(status: $status, data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class $AirtimeVerifyOtpResponseCopyWith<$Res>  {
  factory $AirtimeVerifyOtpResponseCopyWith(AirtimeVerifyOtpResponse value, $Res Function(AirtimeVerifyOtpResponse) _then) = _$AirtimeVerifyOtpResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "status") String? status,@JsonKey(name: "data") AirtimeSessionData? data,@JsonKey(name: "message") String? message
});


$AirtimeSessionDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$AirtimeVerifyOtpResponseCopyWithImpl<$Res>
    implements $AirtimeVerifyOtpResponseCopyWith<$Res> {
  _$AirtimeVerifyOtpResponseCopyWithImpl(this._self, this._then);

  final AirtimeVerifyOtpResponse _self;
  final $Res Function(AirtimeVerifyOtpResponse) _then;

/// Create a copy of AirtimeVerifyOtpResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? data = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AirtimeSessionData?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AirtimeVerifyOtpResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AirtimeSessionDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $AirtimeSessionDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [AirtimeVerifyOtpResponse].
extension AirtimeVerifyOtpResponsePatterns on AirtimeVerifyOtpResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AirtimeVerifyOtpResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AirtimeVerifyOtpResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AirtimeVerifyOtpResponse value)  $default,){
final _that = this;
switch (_that) {
case _AirtimeVerifyOtpResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AirtimeVerifyOtpResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AirtimeVerifyOtpResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  AirtimeSessionData? data, @JsonKey(name: "message")  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AirtimeVerifyOtpResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  AirtimeSessionData? data, @JsonKey(name: "message")  String? message)  $default,) {final _that = this;
switch (_that) {
case _AirtimeVerifyOtpResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  AirtimeSessionData? data, @JsonKey(name: "message")  String? message)?  $default,) {final _that = this;
switch (_that) {
case _AirtimeVerifyOtpResponse() when $default != null:
return $default(_that.status,_that.data,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AirtimeVerifyOtpResponse implements AirtimeVerifyOtpResponse {
  const _AirtimeVerifyOtpResponse({@JsonKey(name: "status") this.status, @JsonKey(name: "data") this.data, @JsonKey(name: "message") this.message});
  factory _AirtimeVerifyOtpResponse.fromJson(Map<String, dynamic> json) => _$AirtimeVerifyOtpResponseFromJson(json);

@override@JsonKey(name: "status") final  String? status;
@override@JsonKey(name: "data") final  AirtimeSessionData? data;
@override@JsonKey(name: "message") final  String? message;

/// Create a copy of AirtimeVerifyOtpResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AirtimeVerifyOtpResponseCopyWith<_AirtimeVerifyOtpResponse> get copyWith => __$AirtimeVerifyOtpResponseCopyWithImpl<_AirtimeVerifyOtpResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AirtimeVerifyOtpResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AirtimeVerifyOtpResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.data, data) || other.data == data)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,data,message);

@override
String toString() {
  return 'AirtimeVerifyOtpResponse(status: $status, data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class _$AirtimeVerifyOtpResponseCopyWith<$Res> implements $AirtimeVerifyOtpResponseCopyWith<$Res> {
  factory _$AirtimeVerifyOtpResponseCopyWith(_AirtimeVerifyOtpResponse value, $Res Function(_AirtimeVerifyOtpResponse) _then) = __$AirtimeVerifyOtpResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "status") String? status,@JsonKey(name: "data") AirtimeSessionData? data,@JsonKey(name: "message") String? message
});


@override $AirtimeSessionDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$AirtimeVerifyOtpResponseCopyWithImpl<$Res>
    implements _$AirtimeVerifyOtpResponseCopyWith<$Res> {
  __$AirtimeVerifyOtpResponseCopyWithImpl(this._self, this._then);

  final _AirtimeVerifyOtpResponse _self;
  final $Res Function(_AirtimeVerifyOtpResponse) _then;

/// Create a copy of AirtimeVerifyOtpResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? data = freezed,Object? message = freezed,}) {
  return _then(_AirtimeVerifyOtpResponse(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AirtimeSessionData?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AirtimeVerifyOtpResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AirtimeSessionDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $AirtimeSessionDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$AirtimeSessionData {

@JsonKey(name: "sessionId") String? get sessionId;
/// Create a copy of AirtimeSessionData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AirtimeSessionDataCopyWith<AirtimeSessionData> get copyWith => _$AirtimeSessionDataCopyWithImpl<AirtimeSessionData>(this as AirtimeSessionData, _$identity);

  /// Serializes this AirtimeSessionData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AirtimeSessionData&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId);

@override
String toString() {
  return 'AirtimeSessionData(sessionId: $sessionId)';
}


}

/// @nodoc
abstract mixin class $AirtimeSessionDataCopyWith<$Res>  {
  factory $AirtimeSessionDataCopyWith(AirtimeSessionData value, $Res Function(AirtimeSessionData) _then) = _$AirtimeSessionDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "sessionId") String? sessionId
});




}
/// @nodoc
class _$AirtimeSessionDataCopyWithImpl<$Res>
    implements $AirtimeSessionDataCopyWith<$Res> {
  _$AirtimeSessionDataCopyWithImpl(this._self, this._then);

  final AirtimeSessionData _self;
  final $Res Function(AirtimeSessionData) _then;

/// Create a copy of AirtimeSessionData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = freezed,}) {
  return _then(_self.copyWith(
sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AirtimeSessionData].
extension AirtimeSessionDataPatterns on AirtimeSessionData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AirtimeSessionData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AirtimeSessionData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AirtimeSessionData value)  $default,){
final _that = this;
switch (_that) {
case _AirtimeSessionData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AirtimeSessionData value)?  $default,){
final _that = this;
switch (_that) {
case _AirtimeSessionData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "sessionId")  String? sessionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AirtimeSessionData() when $default != null:
return $default(_that.sessionId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "sessionId")  String? sessionId)  $default,) {final _that = this;
switch (_that) {
case _AirtimeSessionData():
return $default(_that.sessionId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "sessionId")  String? sessionId)?  $default,) {final _that = this;
switch (_that) {
case _AirtimeSessionData() when $default != null:
return $default(_that.sessionId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AirtimeSessionData implements AirtimeSessionData {
  const _AirtimeSessionData({@JsonKey(name: "sessionId") this.sessionId});
  factory _AirtimeSessionData.fromJson(Map<String, dynamic> json) => _$AirtimeSessionDataFromJson(json);

@override@JsonKey(name: "sessionId") final  String? sessionId;

/// Create a copy of AirtimeSessionData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AirtimeSessionDataCopyWith<_AirtimeSessionData> get copyWith => __$AirtimeSessionDataCopyWithImpl<_AirtimeSessionData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AirtimeSessionDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AirtimeSessionData&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId);

@override
String toString() {
  return 'AirtimeSessionData(sessionId: $sessionId)';
}


}

/// @nodoc
abstract mixin class _$AirtimeSessionDataCopyWith<$Res> implements $AirtimeSessionDataCopyWith<$Res> {
  factory _$AirtimeSessionDataCopyWith(_AirtimeSessionData value, $Res Function(_AirtimeSessionData) _then) = __$AirtimeSessionDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "sessionId") String? sessionId
});




}
/// @nodoc
class __$AirtimeSessionDataCopyWithImpl<$Res>
    implements _$AirtimeSessionDataCopyWith<$Res> {
  __$AirtimeSessionDataCopyWithImpl(this._self, this._then);

  final _AirtimeSessionData _self;
  final $Res Function(_AirtimeSessionData) _then;

/// Create a copy of AirtimeSessionData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = freezed,}) {
  return _then(_AirtimeSessionData(
sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AirtimeCheckQuotaRequest {

@JsonKey(name: "network") String get network;@JsonKey(name: "amount") num get amount;
/// Create a copy of AirtimeCheckQuotaRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AirtimeCheckQuotaRequestCopyWith<AirtimeCheckQuotaRequest> get copyWith => _$AirtimeCheckQuotaRequestCopyWithImpl<AirtimeCheckQuotaRequest>(this as AirtimeCheckQuotaRequest, _$identity);

  /// Serializes this AirtimeCheckQuotaRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AirtimeCheckQuotaRequest&&(identical(other.network, network) || other.network == network)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,network,amount);

@override
String toString() {
  return 'AirtimeCheckQuotaRequest(network: $network, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $AirtimeCheckQuotaRequestCopyWith<$Res>  {
  factory $AirtimeCheckQuotaRequestCopyWith(AirtimeCheckQuotaRequest value, $Res Function(AirtimeCheckQuotaRequest) _then) = _$AirtimeCheckQuotaRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "network") String network,@JsonKey(name: "amount") num amount
});




}
/// @nodoc
class _$AirtimeCheckQuotaRequestCopyWithImpl<$Res>
    implements $AirtimeCheckQuotaRequestCopyWith<$Res> {
  _$AirtimeCheckQuotaRequestCopyWithImpl(this._self, this._then);

  final AirtimeCheckQuotaRequest _self;
  final $Res Function(AirtimeCheckQuotaRequest) _then;

/// Create a copy of AirtimeCheckQuotaRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? network = null,Object? amount = null,}) {
  return _then(_self.copyWith(
network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [AirtimeCheckQuotaRequest].
extension AirtimeCheckQuotaRequestPatterns on AirtimeCheckQuotaRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AirtimeCheckQuotaRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AirtimeCheckQuotaRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AirtimeCheckQuotaRequest value)  $default,){
final _that = this;
switch (_that) {
case _AirtimeCheckQuotaRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AirtimeCheckQuotaRequest value)?  $default,){
final _that = this;
switch (_that) {
case _AirtimeCheckQuotaRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "network")  String network, @JsonKey(name: "amount")  num amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AirtimeCheckQuotaRequest() when $default != null:
return $default(_that.network,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "network")  String network, @JsonKey(name: "amount")  num amount)  $default,) {final _that = this;
switch (_that) {
case _AirtimeCheckQuotaRequest():
return $default(_that.network,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "network")  String network, @JsonKey(name: "amount")  num amount)?  $default,) {final _that = this;
switch (_that) {
case _AirtimeCheckQuotaRequest() when $default != null:
return $default(_that.network,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AirtimeCheckQuotaRequest implements AirtimeCheckQuotaRequest {
  const _AirtimeCheckQuotaRequest({@JsonKey(name: "network") required this.network, @JsonKey(name: "amount") required this.amount});
  factory _AirtimeCheckQuotaRequest.fromJson(Map<String, dynamic> json) => _$AirtimeCheckQuotaRequestFromJson(json);

@override@JsonKey(name: "network") final  String network;
@override@JsonKey(name: "amount") final  num amount;

/// Create a copy of AirtimeCheckQuotaRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AirtimeCheckQuotaRequestCopyWith<_AirtimeCheckQuotaRequest> get copyWith => __$AirtimeCheckQuotaRequestCopyWithImpl<_AirtimeCheckQuotaRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AirtimeCheckQuotaRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AirtimeCheckQuotaRequest&&(identical(other.network, network) || other.network == network)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,network,amount);

@override
String toString() {
  return 'AirtimeCheckQuotaRequest(network: $network, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$AirtimeCheckQuotaRequestCopyWith<$Res> implements $AirtimeCheckQuotaRequestCopyWith<$Res> {
  factory _$AirtimeCheckQuotaRequestCopyWith(_AirtimeCheckQuotaRequest value, $Res Function(_AirtimeCheckQuotaRequest) _then) = __$AirtimeCheckQuotaRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "network") String network,@JsonKey(name: "amount") num amount
});




}
/// @nodoc
class __$AirtimeCheckQuotaRequestCopyWithImpl<$Res>
    implements _$AirtimeCheckQuotaRequestCopyWith<$Res> {
  __$AirtimeCheckQuotaRequestCopyWithImpl(this._self, this._then);

  final _AirtimeCheckQuotaRequest _self;
  final $Res Function(_AirtimeCheckQuotaRequest) _then;

/// Create a copy of AirtimeCheckQuotaRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? network = null,Object? amount = null,}) {
  return _then(_AirtimeCheckQuotaRequest(
network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}


/// @nodoc
mixin _$AirtimeCheckQuotaResponse {

@JsonKey(name: "status") String? get status;@JsonKey(name: "data") AirtimeCodeMessage? get data;@JsonKey(name: "message") String? get message;
/// Create a copy of AirtimeCheckQuotaResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AirtimeCheckQuotaResponseCopyWith<AirtimeCheckQuotaResponse> get copyWith => _$AirtimeCheckQuotaResponseCopyWithImpl<AirtimeCheckQuotaResponse>(this as AirtimeCheckQuotaResponse, _$identity);

  /// Serializes this AirtimeCheckQuotaResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AirtimeCheckQuotaResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.data, data) || other.data == data)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,data,message);

@override
String toString() {
  return 'AirtimeCheckQuotaResponse(status: $status, data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class $AirtimeCheckQuotaResponseCopyWith<$Res>  {
  factory $AirtimeCheckQuotaResponseCopyWith(AirtimeCheckQuotaResponse value, $Res Function(AirtimeCheckQuotaResponse) _then) = _$AirtimeCheckQuotaResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "status") String? status,@JsonKey(name: "data") AirtimeCodeMessage? data,@JsonKey(name: "message") String? message
});


$AirtimeCodeMessageCopyWith<$Res>? get data;

}
/// @nodoc
class _$AirtimeCheckQuotaResponseCopyWithImpl<$Res>
    implements $AirtimeCheckQuotaResponseCopyWith<$Res> {
  _$AirtimeCheckQuotaResponseCopyWithImpl(this._self, this._then);

  final AirtimeCheckQuotaResponse _self;
  final $Res Function(AirtimeCheckQuotaResponse) _then;

/// Create a copy of AirtimeCheckQuotaResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? data = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AirtimeCodeMessage?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AirtimeCheckQuotaResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AirtimeCodeMessageCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $AirtimeCodeMessageCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [AirtimeCheckQuotaResponse].
extension AirtimeCheckQuotaResponsePatterns on AirtimeCheckQuotaResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AirtimeCheckQuotaResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AirtimeCheckQuotaResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AirtimeCheckQuotaResponse value)  $default,){
final _that = this;
switch (_that) {
case _AirtimeCheckQuotaResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AirtimeCheckQuotaResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AirtimeCheckQuotaResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  AirtimeCodeMessage? data, @JsonKey(name: "message")  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AirtimeCheckQuotaResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  AirtimeCodeMessage? data, @JsonKey(name: "message")  String? message)  $default,) {final _that = this;
switch (_that) {
case _AirtimeCheckQuotaResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  AirtimeCodeMessage? data, @JsonKey(name: "message")  String? message)?  $default,) {final _that = this;
switch (_that) {
case _AirtimeCheckQuotaResponse() when $default != null:
return $default(_that.status,_that.data,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AirtimeCheckQuotaResponse implements AirtimeCheckQuotaResponse {
  const _AirtimeCheckQuotaResponse({@JsonKey(name: "status") this.status, @JsonKey(name: "data") this.data, @JsonKey(name: "message") this.message});
  factory _AirtimeCheckQuotaResponse.fromJson(Map<String, dynamic> json) => _$AirtimeCheckQuotaResponseFromJson(json);

@override@JsonKey(name: "status") final  String? status;
@override@JsonKey(name: "data") final  AirtimeCodeMessage? data;
@override@JsonKey(name: "message") final  String? message;

/// Create a copy of AirtimeCheckQuotaResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AirtimeCheckQuotaResponseCopyWith<_AirtimeCheckQuotaResponse> get copyWith => __$AirtimeCheckQuotaResponseCopyWithImpl<_AirtimeCheckQuotaResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AirtimeCheckQuotaResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AirtimeCheckQuotaResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.data, data) || other.data == data)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,data,message);

@override
String toString() {
  return 'AirtimeCheckQuotaResponse(status: $status, data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class _$AirtimeCheckQuotaResponseCopyWith<$Res> implements $AirtimeCheckQuotaResponseCopyWith<$Res> {
  factory _$AirtimeCheckQuotaResponseCopyWith(_AirtimeCheckQuotaResponse value, $Res Function(_AirtimeCheckQuotaResponse) _then) = __$AirtimeCheckQuotaResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "status") String? status,@JsonKey(name: "data") AirtimeCodeMessage? data,@JsonKey(name: "message") String? message
});


@override $AirtimeCodeMessageCopyWith<$Res>? get data;

}
/// @nodoc
class __$AirtimeCheckQuotaResponseCopyWithImpl<$Res>
    implements _$AirtimeCheckQuotaResponseCopyWith<$Res> {
  __$AirtimeCheckQuotaResponseCopyWithImpl(this._self, this._then);

  final _AirtimeCheckQuotaResponse _self;
  final $Res Function(_AirtimeCheckQuotaResponse) _then;

/// Create a copy of AirtimeCheckQuotaResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? data = freezed,Object? message = freezed,}) {
  return _then(_AirtimeCheckQuotaResponse(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AirtimeCodeMessage?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AirtimeCheckQuotaResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AirtimeCodeMessageCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $AirtimeCodeMessageCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$AirtimeTransferRequest {

@JsonKey(name: "network") String get network;@JsonKey(name: "phone") String get phone;@JsonKey(name: "amount") num get amount;@JsonKey(name: "pin") String get pin;@JsonKey(name: "sessionId") String get sessionId;
/// Create a copy of AirtimeTransferRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AirtimeTransferRequestCopyWith<AirtimeTransferRequest> get copyWith => _$AirtimeTransferRequestCopyWithImpl<AirtimeTransferRequest>(this as AirtimeTransferRequest, _$identity);

  /// Serializes this AirtimeTransferRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AirtimeTransferRequest&&(identical(other.network, network) || other.network == network)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.pin, pin) || other.pin == pin)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,network,phone,amount,pin,sessionId);

@override
String toString() {
  return 'AirtimeTransferRequest(network: $network, phone: $phone, amount: $amount, pin: $pin, sessionId: $sessionId)';
}


}

/// @nodoc
abstract mixin class $AirtimeTransferRequestCopyWith<$Res>  {
  factory $AirtimeTransferRequestCopyWith(AirtimeTransferRequest value, $Res Function(AirtimeTransferRequest) _then) = _$AirtimeTransferRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "network") String network,@JsonKey(name: "phone") String phone,@JsonKey(name: "amount") num amount,@JsonKey(name: "pin") String pin,@JsonKey(name: "sessionId") String sessionId
});




}
/// @nodoc
class _$AirtimeTransferRequestCopyWithImpl<$Res>
    implements $AirtimeTransferRequestCopyWith<$Res> {
  _$AirtimeTransferRequestCopyWithImpl(this._self, this._then);

  final AirtimeTransferRequest _self;
  final $Res Function(AirtimeTransferRequest) _then;

/// Create a copy of AirtimeTransferRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? network = null,Object? phone = null,Object? amount = null,Object? pin = null,Object? sessionId = null,}) {
  return _then(_self.copyWith(
network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,pin: null == pin ? _self.pin : pin // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AirtimeTransferRequest].
extension AirtimeTransferRequestPatterns on AirtimeTransferRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AirtimeTransferRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AirtimeTransferRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AirtimeTransferRequest value)  $default,){
final _that = this;
switch (_that) {
case _AirtimeTransferRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AirtimeTransferRequest value)?  $default,){
final _that = this;
switch (_that) {
case _AirtimeTransferRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "network")  String network, @JsonKey(name: "phone")  String phone, @JsonKey(name: "amount")  num amount, @JsonKey(name: "pin")  String pin, @JsonKey(name: "sessionId")  String sessionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AirtimeTransferRequest() when $default != null:
return $default(_that.network,_that.phone,_that.amount,_that.pin,_that.sessionId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "network")  String network, @JsonKey(name: "phone")  String phone, @JsonKey(name: "amount")  num amount, @JsonKey(name: "pin")  String pin, @JsonKey(name: "sessionId")  String sessionId)  $default,) {final _that = this;
switch (_that) {
case _AirtimeTransferRequest():
return $default(_that.network,_that.phone,_that.amount,_that.pin,_that.sessionId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "network")  String network, @JsonKey(name: "phone")  String phone, @JsonKey(name: "amount")  num amount, @JsonKey(name: "pin")  String pin, @JsonKey(name: "sessionId")  String sessionId)?  $default,) {final _that = this;
switch (_that) {
case _AirtimeTransferRequest() when $default != null:
return $default(_that.network,_that.phone,_that.amount,_that.pin,_that.sessionId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AirtimeTransferRequest implements AirtimeTransferRequest {
  const _AirtimeTransferRequest({@JsonKey(name: "network") required this.network, @JsonKey(name: "phone") required this.phone, @JsonKey(name: "amount") required this.amount, @JsonKey(name: "pin") required this.pin, @JsonKey(name: "sessionId") required this.sessionId});
  factory _AirtimeTransferRequest.fromJson(Map<String, dynamic> json) => _$AirtimeTransferRequestFromJson(json);

@override@JsonKey(name: "network") final  String network;
@override@JsonKey(name: "phone") final  String phone;
@override@JsonKey(name: "amount") final  num amount;
@override@JsonKey(name: "pin") final  String pin;
@override@JsonKey(name: "sessionId") final  String sessionId;

/// Create a copy of AirtimeTransferRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AirtimeTransferRequestCopyWith<_AirtimeTransferRequest> get copyWith => __$AirtimeTransferRequestCopyWithImpl<_AirtimeTransferRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AirtimeTransferRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AirtimeTransferRequest&&(identical(other.network, network) || other.network == network)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.pin, pin) || other.pin == pin)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,network,phone,amount,pin,sessionId);

@override
String toString() {
  return 'AirtimeTransferRequest(network: $network, phone: $phone, amount: $amount, pin: $pin, sessionId: $sessionId)';
}


}

/// @nodoc
abstract mixin class _$AirtimeTransferRequestCopyWith<$Res> implements $AirtimeTransferRequestCopyWith<$Res> {
  factory _$AirtimeTransferRequestCopyWith(_AirtimeTransferRequest value, $Res Function(_AirtimeTransferRequest) _then) = __$AirtimeTransferRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "network") String network,@JsonKey(name: "phone") String phone,@JsonKey(name: "amount") num amount,@JsonKey(name: "pin") String pin,@JsonKey(name: "sessionId") String sessionId
});




}
/// @nodoc
class __$AirtimeTransferRequestCopyWithImpl<$Res>
    implements _$AirtimeTransferRequestCopyWith<$Res> {
  __$AirtimeTransferRequestCopyWithImpl(this._self, this._then);

  final _AirtimeTransferRequest _self;
  final $Res Function(_AirtimeTransferRequest) _then;

/// Create a copy of AirtimeTransferRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? network = null,Object? phone = null,Object? amount = null,Object? pin = null,Object? sessionId = null,}) {
  return _then(_AirtimeTransferRequest(
network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,pin: null == pin ? _self.pin : pin // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AirtimeTransferResponse {

@JsonKey(name: "status") String? get status;@JsonKey(name: "data") AirtimeTransferData? get data;@JsonKey(name: "message") String? get message;
/// Create a copy of AirtimeTransferResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AirtimeTransferResponseCopyWith<AirtimeTransferResponse> get copyWith => _$AirtimeTransferResponseCopyWithImpl<AirtimeTransferResponse>(this as AirtimeTransferResponse, _$identity);

  /// Serializes this AirtimeTransferResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AirtimeTransferResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.data, data) || other.data == data)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,data,message);

@override
String toString() {
  return 'AirtimeTransferResponse(status: $status, data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class $AirtimeTransferResponseCopyWith<$Res>  {
  factory $AirtimeTransferResponseCopyWith(AirtimeTransferResponse value, $Res Function(AirtimeTransferResponse) _then) = _$AirtimeTransferResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "status") String? status,@JsonKey(name: "data") AirtimeTransferData? data,@JsonKey(name: "message") String? message
});


$AirtimeTransferDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$AirtimeTransferResponseCopyWithImpl<$Res>
    implements $AirtimeTransferResponseCopyWith<$Res> {
  _$AirtimeTransferResponseCopyWithImpl(this._self, this._then);

  final AirtimeTransferResponse _self;
  final $Res Function(AirtimeTransferResponse) _then;

/// Create a copy of AirtimeTransferResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? data = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AirtimeTransferData?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AirtimeTransferResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AirtimeTransferDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $AirtimeTransferDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [AirtimeTransferResponse].
extension AirtimeTransferResponsePatterns on AirtimeTransferResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AirtimeTransferResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AirtimeTransferResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AirtimeTransferResponse value)  $default,){
final _that = this;
switch (_that) {
case _AirtimeTransferResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AirtimeTransferResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AirtimeTransferResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  AirtimeTransferData? data, @JsonKey(name: "message")  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AirtimeTransferResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  AirtimeTransferData? data, @JsonKey(name: "message")  String? message)  $default,) {final _that = this;
switch (_that) {
case _AirtimeTransferResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "status")  String? status, @JsonKey(name: "data")  AirtimeTransferData? data, @JsonKey(name: "message")  String? message)?  $default,) {final _that = this;
switch (_that) {
case _AirtimeTransferResponse() when $default != null:
return $default(_that.status,_that.data,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AirtimeTransferResponse implements AirtimeTransferResponse {
  const _AirtimeTransferResponse({@JsonKey(name: "status") this.status, @JsonKey(name: "data") this.data, @JsonKey(name: "message") this.message});
  factory _AirtimeTransferResponse.fromJson(Map<String, dynamic> json) => _$AirtimeTransferResponseFromJson(json);

@override@JsonKey(name: "status") final  String? status;
@override@JsonKey(name: "data") final  AirtimeTransferData? data;
@override@JsonKey(name: "message") final  String? message;

/// Create a copy of AirtimeTransferResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AirtimeTransferResponseCopyWith<_AirtimeTransferResponse> get copyWith => __$AirtimeTransferResponseCopyWithImpl<_AirtimeTransferResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AirtimeTransferResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AirtimeTransferResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.data, data) || other.data == data)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,data,message);

@override
String toString() {
  return 'AirtimeTransferResponse(status: $status, data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class _$AirtimeTransferResponseCopyWith<$Res> implements $AirtimeTransferResponseCopyWith<$Res> {
  factory _$AirtimeTransferResponseCopyWith(_AirtimeTransferResponse value, $Res Function(_AirtimeTransferResponse) _then) = __$AirtimeTransferResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "status") String? status,@JsonKey(name: "data") AirtimeTransferData? data,@JsonKey(name: "message") String? message
});


@override $AirtimeTransferDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$AirtimeTransferResponseCopyWithImpl<$Res>
    implements _$AirtimeTransferResponseCopyWith<$Res> {
  __$AirtimeTransferResponseCopyWithImpl(this._self, this._then);

  final _AirtimeTransferResponse _self;
  final $Res Function(_AirtimeTransferResponse) _then;

/// Create a copy of AirtimeTransferResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? data = freezed,Object? message = freezed,}) {
  return _then(_AirtimeTransferResponse(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AirtimeTransferData?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AirtimeTransferResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AirtimeTransferDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $AirtimeTransferDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$AirtimeTransferData {

// 2000 = credited immediately. 4000 = accepted, processing — will be
// credited once the network confirms. Any other/absent code is
// treated as a failure by the repository even on HTTP 200, since this
// API reports business-logic outcomes via `code`, not just HTTP status.
@JsonKey(name: "code") int? get code;@JsonKey(name: "message") String? get message;@JsonKey(name: "reference") String? get reference;
/// Create a copy of AirtimeTransferData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AirtimeTransferDataCopyWith<AirtimeTransferData> get copyWith => _$AirtimeTransferDataCopyWithImpl<AirtimeTransferData>(this as AirtimeTransferData, _$identity);

  /// Serializes this AirtimeTransferData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AirtimeTransferData&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.reference, reference) || other.reference == reference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,reference);

@override
String toString() {
  return 'AirtimeTransferData(code: $code, message: $message, reference: $reference)';
}


}

/// @nodoc
abstract mixin class $AirtimeTransferDataCopyWith<$Res>  {
  factory $AirtimeTransferDataCopyWith(AirtimeTransferData value, $Res Function(AirtimeTransferData) _then) = _$AirtimeTransferDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "code") int? code,@JsonKey(name: "message") String? message,@JsonKey(name: "reference") String? reference
});




}
/// @nodoc
class _$AirtimeTransferDataCopyWithImpl<$Res>
    implements $AirtimeTransferDataCopyWith<$Res> {
  _$AirtimeTransferDataCopyWithImpl(this._self, this._then);

  final AirtimeTransferData _self;
  final $Res Function(AirtimeTransferData) _then;

/// Create a copy of AirtimeTransferData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? message = freezed,Object? reference = freezed,}) {
  return _then(_self.copyWith(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AirtimeTransferData].
extension AirtimeTransferDataPatterns on AirtimeTransferData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AirtimeTransferData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AirtimeTransferData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AirtimeTransferData value)  $default,){
final _that = this;
switch (_that) {
case _AirtimeTransferData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AirtimeTransferData value)?  $default,){
final _that = this;
switch (_that) {
case _AirtimeTransferData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "code")  int? code, @JsonKey(name: "message")  String? message, @JsonKey(name: "reference")  String? reference)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AirtimeTransferData() when $default != null:
return $default(_that.code,_that.message,_that.reference);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "code")  int? code, @JsonKey(name: "message")  String? message, @JsonKey(name: "reference")  String? reference)  $default,) {final _that = this;
switch (_that) {
case _AirtimeTransferData():
return $default(_that.code,_that.message,_that.reference);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "code")  int? code, @JsonKey(name: "message")  String? message, @JsonKey(name: "reference")  String? reference)?  $default,) {final _that = this;
switch (_that) {
case _AirtimeTransferData() when $default != null:
return $default(_that.code,_that.message,_that.reference);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AirtimeTransferData implements AirtimeTransferData {
  const _AirtimeTransferData({@JsonKey(name: "code") this.code, @JsonKey(name: "message") this.message, @JsonKey(name: "reference") this.reference});
  factory _AirtimeTransferData.fromJson(Map<String, dynamic> json) => _$AirtimeTransferDataFromJson(json);

// 2000 = credited immediately. 4000 = accepted, processing — will be
// credited once the network confirms. Any other/absent code is
// treated as a failure by the repository even on HTTP 200, since this
// API reports business-logic outcomes via `code`, not just HTTP status.
@override@JsonKey(name: "code") final  int? code;
@override@JsonKey(name: "message") final  String? message;
@override@JsonKey(name: "reference") final  String? reference;

/// Create a copy of AirtimeTransferData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AirtimeTransferDataCopyWith<_AirtimeTransferData> get copyWith => __$AirtimeTransferDataCopyWithImpl<_AirtimeTransferData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AirtimeTransferDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AirtimeTransferData&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.reference, reference) || other.reference == reference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,reference);

@override
String toString() {
  return 'AirtimeTransferData(code: $code, message: $message, reference: $reference)';
}


}

/// @nodoc
abstract mixin class _$AirtimeTransferDataCopyWith<$Res> implements $AirtimeTransferDataCopyWith<$Res> {
  factory _$AirtimeTransferDataCopyWith(_AirtimeTransferData value, $Res Function(_AirtimeTransferData) _then) = __$AirtimeTransferDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "code") int? code,@JsonKey(name: "message") String? message,@JsonKey(name: "reference") String? reference
});




}
/// @nodoc
class __$AirtimeTransferDataCopyWithImpl<$Res>
    implements _$AirtimeTransferDataCopyWith<$Res> {
  __$AirtimeTransferDataCopyWithImpl(this._self, this._then);

  final _AirtimeTransferData _self;
  final $Res Function(_AirtimeTransferData) _then;

/// Create a copy of AirtimeTransferData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? message = freezed,Object? reference = freezed,}) {
  return _then(_AirtimeTransferData(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
