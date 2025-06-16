import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/data/models/notification_model.dart';
import 'package:bundlegram/presentation/features/notifications/screens/widgets/notification_listtile.dart';
import 'package:flutter/material.dart';

class NotificationListWidget extends StatelessWidget {
  final List<NotificationItem> notifications;
  final Function(NotificationItem) onNotificationTap;
  final VoidCallback onClearAll;

  const NotificationListWidget({
    super.key,
    required this.notifications,
    required this.onNotificationTap,
    required this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
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
        if (notifications.isNotEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: TextButton(
              onPressed: onClearAll,
              style: TextButton.styleFrom(
                backgroundColor: Colors.red.withOpacity(0.1),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'All notifications has been cleared!',
                style: context.textTheme.labelMedium?.copyWith(
                  color: Colors.red,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
