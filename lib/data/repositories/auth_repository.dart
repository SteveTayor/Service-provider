import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:bundlegram/domain/entities/user_entity.dart';
import 'package:bundlegram/domain/repositories/i_auth_repository.dart';
import 'package:bundlegram/data/datasources/remote/api_client.dart';
import 'package:bundlegram/data/models/auth/auth_model.dart';

part 'auth_repository.g.dart';

class AuthRepository implements IAuthRepository {

  AuthRepository(this._dio);
  final ApiClient _dio;

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      final response = await _dio.get<UserEntity>('/auth/me');
      if (response.data != null) {
        return UserEntity.fromJson(response.data!.toJson());
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    await _dio.post('/auth/reset-password', data: {'email': email});
  }

  @override
  Future<UserEntity> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post<UserEntity>(
      '/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );
    return UserEntity.fromJson(response.data!.toJson());
  }

  @override
  Future<void> signOut() async {
    await _dio.post('/auth/logout');
  }

  @override
  Future<UserEntity> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final response = await _dio.post<UserEntity>(
      '/auth/register',
      data: {
        'email': email,
        'password': password,
        'name': name,
      },
    );
    return UserEntity.fromJson(response.data!.toJson());
  }

  Future<AuthResponse> register(RegisterRequest request) async {
    try {
      final response = await _dio.post<AuthResponse>('/register', data: request.toJson());
      return AuthResponse.fromJson(response.data!.toJson());
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<AuthResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post<AuthResponse>('/login', data: request.toJson());
      return AuthResponse.fromJson(response.data!.toJson());
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<AuthResponse> forgotPassword(ForgotPasswordRequest request) async {
    try {
      final response = await _dio.post<AuthResponse>('/forget-password', data: request.toJson());
      return AuthResponse.fromJson(response.data!.toJson());
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<AuthResponse> verifyOtp(VerifyOtpRequest request) async {
    try {
      final response = await _dio.post<AuthResponse>('/verify-otp', data: request.toJson());
      return AuthResponse.fromJson(response.data!.toJson());
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<AuthResponse> setNewPassword(NewPasswordRequest request) async {
    try {
      final response = await _dio.post<AuthResponse>('/new-password', data: request.toJson());
      return AuthResponse.fromJson(response.data!.toJson());
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.response?.data != null) {
      final errorResponse = AuthResponse.fromJson(
      {},);
      return Exception(errorResponse.message ?? 'An error occurred');
    }
    return Exception('Network error occurred');
  }

}

@riverpod
AuthRepository authRepository(Ref ref) {
  final dio = ref.watch(apiClientProvider);
  return AuthRepository(dio);
}

// Override the interface provider with our implementation
@Riverpod(keepAlive: true)
IAuthRepository authRepository2(Ref ref) {
  return ref.watch(authRepositoryProvider);
} 