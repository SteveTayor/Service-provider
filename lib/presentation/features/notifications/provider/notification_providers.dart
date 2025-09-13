import 'package:bundlegram/core/error/error_sanitixed_users.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/models/notification/notification_response.dart';
import 'package:bundlegram/data/models/notification_model.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final notificationProvider =
    ChangeNotifierProvider<NotificationProvider>((ref) {
  return NotificationProvider(ref, ref.read(apiServiceProvider));
});

class NotificationProvider extends ChangeNotifier {
  final Ref _ref;
  final ApiService _api;
  final Uuid _uuid = const Uuid();

  NotificationProvider(this._ref, this._api);

  List<NotificationItem> _notifications = [];
  bool _isLoading = false;
  bool _isMarkingAllRead = false;

  List<NotificationItem> get notifications => _notifications;
  bool get isLoading => _isLoading;
  bool get isMarkingAllRead => _isMarkingAllRead;

  Future<void> fetchNotifications(BuildContext context) async {
    _setLoading(true);
    try {
      final token = await _ref.read(secureStorageHelperProvider).getAuthToken();
      debugPrint('fetchNotifications: retrieved token = $token');

      if (token == null) {
        context.showErrorSnackBar('Authentication token not found');
        _setLoading(false);
        return;
      }

      final result = await _api.getAllNotifications(token);
      debugPrint('fetchNotifications: API call completed, result = $result');

      result.fold(
        (failure) {
          final userMsg = userFacingMessageFromFailure(failure);
          debugPrint(
              'fetchNotifications: API failure = $failure, userMsg = $userMsg');
          context.showErrorSnackBar(userMsg ?? "Failed to fetch notifications");
        },
        (response) {
          debugPrint('fetchNotifications: API success, response = $response');

          final apiNotifications = (response.notifications ?? [])
              .where((n) => n != null)
              .map((n) {
                try {
                  final type = _mapApiType(n.data?.type);
                  debugPrint(
                    'fetchNotifications: mapping notification id=${n.id}, '
                    'apiType=${n.data?.type}, mappedType=$type, createdAt=${n.createdAt}',
                  );

                  debugPrint(
                    'fetchNotifications: mapping notification id=${n.id}, '
                    'type=${n.data?.type}, createdAt=${n.createdAt}',
                  );

                  return NotificationItem(
                    id: n.id ?? '',
                    title: _getNotificationTitle(n),
                    description: n.data?.message ?? '',
                    time: _formatNotificationTime(n.createdAt),
                    type: type,
                    isRead: n.readAt != null,
                    isBroadcast: false,
                  );
                } catch (e, st) {
                  debugPrint(
                      'fetchNotifications: error mapping notification ${n.id} -> $e\n$st');
                  return null; // skip bad notifications
                }
              })
              .whereType<NotificationItem>()
              .toList();

          debugPrint(
              'fetchNotifications: mapped ${apiNotifications.length} notifications');
          _mergeNotifications(apiNotifications);
        },
      );
    } catch (e, st) {
      debugPrint('fetchNotifications: unexpected error = $e\n$st');
      context
          .showErrorSnackBar('An error occurred while fetching notifications');
    } finally {
      _setLoading(false);
    }
  }

  NotificationType _mapApiType(String? type) {
    switch (type?.toLowerCase()) {
      case 'airtime':
        return NotificationType.airtime;
      case 'mobile_data':
        return NotificationType.mobileData;
      case 'betting':
        return NotificationType.betting;
      case 'electricity':
        return NotificationType.electricity;
      case 'cable':
        return NotificationType.cable;
      case 'payment':
        return NotificationType.payment;
      case 'promo':
        return NotificationType.promo;
      default:
        return NotificationType.system;
    }
  }

  Future<void> markAllNotificationsAsRead(BuildContext context) async {
    _setMarkingAllRead(true);
    try {
      final token = await _ref.read(secureStorageHelperProvider).getAuthToken();
      if (token == null) {
        context.showErrorSnackBar('Authentication token not found');
        _setMarkingAllRead(false);
        return;
      }

      final result = await _api.markAllNotificationsAsRead(token);
      result.fold(
        (failure) {
          final userMsg = userFacingMessageFromFailure(failure);
          context.showErrorSnackBar(
              userMsg ?? "Failed to mark notifications as read");
        },
        (response) {
          if (response.status == 'success') {
            _notifications =
                _notifications.map((n) => n.copyWith(isRead: true)).toList();
            //  _notifications = _notifications.map((n) {
            // Only mark API notifications as read, preserve broadcast notifications
            //   if (!n.isBroadcast) {
            //     return n.copyWith(isRead: true);
            //   }
            //   return n;
            // }).toList();
            context.showSuccessSnackBar(
                response.message ?? 'All notifications marked as read');
          } else {
            context.showErrorSnackBar(
                response.message ?? 'Failed to mark notifications as read');
          }
        },
      );
    } catch (e) {
      context.showErrorSnackBar('An error occurred');
    } finally {
      _setMarkingAllRead(false);
    }
  }

  String _getNotificationTitle(Notfication notification) {
    switch (notification.data?.type?.toLowerCase()) {
      case 'mobile_data':
        return 'Data Subscription Successful';
      case 'airtime':
        return 'Airtime Recharge Successful';
      case 'betting':
        return 'Betting Transaction Successful';
      case 'electricity':
        return 'Electricity Bill Payment Successful';
      case 'cable':
        return 'Cable Subscription Successful';
      case 'payment':
        return 'Payment Successful';
      case 'promo':
        return 'New Offer Available';
      default:
        return 'System Notification';
    }
  }

// Add a broadcast notification
  void addBroadcastNotification({
    required String message,
    required String type,
    required DateTime createdAt,
    String? title,
  }) {
    final notificationType = _mapBroadcastType(type);
    final broadcastNotification = NotificationItem(
      id: _uuid.v4(), // Generate unique ID for broadcast
      title: title ?? _getBroadcastTitle(type),
      description: message,
      time: _formatNotificationTime(createdAt),
      type: notificationType,
      isRead: false,
      isBroadcast: true,
    );
    _mergeNotifications([..._notifications, broadcastNotification]);
  }

  // Merge API and broadcast notifications, sort by createdAt (newest first)
  void _mergeNotifications(List<NotificationItem> newNotifications) {
    _notifications = newNotifications;
    _notifications.sort((a, b) {
      final aTime = _parseNotificationTime(a.time);
      final bTime = _parseNotificationTime(b.time);
      return bTime.compareTo(aTime); // Newest first
    });
    notifyListeners();
  }

  // Map broadcast type to NotificationType
  NotificationType _mapBroadcastType(String type) {
    switch (type?.toLowerCase()) {
      case 'airtime':
        return NotificationType.airtime;
      case 'mobile_data':
        return NotificationType.mobileData;
      case 'betting':
        return NotificationType.betting;
      case 'electricity':
        return NotificationType.electricity;
      case 'cable':
        return NotificationType.cable;
      case 'payment':
        return NotificationType.payment;
      case 'promo':
        return NotificationType.promo;
      default:
        return NotificationType.system;
    }
  }

  // Generate title for broadcast notifications
  String _getBroadcastTitle(String type) {
    switch (type.toLowerCase()) {
      case 'mobile_data':
        return 'Data Subscription Alert';
      case 'airtime':
        return 'Airtime Recharge Alert';
      case 'payment':
        return 'Payment Alert';
      case 'promo':
        return 'New Promotion';
      default:
        return 'System Alert';
    }
  }

// Parse notification time for sorting
  DateTime _parseNotificationTime(String time) {
    if (time.startsWith('Today')) {
      final timeParts = time.split(' • ')[1].split(':');
      final now = DateTime.now();
      return DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(timeParts[0]),
        int.parse(timeParts[1]),
      );
    }
    final parts = time.split(' • ');
    final dateParts = parts[0].split(' ');
    final timeParts = parts[1].split(':');
    final month = _getMonthNameIndex(dateParts[1]);
    return DateTime(
      int.parse(dateParts[2]),
      month,
      int.parse(dateParts[0]),
      int.parse(timeParts[0]),
      int.parse(timeParts[1]),
    );
  }

  String _formatNotificationTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    if (difference.inDays > 0) {
      return '${dateTime.day} ${_getMonthName(dateTime.month)} ${dateTime.year} • ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
    return 'Today • ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  int _getMonthNameIndex(String month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months.indexOf(month) + 1;
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setMarkingAllRead(bool value) {
    _isMarkingAllRead = value;
    notifyListeners();
  }
}
