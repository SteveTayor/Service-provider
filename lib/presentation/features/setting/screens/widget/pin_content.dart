import 'dart:math';
import 'package:bundlegram/core/extensions/responsive_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/features/setting/provider/create_pin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PinContent extends ConsumerStatefulWidget {
  final bool compact;

  final VoidCallback?
      onComplete; // optional hook if caller wants callback when done
  final bool useResponsive;
  const PinContent({
    Key? key,
    this.compact = false,
    this.onComplete,
    this.useResponsive = true,
  }) : super(key: key);

  @override
  ConsumerState<PinContent> createState() => _PinContentState();
}

class _PinContentState extends ConsumerState<PinContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _shakeController;
  late Animation<double> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween(begin: 0.0, end: 24.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_shakeController);

    ref.read(pinControllerProvider.notifier).setShake(_shakeController);
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  Widget _buildPinDot(int index) {
    final r = context.responsive;
    final controller = ref.watch(pinControllerProvider);
    final isFilled = controller.pin[index].isNotEmpty;
    final dotSize = widget.compact
        ? (widget.useResponsive ? r.spacing(18) : 18.w)
        : (widget.useResponsive ? r.spacing(24) : 24.w);

    final marginSize = widget.compact
        ? (widget.useResponsive ? r.spacing(6) : 6.w)
        : (widget.useResponsive ? r.spacing(8) : 8.w);

    return Container(
      width: dotSize,
      height: dotSize,
      margin: EdgeInsets.symmetric(horizontal: marginSize),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isFilled ? AppColors.primaryColor : Colors.transparent,
        border: Border.all(
          color: AppColors.primaryColor,
          width: 1.5,
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    final r = context.responsive;
    final padding = widget.compact
        ? (widget.useResponsive ? r.spacing(12) : 12.w)
        : (widget.useResponsive ? r.spacing(20) : 20.w);
    final fontSiz = widget.compact
        ? (widget.useResponsive ? r.textSize(18) : 18)
        : (widget.useResponsive ? r.textSize(22) : null);
    final style = context.textTheme.titleMedium!.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: fontSiz?.toDouble(),
    );

    return TextButton(
      onPressed: () {
        ref.read(pinControllerProvider.notifier).updatePin(number, context);
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(padding),
        shape: const CircleBorder(),
      ),
      child: Text(number, style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final controller = ref.watch(pinControllerProvider);
    final horizontalPadding = widget.compact
        ? (widget.useResponsive ? r.spacing(16) : 16.w)
        : (widget.useResponsive ? r.spacing(20) : 20.w);

    final verticalPadding = widget.compact
        ? (widget.useResponsive ? r.spacing(12) : 12.h)
        : (widget.useResponsive ? r.spacing(20) : 20.h);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: widget.compact
                ? (widget.useResponsive ? r.spacing(6) : 6.h)
                : (widget.useResponsive ? r.spacing(10) : 10.h),
          ),
          Text(
            'The PIN will be used to authorize transactions.',
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall!.copyWith(
              color: AppColors.grey33,
              height: 1.4,
              fontSize: widget.compact
                  ? (widget.useResponsive ? r.textSize(12) : 12)
                  : (widget.useResponsive ? r.textSize(12) : null),
            ),
          ),
          SizedBox(
            height: widget.compact
                ? (widget.useResponsive ? r.spacing(18) : 18.h)
                : (widget.useResponsive ? r.spacing(40) : 40.h),
          ),

          AnimatedBuilder(
            animation: _shakeController,
            builder: (context, child) {
              final offset = sin(_offsetAnimation.value) * 12;
              return Transform.translate(
                offset: Offset(offset, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, _buildPinDot),
                ),
              );
            },
          ),
          if (controller.errorMessage != null) ...[
            SizedBox(
              height: widget.compact
                  ? (widget.useResponsive ? r.spacing(12) : 12.h)
                  : (widget.useResponsive ? r.spacing(20) : 20.h),
            ),
            Text(
              controller.errorMessage!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.errorText,
                fontSize: widget.useResponsive ? r.textSize(14) : 14,
              ),
            ),
          ],

          SizedBox(
            height: widget.compact
                ? (widget.useResponsive ? r.spacing(8) : 8.h)
                : (widget.useResponsive ? r.spacing(24) : 24.h),
          ),
          // keypad
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: widget.useResponsive
                ? r.when(
                    phone: 1.2,
                    tablet: widget.compact ? 1.3 : 1.5,
                    desktop: widget.compact ? 1.5 : 1.8,
                  )
                : 1.2,
            mainAxisSpacing: widget.compact
                ? (widget.useResponsive ? r.spacing(8) : 8.h)
                : (widget.useResponsive ? r.spacing(10) : 10.h),
            crossAxisSpacing: widget.compact
                ? (widget.useResponsive ? r.spacing(8) : 8.w)
                : (widget.useResponsive ? r.spacing(10) : 10.w),
            padding: EdgeInsets.symmetric(
              horizontal: widget.compact
                  ? (widget.useResponsive ? r.spacing(8) : 8.w)
                  : (widget.useResponsive ? r.spacing(20) : 20.w),
            ),
            children: [
              ...List.generate(
                  9, (index) => _buildNumberButton('${index + 1}')),
              // Empty space
              SizedBox(
                width: widget.useResponsive ? r.spacing(24) : 24,
                height: widget.useResponsive ? r.spacing(24) : 24,
              ),
              _buildNumberButton('0'),
              IconButton(
                onPressed: () =>
                    ref.read(pinControllerProvider.notifier).deletePin(),
                icon: Icon(Icons.backspace_outlined,
                    size: widget.useResponsive ? r.iconSize(base: 24) : 24,
                    color: AppColors.grey83),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
