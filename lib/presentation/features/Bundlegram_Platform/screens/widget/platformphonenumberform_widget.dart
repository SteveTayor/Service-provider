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
    this.imagePaths,
    this.onProviderSelected,
    this.initialProviderImage,
    required this.serviceType,
  });

  final String? inputHint;
  final String? secondaryInputHint;
  final String? dropdownHint;
  final List<String>? imagePaths;
  final Function(String?)? onProviderSelected;
  final String? initialProviderImage;
  final PlatformProductType serviceType;

  @override
  State<PlatformphonenumberformWidget> createState() =>
      _PlatformphonenumberformWidgetState();
}

class _PlatformphonenumberformWidgetState
    extends State<PlatformphonenumberformWidget> {
  String? _selectedProviderImage;
  String? _selectedProvider;

  @override
  void initState() {
    super.initState();
    _selectedProviderImage = widget.initialProviderImage;
    _selectedProvider = widget.initialProviderImage!.contains('mtn')
        ? 'mtn'
        : null; // Default to MTN if set
  }

  bool _isSvgPath(String path) =>
      path.startsWith('assets/svgs/') ||
      Assets.svgs.values.any((svg) => svg == path);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.inputHint != null)
          AppTextField(
            hintText: widget.inputHint!,
            prefixIcon: (widget.imagePaths != null)
                ? GestureDetector(
                    onTap: () {
                      context.showBottomSheet(
                        child: ChoosebillerWidget(
                          imagePaths: widget.imagePaths!,
                          onProviderSelected: (imagePath, provider) {
                            setState(() {
                              _selectedProviderImage = imagePath;
                            });
                            if (widget.onProviderSelected != null) {
                              widget.onProviderSelected!(provider);
                            }
                          },
                          serviceType: widget.serviceType,
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_selectedProviderImage != null)
                          _isSvgPath(_selectedProviderImage!)
                              ? AppSvgIcon(path: _selectedProviderImage!)
                              : Image.asset(
                                  _selectedProviderImage!,
                                  width: 24.w,
                                  height: 24.w,
                                )
                        else if (widget.initialProviderImage != null)
                          _isSvgPath(widget.initialProviderImage!)
                              ? AppSvgIcon(path: widget.initialProviderImage!)
                              : Image.asset(
                                  widget.initialProviderImage!,
                                  width: 24.w,
                                  height: 24.w,
                                )
                        else
                          Assets.images.mtn.image(),
                        AppSvgIcon(path: Assets.svgs.chevronDown),
                        8.horizontalSpace,
                      ],
                    ),
                  )
                : null,
          ),
        if (widget.secondaryInputHint != null)
          Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: AppTextField(
              hintText: widget.secondaryInputHint!,
            ),
          ),
        if (widget.dropdownHint != null)
          Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: AppDropdown(title: widget.dropdownHint!),
          ),
      ],
    );
  }
}
