import 'package:bundlegram/core/extensions/responsive_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptytransactionWidget extends StatelessWidget {
  const EmptytransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return Column(
      children: [
        AppSvgIcon(path: Assets.svgs.noTransactionsECommerce1),
        SizedBox(height: r.spacing(32)),
        Text(
          'No transaction yet',
          style: context.textTheme.bodyMedium,
        ),
        Text(
          'You will find history of your transactions here',
          style: context.textTheme.labelSmall,
        ),
      ],
    );
  }
}
