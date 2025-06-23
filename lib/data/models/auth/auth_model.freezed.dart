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
  $Res call({String email, String password});
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
  $Res call({String email, String password});
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginRequestImpl with DiagnosticableTreeMixin implements _LoginRequest {
  const _$LoginRequestImpl({required this.email, required this.password});

  factory _$LoginRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginRequestImplFromJson(json);

  @override
  final String email;
  @override
  final String password;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LoginRequest(email: $email, password: $password)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LoginRequest'))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('password', password));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginRequestImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, password);

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
      required final String password}) = _$LoginRequestImpl;

  factory _LoginRequest.fromJson(Map<String, dynamic> json) =
      _$LoginRequestImpl.fromJson;

  @override
  String get email;
  @override
  String get password;

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

NewPasswordRequest _$NewPasswordRequestFromJson(Map<String, dynamic> json) {
  return _NewPasswordRequest.fromJson(json);
}

/// @nodoc
mixin _$NewPasswordRequest {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  @JsonKey(name: 'password_confirm')
  String get passwordConfirm => throw _privateConstructorUsedError;
  String get otp => throw _privateConstructorUsedError;

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
      @JsonKey(name: 'password_confirm') String passwordConfirm,
      String otp});
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
    Object? otp = null,
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
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
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
      @JsonKey(name: 'password_confirm') String passwordConfirm,
      String otp});
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
    Object? otp = null,
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
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
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
      @JsonKey(name: 'password_confirm') required this.passwordConfirm,
      required this.otp});

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
  final String otp;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NewPasswordRequest(email: $email, password: $password, passwordConfirm: $passwordConfirm, otp: $otp)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NewPasswordRequest'))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('password', password))
      ..add(DiagnosticsProperty('passwordConfirm', passwordConfirm))
      ..add(DiagnosticsProperty('otp', otp));
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
                other.passwordConfirm == passwordConfirm) &&
            (identical(other.otp, otp) || other.otp == otp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, email, password, passwordConfirm, otp);

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
      @JsonKey(name: 'password_confirm') required final String passwordConfirm,
      required final String otp}) = _$NewPasswordRequestImpl;

  factory _NewPasswordRequest.fromJson(Map<String, dynamic> json) =
      _$NewPasswordRequestImpl.fromJson;

  @override
  String get email;
  @override
  String get password;
  @override
  @JsonKey(name: 'password_confirm')
  String get passwordConfirm;
  @override
  String get otp;

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
