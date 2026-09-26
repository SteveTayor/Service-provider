import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/subproduct_ext.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_product_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataPlanSelector extends ConsumerStatefulWidget {
  const DataPlanSelector({super.key, required this.serviceType});
  final PlatformProductType serviceType;

  @override
  ConsumerState<DataPlanSelector> createState() => _DataPlanSelectorState();
}

class _DataPlanSelectorState extends ConsumerState<DataPlanSelector> {
  bool _expanded = false;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(platformProductProvider(widget.serviceType));
    final notifier = ref.read(
      platformProductProvider(widget.serviceType).notifier,
    );

    final base = state.selectedDataType != null
        ? state.subProducts
              .where((e) => e.dataType == state.selectedDataType)
              .toList()
        : state.subProducts;
    final sorted = base.where((e) => e.cleanedSubName.isNotEmpty).toList()
      ..sort((a, b) {
        final p = a.sortPriority.compareTo(b.sortPriority);
        return p != 0 ? p : a.sortSizeInMb.compareTo(b.sortSizeInMb);
      });

    final query = _searchController.text.trim().toLowerCase();
    final filtered = query.isEmpty
        ? sorted
        : sorted
              .where((e) => (e.subName ?? '').toLowerCase().contains(query))
              .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        15.verticalSpace,
        Text(
          'SELECT DATA PLAN',
          style: context.textTheme.bodySmall?.copyWith(color: AppColors.grey80),
        ),
        8.verticalSpace,
        InkWell(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: _expanded ? AppColors.primaryColor : AppColors.greyD0,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  state.selectedSubProduct?.displayName ??
                      'Choose a data plan...',
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: state.selectedSubProduct == null
                        ? AppColors.grey8E
                        : AppColors.grey19,
                  ),
                ),
                Icon(
                  _expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
              ],
            ),
          ),
        ),
        if (_expanded) ...[
          8.verticalSpace,
          AppTextField(
            controller: _searchController,
            hintText: 'Search plan (e.g. 1GB, 2GB, 30 days)...',
            decoration: const InputDecoration().search(),
            onChange: (_) => setState(() {}),
          ),
          8.verticalSpace,
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 280.h),
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 25.h),
              itemCount: filtered.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, color: AppColors.greyEE),
              itemBuilder: (_, i) {
                final item = filtered[i];
                final originalPrice = double.tryParse(item.subPrice ?? '') ?? 0;
                final discountPercent =
                    double.tryParse(item.userPercent ?? '') ?? 0;
                final hasDiscount = discountPercent > 0 && originalPrice > 0;
                final discountedPrice = hasDiscount
                    ? originalPrice - (originalPrice * discountPercent / 100)
                    : originalPrice;

                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    item.displayName,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        item.duration ?? '',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.grey80,
                        ),
                      ),
                      if (hasDiscount) ...[
                        8.horizontalSpace,
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.success.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            '${discountPercent.toStringAsFixed(discountPercent.truncateToDouble() == discountPercent ? 0 : 1)}% OFF',
                            style: context.textTheme.labelSmall?.copyWith(
                              color: AppColors.success,
                              fontWeight: FontWeight.w600,
                              fontSize: 9.sp,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '₦${discountedPrice.toStringAsFixed(2)}',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (hasDiscount)
                        Text(
                          '₦${originalPrice.toStringAsFixed(2)}',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: AppColors.grey80,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 10.sp,
                          ),
                        ),
                    ],
                  ),
                  onTap: () {
                    notifier.selectSubProduct(item);
                    setState(() => _expanded = false);
                  },
                );
              },
            ),
          ),
        ],
        if (state.selectedSubProduct != null &&
            state.selectedSubProduct!.subPrice != null &&
            state.selectedSubProduct!.subPrice!.isNotEmpty) ...[
          24.verticalSpace,
          Container(
            width: context.width,
            padding: context.symmetricPadding(20, 12),
            decoration: BoxDecoration(
              color: AppColors.greyD0.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.greyD0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Amount', style: context.textTheme.bodySmall),
                8.verticalSpace,
                Text(
                  '₦${state.amountController.text.trim()}',
                  style: context.textTheme.bodySmall!.copyWith(
                    color: AppColors.grey19,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
