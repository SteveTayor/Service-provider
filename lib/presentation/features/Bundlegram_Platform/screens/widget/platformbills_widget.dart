import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/data/platform_data.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlatformbillsWidget extends StatefulWidget {
  const PlatformbillsWidget({super.key});

  @override
  State<PlatformbillsWidget> createState() => _PlatformbillsWidgetState();
}

class _PlatformbillsWidgetState extends State<PlatformbillsWidget> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredWidgets = PlatFormData.billWidgets
        .where((item) =>
            item.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Column(
      mainAxisSize:
          MainAxisSize.min, // Important: prevents taking infinite height
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: context.symmetricPadding(20, 0),
          child: AppTextField(
            decoration: InputDecoration(
              fillColor: AppColors.searchbarColor,
              filled: true,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Icon(
                  Icons.search,
                  color: AppColors.grey8E,
                ),
              ),
              hintText: 'Search for bill',
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: AppColors.searchHintColor,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(80.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(80.r),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(80.r),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(80.r),
              ),
            ),
            onChange: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),

        // Add some spacing after search
        16.verticalSpace,

        // Handle empty state
        if (filteredWidgets.isEmpty && _searchQuery.isNotEmpty) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off,
                  size: 48.w,
                  color: AppColors.grey8E,
                ),
                16.verticalSpace,
                Text(
                  'No bills found',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.grey8E,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                8.verticalSpace,
                Text(
                  'Try searching with different keywords',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.grey8E,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ] else ...[
          // Use Column.children instead of List.generate for better performance with many items
          ...filteredWidgets.map((item) {
            return Builder(
              builder: (context) => item.builder(context).withContainer(
                    padding: context.symmetricPadding(0, 16.h),
                    margin: context.symmetricPadding(20.w, 8.h),
                  ),
            );
          }).toList(),
        ],

        // Add bottom padding for better spacing in bottom sheet
        24.verticalSpace,
      ],
    );
  }
}
