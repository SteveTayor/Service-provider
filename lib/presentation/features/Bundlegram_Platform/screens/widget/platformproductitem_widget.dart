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
    Key? key,
    this.showContinueButton = false,
    required this.bundles,
    this.selectedBundle,
    required this.onBundleSelected,
  }) : super(key: key);

  @override
  State<ProductItemGrid> createState() => _ProductItemGridState();
}

class _ProductItemGridState extends State<ProductItemGrid> {
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    // If a bundle was pre-selected, find its index
    _selectedIndex = widget.selectedBundle != null
        ? widget.bundles.indexOf(widget.selectedBundle!)
        : null;
  }

  Widget _buildBundleOption(Map<String, String> bundle, int index) {
    final isSelected = _selectedIndex == index;
    // Pick the key that represents the main label
    final dataKey = bundle.keys.firstWhere(
      (k) => k == 'data' || k == 'amount',
      orElse: () => bundle.keys.first,
    );
    final hasDuration =
        bundle.containsKey('duration') && bundle['duration']!.isNotEmpty;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedIndex = index);
        widget.onBundleSelected(bundle);
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffEEF3FF),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : AppColors.grey83.withOpacity(0.2),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Padding(
          padding: EdgeInsets.only(left: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  bundle[dataKey]!,
                  style: context.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                    color:
                        isSelected ? AppColors.primaryColor : AppColors.grey83,
                  ),
                ),
              ),
              if (hasDuration) ...[
                4.verticalSpace,
                Flexible(
                  child: Text(
                    bundle['duration']!,
                    style: context.textTheme.bodySmall!.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.grey83,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        24.verticalSpace,
        // Grid of bundle options
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 20.h,
            crossAxisSpacing: 10.w,
            childAspectRatio: 1.0,
          ),
          itemCount: widget.bundles.length,
          itemBuilder: (ctx, i) => _buildBundleOption(widget.bundles[i], i),
        ),
        // Show the selected amount box only if something is selected
        if (_selectedIndex != null) ...[
          24.verticalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Amount', style: context.textTheme.bodySmall),
              8.verticalSpace,
              Text(
                // Use the same dataKey logic to retrieve the displayed value
                widget.bundles[_selectedIndex!].entries
                    .firstWhere(
                      (e) => e.key == 'data' || e.key == 'amount',
                      orElse: () =>
                          widget.bundles[_selectedIndex!].entries.first,
                    )
                    .value,
                style: context.textTheme.bodySmall!
                    .copyWith(color: AppColors.grey19),
              ),
            ],
          ).withContainer(
            width: context.width,
            padding: context.symmetricPadding(20, 12),
            color: AppColors.greyD0.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.greyD0),
          )
        ],
        24.verticalSpace,
      ],
    );
  }
}
