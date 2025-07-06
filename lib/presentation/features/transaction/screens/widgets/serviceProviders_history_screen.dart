import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/core/providers/service_provider.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
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

class ServiceHistoryScreen extends ConsumerStatefulWidget {
  const ServiceHistoryScreen({
    Key? key,
    required this.serviceType,
  }) : super(key: key);

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

    return HistoryScreen<UserTransactions>(
      titleText: 'History',
      items: state.filteredTransactions,
      isLoading: state.isLoading,
      onSearchChanged: (query) => ref.read(provider.notifier).search(query),
      onFilterPressed: (ctx) => ctx.showBottomSheet(
        child: TransactionFilterWidget(
          onApply: ({
            required sortBy,
            required amountBy,
            required statusSet,
            required typeSet,
          }) {
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
      itemBuilder: (ctx, item, idx) => ServiceListItem(transaction: item),
      onItemTap: _showReceiptPopup,
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

  void _showReceiptPopup(UserTransactions txn) {
    final subProduct = txn.subProduct;
    final dateTime = txn.createdAt ?? DateTime.now();

    final receiptData = TransactionReceiptData(
      transactionId: txn.transRef ?? '',
      amount: txn.amount ?? '₦0.00',
      type: subProduct?.product?.type ?? '',
      status: txn.status ?? 'pending',
      date: _formatDate(dateTime),
      time: _formatTime(dateTime),
      bankName: txn.bank.toString() ?? '',
      accountNumber: txn.crAcc,
      description: subProduct?.subName ?? '',
    );

    context.showPopUp(
      color: Colors.transparent,
      TransactionReceiptWidget(data: receiptData),
      isDismissable: true,
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final txnDate = DateTime(date.year, date.month, date.day);

    if (txnDate == today) return 'Today';
    if (txnDate == yesterday) return 'Yesterday';

    return date.toIso8601String();
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute;
    final period = hour >= 12 ? 'pm' : 'am';
    final displayHour = hour > 12
        ? hour - 12
        : hour == 0
            ? 12
            : hour;

    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}$period';
  }
}
