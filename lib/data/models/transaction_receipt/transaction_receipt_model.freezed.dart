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
  String? get transactionId =>
      throw _privateConstructorUsedError; // Unique identifier for the transaction from transRef or generated
  String? get date =>
      throw _privateConstructorUsedError; // Date of the transaction derived from createdAt
  String? get time =>
      throw _privateConstructorUsedError; // Time of the transaction derived from createdAt
  String? get type =>
      throw _privateConstructorUsedError; // Transaction type, dynamically set (e.g., productName or transType)
  String? get amount =>
      throw _privateConstructorUsedError; // Transaction amount, formatted based on transType
  String? get bankName =>
      throw _privateConstructorUsedError; // Name of the bank (if applicable,)
  String? get accountNumber =>
      throw _privateConstructorUsedError; // Account number or name (e.g., crAcc for withdrawal),
  String get status =>
      throw _privateConstructorUsedError; // Status of the transaction
  String? get description =>
      throw _privateConstructorUsedError; // Additional description from subProduct or productName
  String? get reference =>
      throw _privateConstructorUsedError; // Reference number
  String? get beneficiary =>
      throw _privateConstructorUsedError; // Beneficiary details (e.g., phone number for airtime),
  String? get provider =>
      throw _privateConstructorUsedError; // Service provider (e.g., MTN, Startimes),
  String? get meterType =>
      throw _privateConstructorUsedError; // Meter type (e.g., Prepaid/Postpaid for electricity),
  String? get meterNumber =>
      throw _privateConstructorUsedError; // Meter number (e.g., for electricity),
  String? get smartCardNumber =>
      throw _privateConstructorUsedError; // Smart card number (e.g., for cable TV),
  String? get package =>
      throw _privateConstructorUsedError; // Package details (e.g., Startimes Plus),
  String? get userBalance =>
      throw _privateConstructorUsedError; // User's balance after the transaction, from balanceAfter
  String? get paymentMethod =>
      throw _privateConstructorUsedError; // Payment method (e.g., Wallet, Monnify),
  String? get agentName =>
      throw _privateConstructorUsedError; // Agent name (e.g., for bulk e-PIN),
  String? get agentEmail =>
      throw _privateConstructorUsedError; // Agent email (e.g., for bulk e-PIN),
  String? get agentPhoneNumber =>
      throw _privateConstructorUsedError; // Agent phone number (e.g., for bulk e-PIN),
  String? get businessName =>
      throw _privateConstructorUsedError; // Business name (e.g., for bulk e-PIN),
  String? get network =>
      throw _privateConstructorUsedError; // Network provider (e.g., MTN, Glo),
  String? get quantity =>
      throw _privateConstructorUsedError; // Quantity (e.g., for bulk e-PIN),
  String? get subProduct =>
      throw _privateConstructorUsedError; // Sub-product details,
  String? get dataBundle =>
      throw _privateConstructorUsedError; // Data bundle details (e.g., 100MB 1 Day),
  String? get phoneNumber =>
      throw _privateConstructorUsedError; // Phone number (e.g., for data or airtime), from crAcc
  String? get balanceBefore =>
      throw _privateConstructorUsedError; // User's balance before the transaction, from balanceBefore
  String? get token =>
      throw _privateConstructorUsedError; // Token for electricity transactions, copyable in UI
  String? get units => throw _privateConstructorUsedError;

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
      {String? transactionId,
      String? date,
      String? time,
      String? type,
      String? amount,
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
      String? phoneNumber,
      String? balanceBefore,
      String? token,
      String? units});
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
    Object? transactionId = freezed,
    Object? date = freezed,
    Object? time = freezed,
    Object? type = freezed,
    Object? amount = freezed,
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
    Object? balanceBefore = freezed,
    Object? token = freezed,
    Object? units = freezed,
  }) {
    return _then(_value.copyWith(
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
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
      balanceBefore: freezed == balanceBefore
          ? _value.balanceBefore
          : balanceBefore // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      units: freezed == units
          ? _value.units
          : units // ignore: cast_nullable_to_non_nullable
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
      {String? transactionId,
      String? date,
      String? time,
      String? type,
      String? amount,
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
      String? phoneNumber,
      String? balanceBefore,
      String? token,
      String? units});
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
    Object? transactionId = freezed,
    Object? date = freezed,
    Object? time = freezed,
    Object? type = freezed,
    Object? amount = freezed,
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
    Object? balanceBefore = freezed,
    Object? token = freezed,
    Object? units = freezed,
  }) {
    return _then(_$TransactionReceiptDataImpl(
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
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
      balanceBefore: freezed == balanceBefore
          ? _value.balanceBefore
          : balanceBefore // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      units: freezed == units
          ? _value.units
          : units // ignore: cast_nullable_to_non_nullable
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
      this.phoneNumber,
      this.balanceBefore,
      this.token,
      this.units});

  factory _$TransactionReceiptDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionReceiptDataImplFromJson(json);

  @override
  final String? transactionId;
// Unique identifier for the transaction from transRef or generated
  @override
  final String? date;
// Date of the transaction derived from createdAt
  @override
  final String? time;
// Time of the transaction derived from createdAt
  @override
  final String? type;
// Transaction type, dynamically set (e.g., productName or transType)
  @override
  final String? amount;
// Transaction amount, formatted based on transType
  @override
  final String? bankName;
// Name of the bank (if applicable,)
  @override
  final String? accountNumber;
// Account number or name (e.g., crAcc for withdrawal),
  @override
  final String status;
// Status of the transaction
  @override
  final String? description;
// Additional description from subProduct or productName
  @override
  final String? reference;
// Reference number
  @override
  final String? beneficiary;
// Beneficiary details (e.g., phone number for airtime),
  @override
  final String? provider;
// Service provider (e.g., MTN, Startimes),
  @override
  final String? meterType;
// Meter type (e.g., Prepaid/Postpaid for electricity),
  @override
  final String? meterNumber;
// Meter number (e.g., for electricity),
  @override
  final String? smartCardNumber;
// Smart card number (e.g., for cable TV),
  @override
  final String? package;
// Package details (e.g., Startimes Plus),
  @override
  final String? userBalance;
// User's balance after the transaction, from balanceAfter
  @override
  final String? paymentMethod;
// Payment method (e.g., Wallet, Monnify),
  @override
  final String? agentName;
// Agent name (e.g., for bulk e-PIN),
  @override
  final String? agentEmail;
// Agent email (e.g., for bulk e-PIN),
  @override
  final String? agentPhoneNumber;
// Agent phone number (e.g., for bulk e-PIN),
  @override
  final String? businessName;
// Business name (e.g., for bulk e-PIN),
  @override
  final String? network;
// Network provider (e.g., MTN, Glo),
  @override
  final String? quantity;
// Quantity (e.g., for bulk e-PIN),
  @override
  final String? subProduct;
// Sub-product details,
  @override
  final String? dataBundle;
// Data bundle details (e.g., 100MB 1 Day),
  @override
  final String? phoneNumber;
// Phone number (e.g., for data or airtime), from crAcc
  @override
  final String? balanceBefore;
// User's balance before the transaction, from balanceBefore
  @override
  final String? token;
// Token for electricity transactions, copyable in UI
  @override
  final String? units;

  @override
  String toString() {
    return 'TransactionReceiptData(transactionId: $transactionId, date: $date, time: $time, type: $type, amount: $amount, bankName: $bankName, accountNumber: $accountNumber, status: $status, description: $description, reference: $reference, beneficiary: $beneficiary, provider: $provider, meterType: $meterType, meterNumber: $meterNumber, smartCardNumber: $smartCardNumber, package: $package, userBalance: $userBalance, paymentMethod: $paymentMethod, agentName: $agentName, agentEmail: $agentEmail, agentPhoneNumber: $agentPhoneNumber, businessName: $businessName, network: $network, quantity: $quantity, subProduct: $subProduct, dataBundle: $dataBundle, phoneNumber: $phoneNumber, balanceBefore: $balanceBefore, token: $token, units: $units)';
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
                other.phoneNumber == phoneNumber) &&
            (identical(other.balanceBefore, balanceBefore) ||
                other.balanceBefore == balanceBefore) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.units, units) || other.units == units));
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
        phoneNumber,
        balanceBefore,
        token,
        units
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
      {required final String? transactionId,
      required final String? date,
      required final String? time,
      required final String? type,
      required final String? amount,
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
      final String? phoneNumber,
      final String? balanceBefore,
      final String? token,
      final String? units}) = _$TransactionReceiptDataImpl;

  factory _TransactionReceiptData.fromJson(Map<String, dynamic> json) =
      _$TransactionReceiptDataImpl.fromJson;

  @override
  String?
      get transactionId; // Unique identifier for the transaction from transRef or generated
  @override
  String? get date; // Date of the transaction derived from createdAt
  @override
  String? get time; // Time of the transaction derived from createdAt
  @override
  String?
      get type; // Transaction type, dynamically set (e.g., productName or transType)
  @override
  String? get amount; // Transaction amount, formatted based on transType
  @override
  String? get bankName; // Name of the bank (if applicable,)
  @override
  String?
      get accountNumber; // Account number or name (e.g., crAcc for withdrawal),
  @override
  String get status; // Status of the transaction
  @override
  String?
      get description; // Additional description from subProduct or productName
  @override
  String? get reference; // Reference number
  @override
  String?
      get beneficiary; // Beneficiary details (e.g., phone number for airtime),
  @override
  String? get provider; // Service provider (e.g., MTN, Startimes),
  @override
  String? get meterType; // Meter type (e.g., Prepaid/Postpaid for electricity),
  @override
  String? get meterNumber; // Meter number (e.g., for electricity),
  @override
  String? get smartCardNumber; // Smart card number (e.g., for cable TV),
  @override
  String? get package; // Package details (e.g., Startimes Plus),
  @override
  String?
      get userBalance; // User's balance after the transaction, from balanceAfter
  @override
  String? get paymentMethod; // Payment method (e.g., Wallet, Monnify),
  @override
  String? get agentName; // Agent name (e.g., for bulk e-PIN),
  @override
  String? get agentEmail; // Agent email (e.g., for bulk e-PIN),
  @override
  String? get agentPhoneNumber; // Agent phone number (e.g., for bulk e-PIN),
  @override
  String? get businessName; // Business name (e.g., for bulk e-PIN),
  @override
  String? get network; // Network provider (e.g., MTN, Glo),
  @override
  String? get quantity; // Quantity (e.g., for bulk e-PIN),
  @override
  String? get subProduct; // Sub-product details,
  @override
  String? get dataBundle; // Data bundle details (e.g., 100MB 1 Day),
  @override
  String?
      get phoneNumber; // Phone number (e.g., for data or airtime), from crAcc
  @override
  String?
      get balanceBefore; // User's balance before the transaction, from balanceBefore
  @override
  String? get token; // Token for electricity transactions, copyable in UI
  @override
  String? get units;

  /// Create a copy of TransactionReceiptData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionReceiptDataImplCopyWith<_$TransactionReceiptDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
