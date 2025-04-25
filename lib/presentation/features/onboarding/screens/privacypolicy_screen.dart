import 'package:bundlegram/data/onboarding/onboarding_data.dart';
import 'package:bundlegram/presentation/features/onboarding/screens/widgets/plain_text.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:flutter/material.dart';


class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   const BundlegramScaffold(
      appBar: BundlegramAppbar(titleText: 'Privacy policy',),
      body: 
    PlainTextWidget(text: OnboardingData.privacyPolicy),
    );
  }
}
