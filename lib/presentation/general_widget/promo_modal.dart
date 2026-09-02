import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/core/utils/styles.dart';
import 'package:bundlegram/gen/fonts.gen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/platformproduct_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PromoModal extends StatelessWidget {
  const PromoModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon/Image (optional)
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.discount_rounded,
                size: 40.sp,
                color: AppColors.primaryColor,
              ),
            ),
            20.verticalSpace,

            // Title
            Text(
              'Special Offer! 🎉',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                fontFamily: FontFamily.mabryPro,
                color: AppColors.black,
              ),
              textAlign: TextAlign.center,
            ),
            12.verticalSpace,

            // Message
            Text(
              'Buy airtime and data and enjoy 5 - 10% discount on every transaction.',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.mabryPro,
                color: AppColors.grey8E,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            30.verticalSpace,

            // Buttons
            Row(
              children: [
                Expanded(
                  child: BundlegramButton(
                    text: 'Buy Data',
                    height: 48.h,
                    textStyle: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.mabryPro,
                    ),
                    onPressed: () {
                      context
                        ..pop()
                        // Navigate to Buy Data screen
                        // context.push(RouteConstants.buyData);
                        ..push(RouteConstants.platformProduct,
                            extra: PlatformProductType.mobileData);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => const PlatformproductScreen(
                      //         serviceType: PlatformProductType.mobileData),
                      //   ),
                      // );
                    },
                    cornerRadius: 8.r,
                    buttonStyle: BundlegramButtonStyle.primary(),
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      context
                        ..pop()
                        // Navigate to Buy Airtime screen
                        ..push(RouteConstants.platformProduct,
                            extra: PlatformProductType.airtime);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => const PlatformproductScreen(
                      //         serviceType: PlatformProductType.airtime),
                      //   ),
                      // );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Text(
                      'Buy Airtime',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: FontFamily.mabryPro,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Skip button
            12.verticalSpace,
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Maybe Later',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontFamily.mabryPro,
                  color: AppColors.grey8E,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/// Helper function to show the modal. Returns the dialog's Future so
/// callers can `await` its dismissal 
Future<void> showPromoModal(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const PromoModal(),
  );
}