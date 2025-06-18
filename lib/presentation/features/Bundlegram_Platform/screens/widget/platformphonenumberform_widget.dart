// lib/presentation/features/Bundlegram_Platform/screens/widget/PlatformphonenumberformWidget_widget.dart

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/choosebiller.dart';
import 'package:bundlegram/presentation/general_widget/app_dropdown.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlatformphonenumberformWidget extends StatefulWidget {
  const PlatformphonenumberformWidget({
    super.key,
    this.inputHint,
    this.secondaryInputHint,
    this.dropdownHint,
    this.onProviderSelected,
    this.initialProviderImage,
    this.secondaryInputfieldController,
    this.firstInputfieldController,
    this.dropdownOptions,
    this.onPaymentTypeSelected,
    required this.serviceType,
  });

  final String? inputHint;
  final String? secondaryInputHint;
  final String? dropdownHint;
  final Function(String?)? onProviderSelected;
  final String? initialProviderImage;
  final TextEditingController? secondaryInputfieldController;
  final TextEditingController? firstInputfieldController;
  final PlatformProductType serviceType;
  final List<String>? dropdownOptions;
  final Function(String?)? onPaymentTypeSelected;

  @override
  State<PlatformphonenumberformWidget> createState() =>
      _PlatformphonenumberformWidgetState();
}

class _PlatformphonenumberformWidgetState
    extends State<PlatformphonenumberformWidget>
    with SingleTickerProviderStateMixin {
  String? _selectedProviderImage;
  String? _selectedProviderName;
  String? _selectedDropdown;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    final opts = widget.dropdownOptions;
    _selectedDropdown = (opts != null && opts.isNotEmpty) ? opts.first : null;
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      final selectedType = _tabController.index == 0 ? 'prepaid' : 'postpaid';
      widget.onPaymentTypeSelected?.call(selectedType);
    });
    _selectedProviderImage = widget.initialProviderImage;
    _selectedProviderName = null;
  }

  @override
  void dispose() {
    if (widget.serviceType == PlatformProductType.electricity) {
      _tabController.dispose();
    }
    super.dispose();
  }

  bool get _allowsFreeText =>
      widget.serviceType == PlatformProductType.airtime ||
      widget.serviceType == PlatformProductType.mobileData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          hintText: _allowsFreeText
              ? widget.inputHint
              : (_selectedProviderName ?? 'Select biller'),
          readOnly: !_allowsFreeText,
          autofocus: false,
          controller: widget.firstInputfieldController,
          onTap: !_allowsFreeText ? () => _showBillerPicker(context) : null,
          prefixIcon: SizedBox(
            child: GestureDetector(
              onTap: _showBillerPicker,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  16.horizontalSpace,
                  if (_selectedProviderImage != null)
                    _selectedProviderImage!.endsWith('.svg')
                        ? CircleAvatar(
                            radius: 15,
                            child: ClipOval(
                              child: AppSvgIcon(
                                path: _selectedProviderImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Image.asset(_selectedProviderImage!, width: 24)
                  else
                    // (_allowsFreeText == true)
                    //     ? SizedBox(
                    //         width: 24,
                    //         height: 24,
                    //         child: CircleAvatar(
                    //           child: AppSvgIcon(
                    //               path: Assets.svgs.call, fit: BoxFit.fill),
                    //         ),
                    //       )
                    //     :
                    SizedBox.shrink(),
                  8.horizontalSpace,
                  AppSvgIcon(path: Assets.svgs.chevronDown),
                  8.horizontalSpace,
                ],
              ),
            ),
          ),
        ),
        if (widget.serviceType == PlatformProductType.electricity)
          Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: Container(
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Color(0xFFE8EFFF),
                  border: Border.all(
                    width: 1,
                    color: AppColors.primaryColor,
                  ),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent, // Remove default divider
                labelColor: AppColors.primaryColor, // Active tab text color

                labelStyle: context.textTheme.bodySmall,
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: AppColors.black,
                ),
                tabs: [
                  Container(
                      width: 263.w,
                      height: 58.h,
                      decoration: BoxDecoration(),
                      child: Tab(text: 'Prepaid')),
                  Tab(text: 'Postpaid'),
                ],
              ),
            ),
          ),
        if (widget.dropdownOptions != null &&
            widget.dropdownOptions!.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: AppDropdown(
              title: _selectedDropdown ?? widget.dropdownHint!,
              options: widget.dropdownOptions!,
              selected: _selectedDropdown,
              onChanged: (val) {
                setState(() => _selectedDropdown = val);
                widget.onProviderSelected?.call(val);
              },
            ),
          ),
        if (widget.secondaryInputHint != null)
          Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: AppTextField(
              hintText: widget.secondaryInputHint,
              hintStyle: InputDecoration().hintStyle,
              controller: widget.secondaryInputfieldController,
            ),
          ),
      ],
    );
  }

  void _showBillerPicker([_]) {
    context.showBottomSheet(
      child: ChoosebillerWidget(
        serviceType: widget.serviceType,
        onProviderSelected: (path, name) {
          setState(() {
            _selectedProviderImage = path;
            _selectedProviderName = name;
          });
          widget.onProviderSelected?.call(name);
        },
      ),
    );
  }
}
