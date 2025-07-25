import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_formatter.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
import 'package:bundlegram/data/models/transaction_receipt/transaction_receipt_model.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/filter_widget.dart';
import 'package:bundlegram/presentation/general_widget/history_widget.dart';
import 'package:bundlegram/presentation/general_widget/receipt_widget.dart';
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
import 'package:intl/intl.dart';

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
      ref.read(walletServiceHistoryProvider('wallet').notifier).refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(walletServiceHistoryProvider('wallet'));
    final allTxns = state.filteredTransactions;

    return HistoryScreen<UserTransactions>(
      titleText: 'Wallet History',
      items: allTxns,
      isLoading: state.isLoading,
      onSearchChanged: (query) {
        ref.read(walletServiceHistoryProvider('wallet').notifier).search(query);
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

              ref
                  .read(walletServiceHistoryProvider('wallet').notifier)
                  .applyFilters(
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
      itemBuilder: (ctx, txn, index) => ServiceListItem(transaction: txn),
      onItemTap: _showTransactionDetails,
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

  String _formatDate(String? dateStr) {
    final dt = dateStr?.toDateTime();
    if (dt == null) return '--';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final txnDate = DateTime(dt.year, dt.month, dt.day);

    if (txnDate == today) return 'Today';
    if (txnDate == yesterday) return 'Yesterday';

    return DateFormat('MMMM d, yyyy').format(dt); // ➤ e.g., July 6, 2025
  }

  String _formatTime(String? createdAt) {
    try {
      final time = createdAt!.toDateTime()?.toLocal();
      return time == null
          ? '--:--'
          : '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return '--:--';
    }
  }

  void _showTransactionDetails(UserTransactions txn) {
    TransactionReceiptData transactionData;
    final transTypeLower = (txn.transType ?? '').toLowerCase();

    if (transTypeLower.contains('fund_wallet')) {
      // Handle fund wallet transaction
      transactionData = TransactionReceiptData(
        transactionId: txn.transRef.toString(),
        date: _formatDate(txn.createdAt.toString() ?? ''),
        time: _formatTime(txn.createdAt.toString()),
        type: txn.transType,
        amount: CurrencyFormatter.format(txn.amount),
        accountNumber: txn.crAcc,
        status: txn.status ?? '',
        description: txn.subProduct?.subName ?? '',
        paymentMethod: txn.paymentType ?? '',
        userBalance: txn.balanceAfter != null
            ? CurrencyFormatter.format(txn.balanceAfter)
            : null,
        balanceBefore: txn.balanceBefore != null
            ? CurrencyFormatter.format(txn.balanceBefore)
            : null,
      );
    } else if (transTypeLower.contains('withdrawal')) {
      // Handle withdrawal transaction
      transactionData = TransactionReceiptData(
        transactionId: txn.transRef.toString(),
        date: _formatDate(txn.createdAt.toString() ?? ''),
        time: _formatTime(txn.createdAt.toString()),
        type: txn.transType,
        amount: CurrencyFormatter.format(txn.amount),
        accountNumber: txn.crAcc,
        status: txn.status ?? '',
        description: txn.subProduct?.subName ?? '',
        userBalance: txn.balanceAfter != null
            ? CurrencyFormatter.format(txn.balanceAfter)
            : null,
        balanceBefore: txn.balanceBefore != null
            ? CurrencyFormatter.format(txn.balanceBefore)
            : null,
      );
    } else {
      // Default case (should not occur for wallet, but included for robustness)
      transactionData = TransactionReceiptData(
        transactionId: txn.transRef.toString(),
        date: _formatDate(txn.createdAt.toString() ?? ''),
        time: _formatTime(txn.createdAt.toString()),
        type: txn.transType.toString(),
        amount: CurrencyFormatter.format(txn.amount),
        phoneNumber: txn.crAcc,
        status: txn.status ?? '',
        description: txn.subProduct?.subName ?? '',
      );
    }

    context.showPopUp(
      color: Colors.transparent,
      TransactionReceiptWidget(
        data: transactionData,
        onShareReceipt: () {
          context
            ..pop()
            ..showPopUp(
              color: Colors.transparent,
              ReceiptShareWrapper(data: transactionData),
              isDismissable: true,
            );
        },
      ),
      isDismissable: true,
    );
  }
}
