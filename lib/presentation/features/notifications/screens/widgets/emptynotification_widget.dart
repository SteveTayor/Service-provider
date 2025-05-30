import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';


class EmptynotificationWidget extends StatelessWidget {
  const EmptynotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return     Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppSvgIcon(path: Assets.svgs.notificationbell),
        Text('No notification yet.',style: context.textTheme.displayLarge,),
        Text('You will find all notifications here',style: context.textTheme.labelMedium,),
      ],
    );
  }
}