import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: context.symmetricPadding(20, 0),
          child: AppTextField(
            hintText: 'Search for bill',
            decoration: const InputDecoration().search(),
            onChange: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(filteredWidgets.length, (index) {
            final item = filteredWidgets[index];
            return Builder(
              builder: (context) => item.builder(context).withContainer(
                    padding: context.symmetricPadding(0, 20.h),
                    margin: context.symmetricPadding(20.w, 8.h),
                  ),
            );
          }),
        ),
      ],
    );
  }
}
