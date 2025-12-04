import 'dart:math';
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

  const PinContent({Key? key, this.compact = false, this.onComplete})
      : super(key: key);

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
    final controller = ref.watch(pinControllerProvider);
    final isFilled = controller.pin[index].isNotEmpty;
    final dotSize = widget.compact ? 18.w : 24.w;

    return Container(
      width: dotSize,
      height: dotSize,
      margin: EdgeInsets.symmetric(horizontal: (widget.compact ? 6.w : 8.w)),
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
    final padding = widget.compact ? 12.w : 20.w;
    final style = context.textTheme.titleMedium!.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: widget.compact ? 18 : null,
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
    final controller = ref.watch(pinControllerProvider);

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: widget.compact ? 16.w : 20.w,
          vertical: widget.compact ? 12.h : 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: widget.compact ? 6.h : 10.h),
          Text(
            'The PIN will be used to authorize transactions.',
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall!.copyWith(
              color: AppColors.grey33,
              height: 1.4,
              fontSize: widget.compact ? 12 : null,
            ),
          ),
          SizedBox(height: widget.compact ? 18.h : 40.h),
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
            SizedBox(height: widget.compact ? 12.h : 20.h),
            Text(
              controller.errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.errorText,
                fontSize: 14,
              ),
            ),
          ],
          SizedBox(height: widget.compact ? 8.h : 24.h),
          // keypad
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: 1.2,
            mainAxisSpacing: widget.compact ? 8.h : 10.h,
            crossAxisSpacing: widget.compact ? 8.w : 10.w,
            padding:
                EdgeInsets.symmetric(horizontal: widget.compact ? 8.w : 20.w),
            children: [
              ...List.generate(
                  9, (index) => _buildNumberButton('${index + 1}')),
              SizedBox(width: 24, height: 24),
              _buildNumberButton('0'),
              IconButton(
                onPressed: () =>
                    ref.read(pinControllerProvider.notifier).deletePin(),
                icon: const Icon(Icons.backspace_outlined,
                    size: 24, color: AppColors.grey83),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
