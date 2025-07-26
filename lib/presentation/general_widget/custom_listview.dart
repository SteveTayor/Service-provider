// import 'package:bundlegram/core/utils/colors.dart';
// import 'package:bundlegram/presentation/features/transaction/screens/widgets/emptytransaction_widget.dart';
// import 'package:bundlegram/presentation/general_widget/app_loader.dart';
// import 'package:bundlegram/presentation/general_widget/custom_listview_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CustomListView<T> extends StatelessWidget {
//   const CustomListView({
//     super.key,
//     required this.items,
//     required this.itemBuilder,
//     this.isLoading = false,
//     this.onItemTap,
//     this.onRefresh,
//     this.emptyWidget,
//     this.errorWidget,
//     this.loadingWidget,
//     this.separatorBuilder,
//     this.shrinkWrap = false,
//     this.physics,
//     this.padding,
//     this.backgroundColor,
//     this.itemBackgroundColor,
//     this.showDividers = false,
//     this.loadingItemCount = 5,
//     this.loadingItemHeight = 80.0,
//     this.header,
//     this.footer,
//   });

//   final List<T> items;
//   final Widget Function(T item, int index) itemBuilder;
//   final bool isLoading;
//   final Function(T item, int index)? onItemTap;
//   final Future<void> Function()? onRefresh;
//   final Widget? emptyWidget;
//   final Widget? errorWidget;
//   final Widget? loadingWidget;
//   final Widget Function(BuildContext context, int index)? separatorBuilder;
//   final bool shrinkWrap;
//   final ScrollPhysics? physics;
//   final EdgeInsetsGeometry? padding;
//   final Color? backgroundColor;
//   final Color? itemBackgroundColor;
//   final bool showDividers;
//   final int loadingItemCount;
//   final double loadingItemHeight;
//   final Widget? header;
//   final Widget? footer;

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return _buildLoadingList();
//     }

//     if (items.isEmpty) {
//       return _buildEmptyState();
//     }

//     return _buildList();
//   }

//   Widget _buildLoadingList() {
//     return loadingWidget ??
//         Container(
//           color: backgroundColor,
//           child: ListView.separated(
//             shrinkWrap: shrinkWrap,
//             physics: physics ?? const NeverScrollableScrollPhysics(),
//             padding: padding ?? EdgeInsets.all(16.w),
//             itemCount: loadingItemCount,
//             separatorBuilder: (context, index) => SizedBox(height: 12.h),
//             itemBuilder: (context, index) {
//               return Container(
//                 height: loadingItemHeight,
//                 decoration: BoxDecoration(
//                   color: AppColors.greyD0.withOpacity(0.3),
//                   borderRadius: BorderRadius.circular(8.r),
//                 ),
//                 child: Center(
//                   child: AppLoader(
//                     size: 20.w,
//                     color: AppColors.primaryColor,
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//   }

//   Widget _buildEmptyState() {
//     return emptyWidget ??
//         Container(
//           color: backgroundColor,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 EmptytransactionWidget(),
//                 SizedBox(height: 16.h),
//                 Text(
//                   'No items found',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: AppColors.grey8E,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//   }

//   Widget _buildList() {
//     Widget listView = ListView.separated(
//       shrinkWrap: shrinkWrap,
//       physics: physics,
//       padding: padding ?? EdgeInsets.symmetric(vertical: 8.h),
//       itemCount:
//           items.length + (header != null ? 1 : 0) + (footer != null ? 1 : 0),
//       separatorBuilder: (context, index) {
//         // Handle separator for header
//         if (header != null && index == 0) {
//           return SizedBox(height: 16.h);
//         }

//         // Handle separator for footer
//         if (footer != null && index == items.length) {
//           return SizedBox(height: 16.h);
//         }

//         // Adjust index for actual items when header exists
//         final adjustedIndex = header != null ? index - 1 : index;

//         return separatorBuilder?.call(context, adjustedIndex) ??
//             SizedBox(height: showDividers ? 0 : 8.h);
//       },
//       itemBuilder: (context, index) {
//         // Header
//         if (header != null && index == 0) {
//           return header!;
//         }

//         // Footer
//         if (footer != null &&
//             index == items.length + (header != null ? 1 : 0)) {
//           return footer!;
//         }

//         // Adjust index for actual items
//         final adjustedIndex = header != null ? index - 1 : index;
//         final item = items[adjustedIndex];

//         return CustomListItem<T>(
//           item: item,
//           backgroundColor: itemBackgroundColor,
//           showDivider: showDividers,
//           onTap:
//               onItemTap != null ? () => onItemTap!(item, adjustedIndex) : null,
//           itemBuilder: (item) => itemBuilder(item, adjustedIndex),
//         );
//       },
//     );

//     if (onRefresh != null) {
//       listView = RefreshIndicator(
//         onRefresh: onRefresh!,
//         child: listView,
//       );
//     }

//     return Container(
//       color: backgroundColor,
//       child: listView,
//     );
//   }
// }
