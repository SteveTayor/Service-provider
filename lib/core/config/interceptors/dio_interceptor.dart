import 'dart:async';
import 'dart:convert';

import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/env.dart';
import 'package:bundlegram/presentation/app.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bundlegram/data/datasources/remote/endpoints.dart';
import 'package:go_router/go_router.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final dioProvider = Provider<Dio>((ref) {
  final secureStorage = ref.read(secureStorageHelperProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: Endpoints.baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

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
            (resData is Map &&
                (resData['status']?.toString().toLowerCase() == 'logout' ||
                    resData['message']
                            ?.toString()
                            .toLowerCase()
                            .contains('expired') ==
                        true))) {
          // Clear local storage
          await secureStorage.deleteAuthToken();

          final context = navigatorKey.currentContext;
          if (context != null) {
            final currentRoute = ModalRoute.of(context)?.settings.name ?? '';

            if (!currentRoute.contains(RouteConstants.lockScreen)) {
              //Clear token
              await secureStorage.deleteAuthToken();
              // Show snackbar
              context.showCustomSnackBar(
                'Session expired. Please log in again.',
              );

              // Navigate to lockscreen
              unawaited(Future.microtask(() {
                context.go(RouteConstants.lockScreen);
              }));
            }
          }
        }

        // Handle banned accounts
        if (error.response?.statusCode == 403 ||
            (resData is Map &&
                (resData['status']?.toString().toLowerCase() == 'banned' ||
                    resData['message']
                            ?.toString()
                            .toLowerCase()
                            .contains('banned') ==
                        true ||
                    resData['message']
                            ?.toString()
                            .toLowerCase()
                            .contains('suspended') ==
                        true))) {
          await secureStorage.deleteAuthToken();

          final context = navigatorKey.currentContext;
          if (context != null) {
            final currentRoute = ModalRoute.of(context)?.settings.name ?? '';

            if (!currentRoute.contains(RouteConstants.login)) {
              context.showCustomSnackBar(
                'Your account has been banned. Contact support.',
              );
              unawaited(
                Future.microtask(() {
                  context.go(RouteConstants.login);
                }),
              );
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
