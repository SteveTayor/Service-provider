import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/styles.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/gen/fonts.gen.dart';
import 'package:bundlegram/presentation/features/account%20setup/notifier/help_and_support_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// One-time prompt encouraging users to follow the Bundlegram WhatsApp
/// channel.
class WhatsappChannelModal extends ConsumerWidget {
  const WhatsappChannelModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(helpSupportProvider);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                color: const Color(0xFF25D366).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: AppSvgIcon(
                  path: Assets.svgs.whatsappColorIcon,
                  width: 40.w,
                  height: 40.h,
                ),
              ),
            ),
            20.verticalSpace,

            Text(
              'Join Our WhatsApp Channel! 📢',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                fontFamily: FontFamily.mabryPro,
                color: AppColors.black,
              ),
              textAlign: TextAlign.center,
            ),
            12.verticalSpace,

            Text(
              'Get instant updates on new features, promos, and important '
              'announcements.',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.mabryPro,
                color: AppColors.grey8E,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            24.verticalSpace,

            BundlegramButton(
              text: 'Follow Channel',
              width: double.infinity,
              height: 48.h,
              leading: null,
              textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: FontFamily.mabryPro,
                fontSize: 16.sp,
              ),
              onPressed: () {
                provider.openWhatsappChannel();
                Navigator.of(context).pop();
              },
              cornerRadius: 8.r,
              buttonStyle: BundlegramButtonStyle.primary(),
            ),

            8.verticalSpace,
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

            16.verticalSpace,

            // This tell the user
            // where to find this again, visible before they've even
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.greyF5,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16.sp,
                    color: AppColors.grey8E,
                  ),
                  8.horizontalSpace,
                  Expanded(
                    child: Text(
                      'You can always find this later under ☰ Menu → '
                      'WhatsApp Channel, or in Help & Support.',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: FontFamily.mabryPro,
                        color: AppColors.grey8E,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shows the modal and returns a Future that completes once it's
/// dismissed
Future<void> showWhatsappChannelModal(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => const WhatsappChannelModal(),
  );
}
