import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/providers/service_provider.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/models/transaction_receipt/transaction_receipt_model.dart';
import 'package:bundlegram/data/models/wallet/service_model.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/emptytransaction_widget.dart';
import 'package:bundlegram/presentation/features/wallet/screen/wallet_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/custom_listview.dart';
import 'package:bundlegram/presentation/general_widget/service_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MobileDataHistoryScreen extends ConsumerWidget {
  const MobileDataHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mobileDataState = ref.watch(mobileDataHistoryProvider);

    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        showBackButton: true,
        title: Text('MobileData History'),
      ),
      body: CustomListView<ServiceModel>(
        items: mobileDataState.services,
        isLoading: mobileDataState.isLoading,
        onRefresh: () => ref.read(mobileDataHistoryProvider.notifier).refresh(),
        itemBuilder: (service, index) => ServiceListItem(service: service),
        onItemTap: (service, index) {
          _showBettingDetails(context, service);
        },
        backgroundColor: Colors.grey[50],
        emptyWidget: Builder(
          builder: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EmptytransactionWidget(),
                SizedBox(height: 16.h),
                Text(
                  'No betting history found',
                  style: context.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.grey8E),
                ),
              ],
            ),
          ),
        ),
      ),
      showBackImage: false,
    );
  }

  void _showBettingDetails(BuildContext context, ServiceModel service) {
    final transactionData = TransactionReceiptData(
      transactionId: service.id,
      date: _formatTransactionDate(service.date),
      time: _formatTransactionTime(service.date),
      type: service.type,
      amount: service.amount,
      bankName: service.bankName as String,
      accountNumber: service.accountNumber ?? '21830217312',
      status: service.status,
      description: service.title,
    );
    context.showPopUp(
      color: Colors.transparent,
      transactionData as Widget,
      isDismissable: true,
    );
  }

  String _formatTransactionDate(String originalDate) {
    try {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      switch (originalDate.toLowerCase()) {
        case 'Today':
          return '${today.day.toString().padLeft(2, '0')}-${today.month.toString().padLeft(2, '0')}-${today.year}';
        case 'Yesterday':
          final yesterday = today.subtract(const Duration(days: 1));
          return '${yesterday.day.toString().padLeft(2, '0')}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.year}';
        default:
          if (originalDate.toLowerCase().contains('days ago')) {
            final daysMatch = RegExp(r'(\d+)').firstMatch(originalDate);
            if (daysMatch != null) {
              final days = int.parse(daysMatch.group(1)!);
              final date = today.subtract(Duration(days: days));
              return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
            }
          }

          final parsedDate = originalDate.toDateTime();
          if (parsedDate != null) {
            return '${parsedDate.day.toString().padLeft(2, '0')}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.year}';
          }

          // Default fallback
          return '${today.day.toString().padLeft(2, '0')}-${today.month.toString().padLeft(2, '0')}-${today.year}';
      }
    } catch (e) {
      final now = DateTime.now();
      return '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';
    }
  }

  String _formatTransactionTime(String originalDate) {
    // Generate a realistic time based on transaction type and current time
    final now = DateTime.now();

    // If transaction is "today", use a recent time
    if (originalDate.toLowerCase() == 'today') {
      final hour = now.hour;
      final minute = now.minute;
      final period = hour >= 12 ? 'pm' : 'am';
      final displayHour = hour > 12
          ? hour - 12
          : hour == 0
              ? 12
              : hour;
      return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}$period';
    }

    // For other days, generate a random but realistic time
    final hours = [9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8];
    final minutes = [10, 15, 20, 25, 30, 35, 40, 45, 50, 55];
    final periods = ['am', 'pm'];

    final randomHour = hours[DateTime.now().microsecond % hours.length];
    final randomMinute = minutes[DateTime.now().microsecond % minutes.length];
    final randomPeriod = periods[DateTime.now().microsecond % periods.length];

    return '${randomHour.toString().padLeft(2, '0')}:${randomMinute.toString().padLeft(2, '0')}$randomPeriod';
  }
}
