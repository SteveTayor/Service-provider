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
    this.onToggle, // Add callback for handling toggle
    super.key,
  });
  final String title;
  final String label;
  final bool? switchValue;
  final Function(bool)? onToggle; // Callback function

  @override
  State<ListtileswitchWidget> createState() => _ListtileswitchWidgetState();
}

class _ListtileswitchWidgetState extends State<ListtileswitchWidget> {
  bool switchValue = true;

  @override
  void initState() {
    super.initState();
    // Initialize with provided value or default to true
    switchValue = widget.switchValue ?? true;
  }

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
                    // fontSize: 22.sp,
                    ),
              ),
            ),
            CupertinoSwitch(
              activeTrackColor: AppColors.primaryColor,
              value: switchValue,
              onChanged: (c) {
                // If callback is provided, use it; otherwise use default behavior
                if (widget.onToggle != null) {
                  widget.onToggle!(c);
                } else {
                  setState(() {
                    switchValue = c;
                  });
                }
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
