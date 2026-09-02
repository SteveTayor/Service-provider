import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/gen/fonts.gen.dart';
import 'package:bundlegram/presentation/features/account%20setup/notifier/help_and_support_provider.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/faqs_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class HelpandsupportScreen extends ConsumerWidget {
  const HelpandsupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(helpSupportProvider);

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
                      style: context.textTheme.bodySmall,
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
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            40.verticalSpace,
            buildItemRow(
              Assets.svgs.helpQuestion1StreamlineCore,
              'Help center (FAQs)',
              'We collated some likely questions you may have, with their respective answers. If you don’t find answer to your question, please call support or send an email to the addresses below.',
              extraWidget: GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const HelpCenterScreen(),
                    ),
                  );
                },
                child: Text(
                  'View FAQs',
                  style: context.textTheme.bodyMedium?.copyWith(
                    // fontSize: 16,
                    height: 3,
                    color: AppColors.primaryColor,
                    decorationColor: AppColors.primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            buildItemRow(
              Assets.svgs.sendEmailMailSendEmailPaperAirplane,
              'Send an email',
              '',
              extraWidget: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () =>
                              provider.launchEmail('info@bundlegram.com'),
                          child: Text(
                            'Enquiry: info@bundlegram.com',
                            style: context.textTheme.bodySmall!.copyWith(
                              // fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey33,
                            ),
                          ),
                        ),
                      ),
                      5.horizontalSpace,
                      GestureDetector(
                        onTap: () => provider.copyToClipboard(
                            context, 'info@bundlegram.com'),
                        child: AppSvgIcon(path: Assets.svgs.copy),
                      ),
                    ],
                  ),
                  8.verticalSpace,
                  Row(
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () =>
                              provider.launchEmail('support@bundlegram.com'),
                          child: Text(
                            'Technical: support@bundlegram.com',
                            style: context.textTheme.bodySmall!.copyWith(
                              // fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey33,
                            ),
                          ),
                        ),
                      ),
                      5.horizontalSpace,
                      GestureDetector(
                        onTap: () => provider.copyToClipboard(
                            context, 'support@bundlegram.com'),
                        child: AppSvgIcon(path: Assets.svgs.copy),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            buildItemRow(
              Assets.svgs.phoneRinging1StreamlineCore,
              'Call support',
              '',
              extraWidget: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => provider.launchPhoneCall('08133434566'),
                        child: Text(
                          '08133434566',
                          style: context.textTheme.bodySmall!.copyWith(
                            // fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey33,
                          ),
                        ),
                      ),
                      5.horizontalSpace,
                      GestureDetector(
                        onTap: () =>
                            provider.copyToClipboard(context, '08133434566'),
                        child: AppSvgIcon(path: Assets.svgs.copy),
                      ),
                    ],
                  ),
                ],
              ),
            ),


            // const SizedBox(height: 35),
            Container(
              padding: context.symmetricPadding(24.h, 8),
              margin: EdgeInsets.only(bottom: 24.h),
              child: Text(
                'Social Media Support',
                // textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium,
              ),
            ),

             // NEW: WhatsApp Channel
            buildItemRow(
              Assets.svgs.whatsappColorIcon,
              'WhatsApp Channel',
              'Follow our official WhatsApp channel for news, promos, and announcements.',
              extraWidget: GestureDetector(
                onTap: () => provider.openWhatsappChannel(),
                child: Text(
                  'Follow Channel',
                  style: context.textTheme.bodyMedium?.copyWith(
                    height: 3,
                    color: AppColors.primaryColor,
                    decorationColor: AppColors.primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Container(
              padding: context.symmetricPadding(24.h, 8),
              margin: EdgeInsets.only(bottom: 24.h),
              child: Text(
                'Social Media Support',
                style: context.textTheme.bodyMedium,
              ),
            ),
            // const SizedBox(height: 10),
            Container(
              padding: context.symmetricPadding(24.h, 8),
              margin: EdgeInsets.only(bottom: 24.h),
              child: Wrap(
                spacing: 24,
                runSpacing: 24,
                children: [
                  AppSvgIcon(
                      height: 40,
                      path: Assets.svgs.xSocialMediaLogoIcon,
                      onTap: () => provider.openTwitter()),
                  AppSvgIcon(
                      height: 40,
                      path: Assets.svgs.facebookRoundColorIcon,
                      onTap: () => provider.openFacebook()),
                  AppSvgIcon(
                      height: 40,
                      path: Assets.svgs.igInstagramIcon,
                      onTap: () => provider.openInstagram()),
                  // AppSvgIcon(
                  //     height: 40,
                  //     path: Assets.svgs.linkedinAppIcon,
                  //     onTap: () => provider.openLinkedIn()),
                  AppSvgIcon(
                      height: 40,
                      path: Assets.svgs.telegramIcon,
                      onTap: () => provider.openTelegram()),
                  AppSvgIcon(
                      height: 40,
                      path: Assets.svgs.tiktokColorIcon,
                      onTap: () => provider.openTikTok()),
                  AppSvgIcon(
                      height: 40,
                      color: null,
                      path: Assets.svgs.whatsappColorIcon,
                      onTap: () => provider.openWhatsapp()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
