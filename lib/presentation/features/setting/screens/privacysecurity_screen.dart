import 'package:bundlegram/presentation/features/setting/screens/widget/listtileswitch_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:flutter/material.dart';


class PrivacysecurityScreen extends StatelessWidget {
  const PrivacysecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BundlegramScaffold(
      appBar: BundlegramAppbar(titleText: 'Privacy & Security',),
      body: 
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListtileswitchWidget(title: 'Use Face ID to log in',
         label: 'A face recognition scan will be done anytime you log in to your account.',),
        ListtileswitchWidget(title: 'Use fingerprint to log in',
         label: 'Enable your fingerprint to log in the app',),
        ListtileswitchWidget(title: 'Use fingerprint for payment',
         label: 'You can make payment with your fingerprint instead of account pin.',),
       
      ],
    )
    ,);
  }
}