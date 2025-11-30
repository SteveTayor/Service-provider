// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) {
  return _LoginRequest.fromJson(json);
}

/// @nodoc
mixin _$LoginRequest {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  @JsonKey(name: 'device_token')
  String? get deviceToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'fcm_token')
  String? get fcmToken => throw _privateConstructorUsedError;

  /// Serializes this LoginRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginRequestCopyWith<LoginRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginRequestCopyWith<$Res> {
  factory $LoginRequestCopyWith(
          LoginRequest value, $Res Function(LoginRequest) then) =
      _$LoginRequestCopyWithImpl<$Res, LoginRequest>;
  @useResult
  $Res call(
      {String email,
      String password,
      @JsonKey(name: 'device_token') String? deviceToken,
      @JsonKey(name: 'fcm_token') String? fcmToken});
}

/// @nodoc
class _$LoginRequestCopyWithImpl<$Res, $Val extends LoginRequest>
    implements $LoginRequestCopyWith<$Res> {
  _$LoginRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? deviceToken = freezed,
    Object? fcmToken = freezed,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      deviceToken: freezed == deviceToken
          ? _value.deviceToken
          : deviceToken // ignore: cast_nullable_to_non_nullable
              as String?,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginRequestImplCopyWith<$Res>
    implements $LoginRequestCopyWith<$Res> {
  factory _$$LoginRequestImplCopyWith(
          _$LoginRequestImpl value, $Res Function(_$LoginRequestImpl) then) =
      __$$LoginRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      String password,
      @JsonKey(name: 'device_token') String? deviceToken,
      @JsonKey(name: 'fcm_token') String? fcmToken});
}

/// @nodoc
class __$$LoginRequestImplCopyWithImpl<$Res>
    extends _$LoginRequestCopyWithImpl<$Res, _$LoginRequestImpl>
    implements _$$LoginRequestImplCopyWith<$Res> {
  __$$LoginRequestImplCopyWithImpl(
      _$LoginRequestImpl _value, $Res Function(_$LoginRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? deviceToken = freezed,
    Object? fcmToken = freezed,
  }) {
    return _then(_$LoginRequestImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      deviceToken: freezed == deviceToken
          ? _value.deviceToken
          : deviceToken // ignore: cast_nullable_to_non_nullable
              as String?,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginRequestImpl with DiagnosticableTreeMixin implements _LoginRequest {
  const _$LoginRequestImpl(
      {required this.email,
      required this.password,
      @JsonKey(name: 'device_token') this.deviceToken,
      @JsonKey(name: 'fcm_token') this.fcmToken});

  factory _$LoginRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginRequestImplFromJson(json);

  @override
  final String email;
  @override
  final String password;
  @override
  @JsonKey(name: 'device_token')
  final String? deviceToken;
  @override
  @JsonKey(name: 'fcm_token')
  final String? fcmToken;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LoginRequest(email: $email, password: $password, deviceToken: $deviceToken, fcmToken: $fcmToken)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LoginRequest'))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('password', password))
      ..add(DiagnosticsProperty('deviceToken', deviceToken))
      ..add(DiagnosticsProperty('fcmToken', fcmToken));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginRequestImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.deviceToken, deviceToken) ||
                other.deviceToken == deviceToken) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, email, password, deviceToken, fcmToken);

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginRequestImplCopyWith<_$LoginRequestImpl> get copyWith =>
      __$$LoginRequestImplCopyWithImpl<_$LoginRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginRequestImplToJson(
      this,
    );
  }
}

abstract class _LoginRequest implements LoginRequest {
  const factory _LoginRequest(
      {required final String email,
      required final String password,
      @JsonKey(name: 'device_token') final String? deviceToken,
      @JsonKey(name: 'fcm_token') final String? fcmToken}) = _$LoginRequestImpl;

  factory _LoginRequest.fromJson(Map<String, dynamic> json) =
      _$LoginRequestImpl.fromJson;

  @override
  String get email;
  @override
  String get password;
  @override
  @JsonKey(name: 'device_token')
  String? get deviceToken;
  @override
  @JsonKey(name: 'fcm_token')
  String? get fcmToken;

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginRequestImplCopyWith<_$LoginRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) {
  return _RegisterRequest.fromJson(json);
}

/// @nodoc
mixin _$RegisterRequest {
  String get email => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name')
  String get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name')
  String get lastName => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  @JsonKey(name: 'password_confirm')
  String get passwordConfirm => throw _privateConstructorUsedError;

  /// Serializes this RegisterRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterRequestCopyWith<RegisterRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterRequestCopyWith<$Res> {
  factory $RegisterRequestCopyWith(
          RegisterRequest value, $Res Function(RegisterRequest) then) =
      _$RegisterRequestCopyWithImpl<$Res, RegisterRequest>;
  @useResult
  $Res call(
      {String email,
      String phone,
      @JsonKey(name: 'first_name') String firstName,
      @JsonKey(name: 'last_name') String lastName,
      String password,
      @JsonKey(name: 'password_confirm') String passwordConfirm});
}

/// @nodoc
class _$RegisterRequestCopyWithImpl<$Res, $Val extends RegisterRequest>
    implements $RegisterRequestCopyWith<$Res> {
  _$RegisterRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? phone = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? password = null,
    Object? passwordConfirm = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      passwordConfirm: null == passwordConfirm
          ? _value.passwordConfirm
          : passwordConfirm // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisterRequestImplCopyWith<$Res>
    implements $RegisterRequestCopyWith<$Res> {
  factory _$$RegisterRequestImplCopyWith(_$RegisterRequestImpl value,
          $Res Function(_$RegisterRequestImpl) then) =
      __$$RegisterRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      String phone,
      @JsonKey(name: 'first_name') String firstName,
      @JsonKey(name: 'last_name') String lastName,
      String password,
      @JsonKey(name: 'password_confirm') String passwordConfirm});
}

/// @nodoc
class __$$RegisterRequestImplCopyWithImpl<$Res>
    extends _$RegisterRequestCopyWithImpl<$Res, _$RegisterRequestImpl>
    implements _$$RegisterRequestImplCopyWith<$Res> {
  __$$RegisterRequestImplCopyWithImpl(
      _$RegisterRequestImpl _value, $Res Function(_$RegisterRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? phone = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? password = null,
    Object? passwordConfirm = null,
  }) {
    return _then(_$RegisterRequestImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      passwordConfirm: null == passwordConfirm
          ? _value.passwordConfirm
          : passwordConfirm // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisterRequestImpl
    with DiagnosticableTreeMixin
    implements _RegisterRequest {
  const _$RegisterRequestImpl(
      {required this.email,
      required this.phone,
      @JsonKey(name: 'first_name') required this.firstName,
      @JsonKey(name: 'last_name') required this.lastName,
      required this.password,
      @JsonKey(name: 'password_confirm') required this.passwordConfirm});

  factory _$RegisterRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisterRequestImplFromJson(json);

  @override
  final String email;
  @override
  final String phone;
  @override
  @JsonKey(name: 'first_name')
  final String firstName;
  @override
  @JsonKey(name: 'last_name')
  final String lastName;
  @override
  final String password;
  @override
  @JsonKey(name: 'password_confirm')
  final String passwordConfirm;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RegisterRequest(email: $email, phone: $phone, firstName: $firstName, lastName: $lastName, password: $password, passwordConfirm: $passwordConfirm)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RegisterRequest'))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('phone', phone))
      ..add(DiagnosticsProperty('firstName', firstName))
      ..add(DiagnosticsProperty('lastName', lastName))
      ..add(DiagnosticsProperty('password', password))
      ..add(DiagnosticsProperty('passwordConfirm', passwordConfirm));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterRequestImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.passwordConfirm, passwordConfirm) ||
                other.passwordConfirm == passwordConfirm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, phone, firstName,
      lastName, password, passwordConfirm);

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterRequestImplCopyWith<_$RegisterRequestImpl> get copyWith =>
      __$$RegisterRequestImplCopyWithImpl<_$RegisterRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisterRequestImplToJson(
      this,
    );
  }
}

abstract class _RegisterRequest implements RegisterRequest {
  const factory _RegisterRequest(
      {required final String email,
      required final String phone,
      @JsonKey(name: 'first_name') required final String firstName,
      @JsonKey(name: 'last_name') required final String lastName,
      required final String password,
      @JsonKey(name: 'password_confirm')
      required final String passwordConfirm}) = _$RegisterRequestImpl;

  factory _RegisterRequest.fromJson(Map<String, dynamic> json) =
      _$RegisterRequestImpl.fromJson;

  @override
  String get email;
  @override
  String get phone;
  @override
  @JsonKey(name: 'first_name')
  String get firstName;
  @override
  @JsonKey(name: 'last_name')
  String get lastName;
  @override
  String get password;
  @override
  @JsonKey(name: 'password_confirm')
  String get passwordConfirm;

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterRequestImplCopyWith<_$RegisterRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ForgotPasswordRequest _$ForgotPasswordRequestFromJson(
    Map<String, dynamic> json) {
  return _ForgotPasswordRequest.fromJson(json);
}

/// @nodoc
mixin _$ForgotPasswordRequest {
  String get email => throw _privateConstructorUsedError;

  /// Serializes this ForgotPasswordRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForgotPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForgotPasswordRequestCopyWith<ForgotPasswordRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForgotPasswordRequestCopyWith<$Res> {
  factory $ForgotPasswordRequestCopyWith(ForgotPasswordRequest value,
          $Res Function(ForgotPasswordRequest) then) =
      _$ForgotPasswordRequestCopyWithImpl<$Res, ForgotPasswordRequest>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class _$ForgotPasswordRequestCopyWithImpl<$Res,
        $Val extends ForgotPasswordRequest>
    implements $ForgotPasswordRequestCopyWith<$Res> {
  _$ForgotPasswordRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForgotPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ForgotPasswordRequestImplCopyWith<$Res>
    implements $ForgotPasswordRequestCopyWith<$Res> {
  factory _$$ForgotPasswordRequestImplCopyWith(
          _$ForgotPasswordRequestImpl value,
          $Res Function(_$ForgotPasswordRequestImpl) then) =
      __$$ForgotPasswordRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$ForgotPasswordRequestImplCopyWithImpl<$Res>
    extends _$ForgotPasswordRequestCopyWithImpl<$Res,
        _$ForgotPasswordRequestImpl>
    implements _$$ForgotPasswordRequestImplCopyWith<$Res> {
  __$$ForgotPasswordRequestImplCopyWithImpl(_$ForgotPasswordRequestImpl _value,
      $Res Function(_$ForgotPasswordRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ForgotPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$ForgotPasswordRequestImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ForgotPasswordRequestImpl
    with DiagnosticableTreeMixin
    implements _ForgotPasswordRequest {
  const _$ForgotPasswordRequestImpl({required this.email});

  factory _$ForgotPasswordRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForgotPasswordRequestImplFromJson(json);

  @override
  final String email;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ForgotPasswordRequest(email: $email)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ForgotPasswordRequest'))
      ..add(DiagnosticsProperty('email', email));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForgotPasswordRequestImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of ForgotPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForgotPasswordRequestImplCopyWith<_$ForgotPasswordRequestImpl>
      get copyWith => __$$ForgotPasswordRequestImplCopyWithImpl<
          _$ForgotPasswordRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForgotPasswordRequestImplToJson(
      this,
    );
  }
}

abstract class _ForgotPasswordRequest implements ForgotPasswordRequest {
  const factory _ForgotPasswordRequest({required final String email}) =
      _$ForgotPasswordRequestImpl;

  factory _ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =
      _$ForgotPasswordRequestImpl.fromJson;

  @override
  String get email;

  /// Create a copy of ForgotPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForgotPasswordRequestImplCopyWith<_$ForgotPasswordRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

VerifyOtpRequest _$VerifyOtpRequestFromJson(Map<String, dynamic> json) {
  return _VerifyOtpRequest.fromJson(json);
}

/// @nodoc
mixin _$VerifyOtpRequest {
  String get email => throw _privateConstructorUsedError;
  String get otp => throw _privateConstructorUsedError;

  /// Serializes this VerifyOtpRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VerifyOtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VerifyOtpRequestCopyWith<VerifyOtpRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyOtpRequestCopyWith<$Res> {
  factory $VerifyOtpRequestCopyWith(
          VerifyOtpRequest value, $Res Function(VerifyOtpRequest) then) =
      _$VerifyOtpRequestCopyWithImpl<$Res, VerifyOtpRequest>;
  @useResult
  $Res call({String email, String otp});
}

/// @nodoc
class _$VerifyOtpRequestCopyWithImpl<$Res, $Val extends VerifyOtpRequest>
    implements $VerifyOtpRequestCopyWith<$Res> {
  _$VerifyOtpRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VerifyOtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? otp = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerifyOtpRequestImplCopyWith<$Res>
    implements $VerifyOtpRequestCopyWith<$Res> {
  factory _$$VerifyOtpRequestImplCopyWith(_$VerifyOtpRequestImpl value,
          $Res Function(_$VerifyOtpRequestImpl) then) =
      __$$VerifyOtpRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String otp});
}

/// @nodoc
class __$$VerifyOtpRequestImplCopyWithImpl<$Res>
    extends _$VerifyOtpRequestCopyWithImpl<$Res, _$VerifyOtpRequestImpl>
    implements _$$VerifyOtpRequestImplCopyWith<$Res> {
  __$$VerifyOtpRequestImplCopyWithImpl(_$VerifyOtpRequestImpl _value,
      $Res Function(_$VerifyOtpRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of VerifyOtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? otp = null,
  }) {
    return _then(_$VerifyOtpRequestImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerifyOtpRequestImpl
    with DiagnosticableTreeMixin
    implements _VerifyOtpRequest {
  const _$VerifyOtpRequestImpl({required this.email, required this.otp});

  factory _$VerifyOtpRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerifyOtpRequestImplFromJson(json);

  @override
  final String email;
  @override
  final String otp;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VerifyOtpRequest(email: $email, otp: $otp)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'VerifyOtpRequest'))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('otp', otp));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyOtpRequestImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.otp, otp) || other.otp == otp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, otp);

  /// Create a copy of VerifyOtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyOtpRequestImplCopyWith<_$VerifyOtpRequestImpl> get copyWith =>
      __$$VerifyOtpRequestImplCopyWithImpl<_$VerifyOtpRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifyOtpRequestImplToJson(
      this,
    );
  }
}

abstract class _VerifyOtpRequest implements VerifyOtpRequest {
  const factory _VerifyOtpRequest(
      {required final String email,
      required final String otp}) = _$VerifyOtpRequestImpl;

  factory _VerifyOtpRequest.fromJson(Map<String, dynamic> json) =
      _$VerifyOtpRequestImpl.fromJson;

  @override
  String get email;
  @override
  String get otp;

  /// Create a copy of VerifyOtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerifyOtpRequestImplCopyWith<_$VerifyOtpRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VerifyEmailRequest _$VerifyEmailRequestFromJson(Map<String, dynamic> json) {
  return _VerifyEmailRequest.fromJson(json);
}

/// @nodoc
mixin _$VerifyEmailRequest {
  String get otp => throw _privateConstructorUsedError;

  /// Serializes this VerifyEmailRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VerifyEmailRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VerifyEmailRequestCopyWith<VerifyEmailRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyEmailRequestCopyWith<$Res> {
  factory $VerifyEmailRequestCopyWith(
          VerifyEmailRequest value, $Res Function(VerifyEmailRequest) then) =
      _$VerifyEmailRequestCopyWithImpl<$Res, VerifyEmailRequest>;
  @useResult
  $Res call({String otp});
}

/// @nodoc
class _$VerifyEmailRequestCopyWithImpl<$Res, $Val extends VerifyEmailRequest>
    implements $VerifyEmailRequestCopyWith<$Res> {
  _$VerifyEmailRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VerifyEmailRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otp = null,
  }) {
    return _then(_value.copyWith(
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerifyEmailRequestImplCopyWith<$Res>
    implements $VerifyEmailRequestCopyWith<$Res> {
  factory _$$VerifyEmailRequestImplCopyWith(_$VerifyEmailRequestImpl value,
          $Res Function(_$VerifyEmailRequestImpl) then) =
      __$$VerifyEmailRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String otp});
}

/// @nodoc
class __$$VerifyEmailRequestImplCopyWithImpl<$Res>
    extends _$VerifyEmailRequestCopyWithImpl<$Res, _$VerifyEmailRequestImpl>
    implements _$$VerifyEmailRequestImplCopyWith<$Res> {
  __$$VerifyEmailRequestImplCopyWithImpl(_$VerifyEmailRequestImpl _value,
      $Res Function(_$VerifyEmailRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of VerifyEmailRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otp = null,
  }) {
    return _then(_$VerifyEmailRequestImpl(
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerifyEmailRequestImpl
    with DiagnosticableTreeMixin
    implements _VerifyEmailRequest {
  const _$VerifyEmailRequestImpl({required this.otp});

  factory _$VerifyEmailRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerifyEmailRequestImplFromJson(json);

  @override
  final String otp;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VerifyEmailRequest(otp: $otp)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'VerifyEmailRequest'))
      ..add(DiagnosticsProperty('otp', otp));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyEmailRequestImpl &&
            (identical(other.otp, otp) || other.otp == otp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, otp);

  /// Create a copy of VerifyEmailRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyEmailRequestImplCopyWith<_$VerifyEmailRequestImpl> get copyWith =>
      __$$VerifyEmailRequestImplCopyWithImpl<_$VerifyEmailRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifyEmailRequestImplToJson(
      this,
    );
  }
}

abstract class _VerifyEmailRequest implements VerifyEmailRequest {
  const factory _VerifyEmailRequest({required final String otp}) =
      _$VerifyEmailRequestImpl;

  factory _VerifyEmailRequest.fromJson(Map<String, dynamic> json) =
      _$VerifyEmailRequestImpl.fromJson;

  @override
  String get otp;

  /// Create a copy of VerifyEmailRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerifyEmailRequestImplCopyWith<_$VerifyEmailRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DeleteAccountRequest _$DeleteAccountRequestFromJson(Map<String, dynamic> json) {
  return _DeleteAccountRequest.fromJson(json);
}

/// @nodoc
mixin _$DeleteAccountRequest {
  String get pin => throw _privateConstructorUsedError;

  /// Serializes this DeleteAccountRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeleteAccountRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeleteAccountRequestCopyWith<DeleteAccountRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeleteAccountRequestCopyWith<$Res> {
  factory $DeleteAccountRequestCopyWith(DeleteAccountRequest value,
          $Res Function(DeleteAccountRequest) then) =
      _$DeleteAccountRequestCopyWithImpl<$Res, DeleteAccountRequest>;
  @useResult
  $Res call({String pin});
}

/// @nodoc
class _$DeleteAccountRequestCopyWithImpl<$Res,
        $Val extends DeleteAccountRequest>
    implements $DeleteAccountRequestCopyWith<$Res> {
  _$DeleteAccountRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeleteAccountRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pin = null,
  }) {
    return _then(_value.copyWith(
      pin: null == pin
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeleteAccountRequestImplCopyWith<$Res>
    implements $DeleteAccountRequestCopyWith<$Res> {
  factory _$$DeleteAccountRequestImplCopyWith(_$DeleteAccountRequestImpl value,
          $Res Function(_$DeleteAccountRequestImpl) then) =
      __$$DeleteAccountRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String pin});
}

/// @nodoc
class __$$DeleteAccountRequestImplCopyWithImpl<$Res>
    extends _$DeleteAccountRequestCopyWithImpl<$Res, _$DeleteAccountRequestImpl>
    implements _$$DeleteAccountRequestImplCopyWith<$Res> {
  __$$DeleteAccountRequestImplCopyWithImpl(_$DeleteAccountRequestImpl _value,
      $Res Function(_$DeleteAccountRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeleteAccountRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pin = null,
  }) {
    return _then(_$DeleteAccountRequestImpl(
      pin: null == pin
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeleteAccountRequestImpl
    with DiagnosticableTreeMixin
    implements _DeleteAccountRequest {
  const _$DeleteAccountRequestImpl({required this.pin});

  factory _$DeleteAccountRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeleteAccountRequestImplFromJson(json);

  @override
  final String pin;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DeleteAccountRequest(pin: $pin)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DeleteAccountRequest'))
      ..add(DiagnosticsProperty('pin', pin));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteAccountRequestImpl &&
            (identical(other.pin, pin) || other.pin == pin));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, pin);

  /// Create a copy of DeleteAccountRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteAccountRequestImplCopyWith<_$DeleteAccountRequestImpl>
      get copyWith =>
          __$$DeleteAccountRequestImplCopyWithImpl<_$DeleteAccountRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeleteAccountRequestImplToJson(
      this,
    );
  }
}

abstract class _DeleteAccountRequest implements DeleteAccountRequest {
  const factory _DeleteAccountRequest({required final String pin}) =
      _$DeleteAccountRequestImpl;

  factory _DeleteAccountRequest.fromJson(Map<String, dynamic> json) =
      _$DeleteAccountRequestImpl.fromJson;

  @override
  String get pin;

  /// Create a copy of DeleteAccountRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteAccountRequestImplCopyWith<_$DeleteAccountRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NewPasswordRequest _$NewPasswordRequestFromJson(Map<String, dynamic> json) {
  return _NewPasswordRequest.fromJson(json);
}

/// @nodoc
mixin _$NewPasswordRequest {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  @JsonKey(name: 'password_confirm')
  String get passwordConfirm => throw _privateConstructorUsedError;

  /// Serializes this NewPasswordRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NewPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NewPasswordRequestCopyWith<NewPasswordRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewPasswordRequestCopyWith<$Res> {
  factory $NewPasswordRequestCopyWith(
          NewPasswordRequest value, $Res Function(NewPasswordRequest) then) =
      _$NewPasswordRequestCopyWithImpl<$Res, NewPasswordRequest>;
  @useResult
  $Res call(
      {String email,
      String password,
      @JsonKey(name: 'password_confirm') String passwordConfirm});
}

/// @nodoc
class _$NewPasswordRequestCopyWithImpl<$Res, $Val extends NewPasswordRequest>
    implements $NewPasswordRequestCopyWith<$Res> {
  _$NewPasswordRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? passwordConfirm = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      passwordConfirm: null == passwordConfirm
          ? _value.passwordConfirm
          : passwordConfirm // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewPasswordRequestImplCopyWith<$Res>
    implements $NewPasswordRequestCopyWith<$Res> {
  factory _$$NewPasswordRequestImplCopyWith(_$NewPasswordRequestImpl value,
          $Res Function(_$NewPasswordRequestImpl) then) =
      __$$NewPasswordRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      String password,
      @JsonKey(name: 'password_confirm') String passwordConfirm});
}

/// @nodoc
class __$$NewPasswordRequestImplCopyWithImpl<$Res>
    extends _$NewPasswordRequestCopyWithImpl<$Res, _$NewPasswordRequestImpl>
    implements _$$NewPasswordRequestImplCopyWith<$Res> {
  __$$NewPasswordRequestImplCopyWithImpl(_$NewPasswordRequestImpl _value,
      $Res Function(_$NewPasswordRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of NewPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? passwordConfirm = null,
  }) {
    return _then(_$NewPasswordRequestImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      passwordConfirm: null == passwordConfirm
          ? _value.passwordConfirm
          : passwordConfirm // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NewPasswordRequestImpl
    with DiagnosticableTreeMixin
    implements _NewPasswordRequest {
  const _$NewPasswordRequestImpl(
      {required this.email,
      required this.password,
      @JsonKey(name: 'password_confirm') required this.passwordConfirm});

  factory _$NewPasswordRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewPasswordRequestImplFromJson(json);

  @override
  final String email;
  @override
  final String password;
  @override
  @JsonKey(name: 'password_confirm')
  final String passwordConfirm;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NewPasswordRequest(email: $email, password: $password, passwordConfirm: $passwordConfirm)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NewPasswordRequest'))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('password', password))
      ..add(DiagnosticsProperty('passwordConfirm', passwordConfirm));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewPasswordRequestImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.passwordConfirm, passwordConfirm) ||
                other.passwordConfirm == passwordConfirm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, email, password, passwordConfirm);

  /// Create a copy of NewPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewPasswordRequestImplCopyWith<_$NewPasswordRequestImpl> get copyWith =>
      __$$NewPasswordRequestImplCopyWithImpl<_$NewPasswordRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NewPasswordRequestImplToJson(
      this,
    );
  }
}

abstract class _NewPasswordRequest implements NewPasswordRequest {
  const factory _NewPasswordRequest(
      {required final String email,
      required final String password,
      @JsonKey(name: 'password_confirm')
      required final String passwordConfirm}) = _$NewPasswordRequestImpl;

  factory _NewPasswordRequest.fromJson(Map<String, dynamic> json) =
      _$NewPasswordRequestImpl.fromJson;

  @override
  String get email;
  @override
  String get password;
  @override
  @JsonKey(name: 'password_confirm')
  String get passwordConfirm;

  /// Create a copy of NewPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewPasswordRequestImplCopyWith<_$NewPasswordRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AddUsernameRequest _$AddUsernameRequestFromJson(Map<String, dynamic> json) {
  return _AddUsernameRequest.fromJson(json);
}

/// @nodoc
mixin _$AddUsernameRequest {
  String get username => throw _privateConstructorUsedError;

  /// Serializes this AddUsernameRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddUsernameRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddUsernameRequestCopyWith<AddUsernameRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddUsernameRequestCopyWith<$Res> {
  factory $AddUsernameRequestCopyWith(
          AddUsernameRequest value, $Res Function(AddUsernameRequest) then) =
      _$AddUsernameRequestCopyWithImpl<$Res, AddUsernameRequest>;
  @useResult
  $Res call({String username});
}

/// @nodoc
class _$AddUsernameRequestCopyWithImpl<$Res, $Val extends AddUsernameRequest>
    implements $AddUsernameRequestCopyWith<$Res> {
  _$AddUsernameRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddUsernameRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddUsernameRequestImplCopyWith<$Res>
    implements $AddUsernameRequestCopyWith<$Res> {
  factory _$$AddUsernameRequestImplCopyWith(_$AddUsernameRequestImpl value,
          $Res Function(_$AddUsernameRequestImpl) then) =
      __$$AddUsernameRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String username});
}

/// @nodoc
class __$$AddUsernameRequestImplCopyWithImpl<$Res>
    extends _$AddUsernameRequestCopyWithImpl<$Res, _$AddUsernameRequestImpl>
    implements _$$AddUsernameRequestImplCopyWith<$Res> {
  __$$AddUsernameRequestImplCopyWithImpl(_$AddUsernameRequestImpl _value,
      $Res Function(_$AddUsernameRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddUsernameRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
  }) {
    return _then(_$AddUsernameRequestImpl(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddUsernameRequestImpl
    with DiagnosticableTreeMixin
    implements _AddUsernameRequest {
  const _$AddUsernameRequestImpl({required this.username});

  factory _$AddUsernameRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddUsernameRequestImplFromJson(json);

  @override
  final String username;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AddUsernameRequest(username: $username)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AddUsernameRequest'))
      ..add(DiagnosticsProperty('username', username));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddUsernameRequestImpl &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, username);

  /// Create a copy of AddUsernameRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddUsernameRequestImplCopyWith<_$AddUsernameRequestImpl> get copyWith =>
      __$$AddUsernameRequestImplCopyWithImpl<_$AddUsernameRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddUsernameRequestImplToJson(
      this,
    );
  }
}

abstract class _AddUsernameRequest implements AddUsernameRequest {
  const factory _AddUsernameRequest({required final String username}) =
      _$AddUsernameRequestImpl;

  factory _AddUsernameRequest.fromJson(Map<String, dynamic> json) =
      _$AddUsernameRequestImpl.fromJson;

  @override
  String get username;

  /// Create a copy of AddUsernameRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddUsernameRequestImplCopyWith<_$AddUsernameRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CheckUsernameRequest _$CheckUsernameRequestFromJson(Map<String, dynamic> json) {
  return _CheckUsernameRequest.fromJson(json);
}

/// @nodoc
mixin _$CheckUsernameRequest {
  String get username => throw _privateConstructorUsedError;

  /// Serializes this CheckUsernameRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CheckUsernameRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CheckUsernameRequestCopyWith<CheckUsernameRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckUsernameRequestCopyWith<$Res> {
  factory $CheckUsernameRequestCopyWith(CheckUsernameRequest value,
          $Res Function(CheckUsernameRequest) then) =
      _$CheckUsernameRequestCopyWithImpl<$Res, CheckUsernameRequest>;
  @useResult
  $Res call({String username});
}

/// @nodoc
class _$CheckUsernameRequestCopyWithImpl<$Res,
        $Val extends CheckUsernameRequest>
    implements $CheckUsernameRequestCopyWith<$Res> {
  _$CheckUsernameRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CheckUsernameRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckUsernameRequestImplCopyWith<$Res>
    implements $CheckUsernameRequestCopyWith<$Res> {
  factory _$$CheckUsernameRequestImplCopyWith(_$CheckUsernameRequestImpl value,
          $Res Function(_$CheckUsernameRequestImpl) then) =
      __$$CheckUsernameRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String username});
}

/// @nodoc
class __$$CheckUsernameRequestImplCopyWithImpl<$Res>
    extends _$CheckUsernameRequestCopyWithImpl<$Res, _$CheckUsernameRequestImpl>
    implements _$$CheckUsernameRequestImplCopyWith<$Res> {
  __$$CheckUsernameRequestImplCopyWithImpl(_$CheckUsernameRequestImpl _value,
      $Res Function(_$CheckUsernameRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of CheckUsernameRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
  }) {
    return _then(_$CheckUsernameRequestImpl(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckUsernameRequestImpl
    with DiagnosticableTreeMixin
    implements _CheckUsernameRequest {
  const _$CheckUsernameRequestImpl({required this.username});

  factory _$CheckUsernameRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckUsernameRequestImplFromJson(json);

  @override
  final String username;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CheckUsernameRequest(username: $username)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CheckUsernameRequest'))
      ..add(DiagnosticsProperty('username', username));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckUsernameRequestImpl &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, username);

  /// Create a copy of CheckUsernameRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckUsernameRequestImplCopyWith<_$CheckUsernameRequestImpl>
      get copyWith =>
          __$$CheckUsernameRequestImplCopyWithImpl<_$CheckUsernameRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckUsernameRequestImplToJson(
      this,
    );
  }
}

abstract class _CheckUsernameRequest implements CheckUsernameRequest {
  const factory _CheckUsernameRequest({required final String username}) =
      _$CheckUsernameRequestImpl;

  factory _CheckUsernameRequest.fromJson(Map<String, dynamic> json) =
      _$CheckUsernameRequestImpl.fromJson;

  @override
  String get username;

  /// Create a copy of CheckUsernameRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckUsernameRequestImplCopyWith<_$CheckUsernameRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ChangePinRequest _$ChangePinRequestFromJson(Map<String, dynamic> json) {
  return _ChangePinRequest.fromJson(json);
}

/// @nodoc
mixin _$ChangePinRequest {
  @JsonKey(name: "oldPin")
  String get oldPin => throw _privateConstructorUsedError;
  @JsonKey(name: "newPin")
  String get newPin => throw _privateConstructorUsedError;

  /// Serializes this ChangePinRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChangePinRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChangePinRequestCopyWith<ChangePinRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangePinRequestCopyWith<$Res> {
  factory $ChangePinRequestCopyWith(
          ChangePinRequest value, $Res Function(ChangePinRequest) then) =
      _$ChangePinRequestCopyWithImpl<$Res, ChangePinRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: "oldPin") String oldPin,
      @JsonKey(name: "newPin") String newPin});
}

/// @nodoc
class _$ChangePinRequestCopyWithImpl<$Res, $Val extends ChangePinRequest>
    implements $ChangePinRequestCopyWith<$Res> {
  _$ChangePinRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChangePinRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldPin = null,
    Object? newPin = null,
  }) {
    return _then(_value.copyWith(
      oldPin: null == oldPin
          ? _value.oldPin
          : oldPin // ignore: cast_nullable_to_non_nullable
              as String,
      newPin: null == newPin
          ? _value.newPin
          : newPin // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChangePinRequestImplCopyWith<$Res>
    implements $ChangePinRequestCopyWith<$Res> {
  factory _$$ChangePinRequestImplCopyWith(_$ChangePinRequestImpl value,
          $Res Function(_$ChangePinRequestImpl) then) =
      __$$ChangePinRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "oldPin") String oldPin,
      @JsonKey(name: "newPin") String newPin});
}

/// @nodoc
class __$$ChangePinRequestImplCopyWithImpl<$Res>
    extends _$ChangePinRequestCopyWithImpl<$Res, _$ChangePinRequestImpl>
    implements _$$ChangePinRequestImplCopyWith<$Res> {
  __$$ChangePinRequestImplCopyWithImpl(_$ChangePinRequestImpl _value,
      $Res Function(_$ChangePinRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChangePinRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldPin = null,
    Object? newPin = null,
  }) {
    return _then(_$ChangePinRequestImpl(
      oldPin: null == oldPin
          ? _value.oldPin
          : oldPin // ignore: cast_nullable_to_non_nullable
              as String,
      newPin: null == newPin
          ? _value.newPin
          : newPin // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChangePinRequestImpl
    with DiagnosticableTreeMixin
    implements _ChangePinRequest {
  const _$ChangePinRequestImpl(
      {@JsonKey(name: "oldPin") required this.oldPin,
      @JsonKey(name: "newPin") required this.newPin});

  factory _$ChangePinRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChangePinRequestImplFromJson(json);

  @override
  @JsonKey(name: "oldPin")
  final String oldPin;
  @override
  @JsonKey(name: "newPin")
  final String newPin;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChangePinRequest(oldPin: $oldPin, newPin: $newPin)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChangePinRequest'))
      ..add(DiagnosticsProperty('oldPin', oldPin))
      ..add(DiagnosticsProperty('newPin', newPin));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangePinRequestImpl &&
            (identical(other.oldPin, oldPin) || other.oldPin == oldPin) &&
            (identical(other.newPin, newPin) || other.newPin == newPin));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, oldPin, newPin);

  /// Create a copy of ChangePinRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangePinRequestImplCopyWith<_$ChangePinRequestImpl> get copyWith =>
      __$$ChangePinRequestImplCopyWithImpl<_$ChangePinRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChangePinRequestImplToJson(
      this,
    );
  }
}

abstract class _ChangePinRequest implements ChangePinRequest {
  const factory _ChangePinRequest(
          {@JsonKey(name: "oldPin") required final String oldPin,
          @JsonKey(name: "newPin") required final String newPin}) =
      _$ChangePinRequestImpl;

  factory _ChangePinRequest.fromJson(Map<String, dynamic> json) =
      _$ChangePinRequestImpl.fromJson;

  @override
  @JsonKey(name: "oldPin")
  String get oldPin;
  @override
  @JsonKey(name: "newPin")
  String get newPin;

  /// Create a copy of ChangePinRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangePinRequestImplCopyWith<_$ChangePinRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ResetPinRequest _$ResetPinRequestFromJson(Map<String, dynamic> json) {
  return _ResetPinRequest.fromJson(json);
}

/// @nodoc
mixin _$ResetPinRequest {
  @JsonKey(name: "password")
  String get password => throw _privateConstructorUsedError;

  /// Serializes this ResetPinRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ResetPinRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResetPinRequestCopyWith<ResetPinRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResetPinRequestCopyWith<$Res> {
  factory $ResetPinRequestCopyWith(
          ResetPinRequest value, $Res Function(ResetPinRequest) then) =
      _$ResetPinRequestCopyWithImpl<$Res, ResetPinRequest>;
  @useResult
  $Res call({@JsonKey(name: "password") String password});
}

/// @nodoc
class _$ResetPinRequestCopyWithImpl<$Res, $Val extends ResetPinRequest>
    implements $ResetPinRequestCopyWith<$Res> {
  _$ResetPinRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResetPinRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResetPinRequestImplCopyWith<$Res>
    implements $ResetPinRequestCopyWith<$Res> {
  factory _$$ResetPinRequestImplCopyWith(_$ResetPinRequestImpl value,
          $Res Function(_$ResetPinRequestImpl) then) =
      __$$ResetPinRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: "password") String password});
}

/// @nodoc
class __$$ResetPinRequestImplCopyWithImpl<$Res>
    extends _$ResetPinRequestCopyWithImpl<$Res, _$ResetPinRequestImpl>
    implements _$$ResetPinRequestImplCopyWith<$Res> {
  __$$ResetPinRequestImplCopyWithImpl(
      _$ResetPinRequestImpl _value, $Res Function(_$ResetPinRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResetPinRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? password = null,
  }) {
    return _then(_$ResetPinRequestImpl(
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResetPinRequestImpl
    with DiagnosticableTreeMixin
    implements _ResetPinRequest {
  const _$ResetPinRequestImpl(
      {@JsonKey(name: "password") required this.password});

  factory _$ResetPinRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResetPinRequestImplFromJson(json);

  @override
  @JsonKey(name: "password")
  final String password;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ResetPinRequest(password: $password)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ResetPinRequest'))
      ..add(DiagnosticsProperty('password', password));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetPinRequestImpl &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, password);

  /// Create a copy of ResetPinRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResetPinRequestImplCopyWith<_$ResetPinRequestImpl> get copyWith =>
      __$$ResetPinRequestImplCopyWithImpl<_$ResetPinRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResetPinRequestImplToJson(
      this,
    );
  }
}

abstract class _ResetPinRequest implements ResetPinRequest {
  const factory _ResetPinRequest(
          {@JsonKey(name: "password") required final String password}) =
      _$ResetPinRequestImpl;

  factory _ResetPinRequest.fromJson(Map<String, dynamic> json) =
      _$ResetPinRequestImpl.fromJson;

  @override
  @JsonKey(name: "password")
  String get password;

  /// Create a copy of ResetPinRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResetPinRequestImplCopyWith<_$ResetPinRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreatePinRequest _$CreatePinRequestFromJson(Map<String, dynamic> json) {
  return _CreatePinRequest.fromJson(json);
}

/// @nodoc
mixin _$CreatePinRequest {
  @JsonKey(name: "pin")
  String get pin => throw _privateConstructorUsedError;
  @JsonKey(name: "pin_confirmation")
  String get pinConfirmation => throw _privateConstructorUsedError;

  /// Serializes this CreatePinRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreatePinRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreatePinRequestCopyWith<CreatePinRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePinRequestCopyWith<$Res> {
  factory $CreatePinRequestCopyWith(
          CreatePinRequest value, $Res Function(CreatePinRequest) then) =
      _$CreatePinRequestCopyWithImpl<$Res, CreatePinRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: "pin") String pin,
      @JsonKey(name: "pin_confirmation") String pinConfirmation});
}

/// @nodoc
class _$CreatePinRequestCopyWithImpl<$Res, $Val extends CreatePinRequest>
    implements $CreatePinRequestCopyWith<$Res> {
  _$CreatePinRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreatePinRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pin = null,
    Object? pinConfirmation = null,
  }) {
    return _then(_value.copyWith(
      pin: null == pin
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String,
      pinConfirmation: null == pinConfirmation
          ? _value.pinConfirmation
          : pinConfirmation // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreatePinRequestImplCopyWith<$Res>
    implements $CreatePinRequestCopyWith<$Res> {
  factory _$$CreatePinRequestImplCopyWith(_$CreatePinRequestImpl value,
          $Res Function(_$CreatePinRequestImpl) then) =
      __$$CreatePinRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "pin") String pin,
      @JsonKey(name: "pin_confirmation") String pinConfirmation});
}

/// @nodoc
class __$$CreatePinRequestImplCopyWithImpl<$Res>
    extends _$CreatePinRequestCopyWithImpl<$Res, _$CreatePinRequestImpl>
    implements _$$CreatePinRequestImplCopyWith<$Res> {
  __$$CreatePinRequestImplCopyWithImpl(_$CreatePinRequestImpl _value,
      $Res Function(_$CreatePinRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreatePinRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pin = null,
    Object? pinConfirmation = null,
  }) {
    return _then(_$CreatePinRequestImpl(
      pin: null == pin
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String,
      pinConfirmation: null == pinConfirmation
          ? _value.pinConfirmation
          : pinConfirmation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreatePinRequestImpl
    with DiagnosticableTreeMixin
    implements _CreatePinRequest {
  const _$CreatePinRequestImpl(
      {@JsonKey(name: "pin") required this.pin,
      @JsonKey(name: "pin_confirmation") required this.pinConfirmation});

  factory _$CreatePinRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreatePinRequestImplFromJson(json);

  @override
  @JsonKey(name: "pin")
  final String pin;
  @override
  @JsonKey(name: "pin_confirmation")
  final String pinConfirmation;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreatePinRequest(pin: $pin, pinConfirmation: $pinConfirmation)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreatePinRequest'))
      ..add(DiagnosticsProperty('pin', pin))
      ..add(DiagnosticsProperty('pinConfirmation', pinConfirmation));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePinRequestImpl &&
            (identical(other.pin, pin) || other.pin == pin) &&
            (identical(other.pinConfirmation, pinConfirmation) ||
                other.pinConfirmation == pinConfirmation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, pin, pinConfirmation);

  /// Create a copy of CreatePinRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatePinRequestImplCopyWith<_$CreatePinRequestImpl> get copyWith =>
      __$$CreatePinRequestImplCopyWithImpl<_$CreatePinRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatePinRequestImplToJson(
      this,
    );
  }
}

abstract class _CreatePinRequest implements CreatePinRequest {
  const factory _CreatePinRequest(
      {@JsonKey(name: "pin") required final String pin,
      @JsonKey(name: "pin_confirmation")
      required final String pinConfirmation}) = _$CreatePinRequestImpl;

  factory _CreatePinRequest.fromJson(Map<String, dynamic> json) =
      _$CreatePinRequestImpl.fromJson;

  @override
  @JsonKey(name: "pin")
  String get pin;
  @override
  @JsonKey(name: "pin_confirmation")
  String get pinConfirmation;

  /// Create a copy of CreatePinRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatePinRequestImplCopyWith<_$CreatePinRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VerifyPinRequest _$VerifyPinRequestFromJson(Map<String, dynamic> json) {
  return _VerifyPinRequest.fromJson(json);
}

/// @nodoc
mixin _$VerifyPinRequest {
  @JsonKey(name: "pin")
  String get pin => throw _privateConstructorUsedError;

  /// Serializes this VerifyPinRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VerifyPinRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VerifyPinRequestCopyWith<VerifyPinRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyPinRequestCopyWith<$Res> {
  factory $VerifyPinRequestCopyWith(
          VerifyPinRequest value, $Res Function(VerifyPinRequest) then) =
      _$VerifyPinRequestCopyWithImpl<$Res, VerifyPinRequest>;
  @useResult
  $Res call({@JsonKey(name: "pin") String pin});
}

/// @nodoc
class _$VerifyPinRequestCopyWithImpl<$Res, $Val extends VerifyPinRequest>
    implements $VerifyPinRequestCopyWith<$Res> {
  _$VerifyPinRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VerifyPinRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pin = null,
  }) {
    return _then(_value.copyWith(
      pin: null == pin
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerifyPinRequestImplCopyWith<$Res>
    implements $VerifyPinRequestCopyWith<$Res> {
  factory _$$VerifyPinRequestImplCopyWith(_$VerifyPinRequestImpl value,
          $Res Function(_$VerifyPinRequestImpl) then) =
      __$$VerifyPinRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: "pin") String pin});
}

/// @nodoc
class __$$VerifyPinRequestImplCopyWithImpl<$Res>
    extends _$VerifyPinRequestCopyWithImpl<$Res, _$VerifyPinRequestImpl>
    implements _$$VerifyPinRequestImplCopyWith<$Res> {
  __$$VerifyPinRequestImplCopyWithImpl(_$VerifyPinRequestImpl _value,
      $Res Function(_$VerifyPinRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of VerifyPinRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pin = null,
  }) {
    return _then(_$VerifyPinRequestImpl(
      pin: null == pin
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerifyPinRequestImpl
    with DiagnosticableTreeMixin
    implements _VerifyPinRequest {
  const _$VerifyPinRequestImpl({@JsonKey(name: "pin") required this.pin});

  factory _$VerifyPinRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerifyPinRequestImplFromJson(json);

  @override
  @JsonKey(name: "pin")
  final String pin;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VerifyPinRequest(pin: $pin)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'VerifyPinRequest'))
      ..add(DiagnosticsProperty('pin', pin));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyPinRequestImpl &&
            (identical(other.pin, pin) || other.pin == pin));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, pin);

  /// Create a copy of VerifyPinRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyPinRequestImplCopyWith<_$VerifyPinRequestImpl> get copyWith =>
      __$$VerifyPinRequestImplCopyWithImpl<_$VerifyPinRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifyPinRequestImplToJson(
      this,
    );
  }
}

abstract class _VerifyPinRequest implements VerifyPinRequest {
  const factory _VerifyPinRequest(
          {@JsonKey(name: "pin") required final String pin}) =
      _$VerifyPinRequestImpl;

  factory _VerifyPinRequest.fromJson(Map<String, dynamic> json) =
      _$VerifyPinRequestImpl.fromJson;

  @override
  @JsonKey(name: "pin")
  String get pin;

  /// Create a copy of VerifyPinRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerifyPinRequestImplCopyWith<_$VerifyPinRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChangePasswordRequest _$ChangePasswordRequestFromJson(
    Map<String, dynamic> json) {
  return _ChangePasswordRequest.fromJson(json);
}

/// @nodoc
mixin _$ChangePasswordRequest {
  @JsonKey(name: "oldPassword")
  String get oldPassword => throw _privateConstructorUsedError;
  @JsonKey(name: "newPassword")
  String get newPassword => throw _privateConstructorUsedError;

  /// Serializes this ChangePasswordRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChangePasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChangePasswordRequestCopyWith<ChangePasswordRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangePasswordRequestCopyWith<$Res> {
  factory $ChangePasswordRequestCopyWith(ChangePasswordRequest value,
          $Res Function(ChangePasswordRequest) then) =
      _$ChangePasswordRequestCopyWithImpl<$Res, ChangePasswordRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: "oldPassword") String oldPassword,
      @JsonKey(name: "newPassword") String newPassword});
}

/// @nodoc
class _$ChangePasswordRequestCopyWithImpl<$Res,
        $Val extends ChangePasswordRequest>
    implements $ChangePasswordRequestCopyWith<$Res> {
  _$ChangePasswordRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChangePasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldPassword = null,
    Object? newPassword = null,
  }) {
    return _then(_value.copyWith(
      oldPassword: null == oldPassword
          ? _value.oldPassword
          : oldPassword // ignore: cast_nullable_to_non_nullable
              as String,
      newPassword: null == newPassword
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChangePasswordRequestImplCopyWith<$Res>
    implements $ChangePasswordRequestCopyWith<$Res> {
  factory _$$ChangePasswordRequestImplCopyWith(
          _$ChangePasswordRequestImpl value,
          $Res Function(_$ChangePasswordRequestImpl) then) =
      __$$ChangePasswordRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "oldPassword") String oldPassword,
      @JsonKey(name: "newPassword") String newPassword});
}

/// @nodoc
class __$$ChangePasswordRequestImplCopyWithImpl<$Res>
    extends _$ChangePasswordRequestCopyWithImpl<$Res,
        _$ChangePasswordRequestImpl>
    implements _$$ChangePasswordRequestImplCopyWith<$Res> {
  __$$ChangePasswordRequestImplCopyWithImpl(_$ChangePasswordRequestImpl _value,
      $Res Function(_$ChangePasswordRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChangePasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldPassword = null,
    Object? newPassword = null,
  }) {
    return _then(_$ChangePasswordRequestImpl(
      oldPassword: null == oldPassword
          ? _value.oldPassword
          : oldPassword // ignore: cast_nullable_to_non_nullable
              as String,
      newPassword: null == newPassword
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChangePasswordRequestImpl
    with DiagnosticableTreeMixin
    implements _ChangePasswordRequest {
  const _$ChangePasswordRequestImpl(
      {@JsonKey(name: "oldPassword") required this.oldPassword,
      @JsonKey(name: "newPassword") required this.newPassword});

  factory _$ChangePasswordRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChangePasswordRequestImplFromJson(json);

  @override
  @JsonKey(name: "oldPassword")
  final String oldPassword;
  @override
  @JsonKey(name: "newPassword")
  final String newPassword;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChangePasswordRequest(oldPassword: $oldPassword, newPassword: $newPassword)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChangePasswordRequest'))
      ..add(DiagnosticsProperty('oldPassword', oldPassword))
      ..add(DiagnosticsProperty('newPassword', newPassword));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangePasswordRequestImpl &&
            (identical(other.oldPassword, oldPassword) ||
                other.oldPassword == oldPassword) &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, oldPassword, newPassword);

  /// Create a copy of ChangePasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangePasswordRequestImplCopyWith<_$ChangePasswordRequestImpl>
      get copyWith => __$$ChangePasswordRequestImplCopyWithImpl<
          _$ChangePasswordRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChangePasswordRequestImplToJson(
      this,
    );
  }
}

abstract class _ChangePasswordRequest implements ChangePasswordRequest {
  const factory _ChangePasswordRequest(
          {@JsonKey(name: "oldPassword") required final String oldPassword,
          @JsonKey(name: "newPassword") required final String newPassword}) =
      _$ChangePasswordRequestImpl;

  factory _ChangePasswordRequest.fromJson(Map<String, dynamic> json) =
      _$ChangePasswordRequestImpl.fromJson;

  @override
  @JsonKey(name: "oldPassword")
  String get oldPassword;
  @override
  @JsonKey(name: "newPassword")
  String get newPassword;

  /// Create a copy of ChangePasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangePasswordRequestImplCopyWith<_$ChangePasswordRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
