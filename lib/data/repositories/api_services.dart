import 'dart:developer';
import 'package:bundlegram/core/config/interceptors/dio_interceptor.dart';
import 'package:bundlegram/core/config/interceptors/helper.dart';
import 'package:bundlegram/core/error/failures.dart';
import 'package:bundlegram/data/datasources/remote/endpoints.dart';
import 'package:bundlegram/data/models/auth/auth_model.dart';
import 'package:bundlegram/data/models/auth/login/login_response.dart';
import 'package:bundlegram/data/models/auth/registeration/registeration_response.dart';
import 'package:bundlegram/data/models/auth/registeration/username/username_response.dart';
import 'package:bundlegram/data/models/auth/wallet/get_wallet_response.dart';
import 'package:bundlegram/data/models/profile/profile_response.dart';
import 'package:bundlegram/domain/api_definitions/api_definition.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiServiceProvider = Provider<ApiService>(
  (ref) {
    var apiDefinition = ApiDefinition(ref.read(dioProvider));
    return ApiService(apiDefinition);
  },
);

class ApiService {
  final ApiDefinition _api;
  const ApiService(this._api);

  Future<Either<Failure, RegisterResponse>> register(RegisterRequest req) {
    return handleApi(() => _api.register(req));
  }

  Future<Either<Failure, LoginResponse>> login(LoginRequest req) {
    return handleApi(() => _api.login(req));
  }

  Future<Either<Failure, void>> logout(String token) {
    return handleApi(() => _api.logout('Bearer $token'));
  }

  Future<Either<Failure, UsernameResponse>> checkUsername(String username) {
    return handleApi(() {
      final req = CheckUsernameRequest(username: username);
      return _api.checkUsername(req);
    });
  }

  Future<Either<Failure, UsernameResponse>> addUsername(
      String token, String username) {
    return handleApi(() {
      final req = AddUsernameRequest(username: username);
      return _api.addUsername('Bearer $token', req);
    });
  }

  Future<Either<Failure, ProfileResponse>> getProfile(String token) {
    return handleApi(() => _api.getProfile('Bearer $token'));
  }

  Future<Either<Failure, GetWalletResponse>> getWallet(String token) {
    return handleApi(() => _api.getWallet('Bearer $token'));
  }

  // … repeat for every endpoint …
}
