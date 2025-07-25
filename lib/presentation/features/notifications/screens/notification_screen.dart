import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/data/models/notification_model.dart';
import 'package:bundlegram/presentation/features/notifications/screens/widgets/emptynotification_widget.dart';
import 'package:bundlegram/presentation/features/notifications/screens/widgets/notification_list.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Sample notification data - replace with your actual data source
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
    return BundlegramScaffold(
      appBar: BundlegramAppbar(
        titleText: 'Notifications',
        trailing: notifications.isNotEmpty
            ? TextButton(
                onPressed: _clearAllNotifications,
                child: Text(
                  'Clear all',
                ),
              )
            : null,
      ),
      body: notifications.isEmpty
          ? const EmptynotificationWidget()
          : NotificationListWidget(
              notifications: notifications,
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
      case NotificationType.transaction:
        // Navigate to transaction details
        break;
      case NotificationType.payment:
        // Navigate to payment history
        break;
      case NotificationType.system:
        // Handle system notifications
        break;
    }
  }

  void _clearAllNotifications() {
    setState(() {
      notifications.clear();
    });
    context.showCustomSnackBar('All notifications has been cleared');
  }
}
