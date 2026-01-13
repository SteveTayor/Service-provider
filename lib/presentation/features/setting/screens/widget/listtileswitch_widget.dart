import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListtileswitchWidget extends StatelessWidget {
  const ListtileswitchWidget({
    required this.title,
    required this.label,
    required this.switchValue,
    required this.onToggle,
    super.key,
  });

  final String title;
  final String label;
  final bool switchValue;
  final Function(bool) onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                style: context.textTheme.bodyMedium,
              ),
            ),
            CupertinoSwitch(
              // activeTrackColor: AppColors.primaryColor,
              activeTrackColor: Theme.of(context).colorScheme.primary,
              value: switchValue,
              onChanged: onToggle,
            ),
          ],
        ),
        8.verticalSpace,
        Text(label, style: context.textTheme.labelMedium),
      ],
    ).withContainer(
      padding: context.symmetricPadding(0, 24),
      border: const Border(bottom: BorderSide(color: Color(0xffECECEC))),
    );
  }
}
