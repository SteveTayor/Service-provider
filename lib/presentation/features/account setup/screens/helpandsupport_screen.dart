import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/gen/fonts.gen.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/faqs_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpandsupportScreen extends StatelessWidget {
  const HelpandsupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildItemRow(
      String asset,
      String title,
      String label, {
      VoidCallback? onPressed,
      Widget? extraWidget,
    }) {
      return InkWell(
        onTap: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppSvgIcon(path: asset),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontFamily: FontFamily.mabryProBold,
                    ),
                  ),
                  8.verticalSpace,
                  if (label.isEmpty)
                    const SizedBox()
                  else
                    Text(
                      label,
                      style: context.textTheme.labelMedium,
                    ),
                  extraWidget ?? const SizedBox(),
                ],
              ),
            ),
          ],
        ).withContainer(
          border: const Border(bottom: BorderSide(color: Color(0xffECECEC))),
          padding: context.symmetricPadding(24.h, 8),
          margin: EdgeInsets.only(bottom: 24.h),
        ),
      );
    }

    return BundlegramScaffold(
      sidePadding: EdgeInsets.zero,
      appBar: const BundlegramAppbar(
        titleText: 'Help & Support',
      ),
      body: Column(
        children: [
          40.verticalSpace,
          buildItemRow(
            Assets.svgs.helpQuestion1StreamlineCore,
            extraWidget: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const HelpCenterScreen(),
                  ),
                );
              },
              child: Text(
                'View FAQs',
                style: context.textTheme.titleMedium!.copyWith(
                  fontSize: 16.sp,
                  height: 3,
                  color: AppColors.primaryColor,
                  decorationColor: AppColors.primaryColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            'Help center (FAQs)',
            'We collated some likely questions you may have, with their respective answers. If you don’t find answer to your question, please call support or send an email to the addresses below.',
          ),
          buildItemRow(
            Assets.svgs.sendEmailMailSendEmailPaperAirplane,
            extraWidget: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Enquiry: info@bundlegram.com',
                        style: context.textTheme.bodySmall!.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey33,
                        ),
                      ),
                    ),
                    5.horizontalSpace,
                    AppSvgIcon(path: Assets.svgs.copy),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Technical: support@bundlegram.com',
                        style: context.textTheme.bodySmall!.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey33,
                        ),
                      ),
                    ),
                    5.horizontalSpace,
                    AppSvgIcon(path: Assets.svgs.copy),
                  ],
                ),
              ],
            ),
            'Send an email',
            '',
          ),
          buildItemRow(
            Assets.svgs.phoneRinging1StreamlineCore,
            extraWidget: Column(
              children: [
                Row(
                  children: [
                    Text(
                      '08133434566',
                      style: context.textTheme.bodySmall!.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey33,
                      ),
                    ),
                    5.horizontalSpace,
                    AppSvgIcon(path: Assets.svgs.copy),
                  ],
                ),
              ],
            ),
            'Call support',
            '',
          ),
        ],
      ),
    );
  }
}
