import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/data/models/notification_model.dart';
import 'package:bundlegram/presentation/features/notifications/provider/notification_providers.dart';
import 'package:bundlegram/presentation/features/notifications/screens/widgets/emptynotification_widget.dart';
import 'package:bundlegram/presentation/features/notifications/screens/widgets/notification_list.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch notifications when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationProvider.notifier).fetchNotifications(context);
    });
  }

  // Sample notification data
  List<NotificationItem> notifications = [
    // NotificationItem(
    //   id: '1',
    //   title: 'Win 1 million naira for free',
    //   description:
    //       'Enjoy ₦100 discount when you deposit ₦500. Don’t miss the opportunity of a lifetime. Stand a chance to win big our MEGA MILLION JACKPOT event!',
    //   time: 'Dec 06, 2024 • 07:35 AM',
    //   type: NotificationType.promo,
    //   isRead: false,
    // ),
    // NotificationItem(
    //   id: '2',
    //   title: 'Airtime recharge successful',
    //   description:
    //       'Your airtime recharge of ₦100 to 07039650430 was successful.',
    //   time: 'Dec 06, 2024 • 07:35 AM',
    //   type: NotificationType.transaction,
    //   isRead: true,
    // ),
    // NotificationItem(
    //   id: '3',
    //   title: 'Payment successful',
    //   description:
    //       'Your payment of ₦2,000 to Ibadan Electricity Distribution Company was successful.',
    //   time: 'Dec 06, 2024 • 07:35 AM',
    //   type: NotificationType.payment,
    //   isRead: true,
    // ),
    // NotificationItem(
    //   id: '4',
    //   title: 'Data subscription successful',
    //   description:
    //       'Your data subscription of 500MB to 07039650430 was successful.',
    //   time: 'Dec 06, 2024 • 07:35 AM',
    //   type: NotificationType.transaction,
    //   isRead: true,
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    // Listen to the notification provider
    final notificationState = ref.watch(notificationProvider);
    return BundlegramScaffold(
      appBar: BundlegramAppbar(
        titleText: 'Notifications',
        trailing: notificationState.notifications.isNotEmpty
            ? FittedBox(
                child: TextButton(
                  onPressed: notificationState.isMarkingAllRead
                      ? null
                      : () => _clearAllNotifications(context),
                  child: Text(
                    'Mark all',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: notificationState.isMarkingAllRead
                          ? AppColors.primaryColor
                          : AppColors.grey5B,
                    ),
                  ),
                ),
              )
            : null,
      ),
      body: notificationState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : notificationState.notifications.isEmpty
              ? const EmptynotificationWidget()
              : NotificationListWidget(
                  notifications: notificationState.notifications,
                  onNotificationTap: _handleNotificationTap,
                ),
    );
  }

  void _handleNotificationTap(NotificationItem notification) {
    setState(() {
      // Mark notification as read
      final index = notifications.indexWhere((n) => n.id == notification.id);
      if (index != -1) {
        notifications[index] = notification.copyWith(isRead: true);
      }
    });

    // Handle navigation based on notification type
    switch (notification.type) {
      case NotificationType.promo:
        // Navigate to promo/offer screen
        break;

      case NotificationType.airtime:
        // Navigate to airtime transaction details
        break;

      case NotificationType.withdrawal:
        break;

      case NotificationType.mobileData:
        // Navigate to mobile data transaction details
        break;

      case NotificationType.betting:
        // Navigate to betting history / receipt
        break;

      case NotificationType.electricity:
        // Navigate to electricity bill details
        break;

      case NotificationType.cable:
        // Navigate to cable subscription details
        break;

      case NotificationType.payment:
        // Navigate to general payment history
        break;

      case NotificationType.system:
        // Handle system notifications
        break;
    }
  }

  // void _clearAllNotifications() {
  //   setState(() {
  //     notifications.clear();
  //   });
  //   context.showCustomSnackBar('All notifications has been cleared');
  // }
  Future<void> _clearAllNotifications(BuildContext context) async {
    await ref
        .read(notificationProvider.notifier)
        .markAllNotificationsAsRead(context);
  }
}
