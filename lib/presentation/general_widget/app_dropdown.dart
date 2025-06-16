// lib/presentation/general_widget/app_dropdown.dart

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AppDropdown extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.title,
    this.options = const [],
    this.onChanged,
    this.selected,
  });

  final String title;
  final List<String> options;
  final void Function(String?)? onChanged;
  final String? selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showMenu(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: context.textTheme.bodyMedium),
          AppSvgIcon(path: Assets.svgs.chevronDown),
        ],
      ).withContainer(
        padding: context.symmetricPadding(16, 23),
        borderRadius: BorderRadius.circular(6.r),
        color: AppColors.white,
        border: Border.all(color: AppColors.greyD0),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    context.showBottomSheet(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          shrinkWrap: true,
          children: options.map((o) {
            return Column(
              children: [
                ListTile(
                  title: Text(
                    o,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  selected: o == selected,
                  onTap: () {
                    context.pop();
                    onChanged?.call(o);
                  },
                ),
                24.verticalSpace,
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
