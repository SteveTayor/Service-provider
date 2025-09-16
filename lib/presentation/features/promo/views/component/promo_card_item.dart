import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/promo/model/promo_model.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromoCard extends StatelessWidget {
  final PromoModel promo;
  final VoidCallback? onClaim;

  const PromoCard({
    super.key,
    required this.promo,
    this.onClaim,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: promo.backgroundColor != null
            ? _hexToColor(promo.backgroundColor!)
            : const Color(0xFFE8F4FD),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          // Gift box image
          Container(
            width: 60.w,
            height: 130.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: AppSvgIcon(
              path: Assets.svgs.availablePromo,
            ),
            //  Image.asset(
            //   'assets/images/gift_box.png', // Replace with your gift box asset
            //   fit: BoxFit.contain,
            // ),
          ),
          16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: promo.textColor != null
                        ? _hexToColor(promo.textColor!)
                        : Colors.blue,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    promo.code,
                    style: TextStyle(
                      color: Color(0xFF0A3BA5),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                8.verticalSpace,
                Text(
                  promo.title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                4.verticalSpace,
                Text(
                  promo.description,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black54,
                  ),
                ),
                12.verticalSpace,
                SizedBox(
                  width: double.infinity,
                  height: 36.h,
                  child: ElevatedButton(
                    onPressed: onClaim,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      // promo.isClaimed! ? 'Claimed' :
                      'Claim now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _hexToColor(String hex) {
    return Color(int.parse(hex.replaceFirst('#', ''), radix: 16) + 0xFF000000);
  }
}
