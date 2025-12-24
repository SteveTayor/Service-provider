// ignore_for_file: inference_failure_on_function_invocation

import 'package:bundlegram/core/extensions/responsive_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';

import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/gen/fonts.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/customizable.row.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BundlegramAppbar extends StatelessWidget implements PreferredSizeWidget {
  const BundlegramAppbar({
    this.showBackButton = true,
    this.title,
    this.trailing,
    this.titleText,
    this.onTap,
    this.leading,
    this.color,
    this.useResponsive = true, // NEW
    super.key,
  });

  final bool showBackButton;
  final Widget? title;
  final Widget? trailing;
  final String? leading;
  final String? titleText;
  final Color? color;
  final VoidCallback? onTap;
  final bool useResponsive; // NEW

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top +
            (useResponsive ? responsive.spacing(5) : 5),
        bottom: 0,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: title == null
              ? BorderSide.none
              : const BorderSide(color: AppColors.greyEE),
        ),
      ),
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        children: [
          Expanded(
            child: CustomizableRow(
              flexValues: const [1, 4, 1],
              children: [
                switch (showBackButton == true) {
                  true => AppSvgIcon(
                      path: leading ?? Assets.svgs.arrowLeft,
                      fit: BoxFit.scaleDown,
                      onTap: onTap ?? () => context.pop(),
                    ),
                  _ => const SizedBox()
                },
                Center(
                  child: title ??
                      (titleText != null
                          ? Text(
                              titleText!,
                              style: useResponsive
                                  ? TextStyle(
                                      fontSize: responsive.textSize(18),
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black,
                                      fontFamily: FontFamily.robotoBold,
                                    )
                                  : context.textTheme.titleSmall,
                            )
                          : const SizedBox()),
                ),
                trailing ?? const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static final _appBar = AppBar();

  @override
  Size get preferredSize => Size.fromHeight(
        _appBar.preferredSize.height + 16,
      );
}
