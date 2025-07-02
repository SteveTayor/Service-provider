import 'dart:convert';

import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/env.dart';
import 'package:bundlegram/presentation/app.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bundlegram/data/datasources/remote/endpoints.dart';
import 'package:go_router/go_router.dart';
import "package:pretty_dio_logger/pretty_dio_logger.dart";

final dioProvider = Provider<Dio>((ref) {
  final secureStorage = ref.read(secureStorageHelperProvider);
  final dio = Dio(BaseOptions(
    baseUrl: Endpoints.baseUrl,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // static AccessToken from env
        options.headers['AccessToken'] = localSterilizer;

        // Authorization token if user is authenticated
        final userToken = await secureStorage.getAuthToken();
        if (userToken != null && userToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $userToken';
        }

        return handler.next(options);
      },
      onResponse: (response, handler) {
        if (response.data is String) {
          try {
            response.data = jsonDecode(response.data as String);
          } catch (_) {}
        }
        return handler.next(response);
      },
      onError: (error, handler) async {
        print('[DIO ERROR]');
        print('URI: ${error.requestOptions.uri}');
        print('Error: ${error.message}');
        print('Response: ${error.response?.data}');

        final resData = error.response?.data;
        if (error.response?.statusCode == 401 &&
            resData is Map &&
            resData['status'] == 'logout') {
          // Clear local storage
          await secureStorage.deleteAuthToken();

          final context = navigatorKey.currentContext;
          if (context != null) {
            final currentPath = GoRouterState.of(context).uri.toString();

            if (!currentPath.contains(RouteConstants.login)) {
              //Clear token
              await secureStorage.deleteAuthToken();
              // Show snackbar
              context.showCustomSnackBar(
                  ("Session expired. Please log in again."));

              // Navigate to login
              context.go(RouteConstants.login);
            }
          }
        }

        handler.next(error);
      },
    ),
  );

  dio.interceptors.add(
    LogInterceptor(
      request: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ),
  );

  dio.interceptors.add(
    PrettyDioLogger(requestBody: true),
  );

  return dio;
});
