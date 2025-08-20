import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:bundlegram/core/error/failures.dart';

// Future<Either<Failure, T>> handleApi<T>(Future<T> Function() call) async {
//   try {
//     final result = await call();

//     log('[API SUCCESS] Response: $result', name: 'handleApi');
//     return Right(result);
//   } on DioException catch (e) {
//     log('[API ERROR] DioException: ${e.message}', name: 'handleApi');
//     log('Request Path: ${e.requestOptions.path}', name: 'handleApi');
//     log('Request Data: ${e.requestOptions.data}', name: 'handleApi');
//     log('Response Data: ${e.response?.data}', name: 'handleApi');
//     log('Status Code: ${e.response?.statusCode}', name: 'handleApi');

//     if (e.type == DioExceptionType.connectionTimeout ||
//         e.type == DioExceptionType.receiveTimeout ||
//         e.type == DioExceptionType.sendTimeout) {
//       return const Left(NetworkFailure(['Connection timed out']));
//     }

//     if (e.response != null) {
//       final statusCode = e.response!.statusCode;
//       final data = e.response!.data;

//       String message = 'Unknown error';
//       final errors = <String>[];

//       if (data is Map<String, dynamic>) {
//         message = data['message']?.toString() ?? message;

//         final validationErrors = data['data'];
//         if (validationErrors is Map<String, dynamic>) {
//           for (final entry in validationErrors.entries) {
//             final val = entry.value;
//             if (val is List) {
//               errors.addAll(val.map((e) => e.toString()));
//             } else if (val != null) {
//               errors.add(val.toString());
//             }
//           }
//         } else if (validationErrors is String) {
//           errors.add(validationErrors);
//         }
//       } else if (data is String) {
//         message = data;
//       }

//       switch (statusCode) {
//         case 400:
//           return Left(
//               ValidationFailure(errors.isNotEmpty ? errors : [message]));
//         case 401:
//           return Left(
//               AuthenticationFailure(errors.isNotEmpty ? errors : [message]));
//         case 403:
//           return const Left(AuthorizationFailure());
//         case 404:
//           return Left(NotFoundFailure([message]));
//         case 500:
//         default:
//           return Left(ServerFailure([message]));
//       }
//     }

//     return const Left(UnknownFailure(['An unexpected error occurred']));
//   } catch (e, stack) {
//     log('[API ERROR] Unknown Exception: $e',
//         name: 'handleApi', stackTrace: stack);

//     log('[API ERROR] $e\n$stack');
//     return Left(UnknownFailure([e.toString()]));
//   }
// }
Future<Either<Failure, T>> handleApi<T>(Future<T> Function() call) async {
  try {
    final result = await call();

    log('[API SUCCESS] Response: $result', name: 'handleApi');
    return Right(result);
  } on DioException catch (e) {
    log('[API ERROR] DioException: ${e.message}', name: 'handleApi');
    log('Request Path: ${e.requestOptions.path}', name: 'handleApi');
    log('Status Code: ${e.response?.statusCode}', name: 'handleApi');
    log('Response Data: ${e.response?.data}', name: 'handleApi');

    // Handle network timeouts
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return const Left(NetworkFailure(
          ['Connection timed out. Please check your internet connection.']));
    }

    // Handle no internet
    if (e.type == DioExceptionType.unknown && e.error is SocketException) {
      return const Left(NetworkFailure(
          ['No internet connection. Please check your network.']));
    }

    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final data = e.response!.data;

      String message = 'An unexpected error occurred';
      final errors = <String>[];

      // Detect HTML response and override message
      bool isHtml = false;
      if (data is String &&
          (data.trim().startsWith('<!DOCTYPE html>') ||
              data.trim().startsWith('<html'))) {
        isHtml = true;
      }

      if (!isHtml) {
        if (data is Map<String, dynamic>) {
          message = _sanitizeErrorMessage(data['message']);

          final validationErrors = data['data'];
          if (validationErrors is Map<String, dynamic>) {
            for (final entry in validationErrors.entries) {
              final val = entry.value;
              if (val is List) {
                errors.addAll(val.map((e) => _sanitizeErrorMessage(e)));
              } else if (val != null) {
                errors.add(_sanitizeErrorMessage(val));
              }
            }
          } else if (validationErrors is String) {
            errors.add(_sanitizeErrorMessage(validationErrors));
          }
        } else if (data is String) {
          message = _sanitizeErrorMessage(data);
        }
      } else {
        message =
            'The server returned an invalid response. Please try again later.';
      }

      switch (statusCode) {
        case 400:
          return Left(
              ValidationFailure(errors.isNotEmpty ? errors : [message]));
        case 401:
          return Left(
              AuthenticationFailure(errors.isNotEmpty ? errors : [message]));
        case 403:
          return const Left(AuthorizationFailure(
              ['You are not authorized to perform this action.']));
        case 404:
          return Left(NotFoundFailure([message]));
        case 500:
        default:
          return Left(ServerFailure([message]));
      }
    }

    // No response (server didn’t respond)
    return const Left(NetworkFailure(
        ['Unable to reach the server. Please try again later.']));
  } catch (e, stack) {
    log('[API ERROR] Unknown Exception: $e',
        name: 'handleApi', stackTrace: stack);
    return Left(UnknownFailure([_sanitizeErrorMessage(e.toString())]));
  }
}

String _sanitizeErrorMessage(dynamic rawMessage) {
  if (rawMessage == null) return 'An unexpected error occurred';

  String message = rawMessage.toString();

  // Strip HTML tags
  message = message.replaceAll(RegExp(r'<[^>]*>'), ' ').trim();

  // Collapse spaces
  message = message.replaceAll(RegExp(r'\s+'), ' ').trim();

  // Limit length to avoid giant snackbars
  if (message.length > 200) {
    message = message.substring(0, 200) + '...';
  }

  return message.isEmpty ? 'An unexpected error occurred' : message;
}
