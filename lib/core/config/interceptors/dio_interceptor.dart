import 'dart:async';
import 'dart:convert';

import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/env.dart';
import 'package:bundlegram/presentation/app.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bundlegram/data/datasources/remote/endpoints.dart';
import 'package:go_router/go_router.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

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
        final userToken = await secureStorage.getAuthToken();
        if (userToken != null && userToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $userToken';
        }

        options.headers['AccessToken'] = localSterilizer;
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
        // FIX: was ungated `print()` — dumping request/response data
        // (including auth headers and any sensitive payload) to the
        // system log in release builds too, not just during development.
        if (kDebugMode) {
          debugPrint('[DIO ERROR]');
          debugPrint('URI: ${error.requestOptions.uri}');
          debugPrint('Error: ${error.message}');
          debugPrint('Response: ${error.response?.data}');
        }

        final resData = error.response?.data;
        final context = navigatorKey.currentContext;

        if (error.response?.statusCode == 401 &&
            (resData is Map &&
                (resData['status']?.toString().toLowerCase() == 'logout' ||
                    resData['message']?.toString().toLowerCase().contains(
                          'expired',
                        ) ==
                        true))) {
          await secureStorage.deleteAuthToken();

          if (context != null) {
            // FIX: restored the "already on this route" guard
            final currentRoute = ModalRoute.of(context)?.settings.name ?? '';

            if (!currentRoute.contains(RouteConstants.lockScreen)) {
              unawaited(
                Future.microtask(() {
                  // FIX: session expiry is not a success.
                  context.showErrorSnackBar(
                    'Session expired. Please log in again.',
                  );
                  context.go(RouteConstants.lockScreen);
                }),
              );
            }
          }
        }

        // Handle banned accounts
        if (error.response?.statusCode == 403 ||
            (resData is Map &&
                (resData['status']?.toString().toLowerCase() == 'banned' ||
                    resData['message']?.toString().toLowerCase().contains(
                          'banned',
                        ) ==
                        true ||
                    resData['message']?.toString().toLowerCase().contains(
                          'suspended',
                        ) ==
                        true))) {
          await secureStorage.deleteAuthToken();

          if (context != null) {
            final currentRoute = ModalRoute.of(context)?.settings.name ?? '';

            if (!currentRoute.contains(RouteConstants.login)) {
              unawaited(
                Future.microtask(() {
                  // FIX: being banned/suspended is not a success either.
                  context.showErrorSnackBar(
                    'Your account has been banned. Contact support.',
                  );
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

  // FIX: LogInterceptor logs full request/response bodies
  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  return dio;
});
