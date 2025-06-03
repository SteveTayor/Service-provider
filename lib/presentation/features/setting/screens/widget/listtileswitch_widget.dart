import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListtileswitchWidget extends StatefulWidget {
  const ListtileswitchWidget({
    required this.title,
    required this.label,
    this.switchValue,
    super.key,
  });
  final String title;
  final String label;
  final bool? switchValue;

  @override
  State<ListtileswitchWidget> createState() => _ListtileswitchWidgetState();
}

class _ListtileswitchWidgetState extends State<ListtileswitchWidget> {
  bool switchValue = true;
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
                widget.title,
                style: context.textTheme.bodyMedium!.copyWith(
                  fontSize: 22.sp,
                ),
              ),
            ),
            CupertinoSwitch(
              activeTrackColor: AppColors.primaryColor,
              value: switchValue,
              onChanged: (c) {
                setState(() {
                  switchValue = c;
                });
              },
            ),
          ],
        ),
        8.verticalSpace,
        Text(widget.label, style: context.textTheme.labelMedium),
      ],
    ).withContainer(
      padding: context.symmetricPadding(0, 24),
      border: const Border(bottom: BorderSide(color: Color(0xffECECEC))),
    );
  }
}
