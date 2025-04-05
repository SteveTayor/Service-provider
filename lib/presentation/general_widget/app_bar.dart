
 // ignore_for_file: inference_failure_on_function_invocation
 
import 'package:bundlegram/Core/extensions/navigation_extensions.dart';
import 'package:bundlegram/Core/utils/colors.dart';

import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/customizable.row.dart';
import 'package:flutter/material.dart';

class BundlegramAppbar extends StatelessWidget implements 
PreferredSizeWidget {
  const BundlegramAppbar({
    this.showBackButton = true,
    this.title,
    this.trailing,
    this.onTap,
    this.leading,
    this.color,
    super.key,
  });

  final bool showBackButton;
  final Widget? title;
  final Widget? trailing;
  final String? leading;

  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        bottom: 20,
      ),
      decoration:   BoxDecoration(color: Colors.transparent,
      border: Border(
        bottom:
        title==null? BorderSide.none:
         const BorderSide(color: AppColors.greyEE),),
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
                  child: title ?? const SizedBox(),
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
  Size get preferredSize => _appBar.preferredSize;
}
