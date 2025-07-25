import 'package:bundlegram/core/extensions/context_extensions.dart';
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
  const ViewStatisticsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final platform = ref.read(platformProvider);

    return GestureDetector(
      onTap: () => platform.openStatisticsBottomSheet(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppSvgIcon(
            path: Assets.svgs.viewstat,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'View statistics',
                  style: context.textTheme.bodyMedium,
                ),
                // SizedBox(height: 4.h),
                Text(
                  'View charts of your transactions',
                  style: context.textTheme.bodySmall,
                  // maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
          ),
          AppSvgIcon(
            path: Assets.svgs.chevronDown,
          ),
        ],
      ).withContainer(
        color: AppColors.white,
        width: context.width,
        boxShadow: [
          const BoxShadow(
            color: Color(0xFFEBEEF1),
            offset: Offset(0, 4),
            blurRadius: 24,
          ),
        ],
        borderRadius: BorderRadius.circular(8.r),
        padding: const EdgeInsets.all(20),
      ),
    );
  }
}
