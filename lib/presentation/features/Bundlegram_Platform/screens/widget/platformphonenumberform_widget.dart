// lib/presentation/features/Bundlegram_Platform/screens/widget/PlatformphonenumberformWidget_widget.dart

import 'package:bundlegram/core/extensions/context_extensions.dart';
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
    required this.serviceType,
  });

  final String? inputHint;
  final String? secondaryInputHint;
  final String? dropdownHint;
  final Function(String?)? onProviderSelected;
  final String? initialProviderImage;
  final TextEditingController? secondaryInputfieldController;
  final PlatformProductType serviceType;

  @override
  State<PlatformphonenumberformWidget> createState() =>
      _PlatformphonenumberformWidgetState();
}

class _PlatformphonenumberformWidgetState
    extends State<PlatformphonenumberformWidget> {
  String? _selectedProviderImage;
  String? _selectedProviderName;

  @override
  void initState() {
    super.initState();
    _selectedProviderImage = widget.initialProviderImage;
    _selectedProviderName = null;
  }

  bool get _allowsFreeText =>
      widget.serviceType == PlatformProductType.airtime ||
      widget.serviceType == PlatformProductType.mobileData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          hintText: !_allowsFreeText && _selectedProviderName != null
              ? _selectedProviderName
              : widget.inputHint,
          readOnly: !_allowsFreeText,
          onTap: !_allowsFreeText ? () => _showBillerPicker(context) : null,
          prefixIcon: SizedBox(
            child: GestureDetector(
              onTap: _showBillerPicker,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  16.horizontalSpace,
                  if (_selectedProviderImage != null)
                    _selectedProviderImage!.contains('.svg')
                        ? CircleAvatar(
                            radius: 15,
                            child: ClipOval(
                              child: AppSvgIcon(
                                path: _selectedProviderImage!,
                                // width: 34,
                                // height: 24,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Image.asset(_selectedProviderImage!, width: 24)
                  else
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircleAvatar(
                        child: AppSvgIcon(
                            path: Assets.svgs.call, fit: BoxFit.fill),
                      ),
                    ),
                  8.horizontalSpace,
                  AppSvgIcon(path: Assets.svgs.chevronDown),
                  8.horizontalSpace,
                ],
              ),
            ),
          ),
          initialValue: !_allowsFreeText && _selectedProviderName != null
              ? _selectedProviderName
              : null,
        ),
        if (widget.secondaryInputHint != null)
          Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: AppTextField(
              hintText: widget.secondaryInputHint,
              controller: widget.secondaryInputfieldController,
            ),
          ),
        if (widget.dropdownHint != null)
          Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: AppDropdown(
              title: widget.dropdownHint!,
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
