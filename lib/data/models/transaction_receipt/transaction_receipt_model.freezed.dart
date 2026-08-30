// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_receipt_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionReceiptData {

 String? get transactionId;// Unique identifier for the transaction from transRef or generated
 String? get date;// Date of the transaction derived from createdAt
 String? get time;// Time of the transaction derived from createdAt
 String? get type;// Transaction type, dynamically set (e.g., productName or transType)
 String? get amount;// Transaction amount, formatted based on transType
 String? get bankName;// Name of the bank (if applicable,)
 String? get accountNumber;// Account number or name (e.g., crAcc for withdrawal),
 String get status;// Status of the transaction
 String? get description;// Additional description from subProduct or productName
 String? get reference;// Reference number
 String? get beneficiary;// Beneficiary details (e.g., phone number for airtime),
 String? get provider;// Service provider (e.g., MTN, Startimes),
 String? get meterType;// Meter type (e.g., Prepaid/Postpaid for electricity),
 String? get meterNumber;// Meter number (e.g., for electricity),
 String? get smartCardNumber;// Smart card number (e.g., for cable TV),
 String? get package;// Package details (e.g., Startimes Plus),
 String? get userBalance;// User's balance after the transaction, from balanceAfter
 String? get paymentMethod;// Payment method (e.g., Wallet, Monnify),
 String? get agentName;// Agent name (e.g., for bulk e-PIN),
 String? get agentEmail;// Agent email (e.g., for bulk e-PIN),
 String? get agentPhoneNumber;// Agent phone number (e.g., for bulk e-PIN),
 String? get businessName;// Business name (e.g., for bulk e-PIN),
 String? get network;// Network provider (e.g., MTN, Glo),
 String? get quantity;// Quantity (e.g., for bulk e-PIN),
 String? get subProduct;// Sub-product details,
 String? get dataBundle;// Data bundle details (e.g., 100MB 1 Day),
 String? get phoneNumber;// Phone number (e.g., for data or airtime), from crAcc
 String? get balanceBefore;// User's balance before the transaction, from balanceBefore
 String? get token;// Token for electricity transactions, copyable in UI
 String? get units;
/// Create a copy of TransactionReceiptData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionReceiptDataCopyWith<TransactionReceiptData> get copyWith => _$TransactionReceiptDataCopyWithImpl<TransactionReceiptData>(this as TransactionReceiptData, _$identity);

  /// Serializes this TransactionReceiptData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionReceiptData&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.status, status) || other.status == status)&&(identical(other.description, description) || other.description == description)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.beneficiary, beneficiary) || other.beneficiary == beneficiary)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.meterType, meterType) || other.meterType == meterType)&&(identical(other.meterNumber, meterNumber) || other.meterNumber == meterNumber)&&(identical(other.smartCardNumber, smartCardNumber) || other.smartCardNumber == smartCardNumber)&&(identical(other.package, package) || other.package == package)&&(identical(other.userBalance, userBalance) || other.userBalance == userBalance)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.agentName, agentName) || other.agentName == agentName)&&(identical(other.agentEmail, agentEmail) || other.agentEmail == agentEmail)&&(identical(other.agentPhoneNumber, agentPhoneNumber) || other.agentPhoneNumber == agentPhoneNumber)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.network, network) || other.network == network)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.subProduct, subProduct) || other.subProduct == subProduct)&&(identical(other.dataBundle, dataBundle) || other.dataBundle == dataBundle)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.balanceBefore, balanceBefore) || other.balanceBefore == balanceBefore)&&(identical(other.token, token) || other.token == token)&&(identical(other.units, units) || other.units == units));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,transactionId,date,time,type,amount,bankName,accountNumber,status,description,reference,beneficiary,provider,meterType,meterNumber,smartCardNumber,package,userBalance,paymentMethod,agentName,agentEmail,agentPhoneNumber,businessName,network,quantity,subProduct,dataBundle,phoneNumber,balanceBefore,token,units]);

@override
String toString() {
  return 'TransactionReceiptData(transactionId: $transactionId, date: $date, time: $time, type: $type, amount: $amount, bankName: $bankName, accountNumber: $accountNumber, status: $status, description: $description, reference: $reference, beneficiary: $beneficiary, provider: $provider, meterType: $meterType, meterNumber: $meterNumber, smartCardNumber: $smartCardNumber, package: $package, userBalance: $userBalance, paymentMethod: $paymentMethod, agentName: $agentName, agentEmail: $agentEmail, agentPhoneNumber: $agentPhoneNumber, businessName: $businessName, network: $network, quantity: $quantity, subProduct: $subProduct, dataBundle: $dataBundle, phoneNumber: $phoneNumber, balanceBefore: $balanceBefore, token: $token, units: $units)';
}


}

/// @nodoc
abstract mixin class $TransactionReceiptDataCopyWith<$Res>  {
  factory $TransactionReceiptDataCopyWith(TransactionReceiptData value, $Res Function(TransactionReceiptData) _then) = _$TransactionReceiptDataCopyWithImpl;
@useResult
$Res call({
 String? transactionId, String? date, String? time, String? type, String? amount, String? bankName, String? accountNumber, String status, String? description, String? reference, String? beneficiary, String? provider, String? meterType, String? meterNumber, String? smartCardNumber, String? package, String? userBalance, String? paymentMethod, String? agentName, String? agentEmail, String? agentPhoneNumber, String? businessName, String? network, String? quantity, String? subProduct, String? dataBundle, String? phoneNumber, String? balanceBefore, String? token, String? units
});




}
/// @nodoc
class _$TransactionReceiptDataCopyWithImpl<$Res>
    implements $TransactionReceiptDataCopyWith<$Res> {
  _$TransactionReceiptDataCopyWithImpl(this._self, this._then);

  final TransactionReceiptData _self;
  final $Res Function(TransactionReceiptData) _then;

/// Create a copy of TransactionReceiptData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactionId = freezed,Object? date = freezed,Object? time = freezed,Object? type = freezed,Object? amount = freezed,Object? bankName = freezed,Object? accountNumber = freezed,Object? status = null,Object? description = freezed,Object? reference = freezed,Object? beneficiary = freezed,Object? provider = freezed,Object? meterType = freezed,Object? meterNumber = freezed,Object? smartCardNumber = freezed,Object? package = freezed,Object? userBalance = freezed,Object? paymentMethod = freezed,Object? agentName = freezed,Object? agentEmail = freezed,Object? agentPhoneNumber = freezed,Object? businessName = freezed,Object? network = freezed,Object? quantity = freezed,Object? subProduct = freezed,Object? dataBundle = freezed,Object? phoneNumber = freezed,Object? balanceBefore = freezed,Object? token = freezed,Object? units = freezed,}) {
  return _then(_self.copyWith(
transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String?,bankName: freezed == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String?,accountNumber: freezed == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,beneficiary: freezed == beneficiary ? _self.beneficiary : beneficiary // ignore: cast_nullable_to_non_nullable
as String?,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,meterType: freezed == meterType ? _self.meterType : meterType // ignore: cast_nullable_to_non_nullable
as String?,meterNumber: freezed == meterNumber ? _self.meterNumber : meterNumber // ignore: cast_nullable_to_non_nullable
as String?,smartCardNumber: freezed == smartCardNumber ? _self.smartCardNumber : smartCardNumber // ignore: cast_nullable_to_non_nullable
as String?,package: freezed == package ? _self.package : package // ignore: cast_nullable_to_non_nullable
as String?,userBalance: freezed == userBalance ? _self.userBalance : userBalance // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,agentName: freezed == agentName ? _self.agentName : agentName // ignore: cast_nullable_to_non_nullable
as String?,agentEmail: freezed == agentEmail ? _self.agentEmail : agentEmail // ignore: cast_nullable_to_non_nullable
as String?,agentPhoneNumber: freezed == agentPhoneNumber ? _self.agentPhoneNumber : agentPhoneNumber // ignore: cast_nullable_to_non_nullable
as String?,businessName: freezed == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String?,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as String?,subProduct: freezed == subProduct ? _self.subProduct : subProduct // ignore: cast_nullable_to_non_nullable
as String?,dataBundle: freezed == dataBundle ? _self.dataBundle : dataBundle // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,balanceBefore: freezed == balanceBefore ? _self.balanceBefore : balanceBefore // ignore: cast_nullable_to_non_nullable
as String?,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,units: freezed == units ? _self.units : units // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionReceiptData].
extension TransactionReceiptDataPatterns on TransactionReceiptData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionReceiptData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionReceiptData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionReceiptData value)  $default,){
final _that = this;
switch (_that) {
case _TransactionReceiptData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionReceiptData value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionReceiptData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? transactionId,  String? date,  String? time,  String? type,  String? amount,  String? bankName,  String? accountNumber,  String status,  String? description,  String? reference,  String? beneficiary,  String? provider,  String? meterType,  String? meterNumber,  String? smartCardNumber,  String? package,  String? userBalance,  String? paymentMethod,  String? agentName,  String? agentEmail,  String? agentPhoneNumber,  String? businessName,  String? network,  String? quantity,  String? subProduct,  String? dataBundle,  String? phoneNumber,  String? balanceBefore,  String? token,  String? units)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionReceiptData() when $default != null:
return $default(_that.transactionId,_that.date,_that.time,_that.type,_that.amount,_that.bankName,_that.accountNumber,_that.status,_that.description,_that.reference,_that.beneficiary,_that.provider,_that.meterType,_that.meterNumber,_that.smartCardNumber,_that.package,_that.userBalance,_that.paymentMethod,_that.agentName,_that.agentEmail,_that.agentPhoneNumber,_that.businessName,_that.network,_that.quantity,_that.subProduct,_that.dataBundle,_that.phoneNumber,_that.balanceBefore,_that.token,_that.units);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? transactionId,  String? date,  String? time,  String? type,  String? amount,  String? bankName,  String? accountNumber,  String status,  String? description,  String? reference,  String? beneficiary,  String? provider,  String? meterType,  String? meterNumber,  String? smartCardNumber,  String? package,  String? userBalance,  String? paymentMethod,  String? agentName,  String? agentEmail,  String? agentPhoneNumber,  String? businessName,  String? network,  String? quantity,  String? subProduct,  String? dataBundle,  String? phoneNumber,  String? balanceBefore,  String? token,  String? units)  $default,) {final _that = this;
switch (_that) {
case _TransactionReceiptData():
return $default(_that.transactionId,_that.date,_that.time,_that.type,_that.amount,_that.bankName,_that.accountNumber,_that.status,_that.description,_that.reference,_that.beneficiary,_that.provider,_that.meterType,_that.meterNumber,_that.smartCardNumber,_that.package,_that.userBalance,_that.paymentMethod,_that.agentName,_that.agentEmail,_that.agentPhoneNumber,_that.businessName,_that.network,_that.quantity,_that.subProduct,_that.dataBundle,_that.phoneNumber,_that.balanceBefore,_that.token,_that.units);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? transactionId,  String? date,  String? time,  String? type,  String? amount,  String? bankName,  String? accountNumber,  String status,  String? description,  String? reference,  String? beneficiary,  String? provider,  String? meterType,  String? meterNumber,  String? smartCardNumber,  String? package,  String? userBalance,  String? paymentMethod,  String? agentName,  String? agentEmail,  String? agentPhoneNumber,  String? businessName,  String? network,  String? quantity,  String? subProduct,  String? dataBundle,  String? phoneNumber,  String? balanceBefore,  String? token,  String? units)?  $default,) {final _that = this;
switch (_that) {
case _TransactionReceiptData() when $default != null:
return $default(_that.transactionId,_that.date,_that.time,_that.type,_that.amount,_that.bankName,_that.accountNumber,_that.status,_that.description,_that.reference,_that.beneficiary,_that.provider,_that.meterType,_that.meterNumber,_that.smartCardNumber,_that.package,_that.userBalance,_that.paymentMethod,_that.agentName,_that.agentEmail,_that.agentPhoneNumber,_that.businessName,_that.network,_that.quantity,_that.subProduct,_that.dataBundle,_that.phoneNumber,_that.balanceBefore,_that.token,_that.units);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransactionReceiptData implements TransactionReceiptData {
  const _TransactionReceiptData({required this.transactionId, required this.date, required this.time, required this.type, required this.amount, this.bankName, this.accountNumber, required this.status, this.description, this.reference, this.beneficiary, this.provider, this.meterType, this.meterNumber, this.smartCardNumber, this.package, this.userBalance, this.paymentMethod, this.agentName, this.agentEmail, this.agentPhoneNumber, this.businessName, this.network, this.quantity, this.subProduct, this.dataBundle, this.phoneNumber, this.balanceBefore, this.token, this.units});
  factory _TransactionReceiptData.fromJson(Map<String, dynamic> json) => _$TransactionReceiptDataFromJson(json);

@override final  String? transactionId;
// Unique identifier for the transaction from transRef or generated
@override final  String? date;
// Date of the transaction derived from createdAt
@override final  String? time;
// Time of the transaction derived from createdAt
@override final  String? type;
// Transaction type, dynamically set (e.g., productName or transType)
@override final  String? amount;
// Transaction amount, formatted based on transType
@override final  String? bankName;
// Name of the bank (if applicable,)
@override final  String? accountNumber;
// Account number or name (e.g., crAcc for withdrawal),
@override final  String status;
// Status of the transaction
@override final  String? description;
// Additional description from subProduct or productName
@override final  String? reference;
// Reference number
@override final  String? beneficiary;
// Beneficiary details (e.g., phone number for airtime),
@override final  String? provider;
// Service provider (e.g., MTN, Startimes),
@override final  String? meterType;
// Meter type (e.g., Prepaid/Postpaid for electricity),
@override final  String? meterNumber;
// Meter number (e.g., for electricity),
@override final  String? smartCardNumber;
// Smart card number (e.g., for cable TV),
@override final  String? package;
// Package details (e.g., Startimes Plus),
@override final  String? userBalance;
// User's balance after the transaction, from balanceAfter
@override final  String? paymentMethod;
// Payment method (e.g., Wallet, Monnify),
@override final  String? agentName;
// Agent name (e.g., for bulk e-PIN),
@override final  String? agentEmail;
// Agent email (e.g., for bulk e-PIN),
@override final  String? agentPhoneNumber;
// Agent phone number (e.g., for bulk e-PIN),
@override final  String? businessName;
// Business name (e.g., for bulk e-PIN),
@override final  String? network;
// Network provider (e.g., MTN, Glo),
@override final  String? quantity;
// Quantity (e.g., for bulk e-PIN),
@override final  String? subProduct;
// Sub-product details,
@override final  String? dataBundle;
// Data bundle details (e.g., 100MB 1 Day),
@override final  String? phoneNumber;
// Phone number (e.g., for data or airtime), from crAcc
@override final  String? balanceBefore;
// User's balance before the transaction, from balanceBefore
@override final  String? token;
// Token for electricity transactions, copyable in UI
@override final  String? units;

/// Create a copy of TransactionReceiptData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionReceiptDataCopyWith<_TransactionReceiptData> get copyWith => __$TransactionReceiptDataCopyWithImpl<_TransactionReceiptData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionReceiptDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionReceiptData&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.status, status) || other.status == status)&&(identical(other.description, description) || other.description == description)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.beneficiary, beneficiary) || other.beneficiary == beneficiary)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.meterType, meterType) || other.meterType == meterType)&&(identical(other.meterNumber, meterNumber) || other.meterNumber == meterNumber)&&(identical(other.smartCardNumber, smartCardNumber) || other.smartCardNumber == smartCardNumber)&&(identical(other.package, package) || other.package == package)&&(identical(other.userBalance, userBalance) || other.userBalance == userBalance)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.agentName, agentName) || other.agentName == agentName)&&(identical(other.agentEmail, agentEmail) || other.agentEmail == agentEmail)&&(identical(other.agentPhoneNumber, agentPhoneNumber) || other.agentPhoneNumber == agentPhoneNumber)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.network, network) || other.network == network)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.subProduct, subProduct) || other.subProduct == subProduct)&&(identical(other.dataBundle, dataBundle) || other.dataBundle == dataBundle)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.balanceBefore, balanceBefore) || other.balanceBefore == balanceBefore)&&(identical(other.token, token) || other.token == token)&&(identical(other.units, units) || other.units == units));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,transactionId,date,time,type,amount,bankName,accountNumber,status,description,reference,beneficiary,provider,meterType,meterNumber,smartCardNumber,package,userBalance,paymentMethod,agentName,agentEmail,agentPhoneNumber,businessName,network,quantity,subProduct,dataBundle,phoneNumber,balanceBefore,token,units]);

@override
String toString() {
  return 'TransactionReceiptData(transactionId: $transactionId, date: $date, time: $time, type: $type, amount: $amount, bankName: $bankName, accountNumber: $accountNumber, status: $status, description: $description, reference: $reference, beneficiary: $beneficiary, provider: $provider, meterType: $meterType, meterNumber: $meterNumber, smartCardNumber: $smartCardNumber, package: $package, userBalance: $userBalance, paymentMethod: $paymentMethod, agentName: $agentName, agentEmail: $agentEmail, agentPhoneNumber: $agentPhoneNumber, businessName: $businessName, network: $network, quantity: $quantity, subProduct: $subProduct, dataBundle: $dataBundle, phoneNumber: $phoneNumber, balanceBefore: $balanceBefore, token: $token, units: $units)';
}


}

/// @nodoc
abstract mixin class _$TransactionReceiptDataCopyWith<$Res> implements $TransactionReceiptDataCopyWith<$Res> {
  factory _$TransactionReceiptDataCopyWith(_TransactionReceiptData value, $Res Function(_TransactionReceiptData) _then) = __$TransactionReceiptDataCopyWithImpl;
@override @useResult
$Res call({
 String? transactionId, String? date, String? time, String? type, String? amount, String? bankName, String? accountNumber, String status, String? description, String? reference, String? beneficiary, String? provider, String? meterType, String? meterNumber, String? smartCardNumber, String? package, String? userBalance, String? paymentMethod, String? agentName, String? agentEmail, String? agentPhoneNumber, String? businessName, String? network, String? quantity, String? subProduct, String? dataBundle, String? phoneNumber, String? balanceBefore, String? token, String? units
});




}
/// @nodoc
class __$TransactionReceiptDataCopyWithImpl<$Res>
    implements _$TransactionReceiptDataCopyWith<$Res> {
  __$TransactionReceiptDataCopyWithImpl(this._self, this._then);

  final _TransactionReceiptData _self;
  final $Res Function(_TransactionReceiptData) _then;

/// Create a copy of TransactionReceiptData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactionId = freezed,Object? date = freezed,Object? time = freezed,Object? type = freezed,Object? amount = freezed,Object? bankName = freezed,Object? accountNumber = freezed,Object? status = null,Object? description = freezed,Object? reference = freezed,Object? beneficiary = freezed,Object? provider = freezed,Object? meterType = freezed,Object? meterNumber = freezed,Object? smartCardNumber = freezed,Object? package = freezed,Object? userBalance = freezed,Object? paymentMethod = freezed,Object? agentName = freezed,Object? agentEmail = freezed,Object? agentPhoneNumber = freezed,Object? businessName = freezed,Object? network = freezed,Object? quantity = freezed,Object? subProduct = freezed,Object? dataBundle = freezed,Object? phoneNumber = freezed,Object? balanceBefore = freezed,Object? token = freezed,Object? units = freezed,}) {
  return _then(_TransactionReceiptData(
transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String?,bankName: freezed == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String?,accountNumber: freezed == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,beneficiary: freezed == beneficiary ? _self.beneficiary : beneficiary // ignore: cast_nullable_to_non_nullable
as String?,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,meterType: freezed == meterType ? _self.meterType : meterType // ignore: cast_nullable_to_non_nullable
as String?,meterNumber: freezed == meterNumber ? _self.meterNumber : meterNumber // ignore: cast_nullable_to_non_nullable
as String?,smartCardNumber: freezed == smartCardNumber ? _self.smartCardNumber : smartCardNumber // ignore: cast_nullable_to_non_nullable
as String?,package: freezed == package ? _self.package : package // ignore: cast_nullable_to_non_nullable
as String?,userBalance: freezed == userBalance ? _self.userBalance : userBalance // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,agentName: freezed == agentName ? _self.agentName : agentName // ignore: cast_nullable_to_non_nullable
as String?,agentEmail: freezed == agentEmail ? _self.agentEmail : agentEmail // ignore: cast_nullable_to_non_nullable
as String?,agentPhoneNumber: freezed == agentPhoneNumber ? _self.agentPhoneNumber : agentPhoneNumber // ignore: cast_nullable_to_non_nullable
as String?,businessName: freezed == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String?,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as String?,subProduct: freezed == subProduct ? _self.subProduct : subProduct // ignore: cast_nullable_to_non_nullable
as String?,dataBundle: freezed == dataBundle ? _self.dataBundle : dataBundle // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,balanceBefore: freezed == balanceBefore ? _self.balanceBefore : balanceBefore // ignore: cast_nullable_to_non_nullable
as String?,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,units: freezed == units ? _self.units : units // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
