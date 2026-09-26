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
                  state.selectedSubProduct?.subName ?? 'Choose a data plan...',
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
              itemCount: filtered.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, color: AppColors.greyEE),
              itemBuilder: (_, i) {
                final item = filtered[i];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    item.displayName,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    item.duration ?? '',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: AppColors.grey80,
                    ),
                  ),

                  // "% OFF" badge (e.g. "₦895.50" / "₦900.00" / "0.5% OFF").
                  trailing: Text(
                    '₦${item.subPrice ?? ''}',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
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
      ],
    );
  }
}
