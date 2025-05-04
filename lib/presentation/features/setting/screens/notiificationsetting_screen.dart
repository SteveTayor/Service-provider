import 'package:bundlegram/presentation/features/setting/screens/widget/listtileswitch_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:flutter/material.dart';


class NotiificationsettingScreen extends StatelessWidget {
  const NotiificationsettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BundlegramScaffold(
      appBar: BundlegramAppbar(titleText: 'Notification settings',),
      body: 
    Column(
      children: [
        ListtileswitchWidget(title: 'Transaction alerts',
         label: 'You can choose to receive notifications for transactions - successful, failed or both.',),
        ListtileswitchWidget(title: 'Account activities',
         label: 'You will receive notifications for account login activity, password changes, or suspicious activity alerts.',),
        ListtileswitchWidget(title: 'Promotion and offers',
         label: 'You may choose to receive notifications for special promotions, discounts, or exclusive offers available through the app.',),
        ListtileswitchWidget(title: 'Services update',
         label: 'You will get notifications about app updates, new features, or changes to terms and conditions.',),
      ],
    )
    ,);
  }
}