import 'dart:async';

import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';

// final dashboardProvider = ChangeNotifierProvider<DashboardProvider>((ref) {
//   return DashboardProvider(ref);
// });

// class DashboardProvider extends ChangeNotifier {
//   final Ref _ref;

//   DashboardProvider(this._ref);

//   int _currentIndex = 0;
//   int get currentIndex => _currentIndex;
//   bool _isLoading = false;
//   String? _error;

//   bool get isLoading => _isLoading;
//   String? get error => _error;

//   Future<void> initDashboard(BuildContext context) {
//     if (_currentIndex != 1 && _currentIndex != 3) {
//       unawaited(_fetchDashboardData(context));
//     }
//     return Future.value();
//   }

//   void resetIndex() {
//     _currentIndex = 0;
//     notifyListeners();
//   }

//   void onDestinationSelected(int index, BuildContext context) {
//     if (_currentIndex != index) {
//       _currentIndex = index;
//       notifyListeners();
//     }
//     if (index != 1 && index != 3) {
//       _fetchDashboardData(context);
//     }
//   }

//   Future<void> _fetchDashboardData(BuildContext context) async {
//     _setLoading(true);
//     _setError(null);

//     final storage = _ref.read(secureStorageHelperProvider);
//     final token = await storage.getAuthToken();
//     // context.showLoadingDialog();

//     if (token == null) {
//       // context.dismissDialog();

//       context
//         // ..showErrorSnackBar(
//         //     'No authentication token found. Please log in again.')
//         ..go(RouteConstants.login);
//       _setLoading(false);
//       return;
//     }

//     final global = _ref.read(globalProvider.notifier);
//     unawaited(global.initializeWalletandAccounts(context));
//     await global.initializePlatformDependencies(context);

//     // context.dismissDialog();
//     _setLoading(false);
//   }

//   void _setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }

//   void _setError(String? message) {
//     _error = message;
//     notifyListeners();
//   }
// }
final dashboardProvider = ChangeNotifierProvider<DashboardProvider>((ref) {
  return DashboardProvider(ref);
});

class DashboardProvider extends ChangeNotifier {
  final Ref _ref;
  DashboardProvider(this._ref);

  int _currentIndex = 0;
  bool _isLoading = false;
  String? _error;

  int get currentIndex => _currentIndex;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Called ONCE when dashboard is first entered
  Future<void> initialize() async {
    // Only initialize for tabs that need global data
    if (_currentIndex == 1 || _currentIndex == 3) return;

    await _initializeGlobal();
  }

  void onDestinationSelected(int index) {
    if (_currentIndex == index) return;

    _currentIndex = index;
    notifyListeners();

    // Wallet & Account do not need global re-init
    if (index == 1 || index == 3) return;

    _initializeGlobal();
  }

  Future<void> _initializeGlobal() async {
    final global = _ref.read(globalProvider.notifier);

    // If global is already ready, do nothing
    if (global.isInitialized) return;

    _setLoading(true);
    _setError(null);

    try {
      await global.initialize();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void resetIndex() {
    _currentIndex = 0;
    notifyListeners();
  }

  void _setError(String? message) {
    _error = message;
    notifyListeners();
  }
}

