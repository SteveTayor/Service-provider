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
      onTap: () => _showMenu(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: context.textTheme.bodyMedium
                  ?.copyWith(fontSize: 16, overflow: TextOverflow.ellipsis)),
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
    final filtered = ValueNotifier<List<String>>(options);
    context.showBottomSheet(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: StatefulBuilder(builder: (context, setState) {
          return SizedBox(
            height: 400.h,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: context.textTheme.bodySmall!
                          .copyWith(color: AppColors.grey33),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      fillColor: isFilled
                          ? AppColors.greyD0.withOpacity(0.3)
                          : AppColors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.search),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.r),
                        borderSide: BorderSide(color: AppColors.greyD0),
                      ),
                    ),
                    onChanged: (val) {
                      filter = val.toLowerCase();
                      setState(() {
                        filtered.value = options
                            .where((o) => o.toLowerCase().contains(filter))
                            .toList();
                      });
                    },
                  ),
                ),
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
                              Navigator.pop(context);
                              onChanged?.call(o);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
