import 'dart:async';

import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/styles.dart';
import 'package:bundlegram/gen/fonts.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// One-time bottom sheet introducing Airtime to Cash, shown once after
/// the first launch following the update that ships the feature.
class AirtimeToCashAnnouncementSheet extends StatefulWidget {
  const AirtimeToCashAnnouncementSheet({super.key});

  @override
  State<AirtimeToCashAnnouncementSheet> createState() =>
      _AirtimeToCashAnnouncementSheetState();
}

class _AirtimeToCashAnnouncementSheetState
    extends State<AirtimeToCashAnnouncementSheet>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      // minChildSize: 0.5,
      // maxChildSize: 0.65,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 28.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Drag handle
                // Container(
                //   width: 36.w,
                //   height: 4.h,
                //   decoration: BoxDecoration(
                //     color: AppColors.greyD0,
                //     borderRadius: BorderRadius.circular(2.r),
                //   ),
                // ),
                24.verticalSpace,
                Text(
                  'NEW FEATURE ✨',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: FontFamily.mabryPro,
                    letterSpacing: 1.2,
                    color: AppColors.primaryColor,
                  ),
                ),
                8.verticalSpace,

                Text(
                  'Turn Airtime Into Cash 💸',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: FontFamily.mabryPro,
                    color: AppColors.black,
                  ),
                ),
                12.verticalSpace,

                // Looping airtime -> cash visual
                SizedBox(
                  height: 72.h,
                  child: _ConvertLoopVisual(controller: _controller),
                ),
                24.verticalSpace,
                Text(
                  'Convert unused airtime to cash directly from Bundlegram. '
                  "It's quick, simple, and you can see your payout before "
                  'confirming.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.mabryPro,
                    color: AppColors.grey8E,
                    height: 1.5,
                  ),
                ),
                28.verticalSpace,

                // Airtime -> Convert -> Cash flow
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _FlowStep(label: 'Airtime', filled: true),
                    _FlowConnector(),
                    _FlowStep(label: 'Convert'),
                    _FlowConnector(),
                    _FlowStep(label: 'Cash', filled: true),
                  ],
                ),
                32.verticalSpace,

                BundlegramButton(
                  text: 'Try Airtime to Cash ',
                  width: double.infinity,
                  height: 35.h,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: FontFamily.mabryPro,
                    fontSize: 13.sp,
                  ),
                  cornerRadius: 10.r,
                  buttonStyle: BundlegramButtonStyle.primary(),
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.push(RouteConstants.airtimeToCash);
                  },
                ),
                10.verticalSpace,

                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Maybe later',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.mabryPro,
                      color: AppColors.grey8E,
                    ),
                  ),
                ),
                20.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }
}

/// A compact looping transition between a SIM/network glyph and a wallet
/// glyph, crossfading through a subtle scale — not a literal lottie
/// animation, kept deliberately minimal.
class _ConvertLoopVisual extends StatelessWidget {
  const _ConvertLoopVisual({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        // 0.0–0.5: show SIM icon, fading out toward 0.5
        // 0.5–1.0: show wallet icon, fading in from 0.5
        final t = controller.value;
        final showingSim = t < 0.5;
        final localT = showingSim ? t / 0.5 : (t - 0.5) / 0.5;
        final opacity = showingSim ? (1 - localT) : localT;
        final scale = 0.9 + (0.1 * (showingSim ? (1 - localT) : localT));

        return Stack(
          alignment: Alignment.center,
          children: [
            _IconBubble(
              icon: Icons.sim_card_rounded,
              opacity: showingSim ? 1 - localT * 0.3 : 0,
              scale: showingSim ? 1 - localT * 0.1 : 0.9,
            ),
            Opacity(
              opacity: 0.9,
              child: Icon(
                Icons.arrow_forward_rounded,
                size: 20.sp,
                color: AppColors.grey80,
              ),
            ),
            _IconBubble(
              icon: Icons.account_balance_wallet_rounded,
              opacity: !showingSim ? 0.3 + localT * 0.7 : 0,
              scale: !showingSim ? 0.9 + localT * 0.1 : 0.9,
              alignment: Alignment.centerRight,
            ),
          ],
        );
      },
    );
  }
}

class _IconBubble extends StatelessWidget {
  const _IconBubble({
    required this.icon,
    required this.opacity,
    required this.scale,
    this.alignment = Alignment.centerLeft,
  });

  final IconData icon;
  final double opacity;
  final double scale;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.w),
        child: Opacity(
          opacity: opacity.clamp(0.0, 1.0),
          child: Transform.scale(
            scale: scale,
            child: Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 26.sp, color: AppColors.primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}

class _FlowStep extends StatelessWidget {
  const _FlowStep({required this.label, this.filled = false});

  final String label;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: filled
            ? AppColors.primaryColor.withOpacity(0.08)
            : AppColors.greyF5,
        borderRadius: BorderRadius.circular(20.r),
        border: filled
            ? Border.all(color: AppColors.primaryColor.withOpacity(0.5))
            : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 9.sp,
          fontWeight: FontWeight.w600,
          fontFamily: FontFamily.mabryPro,
          color: filled ? AppColors.primaryColor : AppColors.grey8E,
        ),
      ),
    );
  }
}

class _FlowConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Icon(
        Icons.arrow_forward_rounded,
        size: 14.sp,
        color: AppColors.grey80,
      ),
    );
  }
}

/// Shows the sheet and returns once it's dismissed.
Future<void> showAirtimeToCashAnnouncementSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.4),
    builder: (context) => const AirtimeToCashAnnouncementSheet(),
  );
}
