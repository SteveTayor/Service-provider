import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/platformproduct_screen.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/accountsetup_screen.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/addbankdetails_screen.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/addbasicinformation_screen.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/becomeagent_screen.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/helpandsupport_screen.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/linkyourbvn_screen.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/widgets/withdrawalaccount_screen.dart';
import 'package:bundlegram/presentation/features/dashboard/screens/dashboard_screen.dart';
import 'package:bundlegram/presentation/features/notifications/screens/notification_screen.dart';
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
import 'package:bundlegram/presentation/features/setting/screens/changeaccountpin_screen.dart';
import 'package:bundlegram/presentation/features/setting/screens/changepassword_screen.dart';
import 'package:bundlegram/presentation/features/setting/screens/notiificationsetting_screen.dart';
import 'package:bundlegram/presentation/features/setting/screens/privacysecurity_screen.dart';
import 'package:bundlegram/presentation/features/setting/screens/resetaccountpin.dart';
import 'package:bundlegram/presentation/features/setting/screens/setting_screen.dart';
import 'package:bundlegram/presentation/features/wallet/screen/enterpin_screen.dart';
import 'package:bundlegram/presentation/features/wallet/screen/topupresult_screen.dart';
import 'package:bundlegram/presentation/features/wallet/screen/wallet_history.dart';
import 'package:bundlegram/presentation/features/wallet/screen/withdrawal_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';

import 'package:flutter/material.dart';

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
        path: RouteConstants.walkThrough,
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
      GoRoute(
        path: RouteConstants.dashboard,
        builder: (context, state) => const Dashboard(),
      ),
      GoRoute(
        path: RouteConstants.notification,
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: RouteConstants.topUpResult,
        builder: (context, state) => const TopUpResultScreen(),
      ),
      GoRoute(
        path: RouteConstants.withdrawFund,
        builder: (context, state) => const WithdrawalScreen(),
      ),
      GoRoute(
        path: RouteConstants.enterPin,
        builder: (context, state) => const EnterPinScreen(),
      ),
      GoRoute(
        path: RouteConstants.platformProduct,
        builder: (context, state) => const PlatformproductScreen(),
      ),
      GoRoute(
        path: RouteConstants.setting,
        builder: (context, state) => const SettingScreen(),
      ),
      GoRoute(
        path: RouteConstants.changePassword,
        builder: (context, state) => const ChangepasswordScreen(),
      ),
      GoRoute(
        path: RouteConstants.changeAccountPin,
        builder: (context, state) => const ChangeaccountpinScreen(),
      ),
      GoRoute(
        path: RouteConstants.resetAccountPin,
        builder: (context, state) => const Resetaccountpin(),
      ),
      GoRoute(
        path: RouteConstants.notificationsetting,
        builder: (context, state) => const NotiificationsettingScreen(),
      ),
      GoRoute(
        path: RouteConstants.privacySecurity,
        builder: (context, state) => const PrivacysecurityScreen(),
      ),
      GoRoute(
        path: RouteConstants.accountSetup,
        builder: (context, state) => const AccountsetupScreen(),
      ),
      GoRoute(
        path: RouteConstants.addbasicinformation,
        builder: (context, state) => const AddbasicinformationScreen(),
      ),
      GoRoute(
        path: RouteConstants.updatebasicinformation,
        builder: (context, state) => const AddbasicinformationScreen(
          userAction: UserAction.update,
        ),
      ),
      GoRoute(
        path: RouteConstants.linkyourbvn,
        builder: (context, state) => const LinkyourbvnScreen(),
      ),
      GoRoute(
        path: RouteConstants.addbankdetail,
        builder: (context, state) => const AddbankdetailsScreen(),
      ),
      GoRoute(
        path: RouteConstants.withdrawalAccount,
        builder: (context, state) => const WithdrawalaccountScreen(),
      ),
      GoRoute(
        path: RouteConstants.helpSupport,
        builder: (context, state) => const HelpandsupportScreen(),
      ),
      GoRoute(
        path: RouteConstants.becomeagent,
        builder: (context, state) => const BecomeagentScreen(),
      ),
      GoRoute(
        path: RouteConstants.walletHistoryScreen,
        builder: (context, state) => const WalletHistoryScreen(),
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
      body: Center(
        child: Text('Error'),
      ),
    ),
  );
}

// Placeholder widgets for screens (to be replaced with actual implementations)
 

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//   @override
//   Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Login')));
// }

 