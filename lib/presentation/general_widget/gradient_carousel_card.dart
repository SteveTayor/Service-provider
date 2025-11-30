import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable gradient promotional card widget
class GradientPromoCard extends StatelessWidget {
  /// Main title text
  final String title;

  /// Subtitle/description text
  final String subtitle;

  /// Button text
  final String buttonText;

  /// Image asset path (from Assets.images.xxx.path)
  final String imagePath;

  /// Callback when card or button is tapped
  final VoidCallback onTap;

  /// Gradient colors (defaults to red gradient)
  final List<Color> gradientColors;

  /// Optional custom height
  final double? height;

  /// Optional custom width
  final double? width;

  const GradientPromoCard({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.imagePath,
    required this.onTap,
    this.gradientColors = const [Color(0xFFE24934), Color(0xFF3A0700)],
    this.height,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 159.h,
        width: width ?? double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
          borderRadius: BorderRadius.circular(8.r),
          // boxShadow: [
          //   BoxShadow(
          //     color: gradientColors.first.withOpacity(0.3),
          //     blurRadius: 20,
          //     offset: const Offset(0, 10),
          //   ),
          // ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Stack(
            children: [
              // Content Section (Left Side)
              Positioned(
                left: 24.w,
                top: 24.h,
                bottom: 24.h,
                child: SizedBox(
                  width: 200.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title
                      Text(
                        title,
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      16.verticalSpace,

                      // Subtitle
                      Text(
                        subtitle,
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.clip,
                      ),
                      const Spacer(),

                      // Button
                      GestureDetector(
                        onTap: onTap,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32.r),
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            buttonText,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: FontFamily.mabryPro,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Image Section (Right Side)
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Image.asset(
                  imagePath,
                  height: double.infinity,
                  fit: BoxFit.contain,
                  alignment: Alignment.centerRight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Variant with more compact design
class CompactGradientPromoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final String imagePath;
  final VoidCallback onTap;
  final List<Color> gradientColors;

  const CompactGradientPromoCard({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.imagePath,
    required this.onTap,
    this.gradientColors = const [Color(0xFFE24934), Color(0xFF3A0700)],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 160.h,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  8.verticalSpace,
                  SizedBox(
                    width: 180.w,
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      maxLines: 2,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(25.r),
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              top: 0,
              child: Image.asset(
                imagePath,
                height: 160.h,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
