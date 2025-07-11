import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/platform_screen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/platformproduct_screen.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/account_screen.dart';
import 'package:bundlegram/presentation/features/dashboard/provider/dashboard_provider.dart';
import 'package:bundlegram/presentation/features/transaction/screens/transaction_screen.dart';
import 'package:bundlegram/presentation/features/wallet/screen/wallet_screen.dart';
import 'package:bundlegram/presentation/general_widget/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(dashboardProvider.notifier).initDashboard(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: ref.watch(dashboardProvider.select((p) => p.currentIndex)),
        children: const [
          PlatformScreen(),
          WalletScreen(),
          TransactionScreen(),
          AccountScreen(),
        ],
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
