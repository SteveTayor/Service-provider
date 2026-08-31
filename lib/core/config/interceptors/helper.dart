import 'dart:developer';
import 'dart:io';

import 'package:bundlegram/core/error/errors.dart';
import 'package:bundlegram/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

Future<Either<Failure, T>> handleApi<T>(Future<T> Function() call) async {
  try {
    final result = await call();

    log('[API SUCCESS] Response: $result', name: 'handleApi');
    return Right(result);
  } on DioException catch (e) {
    log('[API ERROR] DioException: ${e.message}', name: 'handleApi');
    log('Request Path: ${e.requestOptions.uri}', name: 'handleApi');
    log('Status Code: ${e.response?.statusCode}', name: 'handleApi');
    log('Response Data: ${e.response?.data}', name: 'handleApi');

    // Handle network timeouts
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return const Left(
        NetworkFailure([
          'Connection timed out. Please check your internet connection.',
        ]),
      );
    }

    // Handle no internet (SocketException)
    if (e.type == DioExceptionType.unknown && e.error is SocketException) {
      return const Left(
        NetworkFailure(['No internet connection. Please check your network.']),
      );
    }

    // If we have a response from the server
    final resp = e.response;
    if (resp != null) {
      final statusCode = resp.statusCode;
      final data = resp.data;

      String message = 'An unexpected error occurred';
      final errors = <String>[];

      // Detect HTML response (Cloudflare / host error pages) and override message
      final bool isHtml = _isHtmlResponse(resp);

      if (isHtml) {
        message =
            'The server returned an invalid response. Please try again later.';
      } else {
        // If server returned JSON-like payload, try to extract meaningful messages
        try {
          if (data is Map<String, dynamic>) {
            // Common keys: message, error, errors, data
            final rawMessage = data['message'] ?? data['error'];
            if (rawMessage != null) {
              message = sanitizeErrorMessage(rawMessage);
            }

            // Validation / structured errors
            final validation = data['errors'] ?? data['data'];
            if (validation != null) {
              if (validation is Map<String, dynamic>) {
                for (final entry in validation.entries) {
                  final val = entry.value;
                  if (val is List) {
                    errors.addAll(val.map((e) => sanitizeErrorMessage(e)));
                  } else {
                    errors.add(sanitizeErrorMessage(val));
                  }
                }
              } else if (validation is List) {
                errors.addAll(validation.map((e) => sanitizeErrorMessage(e)));
              } else if (validation is String) {
                errors.add(sanitizeErrorMessage(validation));
              }
            }

            // If there is an 'errors' key which is often a map or list
            if (errors.isEmpty && data['errors'] != null) {
              final raw = data['errors'];
              if (raw is Map<String, dynamic>) {
                for (final v in raw.values) {
                  if (v is List) {
                    errors.addAll(v.map((e) => sanitizeErrorMessage(e)));
                  } else {
                    errors.add(sanitizeErrorMessage(v));
                  }
                }
              } else if (raw is List) {
                errors.addAll(raw.map((e) => sanitizeErrorMessage(e)));
              } else if (raw is String) {
                errors.add(sanitizeErrorMessage(raw));
              }
            }
          } else if (data is String) {
            // If the server returned a plain text error message
            message = sanitizeErrorMessage(data);
          }
        } catch (inner) {
          // If parsing fails for any reason, fall back to sanitized string
          message = sanitizeErrorMessage(data);
        }
      }

      // Map status codes to Failure types
      switch (statusCode) {
        case 400:
        case 422:
          return Left(
            ValidationFailure(errors.isNotEmpty ? errors : [message]),
          );
        case 401:
          return Left(
            AuthenticationFailure(errors.isNotEmpty ? errors : [message]),
          );
        case 403:
          return const Left(
            AuthorizationFailure([
              'You are not authorized to perform this action.',
            ]),
          );
        case 404:
          return Left(NotFoundFailure([message]));
        case 429:
          return Left(
            ServerFailure([message]),
          ); // Rate limit -> server failure class OK
        default:
          // All remaining status codes (including 5xx and anything
          // unmapped) fall through to ServerFailure
          return Left(ServerFailure([message]));
      }
    }

    // No response (server didn't respond / connection issue)
    return const Left(
      NetworkFailure(['Unable to reach the server. Please try again later.']),
    );
  } catch (e, stack) {
    log(
      '[API ERROR] Unknown Exception: $e',
      name: 'handleApi',
      stackTrace: stack,
    );
    return Left(UnknownFailure([sanitizeErrorMessage(e.toString())]));
  }
}

/// Return true if response looks like HTML (checks headers and body)
bool _isHtmlResponse(Response? resp) {
  if (resp == null) return false;

  try {
    final ct = resp.headers.value('content-type') ?? '';
    if (ct.toLowerCase().contains('text/html')) return true;

    final data = resp.data;
    if (data is String) {
      final s = data.trimLeft();
      return s.startsWith('<!DOCTYPE') ||
          s.startsWith('<html') ||
          s.startsWith('<HTML');
    }

    // Sometimes error pages come as List<int> (bytes) — check a small prefix
    if (data is List<int>) {
      final prefix = String.fromCharCodes(data.take(256));
      final s = prefix.trimLeft();
      return s.startsWith('<!DOCTYPE') || s.startsWith('<html');
    }
  } catch (_) {
    // ignore parsing errors here
  }
  return false;
}
