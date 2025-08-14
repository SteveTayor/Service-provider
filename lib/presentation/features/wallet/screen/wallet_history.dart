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

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown Date';

    final localDate = date.toLocal(); // <-- Always convert first
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final txnDate = DateTime(localDate.year, localDate.month, localDate.day);

    // if (txnDate.isAtSameMomentAs(today)) return 'Today';
    // if (txnDate.isAtSameMomentAs(yesterday)) return 'Yesterday';

    return DateFormat('EEE MMM dd yyyy').format(localDate);
  }

  String _formatTime(DateTime? date) {
    if (date == null) return '--:--';

    final localDate = date.toLocal(); // <-- Always convert first
    final hour = localDate.hour;
    final minute = localDate.minute;
    final period = hour >= 12 ? 'pm' : 'am';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}$period';
  }

  void _showTransactionDetails(UserTransactions txn) {
    TransactionReceiptData transactionData;
    final transTypeLower = (txn.transType ?? '').toLowerCase();

    if (transTypeLower.contains('fund_wallet')) {
      // Handle fund wallet transaction
      transactionData = TransactionReceiptData(
        transactionId: txn.transRef.toString(),
        date: _formatDate(txn.createdAt),
        time: _formatTime(txn.createdAt),
        type: txn.transType,
        amount: txn.amount.toCurrency(),
        accountNumber: txn.crAcc,
        status: txn.status ?? '',
        description: txn.subProduct?.subName ?? '',
        paymentMethod: txn.paymentType ?? '',
        userBalance:
            txn.balanceAfter != null ? txn.balanceAfter.toCurrency() : null,
        balanceBefore:
            txn.balanceBefore != null ? txn.balanceBefore.toCurrency() : null,
      );
    } else if (transTypeLower.contains('withdrawal')) {
      // Handle withdrawal transaction
      transactionData = TransactionReceiptData(
        transactionId: txn.transRef.toString(),
        date: _formatDate(txn.createdAt),
        time: _formatTime(txn.createdAt),
        type: txn.transType,
        amount: txn.amount.toCurrency(),
        accountNumber: txn.crAcc,
        status: txn.status ?? '',
        description: txn.subProduct?.subName ?? '',
        userBalance:
            txn.balanceAfter != null ? txn.balanceAfter.toCurrency() : null,
        balanceBefore:
            txn.balanceBefore != null ? txn.balanceBefore.toCurrency() : null,
      );
    } else {
      // Default case (should not occur for wallet, but included for robustness)
      transactionData = TransactionReceiptData(
        transactionId: txn.transRef.toString(),
        date: _formatDate(txn.createdAt),
        time: _formatTime(txn.createdAt),
        type: txn.transType.toString(),
        amount: txn.amount.toCurrency(),
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
