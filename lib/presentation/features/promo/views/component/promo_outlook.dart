import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/promo/provider/promo_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromoRewardsSection extends ConsumerWidget {
  const PromoRewardsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final promoState = ref.watch(promoProvider);

    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Promo rewards',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w400,
            ),
          ),
          8.verticalSpace,
          Row(
            children: [
              Text(
                '₦${promoState.totalRewards.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: AppSvgIcon(
                  path: Assets.svgs.promoGiftImage,
                ),
                // Image.asset(
                //   'assets/images/gift_reward.png', // Replace with your gift reward asset
                //   fit: BoxFit.contain,
                // ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
