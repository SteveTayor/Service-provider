import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_formatter.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_input_formatter.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/data/models/products/get_sub_products_response.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_product_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_loader.dart';
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
        serviceType == PlatformProductType.betting ||
        serviceType == PlatformProductType.electricity;

    // final validList =
    // products.where((e) => e.dataSize != null && e.dataSize! > 0).toList();
    final validList =
        products.where((e) => e.dataSize != null && e.dataSize! > 0).toList()
          ..sort((a, b) {
            // Convert everything to MB for sorting
            double sizeInMB(SubProduct p) {
              String? name = p.subName?.toUpperCase();

              // Priority: Check TB, then GB, else assume MB
              if (name != null && name.contains('TB')) {
                return p.dataSize! * 1024 * 1024; // TB to MB
              } else if (name != null && name.contains('GB')) {
                return p.dataSize! * 1024; // GB to MB
              } else {
                return p.dataSize!; // already in MB
              }
            }

            return sizeInMB(a).compareTo(sizeInMB(b));
          });

    if (!isAmountPresetGrid && state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!isAmountPresetGrid && state.isLoading) return AppLoader();
    // if (!isAmountPresetGrid && validList.isEmpty && !state.isLoading)
    //   return const Empty();

    if (!isAmountPresetGrid && validList.isEmpty) {
      // For mobileData we attempted to fetch subProducts — show a friendly message.
      // Avoid telling users to select beneficiary if we already tried to auto-detect.
      final message = serviceType == PlatformProductType.mobileData
          ? 'No bundles available for the selected provider.'
          : 'No available bundles at the moment.';

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(message, style: context.textTheme.bodySmall),
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
            childAspectRatio: isAmountPresetGrid ? 1.6 : 1.4,
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
                    '${formatAmount(amount)}',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      // fontSize: 14,
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

              String formatNumber(double value) {
                return value.toStringAsFixed(1).endsWith('.0')
                    ? value.toStringAsFixed(0)
                    : value.toStringAsFixed(1);
              }

              String formattedData;
              if (item.dataSize! < 0.1) {
                formattedData = '${formatNumber(item.dataSize! * 10000)}MB';
              } else if (item.dataSize! < 1) {
                formattedData = '${formatNumber(item.dataSize! * 1000)}MB';
              } else if (item.subName?.contains('TB') == true) {
                formattedData = '${formatNumber(item.dataSize!)}TB';
              } else {
                formattedData = '${formatNumber(item.dataSize!)}GB';
              }

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
                          style: context.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            // fontSize: 14,
                            color: isSelected
                                ? AppColors.primaryColor
                                : AppColors.grey83,
                          ),
                        ),
                      ),
                      4.verticalSpace,
                      Text(
                        item.duration ?? '',
                        style: context.textTheme.bodySmall?.copyWith(
                          // fontSize: 14.sp,
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
            inputFormatters: [CurrencyTextInputFormatter()],
            keyboardType: TextInputType.number,
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
            serviceType == PlatformProductType.mobileData &&
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
                  state.selectedSubProduct != null
                      ? '₦${state.amountController.text.trim()}'
                      : '₦0.00',
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
                      // HapticFeedback.lightImpact() ;
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
//                     fontSize: 20,
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
//                       fontSize: 12,
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