import 'package:bundlegram/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_product_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_dropdown.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';

class PlatformPhoneNumberFormWidget extends ConsumerStatefulWidget {
  const PlatformPhoneNumberFormWidget({
    Key? key,
    this.inputHint,
    this.secondaryInputHint,
    this.dropdownHint,
    required this.serviceType,
  }) : super(key: key);

  final String? inputHint;
  final String? secondaryInputHint;
  final String? dropdownHint;
  final PlatformProductType serviceType;

  @override
  ConsumerState<PlatformPhoneNumberFormWidget> createState() =>
      _PlatformPhoneNumberFormWidgetState();
}

class _PlatformPhoneNumberFormWidgetState
    extends ConsumerState<PlatformPhoneNumberFormWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    final selected = ref
        .read(platformProductProvider(widget.serviceType))
        .selectedSubProduct;
    if (selected?.subName?.toLowerCase().contains('postpaid') ?? false) {
      _tabController.index = 1;
    }
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        final type = _tabController.index == 0 ? 'prepaid' : 'postpaid';
        final subProduct = ref
            .read(platformProductProvider(widget.serviceType))
            .subProducts
            .firstWhere(
              (e) => e.subName?.toLowerCase().contains(type) ?? false,
            );

        if (subProduct != null) {
          ref
              .read(platformProductProvider(widget.serviceType).notifier)
              .selectSubProduct(subProduct);
        }

        ref
            .read(platformProductProvider(widget.serviceType).notifier)
            .selectPaymentType(type);
      }
    });
  }

  @override
  void dispose() {
    if (widget.serviceType == PlatformProductType.electricity) {
      _tabController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(platformProductProvider(widget.serviceType));
    final notifier =
        ref.read(platformProductProvider(widget.serviceType).notifier);

    final allowsFreeText = widget.serviceType == PlatformProductType.airtime ||
        widget.serviceType == PlatformProductType.mobileData;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Biller selection field (read-only)
        AppTextField(
          hintText: allowsFreeText
              ? 'Enter phone number'
              : state.selectedSubProduct != null
                  ? state.selectedSubProduct?.subName
                  : state.selectedProduct?.productName ?? 'Select biller',
          readOnly: !allowsFreeText,
          controller: state.firstInputController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(11),
            FilteringTextInputFormatter.digitsOnly,
          ],
          onTap:
              allowsFreeText ? null : () => notifier.showBillerPicker(context),
          prefixIcon: GestureDetector(
            onTap: () => notifier.showBillerPicker(context),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                16.horizontalSpace,
                _buildIcon(state.selectedProviderIcon),
                8.horizontalSpace,
                AppSvgIcon(path: Assets.svgs.chevronDown),
                8.horizontalSpace,
              ],
            ),
          ),
        ),

        // Secondary input for betting or cable TV (smart card number)
        // Secondary input for betting, cable TV, electricity, and internet services
        if (widget.serviceType == PlatformProductType.betting ||
            widget.serviceType == PlatformProductType.cableTv ||
            widget.serviceType == PlatformProductType.electricity ||
            widget.serviceType == PlatformProductType.internetServices) ...[
          24.verticalSpace,
          AppTextField(
            hintText: widget.serviceType == PlatformProductType.betting
                ? 'Enter User ID'
                : widget.serviceType == PlatformProductType.cableTv
                    ? 'Enter Smart Card Number'
                    : widget.serviceType == PlatformProductType.electricity
                        ? 'Enter Meter Number'
                        : 'Enter account number', // For internet services
            controller: state.secondaryInputController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ],

        // Electricity prepaid/postpaid tabs
        if (widget.serviceType == PlatformProductType.electricity) ...[
          24.verticalSpace,
          TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: const Color(0xFFE8EFFF),
              border: Border.all(width: 1, color: AppColors.primaryColor),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: AppColors.primaryColor,
            labelStyle: context.textTheme.bodySmall,
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: AppColors.black,
            ),
            tabs: const [Tab(text: 'Prepaid'), Tab(text: 'Postpaid')],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     ChoiceChip(
          //       label: const Text('Prepaid'),
          //       selected: state.selectedSubProduct?.subName
          //               ?.toLowerCase()
          //               .contains('prepaid') ??
          //           false,
          //       onSelected: (selected) {
          //         if (selected) {
          //           final prepaidSubProduct = state.subProducts.firstWhere(
          //             (p) => p.subName!.toLowerCase().contains('prepaid'),
          //           );
          //           notifier.selectSubProduct(prepaidSubProduct);
          //         }
          //       },
          //       selectedColor:
          //           const Color(0xFFE8EFFF), // Background color when selected
          //       labelStyle: TextStyle(
          //         color: AppColors.primaryColor,
          //         fontWeight: FontWeight.w500,
          //         fontSize: 14.sp,
          //       ),
          //       backgroundColor:
          //           Colors.transparent, // Background when not selected
          //       side: BorderSide(
          //         color: state.selectedSubProduct?.subName
          //                     ?.toLowerCase()
          //                     .contains('postpaid') ??
          //                 false
          //             ? AppColors.primaryColor
          //             : Colors.grey.shade300,
          //         width: 1,
          //       ),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8), // Adjust as needed
          //       ),
          //     ),
          //     SizedBox(width: 16.w),
          //     ChoiceChip(
          //       label: const Text('Postpaid'),
          //       selected: state.selectedSubProduct?.subName
          //               ?.toLowerCase()
          //               .contains('postpaid') ??
          //           false,
          //       onSelected: (selected) {
          //         if (selected) {
          //           final postpaidSubProduct = state.subProducts.firstWhere(
          //             (p) => p.subName!.toLowerCase().contains('postpaid'),
          //           );
          //           notifier.selectSubProduct(postpaidSubProduct);
          //         }
          //       },
          //       selectedColor:
          //           const Color(0xFFE8EFFF), // Background color when selected
          //       labelStyle: TextStyle(
          //         color: AppColors.primaryColor,
          //         fontWeight: FontWeight.w500,
          //         fontSize: 14.sp,
          //       ),
          //       backgroundColor:
          //           Colors.transparent, // Background when not selected
          //       side: BorderSide(
          //         color: state.selectedSubProduct?.subName
          //                     ?.toLowerCase()
          //                     .contains('postpaid') ??
          //                 false
          //             ? AppColors.primaryColor
          //             : Colors.grey.shade300,
          //         width: 1,
          //       ),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8), // Adjust as needed
          //       ),
          //     ),
          //   ],
          // ),
        ],

        // Dropdown for dataType (mobile data) or sub_name (cable TV)
        if (state.dropdownOptions.isNotEmpty) ...[
          24.verticalSpace,
          AppDropdown(
            title: state.selectedDataType ?? widget.dropdownHint!,
            options: state.dropdownOptions,
            selected: state.selectedDataType,
            onChanged: (val) => notifier.selectDataType(val!),
          ),
        ] else if (state.subProducts.isNotEmpty &&
            widget.serviceType != PlatformProductType.electricity) ...[
          24.verticalSpace,
          AppDropdown(
            title: state.selectedSubProduct?.subName ?? 'Select package',
            options: state.subProducts.map((e) => e.subName!).toList(),
            selected: state.selectedSubProduct?.subName,
            onChanged: (val) {
              final selected =
                  state.subProducts.firstWhere((e) => e.subName == val);
              notifier.selectSubProduct(selected);
            },
          ),
        ],
      ],
    );
  }

  Widget _buildIcon(String? rawPath) {
    final assetName = ref
        .read(platformProductProvider(widget.serviceType).notifier)
        .normalizeAssetName(rawPath);

    if (assetName != null) {
      if (assetName.endsWith('.svg')) {
        return CircleAvatar(
          radius: 15,
          child: ClipOval(
            child: AppSvgIcon(path: assetName, fit: BoxFit.cover),
          ),
        );
      }
      return Image.asset(assetName,
          width: 24,
          errorBuilder: (_, __, ___) => const Icon(Icons.broken_image));
    }

    if (rawPath != null && rawPath.startsWith('http')) {
      return CircleAvatar(radius: 15, backgroundImage: NetworkImage(rawPath));
    }

    return const CircleAvatar(
      radius: 15,
      child: Icon(Icons.device_unknown, size: 16),
    );
  }
}
