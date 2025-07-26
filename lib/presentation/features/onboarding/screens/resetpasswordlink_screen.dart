import 'package:bundlegram/presentation/features/onboarding/notifier/forgot_password_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/result_widget.dart';

class ResetPasswordLinkScreen extends ConsumerWidget {
  final String title;
  final String subtitle;

  const ResetPasswordLinkScreen({
    required this.subtitle,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrl = ref.read(forgetPasswordProvider);

    return BundlegramScaffold(
      sidePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 40.h),
      body: ResultWidget(
        appIcon: AppSvgIcon(path: Assets.svgs.mailresent),
        title: title,
        subText: subtitle,
        buttonText: 'Go to email app',
        onPressed: () {
          // ctrl.openEmailApp(context);
        },
      ),
    );
  }
}
