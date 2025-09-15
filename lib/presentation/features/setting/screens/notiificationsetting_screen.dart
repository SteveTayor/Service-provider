import 'package:bundlegram/presentation/features/setting/provider/settings_notification_provider.dart';
import 'package:bundlegram/presentation/features/setting/screens/widget/listtileswitch_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotiificationsettingScreen extends ConsumerWidget {
  const NotiificationsettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(notificationSettingsProvider);

    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        titleText: 'Notification settings',
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: ClampingScrollPhysics(),
        ),
        child: Column(
          children: [
            ListtileswitchWidget(
              title: 'Transaction alerts',
              label:
                  'You can choose to receive notifications for transactions - successful, failed or both.',
              switchValue: settings.transactionAlerts,
              onToggle: (v) => ref
                  .read(notificationSettingsProvider.notifier)
                  .toggleTransactionAlerts(v),
            ),
            ListtileswitchWidget(
              title: 'Account activities',
              label:
                  'You will receive notifications for account login activity, password changes, or suspicious activity alerts.',
              switchValue: settings.accountActivities,
              onToggle: (v) => ref
                  .read(notificationSettingsProvider.notifier)
                  .toggleAccountActivities(v),
            ),
            ListtileswitchWidget(
              title: 'Promotion and offers',
              label:
                  'You may choose to receive notifications for special promotions, discounts, or exclusive offers available through the app.',
              switchValue: settings.promotions,
              onToggle: (v) => ref
                  .read(notificationSettingsProvider.notifier)
                  .togglePromotions(v),
            ),
            ListtileswitchWidget(
              title: 'Services update',
              label:
                  'You will get notifications about app updates, new features, or changes to terms and conditions.',
              switchValue: settings.serviceUpdates,
              onToggle: (v) => ref
                  .read(notificationSettingsProvider.notifier)
                  .toggleServiceUpdates(v),
            ),
          ],
        ),
      ),
    );
  }
}
