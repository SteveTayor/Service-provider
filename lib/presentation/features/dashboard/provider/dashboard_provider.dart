import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardProvider = ChangeNotifierProvider<DashboardProvider>((ref) {
  return DashboardProvider(ref);
});

class DashboardProvider extends ChangeNotifier {
  final Ref _ref;

  DashboardProvider(this._ref);

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  Future<void> initDashboard(BuildContext context) async {
    await _fetchDashboardData(context);
  }

  void onDestinationSelected(int index, BuildContext context) {
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
    _fetchDashboardData(context);
  }

  Future<void> _fetchDashboardData(BuildContext context) async {
    final global = _ref.read(globalProvider.notifier);
    await global.initializeWalletandAccounts(context);
  }
}
