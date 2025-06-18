import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/data/models/notification_model.dart';
import 'package:bundlegram/presentation/features/notifications/screens/widgets/notification_listtile.dart';
import 'package:flutter/material.dart';

class NotificationListWidget extends StatelessWidget {
  final List<NotificationItem> notifications;
  final Function(NotificationItem) onNotificationTap;

  const NotificationListWidget({
    super.key,
    required this.notifications,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            // padding: const EdgeInsets.all(16),
            itemCount: notifications.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return NotificationTile(
                notification: notification,
                onTap: () => onNotificationTap(notification),
              );
            },
          ),
        ),
      ],
    );
  }
}
