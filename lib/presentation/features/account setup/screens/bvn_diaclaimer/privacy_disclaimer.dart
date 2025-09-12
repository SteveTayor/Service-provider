import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PrivacyDisclaimerWidget extends StatelessWidget {
  const PrivacyDisclaimerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: SingleChildScrollView(
          physics: CarouselScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Center(
                child: Text(
                  'Disclaimer',
                  style: context.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Icon(
                    Icons.security_rounded,
                    color: AppColors.primaryColor,
                    size: 24.w,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Your Privacy & Security',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Main disclaimer content
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'We prioritize your data security',
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Your Bank Verification Number (BVN) and personal information are handled with the highest level of security and confidentiality.',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.resultwidgetColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Security features list
              _buildSecurityPoint(
                context,
                Icons.lock_rounded,
                'End-to-End Encryption',
                'All data is encrypted during transmission and storage',
              ),
              // SizedBox(height: 16.h),

              // _buildSecurityPoint(
              //   context,
              //   Icons.verified_user_rounded,
              //   'Regulatory Compliance',
              //   'We comply with CBN guidelines and banking regulations',
              // ),
              SizedBox(height: 16.h),

              _buildSecurityPoint(
                context,
                Icons.privacy_tip_rounded,
                'No Data Sharing',
                'Your information is never shared with third parties',
              ),
              SizedBox(height: 16.h),

              _buildSecurityPoint(
                context,
                Icons.auto_delete_rounded,
                'Secure Processing',
                'BVN verification is processed securely and temporarily',
              ),

              SizedBox(height: 24.h),

              // Additional info
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: Colors.blue.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.primaryColor,
                      size: 18.w,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'BVN linking is required for enhanced security and to comply with financial regulations. This helps us verify your identity and protect your account.',
                        style: context.textTheme.labelSmall?.copyWith(
                          // color: AppColors.resultwidgetColor,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 28.h),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        context.push(RouteConstants.privacyPolicy);
                        // Navigator.of(context).pop(false);
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.greyDE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                      child: Text(
                        'Learn More',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.errorText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    flex: 2,
                    child: BundlegramButton(
                      text: 'I Understand, Continue',
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityPoint(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Icon(
            icon,
            color: Colors.green.shade600,
            size: 16.w,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                description,
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.resultwidgetColor,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
