import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_loader.dart';
import 'package:flutter/material.dart';
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
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        final type = _tabController.index == 0 ? 'prepaid' : 'postpaid';
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
        AppTextField(
          hintText: allowsFreeText
              ? widget.inputHint
              : (state.selectedProduct?.productName ?? 'Select biller'),
          readOnly: !allowsFreeText,
          controller: state.firstInputController,
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
        if (widget.serviceType == PlatformProductType.betting) ...[
          24.verticalSpace,
          AppTextField(
            hintText: 'Enter User ID',
            controller: state.secondaryInputController,
            onChange: (val) {
              notifier.validateBill(
                context,
                val,
                state.selectedSubProduct?.id ?? state.selectedProduct?.id,
                state.selectedSubProduct?.autoSubProdId,
              );
            },
            suffixIcon: state.isValidating
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : state.billValidated
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : null,
          ),
          if (state.validatedName != null) ...[
            8.verticalSpace,
            Text(
              'Validated: ${state.validatedName}',
              style: context.textTheme.bodySmall!.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ],
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
        ],
        if (state.dropdownOptions.isNotEmpty) ...[
          24.verticalSpace,
          AppDropdown(
            title: state.selectedDataType ?? widget.dropdownHint!,
            options: state.dropdownOptions,
            selected: state.selectedDataType,
            onChanged: (val) => notifier.selectDataType(val!),
          ),
        ],
        if (
            // widget.secondaryInputHint != null &&
            widget.serviceType != PlatformProductType.airtime &&
                widget.serviceType != PlatformProductType.mobileData) ...[
          24.verticalSpace,
          AppTextField(
            hintText: widget.secondaryInputHint!,
            controller: state.secondaryInputController,
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
