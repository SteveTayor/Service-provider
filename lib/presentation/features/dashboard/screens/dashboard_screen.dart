import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/platform_screen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/platformproduct_screen.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/account_screen.dart';
import 'package:bundlegram/presentation/features/dashboard/provider/dashboard_provider.dart';
import 'package:bundlegram/presentation/features/dashboard/screens/widget/dashboardd_update_checker.dart';
import 'package:bundlegram/presentation/features/transaction/screens/transaction_screen.dart';
import 'package:bundlegram/presentation/features/wallet/screen/wallet_screen.dart';
import 'package:bundlegram/presentation/general_widget/nav_bar.dart';
import 'package:bundlegram/presentation/general_widget/promo_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  bool hasInitialized = false;
  @override
  void initState() {
    super.initState();
// Only initDashboard if not last tab (AccountScreen = index 3)
    final currentIndex = ref.read(dashboardProvider).currentIndex;
    if (currentIndex != 3) {
      Future.microtask(() {
        ref.read(dashboardProvider.notifier).initDashboard(context);
        hasInitialized = true;
        _checkAndShowPromo();
      });
    }
  }

  Future<void> _checkAndShowPromo() async {
    final storage = ref.read(secureStorageHelperProvider);
    final hasSeenPromo = await storage.hasSeenPromoModal();

    if (!hasSeenPromo && mounted) {
      await Future.delayed(const Duration(milliseconds: 800));
      if (mounted) {
        showPromoModal(context);
        await storage.setHasSeenPromoModal(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex =
        ref.watch(dashboardProvider.select((p) => p.currentIndex));

    // If user navigates to a new tab and init wasn't done yet, do it now
    if (!hasInitialized && currentIndex != 3) {
      Future.microtask(() {
        ref.read(dashboardProvider.notifier).initDashboard(context);
        hasInitialized = true;
      });
    }
    return PopScope(
      canPop: false, // Prevent default pop behavior
      onPopInvoked: (didPop) {
        if (didPop) return; // If already popped, do nothing
        if (currentIndex != 0) {
          // If not on the first tab, switch to the first tab
          ref
              .read(dashboardProvider.notifier)
              .onDestinationSelected(0, context);
        } else {
          //  exit the app or do nothing
          // Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            IndexedStack(
              index: ref.watch(dashboardProvider.select((p) => p.currentIndex)),
              children: const [
                PlatformScreen(),
                WalletScreen(),
                TransactionScreen(),
                AccountScreen(),
              ],
            ),
            const DashboardUpdateChecker(),
          ],
        ),
        bottomNavigationBar: const NavBar(),
      ),
    );
  }
}
