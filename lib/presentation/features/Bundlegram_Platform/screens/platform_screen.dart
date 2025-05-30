import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformquickaction_widget.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformdrawer_widget.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformnotice_widget.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/recenttransaction_widget.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/viewstatistics_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlatformScreen extends StatefulWidget {
  const PlatformScreen({super.key});

  @override
  State<PlatformScreen> createState() => _PlatformScreenState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _PlatformScreenState extends State<PlatformScreen> {
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
            const RecenttransactionWidget(),
          ],
        ),
      ),
    );
  }
}
