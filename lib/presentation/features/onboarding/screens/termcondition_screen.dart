import 'package:bundlegram/presentation/features/onboarding/notifier/onboarding_data.dart';
import 'package:bundlegram/presentation/features/onboarding/screens/widgets/plain_text.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:flutter/material.dart';


class TermConditionScreen extends StatelessWidget {
  const TermConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   const BundlegramScaffold(
      appBar: BundlegramAppbar(titleText: 'Terms and conditions',),
      body: 
    PlainTextWidget(text: OnboardingData.termCondition),
    );
  }
}
