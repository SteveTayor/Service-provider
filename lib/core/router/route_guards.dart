import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:bundlegram/core/router/route_constants.dart';

/// Navigation guards for the application
class RouteGuards {
  /// Private constructor to prevent direct instantiation
  RouteGuards._();

  /// Authentication guard
  static String? authGuard(
    BuildContext context,
    GoRouterState state,
  ) {
    // TODO: Implement actual auth check
    const isAuthenticated = false;
    final isAuthRoute = state.matchedLocation == RouteConstants.login ||
        state.matchedLocation == RouteConstants.register;

    // If not authenticated and not on an auth route, redirect to login
    if (!isAuthenticated && !isAuthRoute) {
      return RouteConstants.login;
    }

    // If authenticated and on an auth route, redirect to home
    if (isAuthenticated && isAuthRoute) {
      return RouteConstants.home;
    }

    // Allow navigation to proceed
    return null;
  }
}
