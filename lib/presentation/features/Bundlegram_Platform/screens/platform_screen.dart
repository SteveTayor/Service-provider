import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformquickaction_widget.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformdrawer_widget.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformnotice_widget.dart';
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

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _PlatformScreenState extends ConsumerState<PlatformScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const PlatFormDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 540.h,
              child: const Stack(
                children: [
                  PlatformQuickActionWidget(),
                  Positioned(
                    bottom: 20,
                    left: 16,
                    right: 16,
                    child: ViewStatisticsWidget(),
                  ),
                ],
              ),
            ),
            const PlatformNoticeWidget(),
            40.verticalSpace,
            Padding(
              padding: context.symmetricPadding(20, 0),
              child: RecenttransactionWidget(
                SizedBox(
                  height: 0.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
