import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/responsive_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_screen_provider.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/statisticvisual.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewStatisticsWidget extends ConsumerWidget {
  const ViewStatisticsWidget({
    super.key,
    this.useResponsive = true, // ADD
  });

  final bool useResponsive; // ADD

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = context.responsive; // ADD
    final platform = ref.read(platformProvider);

    return GestureDetector(
      onTap: () => platform.openStatisticsBottomSheet(context),
      child: Container(
        width: context.width,
        padding: EdgeInsets.all(useResponsive ? r.spacing(12) : 12), // CHANGED
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFEBEEF1),
              offset: Offset(0, 4),
              blurRadius: 24,
            ),
          ],
          borderRadius: BorderRadius.circular(
            useResponsive ? r.radiusSize(8) : 8.r, // CHANGED
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.all(useResponsive ? r.spacing(8) : 8.0), // CHANGED
              child: AppSvgIcon(path: Assets.svgs.viewstat),
            ),
            SizedBox(width: useResponsive ? r.spacing(8) : 8.w), // CHANGED
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'View statistics',
                    style: TextStyle(
                      fontSize:
                          useResponsive ? r.textSize(16) : 16.sp, // CHANGED
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                      height: useResponsive ? r.spacing(4) : 4.h), // CHANGED
                  Text(
                    'View charts of your transactions',
                    style: context.textTheme.labelMedium,
                  ),
                ],
              ),
            ),
            SizedBox(width: useResponsive ? r.spacing(12) : 12.w), // CHANGED
            SizedBox(
              width: useResponsive ? r.spacing(24) : 24, // CHANGED
              height: useResponsive ? r.spacing(24) : 24, // CHANGED
              child: AppSvgIcon(path: Assets.svgs.chevronDown),
            ),
            SizedBox(width: useResponsive ? r.spacing(8) : 8.w), // CHANGED
          ],
        ),
      ),
    );
  }
}
