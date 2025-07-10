import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_formatter.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/data/models/products/get_sub_products_response.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_product_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItemGrid extends ConsumerWidget {
  const ProductItemGrid({
    Key? key,
    required this.serviceType,
    this.products = const [],
    this.amounts = const [],
  }) : super(key: key);

  final PlatformProductType serviceType;
  final List<SubProduct> products;
  final List<int> amounts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(platformProductProvider(serviceType));
    final notifier = ref.read(platformProductProvider(serviceType).notifier);

    final isAmountPresetGrid = serviceType == PlatformProductType.airtime ||
        serviceType == PlatformProductType.betting;

    final validList =
        products.where((e) => e.dataSize != null && e.dataSize! > 0).toList();

    if (!isAmountPresetGrid && state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!isAmountPresetGrid && validList.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('No available bundles at the moment.'),
      );
    }

    final selectedAmount = int.tryParse(state.amountController.text);

    return Column(
      children: [
        24.verticalSpace,
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 20.h,
            crossAxisSpacing: 10.w,
            childAspectRatio: isAmountPresetGrid ? 1.5 : 1.3,
          ),
          itemCount: isAmountPresetGrid ? amounts.length : validList.length,
          itemBuilder: (_, i) {
            if (isAmountPresetGrid) {
              final amount = amounts[i];
              final isSelected = state.selectedPresetAmount == amount;

              return GestureDetector(
                onTap: () => notifier.selectPresetAmount(amount),
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
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Text(
                    '${CurrencyFormatter.format(amount)}',
                    style: context.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.grey83,
                    ),
                  ),
                ),
              );
            } else {
              final item = validList[i];
              final isSelected = state.selectedSubProduct?.id == item.id;

              final formattedData = item.dataSize! < 0.1
                  ? '${(item.dataSize! * 10000).toStringAsFixed(0)}MB'
                  : item.dataSize! < 1
                      ? '${(item.dataSize! * 1000).toStringAsFixed(0)}MB'
                      : item.subName!.contains('TB')
                          ? '${item.dataSize!.toStringAsFixed(0)}TB'
                          : '${item.dataSize!.toStringAsFixed(0)}GB';

              return GestureDetector(
                onTap: () => notifier.selectSubProduct(item),
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
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          formattedData,
                          // textAlign: TextAlign.start,
                          style: context.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: isSelected
                                ? AppColors.primaryColor
                                : AppColors.grey83,
                          ),
                        ),
                      ),
                      4.verticalSpace,
                      Text(
                        item.duration ?? '',
                        style: context.textTheme.bodySmall!.copyWith(
                          fontSize: 10.sp,
                          color: AppColors.grey83,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
        if (isAmountPresetGrid) ...[
          24.verticalSpace,
          AppTextField(
            hintText: 'Enter amount',
            controller: state.amountController,
            prefixIcon: Padding(
              padding: context.symmetricPadding(24, 0),
              child: Text('₦', style: context.textTheme.bodyMedium),
            ),
            onChange: (_) {
              notifier
                  .clearSelectedPresetAmount(); // Optional: deselect preset if user types
            },
          ),
        ],
        if (state.selectedSubProduct != null &&
            serviceType == PlatformProductType.mobileData) ...[
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
                  '₦${state.selectedSubProduct!.subPrice}',
                  style: context.textTheme.bodySmall!.copyWith(
                    color: AppColors.grey19,
                  ),
                ),
              ],
            ),
          ),
        ],
        24.verticalSpace,
      ],
    );
  }

  String formatDataSize(double sizeInGb) {
    if (sizeInGb >= 1024) {
      return '${(sizeInGb / 1024).toStringAsFixed(2)}TB';
    } else if (sizeInGb >= 1) {
      return '${sizeInGb.toStringAsFixed(2)}GB';
    } else if (sizeInGb >= 0.001) {
      return '${(sizeInGb * 1000).toStringAsFixed(2)}MB';
    } else {
      return '${(sizeInGb * 1000000).toStringAsFixed(2)}KB';
    }
  }
}




// import 'package:bundlegram/core/extensions/context_extensions.dart';
// import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
// import 'package:bundlegram/core/extensions/widget_extensions.dart';
// import 'package:bundlegram/core/utils/colors.dart';
// import 'package:bundlegram/core/utils/enums.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ProductItemGrid extends StatefulWidget {
//   final List<Map<String, String>> bundles;
//   final Map<String, String>? selectedBundle;
//   final Function(Map<String, String>) onBundleSelected;
//   final bool showContinueButton;
//   final PlatformProductType serviceType;

//   const ProductItemGrid({
//     Key? key,
//     this.showContinueButton = false,
//     required this.bundles,
//     this.selectedBundle,
//     required this.onBundleSelected,
//     required this.serviceType,
//   }) : super(key: key);

//   @override
//   State<ProductItemGrid> createState() => _ProductItemGridState();
// }

// class _ProductItemGridState extends State<ProductItemGrid> {
//   int? _selectedIndex;

//   @override
//   void initState() {
//     super.initState();
//     // If a bundle was pre-selected, find its index
//     _selectedIndex = widget.selectedBundle != null
//         ? widget.bundles.indexOf(widget.selectedBundle!)
//         : 0;
//   }

//   Widget _buildBundleOption(Map<String, String> bundle, int index) {
//     final isSelected = _selectedIndex == index;
//     // Pick the key that represents the main label
//     final dataKey = bundle.keys.firstWhere(
//       (k) => k == 'data' || k == 'amount',
//       orElse: () => bundle.keys.first,
//     );
//     final hasDuration =
//         bundle.containsKey('duration') && bundle['duration']!.isNotEmpty;

//     return GestureDetector(
//       onTap: () {
//         setState(() => _selectedIndex = index);
//         widget.onBundleSelected(bundle);
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: const Color(0xffEEF3FF),
//           border: Border.all(
//             color: isSelected
//                 ? AppColors.primaryColor
//                 : AppColors.grey83.withOpacity(0.2),
//             width: 1.5,
//           ),
//           borderRadius: BorderRadius.circular(8.r),
//         ),
//         padding: EdgeInsets.symmetric(vertical: 16.h),
//         child: Padding(
//           padding: EdgeInsets.only(left: 8),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Flexible(
//                 child: Text(
//                   bundle[dataKey]!,
//                   style: context.textTheme.titleMedium!.copyWith(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 20.sp,
//                     color:
//                         isSelected ? AppColors.primaryColor : AppColors.grey83,
//                   ),
//                 ),
//               ),
//               if (hasDuration) ...[
//                 4.verticalSpace,
//                 Flexible(
//                   child: Text(
//                     bundle['duration']!,
//                     style: context.textTheme.bodySmall!.copyWith(
//                       fontSize: 12.sp,
//                       color: AppColors.grey83,
//                     ),
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final currentIndex = _selectedIndex ?? 0;
//     final hasAnyDuration = widget.bundles.any(
//       (b) => b['duration']?.isNotEmpty == true,
//     );
//     return Column(
//       children: [
//         24.verticalSpace,
//         // Grid of bundle options
//         GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           padding: EdgeInsets.zero,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3,
//             mainAxisSpacing: 20.h,
//             crossAxisSpacing: 10.w,
//             childAspectRatio: hasAnyDuration ? 1.0 : 1.5,
//           ),
//           itemCount: widget.bundles.length,
//           itemBuilder: (ctx, i) => _buildBundleOption(widget.bundles[i], i),
//         ),
//         // Show the selected amount box only if something is selected
//         if (_selectedIndex != null &&
//             (widget.serviceType == PlatformProductType.mobileData)) ...[
//           24.verticalSpace,
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Amount', style: context.textTheme.bodySmall),
//               8.verticalSpace,
//               Text(
//                 // Use the same dataKey logic to retrieve the displayed value
//                 // widget.bundles[_selectedIndex!].entries
//                 //     .firstWhere(
//                 //       (e) => e.key == 'data' || e.key == 'amount',
//                 //       orElse: () =>
//                 //           widget.bundles[_selectedIndex!].entries.first,
//                 //     )
//                 //     .value,

//                 widget.bundles[_selectedIndex!]['price']!,
//                 style: context.textTheme.bodySmall!
//                     .copyWith(color: AppColors.grey19),
//               ),
//             ],
//           ).withContainer(
//             width: context.width,
//             padding: context.symmetricPadding(20, 12),
//             color: AppColors.greyD0.withOpacity(0.3),
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: AppColors.greyD0),
//           )
//         ],
//         24.verticalSpace,
//       ],
//     );
//   }
// }