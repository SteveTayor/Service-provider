import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItemGrid extends StatefulWidget {
  final List<Map<String, String>> bundles;
  final Map<String, String>? selectedBundle;
  final Function(Map<String, String>) onBundleSelected;
  final bool showContinueButton;

  const ProductItemGrid({
    this.showContinueButton = false,
    required this.bundles,
    this.selectedBundle,
    required this.onBundleSelected,
    super.key,
  });

  @override
  State<ProductItemGrid> createState() => _ProductItemGridState();
}

class _ProductItemGridState extends State<ProductItemGrid> {
  int? _selectedIndex;

  Widget _buildBundleOption(Map<String, String> bundle, int index) {
    final isSelected = _selectedIndex == index;
    final dataKey = bundle.keys.firstWhere((k) => k == 'data' || k == 'amount',
        orElse: () => 'amount');
    final durationKey = bundle.keys.contains('duration') ? 'duration' : '';

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        // widget.onBundleSelected?.call(bundle);
        widget.onBundleSelected(bundle);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : AppColors.grey83.withOpacity(0.2),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8.r),
          color: const Color(0xffEEF3FF),
        ),
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              bundle[dataKey]!,
              style: context.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.primaryColor : AppColors.grey83,
              ),
            ),
            if (durationKey.isNotEmpty)
              Column(
                children: [
                  4.verticalSpace,
                  Text(
                    bundle[durationKey]!,
                    style: context.textTheme.bodySmall!.copyWith(
                      color: AppColors.grey83,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        24.verticalSpace,
        Flexible(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 20.h,
              crossAxisSpacing: 10.w,
              childAspectRatio: 1.2,
            ),
            itemCount: widget.bundles.length,
            itemBuilder: (context, index) =>
                _buildBundleOption(widget.bundles[index], index),
          ),
        ),
        24.verticalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amount',
              style: context.textTheme.bodySmall,
            ),
            Text(
              widget.bundles[_selectedIndex!].values
                  .first, // Placeholder, update dynamically
              style: context.textTheme.bodySmall!.copyWith(
                color: AppColors.grey19,
              ),
            ),
          ],
        ).withContainer(
          width: context.width,
          color: AppColors.greyD0.withOpacity(0.3),
          padding: context.symmetricPadding(12, 12),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.greyD0),
        ),
        24.verticalSpace,
      ],
    );
  }
}
