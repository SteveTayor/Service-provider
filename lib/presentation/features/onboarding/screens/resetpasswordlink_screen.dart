import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordLinkScreen extends StatelessWidget {
  const ResetPasswordLinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      sidePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 40.h),
      body: 
    ResultWidget(title: 'Reset link sent!', 
    iconPath: Assets.svgs.mailresent,
    
    subText:
     'A password reset link has been sent to your email, roseowen@gmail.com. Check your inbox and click the link to reset your password.',
      buttonText: 'Go to email app', onPressed: (){
        context.go('/login');
      },),
    );
  }
}
