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
    super.key,
  });
  final String path;
  final Color? color;
  final BoxFit fit;
  final double? height;
  final double? width;
  final VoidCallback? onTap;

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
          : CircleAvatar(
              backgroundColor: color ?? AppColors.primaryColor,
              radius: 20,
              child: Image.asset(
                path,
                width: width ?? 28,
                height: width ?? 28,
                fit: fit,
                // color: color ?? AppColors.primaryColor
                // colorBlendMode: BlendMode.srcIn,
              ),
            ),
    );
  }
}
