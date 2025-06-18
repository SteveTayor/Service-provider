// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_receipt_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TransactionReceiptData _$TransactionReceiptDataFromJson(
    Map<String, dynamic> json) {
  return _TransactionReceiptData.fromJson(json);
}

/// @nodoc
mixin _$TransactionReceiptData {
  String get transactionId => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  String? get bankName => throw _privateConstructorUsedError;
  String? get accountNumber => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get reference => throw _privateConstructorUsedError;
  String? get beneficiary =>
      throw _privateConstructorUsedError; // e.g., phone number for airtime
  String? get provider =>
      throw _privateConstructorUsedError; // e.g., MTN, Startimes, Eko PHCN
  String? get meterType =>
      throw _privateConstructorUsedError; // e.g., Prepaid/Postpaid for electricity
  String? get meterNumber =>
      throw _privateConstructorUsedError; // e.g., electricity meter number
  String? get smartCardNumber =>
      throw _privateConstructorUsedError; // e.g., for cable TV
  String? get package =>
      throw _privateConstructorUsedError; // e.g., Startimes Plus WEB ACCESS
  String? get userBalance =>
      throw _privateConstructorUsedError; // e.g., user's balance after transaction
  String? get paymentMethod =>
      throw _privateConstructorUsedError; // e.g., Wallet, Bank Transfer
  String? get agentName =>
      throw _privateConstructorUsedError; // e.g., for bulk e-PIN
  String? get agentEmail =>
      throw _privateConstructorUsedError; // e.g., for bulk e-PIN
  String? get agentPhoneNumber =>
      throw _privateConstructorUsedError; // e.g., for bulk e-PIN
  String? get businessName =>
      throw _privateConstructorUsedError; // e.g., for bulk e-PIN
  String? get network =>
      throw _privateConstructorUsedError; // e.g., MTN, Glo for bulk e-PIN or data
  String? get quantity =>
      throw _privateConstructorUsedError; // e.g., for bulk e-PIN
  String? get subProduct =>
      throw _privateConstructorUsedError; // e.g., for education transactions
  String? get dataBundle =>
      throw _privateConstructorUsedError; // e.g., 100MB 1 Day for data purchase
  String? get phoneNumber => throw _privateConstructorUsedError;

  /// Serializes this TransactionReceiptData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransactionReceiptData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionReceiptDataCopyWith<TransactionReceiptData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionReceiptDataCopyWith<$Res> {
  factory $TransactionReceiptDataCopyWith(TransactionReceiptData value,
          $Res Function(TransactionReceiptData) then) =
      _$TransactionReceiptDataCopyWithImpl<$Res, TransactionReceiptData>;
  @useResult
  $Res call(
      {String transactionId,
      String date,
      String time,
      String type,
      String amount,
      String? bankName,
      String? accountNumber,
      String status,
      String? description,
      String? reference,
      String? beneficiary,
      String? provider,
      String? meterType,
      String? meterNumber,
      String? smartCardNumber,
      String? package,
      String? userBalance,
      String? paymentMethod,
      String? agentName,
      String? agentEmail,
      String? agentPhoneNumber,
      String? businessName,
      String? network,
      String? quantity,
      String? subProduct,
      String? dataBundle,
      String? phoneNumber});
}

/// @nodoc
class _$TransactionReceiptDataCopyWithImpl<$Res,
        $Val extends TransactionReceiptData>
    implements $TransactionReceiptDataCopyWith<$Res> {
  _$TransactionReceiptDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionReceiptData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = null,
    Object? date = null,
    Object? time = null,
    Object? type = null,
    Object? amount = null,
    Object? bankName = freezed,
    Object? accountNumber = freezed,
    Object? status = null,
    Object? description = freezed,
    Object? reference = freezed,
    Object? beneficiary = freezed,
    Object? provider = freezed,
    Object? meterType = freezed,
    Object? meterNumber = freezed,
    Object? smartCardNumber = freezed,
    Object? package = freezed,
    Object? userBalance = freezed,
    Object? paymentMethod = freezed,
    Object? agentName = freezed,
    Object? agentEmail = freezed,
    Object? agentPhoneNumber = freezed,
    Object? businessName = freezed,
    Object? network = freezed,
    Object? quantity = freezed,
    Object? subProduct = freezed,
    Object? dataBundle = freezed,
    Object? phoneNumber = freezed,
  }) {
    return _then(_value.copyWith(
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      accountNumber: freezed == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      beneficiary: freezed == beneficiary
          ? _value.beneficiary
          : beneficiary // ignore: cast_nullable_to_non_nullable
              as String?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
      meterType: freezed == meterType
          ? _value.meterType
          : meterType // ignore: cast_nullable_to_non_nullable
              as String?,
      meterNumber: freezed == meterNumber
          ? _value.meterNumber
          : meterNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      smartCardNumber: freezed == smartCardNumber
          ? _value.smartCardNumber
          : smartCardNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      package: freezed == package
          ? _value.package
          : package // ignore: cast_nullable_to_non_nullable
              as String?,
      userBalance: freezed == userBalance
          ? _value.userBalance
          : userBalance // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      agentName: freezed == agentName
          ? _value.agentName
          : agentName // ignore: cast_nullable_to_non_nullable
              as String?,
      agentEmail: freezed == agentEmail
          ? _value.agentEmail
          : agentEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      agentPhoneNumber: freezed == agentPhoneNumber
          ? _value.agentPhoneNumber
          : agentPhoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      businessName: freezed == businessName
          ? _value.businessName
          : businessName // ignore: cast_nullable_to_non_nullable
              as String?,
      network: freezed == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String?,
      subProduct: freezed == subProduct
          ? _value.subProduct
          : subProduct // ignore: cast_nullable_to_non_nullable
              as String?,
      dataBundle: freezed == dataBundle
          ? _value.dataBundle
          : dataBundle // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionReceiptDataImplCopyWith<$Res>
    implements $TransactionReceiptDataCopyWith<$Res> {
  factory _$$TransactionReceiptDataImplCopyWith(
          _$TransactionReceiptDataImpl value,
          $Res Function(_$TransactionReceiptDataImpl) then) =
      __$$TransactionReceiptDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String transactionId,
      String date,
      String time,
      String type,
      String amount,
      String? bankName,
      String? accountNumber,
      String status,
      String? description,
      String? reference,
      String? beneficiary,
      String? provider,
      String? meterType,
      String? meterNumber,
      String? smartCardNumber,
      String? package,
      String? userBalance,
      String? paymentMethod,
      String? agentName,
      String? agentEmail,
      String? agentPhoneNumber,
      String? businessName,
      String? network,
      String? quantity,
      String? subProduct,
      String? dataBundle,
      String? phoneNumber});
}

/// @nodoc
class __$$TransactionReceiptDataImplCopyWithImpl<$Res>
    extends _$TransactionReceiptDataCopyWithImpl<$Res,
        _$TransactionReceiptDataImpl>
    implements _$$TransactionReceiptDataImplCopyWith<$Res> {
  __$$TransactionReceiptDataImplCopyWithImpl(
      _$TransactionReceiptDataImpl _value,
      $Res Function(_$TransactionReceiptDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionReceiptData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = null,
    Object? date = null,
    Object? time = null,
    Object? type = null,
    Object? amount = null,
    Object? bankName = freezed,
    Object? accountNumber = freezed,
    Object? status = null,
    Object? description = freezed,
    Object? reference = freezed,
    Object? beneficiary = freezed,
    Object? provider = freezed,
    Object? meterType = freezed,
    Object? meterNumber = freezed,
    Object? smartCardNumber = freezed,
    Object? package = freezed,
    Object? userBalance = freezed,
    Object? paymentMethod = freezed,
    Object? agentName = freezed,
    Object? agentEmail = freezed,
    Object? agentPhoneNumber = freezed,
    Object? businessName = freezed,
    Object? network = freezed,
    Object? quantity = freezed,
    Object? subProduct = freezed,
    Object? dataBundle = freezed,
    Object? phoneNumber = freezed,
  }) {
    return _then(_$TransactionReceiptDataImpl(
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      accountNumber: freezed == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      beneficiary: freezed == beneficiary
          ? _value.beneficiary
          : beneficiary // ignore: cast_nullable_to_non_nullable
              as String?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
      meterType: freezed == meterType
          ? _value.meterType
          : meterType // ignore: cast_nullable_to_non_nullable
              as String?,
      meterNumber: freezed == meterNumber
          ? _value.meterNumber
          : meterNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      smartCardNumber: freezed == smartCardNumber
          ? _value.smartCardNumber
          : smartCardNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      package: freezed == package
          ? _value.package
          : package // ignore: cast_nullable_to_non_nullable
              as String?,
      userBalance: freezed == userBalance
          ? _value.userBalance
          : userBalance // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      agentName: freezed == agentName
          ? _value.agentName
          : agentName // ignore: cast_nullable_to_non_nullable
              as String?,
      agentEmail: freezed == agentEmail
          ? _value.agentEmail
          : agentEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      agentPhoneNumber: freezed == agentPhoneNumber
          ? _value.agentPhoneNumber
          : agentPhoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      businessName: freezed == businessName
          ? _value.businessName
          : businessName // ignore: cast_nullable_to_non_nullable
              as String?,
      network: freezed == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String?,
      subProduct: freezed == subProduct
          ? _value.subProduct
          : subProduct // ignore: cast_nullable_to_non_nullable
              as String?,
      dataBundle: freezed == dataBundle
          ? _value.dataBundle
          : dataBundle // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionReceiptDataImpl implements _TransactionReceiptData {
  const _$TransactionReceiptDataImpl(
      {required this.transactionId,
      required this.date,
      required this.time,
      required this.type,
      required this.amount,
      this.bankName,
      this.accountNumber,
      required this.status,
      this.description,
      this.reference,
      this.beneficiary,
      this.provider,
      this.meterType,
      this.meterNumber,
      this.smartCardNumber,
      this.package,
      this.userBalance,
      this.paymentMethod,
      this.agentName,
      this.agentEmail,
      this.agentPhoneNumber,
      this.businessName,
      this.network,
      this.quantity,
      this.subProduct,
      this.dataBundle,
      this.phoneNumber});

  factory _$TransactionReceiptDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionReceiptDataImplFromJson(json);

  @override
  final String transactionId;
  @override
  final String date;
  @override
  final String time;
  @override
  final String type;
  @override
  final String amount;
  @override
  final String? bankName;
  @override
  final String? accountNumber;
  @override
  final String status;
  @override
  final String? description;
  @override
  final String? reference;
  @override
  final String? beneficiary;
// e.g., phone number for airtime
  @override
  final String? provider;
// e.g., MTN, Startimes, Eko PHCN
  @override
  final String? meterType;
// e.g., Prepaid/Postpaid for electricity
  @override
  final String? meterNumber;
// e.g., electricity meter number
  @override
  final String? smartCardNumber;
// e.g., for cable TV
  @override
  final String? package;
// e.g., Startimes Plus WEB ACCESS
  @override
  final String? userBalance;
// e.g., user's balance after transaction
  @override
  final String? paymentMethod;
// e.g., Wallet, Bank Transfer
  @override
  final String? agentName;
// e.g., for bulk e-PIN
  @override
  final String? agentEmail;
// e.g., for bulk e-PIN
  @override
  final String? agentPhoneNumber;
// e.g., for bulk e-PIN
  @override
  final String? businessName;
// e.g., for bulk e-PIN
  @override
  final String? network;
// e.g., MTN, Glo for bulk e-PIN or data
  @override
  final String? quantity;
// e.g., for bulk e-PIN
  @override
  final String? subProduct;
// e.g., for education transactions
  @override
  final String? dataBundle;
// e.g., 100MB 1 Day for data purchase
  @override
  final String? phoneNumber;

  @override
  String toString() {
    return 'TransactionReceiptData(transactionId: $transactionId, date: $date, time: $time, type: $type, amount: $amount, bankName: $bankName, accountNumber: $accountNumber, status: $status, description: $description, reference: $reference, beneficiary: $beneficiary, provider: $provider, meterType: $meterType, meterNumber: $meterNumber, smartCardNumber: $smartCardNumber, package: $package, userBalance: $userBalance, paymentMethod: $paymentMethod, agentName: $agentName, agentEmail: $agentEmail, agentPhoneNumber: $agentPhoneNumber, businessName: $businessName, network: $network, quantity: $quantity, subProduct: $subProduct, dataBundle: $dataBundle, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionReceiptDataImpl &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.beneficiary, beneficiary) ||
                other.beneficiary == beneficiary) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.meterType, meterType) ||
                other.meterType == meterType) &&
            (identical(other.meterNumber, meterNumber) ||
                other.meterNumber == meterNumber) &&
            (identical(other.smartCardNumber, smartCardNumber) ||
                other.smartCardNumber == smartCardNumber) &&
            (identical(other.package, package) || other.package == package) &&
            (identical(other.userBalance, userBalance) ||
                other.userBalance == userBalance) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.agentName, agentName) ||
                other.agentName == agentName) &&
            (identical(other.agentEmail, agentEmail) ||
                other.agentEmail == agentEmail) &&
            (identical(other.agentPhoneNumber, agentPhoneNumber) ||
                other.agentPhoneNumber == agentPhoneNumber) &&
            (identical(other.businessName, businessName) ||
                other.businessName == businessName) &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.subProduct, subProduct) ||
                other.subProduct == subProduct) &&
            (identical(other.dataBundle, dataBundle) ||
                other.dataBundle == dataBundle) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        transactionId,
        date,
        time,
        type,
        amount,
        bankName,
        accountNumber,
        status,
        description,
        reference,
        beneficiary,
        provider,
        meterType,
        meterNumber,
        smartCardNumber,
        package,
        userBalance,
        paymentMethod,
        agentName,
        agentEmail,
        agentPhoneNumber,
        businessName,
        network,
        quantity,
        subProduct,
        dataBundle,
        phoneNumber
      ]);

  /// Create a copy of TransactionReceiptData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionReceiptDataImplCopyWith<_$TransactionReceiptDataImpl>
      get copyWith => __$$TransactionReceiptDataImplCopyWithImpl<
          _$TransactionReceiptDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionReceiptDataImplToJson(
      this,
    );
  }
}

abstract class _TransactionReceiptData implements TransactionReceiptData {
  const factory _TransactionReceiptData(
      {required final String transactionId,
      required final String date,
      required final String time,
      required final String type,
      required final String amount,
      final String? bankName,
      final String? accountNumber,
      required final String status,
      final String? description,
      final String? reference,
      final String? beneficiary,
      final String? provider,
      final String? meterType,
      final String? meterNumber,
      final String? smartCardNumber,
      final String? package,
      final String? userBalance,
      final String? paymentMethod,
      final String? agentName,
      final String? agentEmail,
      final String? agentPhoneNumber,
      final String? businessName,
      final String? network,
      final String? quantity,
      final String? subProduct,
      final String? dataBundle,
      final String? phoneNumber}) = _$TransactionReceiptDataImpl;

  factory _TransactionReceiptData.fromJson(Map<String, dynamic> json) =
      _$TransactionReceiptDataImpl.fromJson;

  @override
  String get transactionId;
  @override
  String get date;
  @override
  String get time;
  @override
  String get type;
  @override
  String get amount;
  @override
  String? get bankName;
  @override
  String? get accountNumber;
  @override
  String get status;
  @override
  String? get description;
  @override
  String? get reference;
  @override
  String? get beneficiary; // e.g., phone number for airtime
  @override
  String? get provider; // e.g., MTN, Startimes, Eko PHCN
  @override
  String? get meterType; // e.g., Prepaid/Postpaid for electricity
  @override
  String? get meterNumber; // e.g., electricity meter number
  @override
  String? get smartCardNumber; // e.g., for cable TV
  @override
  String? get package; // e.g., Startimes Plus WEB ACCESS
  @override
  String? get userBalance; // e.g., user's balance after transaction
  @override
  String? get paymentMethod; // e.g., Wallet, Bank Transfer
  @override
  String? get agentName; // e.g., for bulk e-PIN
  @override
  String? get agentEmail; // e.g., for bulk e-PIN
  @override
  String? get agentPhoneNumber; // e.g., for bulk e-PIN
  @override
  String? get businessName; // e.g., for bulk e-PIN
  @override
  String? get network; // e.g., MTN, Glo for bulk e-PIN or data
  @override
  String? get quantity; // e.g., for bulk e-PIN
  @override
  String? get subProduct; // e.g., for education transactions
  @override
  String? get dataBundle; // e.g., 100MB 1 Day for data purchase
  @override
  String? get phoneNumber;

  /// Create a copy of TransactionReceiptData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionReceiptDataImplCopyWith<_$TransactionReceiptDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
