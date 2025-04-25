import 'package:bundlegram/presentation/features/onboarding/screens/chooseusername_screen.dart';
import 'package:bundlegram/presentation/features/onboarding/screens/forgetpassword_screen.dart';
import 'package:bundlegram/presentation/features/onboarding/screens/login_screen.dart';
import 'package:bundlegram/presentation/features/onboarding/screens/onboardresult_screen.dart';
import 'package:bundlegram/presentation/features/onboarding/screens/privacypolicy_screen.dart';
import 'package:bundlegram/presentation/features/onboarding/screens/register_screen.dart';
import 'package:bundlegram/presentation/features/onboarding/screens/resetpasswordlink_screen.dart';
import 'package:bundlegram/presentation/features/onboarding/screens/splash_screen.dart';
import 'package:bundlegram/presentation/features/onboarding/screens/termcondition_screen.dart';
import 'package:bundlegram/presentation/features/onboarding/screens/walkthrough_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/providers/auth_provider.dart';
import 'package:bundlegram/presentation/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/router/route_guards.dart';
 
/// Application router configuration using GoRouter
class AppRouter {
  /// Private constructor to prevent direct instantiation
  AppRouter._();

  /// Router instance
  static final GoRouter router = GoRouter(
    initialLocation: RouteConstants.splash,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteConstants.walkThrough ,
        builder: (context, state) => const WalkthroughScreen(),
      ),
      GoRoute(
        path: RouteConstants.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: RouteConstants.termsCondition,
        builder: (context, state) => const TermConditionScreen(),
      ),
      GoRoute(
        path: RouteConstants.privacyPolicy,
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),
      GoRoute(
        path: RouteConstants.chooseUsername,
        builder: (context, state) => const ChooseUsernameScreen(),
      ),
      GoRoute(
        path: RouteConstants.onboardResult,
        builder: (context, state) => const OnboardResultScreen(),
      ),
      GoRoute(
        path: RouteConstants.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteConstants.forgetPassword,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      GoRoute(
        path: RouteConstants.resetPassword,
        builder: (context, state) => const ResetPasswordLinkScreen(),
      ),


     
      
    //   ShellRoute(
    //     builder: (context, state, child) =>const BundlegramScaffold(
    //   body: Center(child: Text('Error'),),
    // ) ,
    //     routes: const [
    //        GoRoute(
    //         path: RouteConstants.agent,
    //         builder: (context, state) => const AgentScreen(),
    //         routes: [
    //           GoRoute(
    //             path: RouteConstants.commission,
    //             builder: (context, state) => const CommissionScreen(),
    //           ),
    //         ],
    //       ),
    //     ],
     
    //   ),
   
    ],
    // redirect: RouteGuards.authGuard,
    errorBuilder: (context, state) => const BundlegramScaffold(
      body: Center(child: Text('Error'),),
    ),
  );
}

// Placeholder widgets for screens (to be replaced with actual implementations)
 

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//   @override
//   Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Login')));
// }

 