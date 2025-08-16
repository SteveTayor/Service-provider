import 'dart:ui';

import 'package:bundlegram/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppSvgIcon extends StatelessWidget {
  const AppSvgIcon({
    required this.path,
    this.color,
    this.fit = BoxFit.contain,
    this.height,
    this.width,
    this.onTap,
    this.useCircleAvatar = true,
    super.key,
  });
  final String path;
  final Color? color;
  final BoxFit fit;
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final bool useCircleAvatar;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: path.contains('.svg')
          ? SvgPicture.asset(
              path,
              width: width,
              height: height,
              fit: fit,
              colorFilter: color == null
                  ? null
                  : ColorFilter.mode(color!, BlendMode.srcIn),
            )
          : useCircleAvatar
              ? CircleAvatar(
                  backgroundColor: color ?? AppColors.primaryColor,
                  radius: (width ?? 28) / 2,
                  child: Image.asset(
                    path,
                    width: width ?? 28,
                    height: height ?? 28,
                    fit: fit,
                  ),
                )
              : Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: color ?? Colors.transparent,
                    borderRadius:
                        BorderRadius.circular(8), // Optional: rounded corners
                  ),
                  child: Image.asset(
                    path,
                    width: width,
                    height: height,
                    fit: fit,
                  ),
                ),
      //  CircleAvatar(
      //     backgroundColor: color ?? AppColors.primaryColor,
      //     // radius: 20,
      //     child: Image.asset(
      //       path,
      //       width: width ?? 28,
      //       height: width ?? 28,
      //       fit: fit,
      //       // color: color ?? AppColors.primaryColor
      //       // colorBlendMode: BlendMode.srcIn,
      //     ),
      //   ),
    );
  }
}
