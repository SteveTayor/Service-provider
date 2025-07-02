import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:bundlegram/core/error/failures.dart';

Future<Either<Failure, T>> handleApi<T>(Future<T> Function() call) async {
  try {
    final result = await call();

    log('[API SUCCESS] Response: $result', name: 'handleApi');
    return Right(result);
  } on DioException catch (e) {
    log('[API ERROR] DioException: ${e.message}', name: 'handleApi');
    log('Request Path: ${e.requestOptions.path}', name: 'handleApi');
    log('Request Data: ${e.requestOptions.data}', name: 'handleApi');
    log('Response Data: ${e.response?.data}', name: 'handleApi');
    log('Status Code: ${e.response?.statusCode}', name: 'handleApi');

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return const Left(NetworkFailure(['Connection timed out']));
    }

    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final data = e.response!.data;

      String message = 'Unknown error';
      final errors = <String>[];

      if (data is Map<String, dynamic>) {
        message = data['message']?.toString() ?? message;

        final validationErrors = data['data'];
        if (validationErrors is Map<String, dynamic>) {
          for (final entry in validationErrors.entries) {
            final val = entry.value;
            if (val is List) {
              errors.addAll(val.map((e) => e.toString()));
            } else if (val != null) {
              errors.add(val.toString());
            }
          }
        } else if (validationErrors is String) {
          errors.add(validationErrors);
        }
      } else if (data is String) {
        message = data;
      }

      switch (statusCode) {
        case 400:
          return Left(
              ValidationFailure(errors.isNotEmpty ? errors : [message]));
        case 401:
          return Left(
              AuthenticationFailure(errors.isNotEmpty ? errors : [message]));
        case 403:
          return const Left(AuthorizationFailure());
        case 404:
          return Left(NotFoundFailure([message]));
        case 500:
        default:
          return Left(ServerFailure([message]));
      }
    }

    return const Left(UnknownFailure(['An unexpected error occurred']));
  } catch (e, stack) {
    log('[API ERROR] Unknown Exception: $e',
        name: 'handleApi', stackTrace: stack);
    return const Left(UnknownFailure(['Unexpected error']));
  }
}
