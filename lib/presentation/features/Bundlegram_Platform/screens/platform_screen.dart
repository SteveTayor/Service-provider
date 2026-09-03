// import 'package:bundlegram/core/extensions/context_extensions.dart';
// import 'package:bundlegram/core/providers/global_provider.dart';
// import 'package:bundlegram/core/providers/service_provider.dart';
// import 'package:bundlegram/gen/assets.gen.dart';
// import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformquickaction_widget.dart';
// import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformdrawer_widget.dart';
// import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformnotice_widget.dart';
// import 'package:bundlegram/presentation/features/dashboard/provider/dashboard_provider.dart';
// import 'package:bundlegram/presentation/features/transaction/screens/widgets/recenttransaction_widget.dart';
// import 'package:bundlegram/presentation/features/transaction/screens/widgets/viewstatistics_widget.dart';
// import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
// import 'package:bundlegram/presentation/general_widget/app_svg.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class PlatformScreen extends ConsumerStatefulWidget {
//   const PlatformScreen({super.key});

//   @override
//   ConsumerState<PlatformScreen> createState() => _PlatformScreenState();
// }

// // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

// class _PlatformScreenState extends ConsumerState<PlatformScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       drawer: const PlatFormDrawer(),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           // Trigger data refresh by calling _fetchDashboardData
//           // await ref.read(dashboardProvider.notifier).initialize();
//           final global = ref.read(globalProvider.notifier);
//           await global.initializeWalletandAccounts(context);
//           await ref.read(recentTransactionsProvider.notifier).refresh();
//         },
//         child: SingleChildScrollView(
//           physics:
//               const AlwaysScrollableScrollPhysics(), // Ensures pull-to-refresh works
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 540.h,
//                 child: const Stack(
//                   children: [
//                     PlatformQuickActionWidget(),
//                     Positioned(
//                       bottom: 20,
//                       left: 16,
//                       right: 16,
//                       child: ViewStatisticsWidget(),
//                     ),
//                   ],
//                 ),
//               ),
//               const PlatformNoticeWidget(),
//               40.verticalSpace,
//               Padding(
//                 padding: context.symmetricPadding(20, 0),
//                 child: RecentTransactionWidget(
//                   SizedBox(
//                     height: 0.h,
//                   ),
//                   transactionProvider: recentTransactionsProvider,
//                 ),
//               ),
//               const SizedBox(
//                 height: 50,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/providers/service_provider.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformquickaction_widget.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformdrawer_widget.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformnotice_widget.dart';
import 'package:bundlegram/presentation/features/dashboard/provider/dashboard_provider.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/recenttransaction_widget.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/viewstatistics_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlatformScreen extends ConsumerStatefulWidget {
  const PlatformScreen({super.key});

  @override
  ConsumerState<PlatformScreen> createState() => _PlatformScreenState();
}

class _PlatformScreenState extends ConsumerState<PlatformScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // How far the stats card hangs below the quick-action widget's
  // baseline. Tune this against ViewStatisticsWidget's real height
  static const double _statsCardOverlap = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const PlatFormDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          // Trigger data refresh by calling _fetchDashboardData
          final global = ref.read(globalProvider.notifier);
          await global.initializeWalletandAccounts(context);
          await ref.read(recentTransactionsProvider.notifier).refresh();
        },
        child: SingleChildScrollView(
          physics:
              const AlwaysScrollableScrollPhysics(), // Ensures pull-to-refresh works
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // Sizes the Stack and removed fixed 540.h wrapper anymore.
                  const PlatformQuickActionWidget(),
                  Positioned(
                    bottom: -_statsCardOverlap.h,
                    left: 16,
                    right: 16,
                    child: const ViewStatisticsWidget(),
                  ),
                ],
              ),
              // Reserve space equal to the overlap so the stats card
              // doesn't sit on top of the notice widget below it.
              SizedBox(height: _statsCardOverlap.h + 20.h),
              const PlatformNoticeWidget(),
              40.verticalSpace,
              Padding(
                padding: context.symmetricPadding(20, 0),
                child: RecentTransactionWidget(
                  SizedBox(height: 0.h),
                  transactionProvider: recentTransactionsProvider,
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
