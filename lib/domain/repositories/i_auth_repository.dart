import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:bundlegram/domain/entities/user_entity.dart';

part 'i_auth_repository.g.dart';

abstract class IAuthRepository {
  Future<UserEntity> signIn({
    required String email,
    required String password,
  });

  Future<UserEntity> signUp({
    required String email,
    required String password,
    required String name,
  });

  Future<void> signOut();

  Future<void> resetPassword(String email);

  Future<UserEntity?> getCurrentUser();
}

@riverpod
IAuthRepository authRepository(Ref ref) {
  throw UnimplementedError('AuthRepository provider not implemented');
} 