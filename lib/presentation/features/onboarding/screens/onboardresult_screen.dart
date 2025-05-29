import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OnboardResultScreen extends StatelessWidget {
  const OnboardResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      sidePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 40.h),
      body: 
    ResultWidget(title: 'Account created!', 
    subText: 'Your Bundlegram account has been \nsuccessfully created, click the button \nbelow to sign in.', buttonText: 'Sign in now', onPressed: (){
      context.go(RouteConstants.login);
    },),
    );
  }
}
