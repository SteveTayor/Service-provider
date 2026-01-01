import 'package:bundlegram/core/extensions/responsive_extensions.dart';
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
  final bool useResponsive;
  const GradientPromoCard({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.imagePath,
    required this.onTap,
    this.gradientColors = const [Color(0xFFE24934), Color(0xFF3A0700)],
    this.height,
    this.width,
    this.useResponsive = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive; // ADD

    final effectiveHeight = height ?? (useResponsive ? r.spacing(129) : 129.h);
    final effectiveWidth = width ?? double.infinity;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: effectiveHeight,
        width: effectiveWidth,
        margin: EdgeInsets.symmetric(
          horizontal: useResponsive ? r.spacing(8) : 8.w, // CHANGED
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
          borderRadius: BorderRadius.circular(
            useResponsive ? r.radiusSize(8) : 8.r, // CHANGED
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            useResponsive ? r.radiusSize(8) : 8.r, // CHANGED
          ),
          child: Stack(
            children: [
              // Content Section (Left Side)
              Positioned(
                left: useResponsive ? r.spacing(24) : 24.w, // CHANGED
                top: useResponsive ? r.spacing(20) : 20.h, // CHANGED
                child: SizedBox(
                  width: useResponsive ? r.spacing(200) : 200.w, // CHANGED
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title
                      Text(
                        title,
                        style: TextStyle(
                          fontSize:
                              useResponsive ? r.textSize(15) : 15, // CHANGED
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontFamily: FontFamily.mabryPro,
                        ),
                      ),
                      SizedBox(
                        height: useResponsive ? r.spacing(6) : 6,
                      ), // CHANGED

                      // Subtitle
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize:
                              useResponsive ? r.textSize(14) : 14, // CHANGED
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontFamily: FontFamily.mabryPro,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.clip,
                      ),
                      SizedBox(
                          height:
                              useResponsive ? r.spacing(16) : 16), // CHANGED

                      // Button
                      GestureDetector(
                        onTap: onTap,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                useResponsive ? r.spacing(18) : 18, // CHANGED
                            vertical:
                                useResponsive ? r.spacing(6) : 6, // CHANGED
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              useResponsive
                                  ? r.radiusSize(32)
                                  : 32.r, // CHANGED
                            ),
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          child: Text(
                            buttonText,
                            style: TextStyle(
                              fontSize: useResponsive
                                  ? r.textSize(14)
                                  : 14, // CHANGED
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
                  colorBlendMode: BlendMode.srcIn,
                  height: useResponsive ? r.spacing(110) : 110.h, // CHANGED
                  fit: BoxFit.cover,
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
