// lib/presentation/general_widget/app_dropdown.dart

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/responsive_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AppDropdown extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.title,
    this.options = const [],
    this.onChanged,
    this.selected,
    this.isFilled = false,
  });

  final String title;
  final List<String> options;
  final void Function(String?)? onChanged;
  final String? selected;
  final bool isFilled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isFilled ? null : () => _showMenu(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: context.textTheme.bodySmall
                  ?.copyWith(overflow: TextOverflow.ellipsis)),
          AppSvgIcon(path: Assets.svgs.chevronDown),
        ],
      ).withContainer(
        padding: context.symmetricPadding(16, 16),
        borderRadius: BorderRadius.circular(6.r),
        color: isFilled ? AppColors.greyD0.withOpacity(0.3) : AppColors.white,
        border: Border.all(color: AppColors.greyD0),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    String filter = '';
    final r = context.responsive;
    final filtered = ValueNotifier<List<String>>(options);
    final dialogHeight = r.when(
      phone: MediaQuery.of(context).size.height * 0.3, // 63% on phone
      tablet: MediaQuery.of(context).size.height * 0.65, // 65% on tablet
      desktop: 550.0, // Fixed on desktop
    );
    context.showBottomSheet(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: StatefulBuilder(builder: (context, setState) {
          return SizedBox(
            height: dialogHeight,
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(16),
                //   child: AppTextField(
                //     decoration: InputDecoration(
                //       fillColor: AppColors.searchbarColor,
                //       filled: true,
                //       prefixIcon: const Padding(
                //         padding: EdgeInsets.only(left: 16),
                //         child: Icon(
                //           Icons.search,
                //           color: AppColors.grey8E,
                //         ),
                //       ),
                //       hintText: 'Search ...',
                //       hintStyle: TextStyle(
                //         fontSize: 14.sp,
                //         color: AppColors.searchHintColor,
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide.none,
                //         borderRadius: BorderRadius.circular(80.r),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide.none,
                //         borderRadius: BorderRadius.circular(80.r),
                //       ),
                //       errorBorder: OutlineInputBorder(
                //         borderSide: BorderSide.none,
                //         borderRadius: BorderRadius.circular(80.r),
                //       ),
                //       focusedErrorBorder: OutlineInputBorder(
                //         borderSide: BorderSide.none,
                //         borderRadius: BorderRadius.circular(80.r),
                //       ),
                //     ),
                //     onChange: (val) {
                //       filter = val.toLowerCase();
                //       setState(() {
                //         filtered.value = options
                //             .where((o) => o.toLowerCase().contains(filter))
                //             .toList();
                //       });
                //     },
                //   ),
                // ),
                SizedBox(height: r.spacing(16)),
                Expanded(
                  child: ValueListenableBuilder<List<String>>(
                    valueListenable: filtered,
                    builder: (context, list, _) {
                      return ListView.separated(
                        itemCount: list.length,
                        separatorBuilder: (_, __) => SizedBox(height: 8.h),
                        itemBuilder: (context, i) {
                          final o = list[i];
                          return ListTile(
                            title: Text(o, style: context.textTheme.bodyMedium),
                            selected: o == selected,
                            onTap: () {
                              HapticFeedback.lightImpact();
                              Navigator.pop(context);
                              onChanged?.call(o);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
