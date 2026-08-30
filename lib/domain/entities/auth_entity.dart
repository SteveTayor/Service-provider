import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_entity.freezed.dart';

@freezed
abstract class AuthEntity with _$AuthEntity {
  const factory AuthEntity({
    required String email,
    required String phone,
    required String firstName,
    required String lastName,
    String? token,
    @Default(false) bool isAuthenticated,
  }) = _AuthEntity;

  const AuthEntity._();

  String get fullName => '$firstName $lastName';
}
