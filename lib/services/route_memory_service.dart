import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Remember last visited route and restore it on resume.
/// - Saves the current router.location when app is backgrounded.
/// - Restores (router.go) on resume, unless the route is blacklisted.
///
/// Usage:
///   final _routeMemory = RouteMemoryService(AppRouter.router);
///   WidgetsBinding.instance.addObserver(_routeMemory);
///   // remove observer on dispose
class RouteMemoryService with WidgetsBindingObserver {
  RouteMemoryService(this.router) {
    // Mark ready only after first frame. Prevent reacting to lifecycle events
    // that fire during restoration.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isReady = true;
    });
  }
  final GoRouter router;

  static const _prefsKey = 'last_route_location';

  bool _isReady = false;

  /// Routes we should NOT restore to (splash, auth, onboarding, etc).
  /// Use prefix matching for groups of routes.
  final List<String> _blacklistPrefixes = const <String>[];

  bool _isBlacklisted(String? location) {
    if (location == null || location.isEmpty) return true;
    for (final prefix in _blacklistPrefixes) {
      if (location.startsWith(prefix)) return true;
    }
    return false;
  }

  String? _getSafeLocation() {
    try {
      final config = router.routerDelegate.currentConfiguration;
      if (config == null) return null;

      // Use the URI to get the route location.
      final uri = config.uri;
      if (uri != null) {
        final uriStr = uri.toString();
        if (uriStr.isNotEmpty) return uriStr;
      }
    } catch (_) {
      // router might be transitional during restoration; swallow errors.
    }
    return null;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_isReady) return;

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      final location = _getSafeLocation();
      if (location == null || _isBlacklisted(location)) return;

      // Schedule write off the lifecycle call stack.
      Future.microtask(() async {
        try {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(_prefsKey, location);
        } catch (_) {
          // ignore - best effort
        }
      });

      return;
    }

    if (state == AppLifecycleState.resumed) {
      // Schedule read off the lifecycle call stack.
      Future.microtask(() async {
        try {
          final prefs = await SharedPreferences.getInstance();
          final last = prefs.getString(_prefsKey);
          if (last == null || last.isEmpty) return;
          if (_isBlacklisted(last)) return;

          String candidate = last;
          if (!candidate.startsWith('/')) {
            final uri = Uri.tryParse(candidate);
            candidate = uri?.path ?? '';
            if (candidate.isEmpty) return;
            if (_isBlacklisted(candidate)) return;
          }

          final current = _getSafeLocation();
          if (current != null && current == candidate) return;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            try {
              router.go(candidate);
            } catch (_) {
              // ignore navigation errors
            }
          });
        } catch (_) {
          // ignore
        }
      });

      return;
    }
  }

  static Future<void> clearSavedRoute() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_prefsKey);
    } catch (_) {}
  }
}

// class RouteMemoryService with WidgetsBindingObserver {
//   RouteMemoryService(this.router);

//   final GoRouter router;
//   static const _key = 'last_route_location';

//   String? _getCurrentLocation() {
//     final config = router.routerDelegate.currentConfiguration;
//     if (config.routes.isEmpty) return null;

//     // Rebuild full path from matched routes
//     return config.uri.toString();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) async {
//     final prefs = await SharedPreferences.getInstance();

//     if (state == AppLifecycleState.paused ||
//         state == AppLifecycleState.inactive) {
//       final location = _getCurrentLocation();
//       if (location != null && location.isNotEmpty) {
//         await prefs.setString(_key, location);
//       }
//     }

//     if (state == AppLifecycleState.resumed) {
//       final lastRoute = prefs.getString(_key);
//       final current = _getCurrentLocation();

//       if (lastRoute != null &&
//           lastRoute.isNotEmpty &&
//           lastRoute != current) {
//         router.go(lastRoute);
//       }
//     }
//   }
// }
