import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  const ResultWidget({required this.title,
   required this.subText, required this.buttonText,
    required this.onPressed, super.key, 
    this.isLinkSent=false,
      this.iconPath,});
  final String title;
  final String subText;
  final bool? isLinkSent;
  final String? iconPath;
  final String buttonText;
    final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppSvgIcon(path: 
              
           isLinkSent!?Assets.svgs.mailresent:  Assets.svgs.successfulIllustration,
              
              ),
              Text(title,style: context.textTheme.headlineLarge,),
              Text(subText,
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall,),
            ],
          ),
        ),
      BundlegramButton(text: buttonText, onPressed: onPressed),
      ],
    );
  }
}
