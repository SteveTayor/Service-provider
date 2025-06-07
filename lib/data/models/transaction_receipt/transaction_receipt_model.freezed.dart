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
      String? reference});
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
      String? reference});
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
      this.reference});

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
  String toString() {
    return 'TransactionReceiptData(transactionId: $transactionId, date: $date, time: $time, type: $type, amount: $amount, bankName: $bankName, accountNumber: $accountNumber, status: $status, description: $description, reference: $reference)';
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
                other.reference == reference));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, transactionId, date, time, type,
      amount, bankName, accountNumber, status, description, reference);

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
      final String? reference}) = _$TransactionReceiptDataImpl;

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

  /// Create a copy of TransactionReceiptData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionReceiptDataImplCopyWith<_$TransactionReceiptDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
