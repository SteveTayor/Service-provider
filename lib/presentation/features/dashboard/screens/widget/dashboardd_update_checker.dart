import 'package:bundlegram/presentation/features/account%20setup/notifier/app_actions_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Invisible widget that checks for updates when dashboard loads
class DashboardUpdateChecker extends ConsumerStatefulWidget {
  const DashboardUpdateChecker({super.key});

  @override
  ConsumerState<DashboardUpdateChecker> createState() =>
      _DashboardUpdateCheckerState();
}

class _DashboardUpdateCheckerState
    extends ConsumerState<DashboardUpdateChecker> {
  static const String _lastCheckKey = 'last_update_check_timestamp';
  static const Duration _checkInterval =
      Duration(hours: 24); // Check once per day

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkForUpdatesIfNeeded();
    });
  }

  Future<void> _checkForUpdatesIfNeeded() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastCheck = prefs.getInt(_lastCheckKey) ?? 0;
      final now = DateTime.now().millisecondsSinceEpoch;

      // Only check if it's been more than 24 hours since last check
      if (now - lastCheck > _checkInterval.inMilliseconds) {
        final appActions = ref.read(appActionsProvider);
        await appActions.checkForUpdateSilently(context);

        // Save last check time
        await prefs.setInt(_lastCheckKey, now);
      }
    } catch (e) {
      debugPrint('Error checking for updates: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // Invisible widget
  }
}
