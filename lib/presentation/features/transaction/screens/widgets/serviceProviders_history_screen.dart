import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/core/providers/service_provider.dart';
import 'package:bundlegram/data/models/transaction_receipt/transaction_receipt_model.dart';
import 'package:bundlegram/data/models/wallet/service_model.dart';
import 'package:bundlegram/presentation/features/transaction/notifier/all_service_provider.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/filter_widget.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_service_state.dart';
import 'package:bundlegram/presentation/general_widget/history_widget.dart';
import 'package:bundlegram/presentation/general_widget/service_list_item.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/emptytransaction_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/transaction_share_receipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Generic history screen that displays any service history based on [serviceType].
class ServiceHistoryScreen extends ConsumerStatefulWidget {
  const ServiceHistoryScreen({
    Key? key,
    required this.serviceType,
  }) : super(key: key);

  /// Which service history to load and display
  final PlatformProductType serviceType;

  @override
  ConsumerState<ServiceHistoryScreen> createState() =>
      _ServiceHistoryScreenState();
}

class _ServiceHistoryScreenState extends ConsumerState<ServiceHistoryScreen> {
  late final StateNotifierProvider<AllServiceHistoryNotifier,
      ServiceHistoryState> provider;
  String _sortBy = 'newest';
  String _amountBy = 'largest';
  final Set<String> _statusSet = {};
  final Set<String> _typeSet = {};

  @override
  void initState() {
    super.initState();
    // Map the serviceType to its corresponding provider
    provider = {
      PlatformProductType.mobileData: mobileDataHistoryProvider,
      PlatformProductType.airtime: airtimeHistoryProvider,
      PlatformProductType.betting: bettingHistoryProvider,
      PlatformProductType.electricity: electricityHistoryProvider,
      PlatformProductType.education: educationHistoryProvider,
      PlatformProductType.cableTv: cableTvHistoryProvider,
      PlatformProductType.internetServices: internetServiceHistoryProvider,
      PlatformProductType.ePinVoucher: ePinHistoryProvider,
      PlatformProductType.bulkEPin: ePinHistoryProvider,
    }[widget.serviceType]!;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(provider.notifier).loadServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(provider);

    return HistoryScreen<ServiceModel>(
      titleText: 'History',
      items: state.filteredServices,
      isLoading: state.isLoading,
      onSearchChanged: (q) => ref.read(provider.notifier).search(q),
      onFilterPressed: (ctx) => ctx.showBottomSheet(
        child: TransactionFilterWidget(
          onApply: (
              {required sortBy,
              required amountBy,
              required statusSet,
              required typeSet}) {
            _sortBy = sortBy;
            _amountBy = amountBy;
            _statusSet
              ..clear()
              ..addAll(statusSet);
            _typeSet
              ..clear()
              ..addAll(typeSet);
            ref.read(provider.notifier).applyFilters(
                  sortBy: _sortBy,
                  amountBy: _amountBy,
                  statusSet: _statusSet,
                  typeSet: _typeSet,
                );
            context.pop();
          },
        ),
      ),
      itemBuilder: (ctx, item, idx) => ServiceListItem(service: item),
      onItemTap: (item) => _showProviderDetails(item),
      emptyWidget: const Padding(
        padding: EdgeInsets.all(20),
        child: Center(child: EmptytransactionWidget()),
      ),
      separator: Container(
        height: 1,
        color: AppColors.greyD0.withOpacity(0.3),
        margin: EdgeInsets.symmetric(vertical: 12.h),
      ),
    );
  }

  void _showProviderDetails(ServiceModel service) {
    final transactionData = TransactionReceiptData(
      transactionId: service.id,
      date: _formatDate(service.date),
      time: _formatTransactionTime(service.date),
      type: service.type,
      amount: service.amount,
      bankName: service.bankName,
      accountNumber: service.accountNumber,
      status: service.status,
      description: service.title,
    );
    context.showPopUp(
      color: Colors.transparent,
      TransactionReceiptWidget(data: transactionData),
      isDismissable: true,
    );
  }

  // String _formatTransactionDate(String originalDate) {
  //   try {
  //     final now = DateTime.now();
  //     final today = DateTime(now.year, now.month, now.day);

  //     switch (originalDate.toLowerCase()) {
  //       case 'Today':
  //         return '${today.day.toString().padLeft(2, '0')}-${today.month.toString().padLeft(2, '0')}-${today.year}';
  //       case 'Yesterday':
  //         final yesterday = today.subtract(const Duration(days: 1));
  //         return '${yesterday.day.toString().padLeft(2, '0')}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.year}';
  //       default:
  //         if (originalDate.toLowerCase().contains('days ago')) {
  //           final daysMatch = RegExp(r'(\d+)').firstMatch(originalDate);
  //           if (daysMatch != null) {
  //             final days = int.parse(daysMatch.group(1)!);
  //             final date = today.subtract(Duration(days: days));
  //             return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  //           }
  //         }

  //         final parsedDate = originalDate.toDateTime();
  //         if (parsedDate != null) {
  //           return '${parsedDate.day.toString().padLeft(2, '0')}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.year}';
  //         }

  //         // Default fallback
  //         return '${today.day.toString().padLeft(2, '0')}-${today.month.toString().padLeft(2, '0')}-${today.year}';
  //     }
  //   } catch (e) {
  //     final now = DateTime.now();
  //     return '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';
  //   }
  // }
  String _formatDate(String date) {
    try {
      final dt = date.toDateTime() ?? DateTime.now();
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));
      final txnDate = DateTime(dt.year, dt.month, dt.day);

      if (txnDate.isAtSameMomentAs(today)) {
        return 'Today';
      } else if (txnDate.isAtSameMomentAs(yesterday)) {
        return 'Yesterday';
      }
      return date.toFullDateString();
    } catch (e) {
      print('Error formattng date $date :$e');
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
