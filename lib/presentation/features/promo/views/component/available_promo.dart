import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/promo/provider/promo_provider.dart';
import 'package:bundlegram/presentation/features/promo/views/component/promo_card_item.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailablePromosSection extends ConsumerWidget {
  const AvailablePromosSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final promoState = ref.watch(promoProvider);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available promos',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          16.verticalSpace,
          if (promoState.availablePromos.isEmpty)
            _buildEmptyState(context)
          else
            ...promoState.availablePromos.map(
              (promo) => PromoCard(
                promo: promo,
                onClaim: () {
                  ref.read(promoProvider.notifier).updatePromoCode(promo.code);
                  ref
                      .read(promoProvider.notifier)
                      .claimPromo(promo.code, context);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppSvgIcon(path: Assets.svgs.noPromo),
          Text(
            'No available promo.',
            style: context.textTheme.bodyMedium,
          ),
          Text(
            'You will find all promos here',
            style: context.textTheme.labelMedium,
          ),
          // Container(
          //   width: 80.w,
          //   height: 80.h,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(12.r),
          //   ),
          //   child: Stack(
          //     alignment: Alignment.center,
          //     children: [
          //       Image.asset(
          //         'assets/images/gift_box.png', // Replace with your gift box asset
          //         width: 60.w,
          //         height: 60.h,
          //         fit: BoxFit.contain,
          //       ),
          //       Positioned(
          //         right: 0,
          //         top: 0,
          //         child: Container(
          //           width: 24.w,
          //           height: 24.h,
          //           decoration: const BoxDecoration(
          //             color: Colors.red,
          //             shape: BoxShape.circle,
          //           ),
          //           child: const Icon(
          //             Icons.close,
          //             color: Colors.white,
          //             size: 16,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // 16.verticalSpace,
          // Text(
          //   'No available promo',
          //   style: TextStyle(
          //     fontSize: 16.sp,
          //     fontWeight: FontWeight.w600,
          //     color: Colors.black,
          //   ),
          // ),
          // 4.verticalSpace,
          // Text(
          //   'You will find all promos here',
          //   style: TextStyle(
          //     fontSize: 14.sp,
          //     color: Colors.grey.shade600,
          //   ),
          // ),
        ],
      ),
    );
  }
}
