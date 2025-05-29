import 'package:bundlegram/domain/entities/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:bundlegram/domain/entities/auth_entity.dart';
import 'package:bundlegram/domain/repositories/i_auth_repository.dart';

part 'auth_usecase.g.dart';

class AuthUseCase {

  AuthUseCase(this._repository);
  final IAuthRepository _repository;

  Future<UserEntity> register({
    required String email,
    required String phone,
    required String firstName,
    required String lastName,
    required String password,
    required String passwordConfirm,
  }) async {
    try {
      final response = await _repository.signUp(
        email: email,
        password: password,
        name: '$firstName $lastName',
      );
      
      return UserEntity(
        email: response.email, name: '', id: '',
      
      );
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _repository.signIn(
        email: email,
        password: password,
      );
      
      return UserEntity(
        email: response.email, name: '', id: '',
      
      );
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _repository.resetPassword(email);
    } catch (e) {
      throw Exception('Failed to send reset password email: $e');
    }
  }

  Future<void> logout() async {
    try {
      await _repository.signOut();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  Future<UserEntity?> getCurrentUser() async {
    try {
      final user = await _repository.getCurrentUser();
      if (user == null) return null;

      return UserEntity(
        email: user.email, name: '', id: '',
      
      );
    } catch (e) {
      return null;
    }
  }
}

@riverpod
AuthUseCase authUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthUseCase(repository);
} 