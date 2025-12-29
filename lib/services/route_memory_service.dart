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
  RouteMemoryService(this.router);

  final GoRouter router;

  static const _prefsKey = 'last_route_location';

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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // IMPORTANT: do not mark this method async (must match signature).
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      // Save location (best-effort). Use then() to avoid async/await inside override.
      final location =
          router.routerDelegate.currentConfiguration.uri.toString();
      if (location.isEmpty || _isBlacklisted(location)) return;

      SharedPreferences.getInstance().then((prefs) {
        try {
          prefs.setString(_prefsKey, location);
        } catch (_) {
          // ignore - best effort
        }
      });
      return;
    }

    if (state == AppLifecycleState.resumed) {
      SharedPreferences.getInstance().then((prefs) {
        try {
          final last = prefs.getString(_prefsKey);
          if (last == null || last.isEmpty) return;
          // If already at the same location, nothing to do.
          if (last == router.routerDelegate.currentConfiguration.uri.toString())
            return;
          if (_isBlacklisted(last)) return;

          // Defer navigation until after a frame to ensure router is ready.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            try {
              // If you want to guard deep-link logic or parameters, handle it here.
              router.go(last);
            } catch (_) {
              // ignore navigation errors (route might no longer exist)
            }
          });
        } catch (_) {
          // ignore
        }
      });
    }
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
