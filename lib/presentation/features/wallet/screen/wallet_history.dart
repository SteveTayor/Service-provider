import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/data/models/transaction_receipt/transaction_receipt_model.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/filter_widget.dart';
import 'package:bundlegram/presentation/general_widget/history_widget.dart';
import 'package:bundlegram/presentation/general_widget/transaction_share_receipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/models/wallet/service_model.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/emptytransaction_widget.dart';
import 'package:bundlegram/presentation/general_widget/service_list_item.dart';
import 'package:bundlegram/core/providers/service_provider.dart';
import 'package:go_router/go_router.dart';

class WalletHistoryScreen extends ConsumerStatefulWidget {
  const WalletHistoryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<WalletHistoryScreen> createState() =>
      _WalletHistoryScreenState();
}

class _WalletHistoryScreenState extends ConsumerState<WalletHistoryScreen> {
  String _sortBy = 'newest';
  String _amountBy = 'largest';
  final Set<String> _statusSet = {};
  final Set<String> _typeSet = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(walletHistoryProvider.notifier).loadServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(walletHistoryProvider);
    final allTxns = state.filteredServices;

    return HistoryScreen<ServiceModel>(
      titleText: 'History',
      items: allTxns,
      isLoading: state.isLoading,
      onSearchChanged: (query) {
        ref.read(walletHistoryProvider.notifier).search(query);
      },
      onFilterPressed: (ctx) {
        ctx.showBottomSheet(
          child: TransactionFilterWidget(
            onApply: ({
              required String sortBy,
              required String amountBy,
              required Set<String> statusSet,
              required Set<String> typeSet,
            }) {
              _sortBy = sortBy;
              _amountBy = amountBy;
              _statusSet
                ..clear()
                ..addAll(statusSet);
              _typeSet
                ..clear()
                ..addAll(typeSet);

              // Apply filters on "wallet" history: only 'top-up' and 'withdrawal'
              ref.read(walletHistoryProvider.notifier).applyFilters(
                    typeSet: _typeSet,
                    statusSet: _statusSet,
                    sortBy: _sortBy,
                    amountBy: _amountBy,
                  );

              context.pop();
            },
          ),
        );
      },
      itemBuilder: (ctx, txn, index) => ServiceListItem(service: txn),
      onItemTap: (txn) => _showTransactionDetails(txn),
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

  List<ServiceModel> _getRecentTransactions(List<ServiceModel> all) {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    return all.where((txn) {
      try {
        final dt = _formatDate(txn.date) as DateTime;
        return dt.isAfter(sevenDaysAgo);
      } catch (_) {
        return false;
      }
    }).toList();
  }

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

  void _showTransactionDetails(ServiceModel txn) {
    // Show a bottom sheet or dialog with transaction details
    final transactionData = TransactionReceiptData(
      transactionId: txn.id,
      date: _formatDate(txn.date),
      time: (txn.date),
      type: txn.type,
      amount: txn.amount,
      bankName: txn.bankName,
      accountNumber: txn.accountNumber,
      status: txn.status,
      description: txn.title,
    );
    context.showPopUp(
      color: Colors.transparent,
      TransactionReceiptWidget(
        data: transactionData,
      ),
      isDismissable: true,
    );
  }
}
