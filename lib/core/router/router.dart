import 'package:bundlegram/presentation/features/onboarding/screens/sign_up.dart';
import 'package:bundlegram/presentation/features/onboarding/screens/walkthrough_screen.dart';
import 'package:flutter/material.dart';

class AppRouter{
  static const String walkThrough = '/walkThrough';
  static const String signUp = '/signUp';

  static final Map<String,Widget Function(BuildContext)> _routes ={
    walkThrough:(context)=>const WalkthroughScreen(),
    signUp:(context)=>const SignUpScreen(),

  };
  static Map<String,Widget Function(BuildContext)> get routes => _routes;

}
