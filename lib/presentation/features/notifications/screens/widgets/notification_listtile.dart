import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/data/models/notification_model.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationTile extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onTap;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: notification.isRead
              ? Colors.transparent
              : Color(0xFFBBC6D0).withOpacity(0.3),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNotificationIcon(context),
                      16.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    notification.title,
                                    style:
                                        context.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                if (!notification.isRead)
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),
                            8.verticalSpace,
                            Text(
                              notification.description,
                              style: context.textTheme.labelMedium,
                              maxLines: null,
                            ),
                            12.verticalSpace,
                            Text(
                              notification.time,
                              style: context.textTheme.labelMedium
                                  ?.copyWith(color: AppColors.grey80),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            8.verticalSpace,
            Divider(
              color: Colors.grey.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationIcon(BuildContext context) {
    IconData iconData;
    Color backgroundColor;

    switch (notification.type) {
      case NotificationType.promo:
        iconData = Icons.campaign;
        backgroundColor = Colors.orange;
        return AppSvgIcon(
          path: Assets.images.logo.path,
        );
      case NotificationType.transaction:
        iconData = Icons.swap_horiz;
        backgroundColor = Colors.blue;
        return AppSvgIcon(path: Assets.svgs.airtime);
      case NotificationType.payment:
        iconData = Icons.payment;
        backgroundColor = Colors.green;
        return AppSvgIcon(path: Assets.svgs.topup);
      case NotificationType.system:
        iconData = Icons.info;

        backgroundColor = Colors.purple;
        AppSvgIcon(path: Assets.svgs.infoCircle1);
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        color: backgroundColor,
        size: 20,
      ),
    );
  }
}
