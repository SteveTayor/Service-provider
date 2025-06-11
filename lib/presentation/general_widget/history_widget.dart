import 'package:bundlegram/presentation/features/transaction/screens/widgets/emptytransaction_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';

typedef ItemBuilder<T> = Widget Function(BuildContext, T, int);
typedef OnSearchChanged = void Function(String);
typedef OnFilterPressed = void Function(BuildContext);

class HistoryScreen<T> extends ConsumerStatefulWidget {
  const HistoryScreen({
    Key? key,
    required this.titleText,
    required this.items,
    required this.isLoading,
    required this.onSearchChanged,
    required this.onFilterPressed,
    required this.itemBuilder,
    required this.onItemTap,
    this.emptyWidget,
    this.separator,
    this.searchHint = 'Search...',
  }) : super(key: key);

  final String titleText;
  final List<T> items;
  final bool isLoading;
  final OnSearchChanged onSearchChanged;
  final OnFilterPressed onFilterPressed;
  final ItemBuilder<T> itemBuilder;
  final void Function(T) onItemTap;
  final Widget? emptyWidget;
  final Widget? separator;
  final String searchHint;

  @override
  ConsumerState<HistoryScreen<T>> createState() => _HistoryScreenState<T>();
}

class _HistoryScreenState<T> extends ConsumerState<HistoryScreen<T>> {
  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      appBar: BundlegramAppbar(
        showBackButton: true,
        titleText: widget.titleText,
        trailing: GestureDetector(
          onTap: () => widget.onFilterPressed(context),
          child: Text(
            'Filter',
            style: context.textTheme.bodySmall!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: AppTextField(
              decoration: const InputDecoration().search(),
              onChange: widget.onSearchChanged,
              label: 'Search...',
            ),
          ),
          16.verticalSpace,
          Expanded(
            child: widget.isLoading
                ? _buildLoadingShimmers()
                : widget.items.isEmpty
                    ? (widget.emptyWidget ??
                        const Center(child: EmptytransactionWidget()
                            // Column(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Icon(Icons.history,
                            //         size: 64.w, color: AppColors.grey8E),
                            //     8.verticalSpace,
                            //     Text(
                            //       'No items found',
                            //       style: context.textTheme.bodySmall!
                            //           .copyWith(color: AppColors.grey8E),
                            //     ),
                            //   ],
                            // ),
                            ))
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        itemCount: widget.items.length,
                        separatorBuilder: (_, __) =>
                            widget.separator ?? SizedBox(height: 12.h),
                        itemBuilder: (ctx, i) {
                          final item = widget.items[i];
                          return GestureDetector(
                            onTap: () => widget.onItemTap(item),
                            child: widget.itemBuilder(ctx, item, i),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingShimmers() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ListView.separated(
        itemCount: 3,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          return Container(
            height: 60.h,
            decoration: BoxDecoration(
              color: AppColors.greyD0.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                16.horizontalSpace,
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: AppColors.greyD0.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120.w,
                        height: 14.h,
                        decoration: BoxDecoration(
                          color: AppColors.greyD0.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      8.verticalSpace,
                      Container(
                        width: 80.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: AppColors.greyD0.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 60.w,
                  height: 14.h,
                  decoration: BoxDecoration(
                    color: AppColors.greyD0.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                16.horizontalSpace,
              ],
            ),
          );
        },
      ),
    );
  }
}
