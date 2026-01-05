import 'package:bundlegram/core/error/errors.dart';
import 'package:bundlegram/core/error/failures.dart';
import 'package:flutter/foundation.dart';

String userFacingMessageFromFailure(Failure fail) {
  // Prefer the properties list (already sanitized in handleApi)
  if (fail.properties.isNotEmpty) {
    final joined =
        fail.properties.map((p) => sanitizeErrorMessage(p)).join('\n');
    // In debug mode, show full joined message; in prod keep it short
    if (kDebugMode) return joined;
    // If it's long, give a trimmed UX-friendly version
    return joined.length <= 200 ? joined : '${joined.substring(0, 200)}...';
  }

  // Map known failure classes
  if (fail is NetworkFailure) {
    return 'No internet connection. Check your network and try again.';
  }
  if (fail is AuthenticationFailure) {
    return 'Authentication failed. Please sign in again.';
  }
  if (fail is AuthorizationFailure) {
    return 'You are not permitted to perform this action.';
  }
  if (fail is NotFoundFailure) {
    return 'Requested resource not found.';
  }
  if (fail is ValidationFailure) {
    return 'Please check the information you entered and try again.';
  }
  if (fail is ServerFailure) {
    return 'Server error. Please try again in a few minutes.';
  }
  if (fail is UnknownFailure) {
    return 'Something went wrong.';
  }

  // Generic fallback
  return 'An error occurred. Please try again.';
}
