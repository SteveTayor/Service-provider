// lib/presentation/features/wallet/wallet_history_screen.dart

import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/data/models/transaction_receipt/transaction_receipt_model.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/filter_sheet.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/filter_widget.dart';
import 'package:bundlegram/presentation/general_widget/history_widget.dart';
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
    final recent = _getRecentTransactions(allTxns);

    return HistoryScreen<ServiceModel>(
      titleText: 'History',
      items: recent,
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
        final dt = _parseDate(txn.date);
        return dt.isAfter(sevenDaysAgo);
      } catch (_) {
        return false;
      }
    }).toList();
  }

  DateTime _parseDate(String s) {
    final today = DateTime.now();
    switch (s.toLowerCase()) {
      case 'today':
        return DateTime(today.year, today.month, today.day);
      case 'yesterday':
        final y = today.subtract(const Duration(days: 1));
        return DateTime(y.year, y.month, y.day);
      default:
        if (s.toLowerCase().contains('days ago')) {
          final m = RegExp(r'(\d+)').firstMatch(s);
          if (m != null) {
            final d = int.parse(m.group(1)!);
            final dd = today.subtract(Duration(days: d));
            return DateTime(dd.year, dd.month, dd.day);
          }
        }
        final dt = s.toDateTime();
        return dt ?? today.subtract(const Duration(days: 8));
    }
  }

  void _showTransactionDetails(ServiceModel txn) {
    // Show a bottom sheet or dialog with transaction details
    final transactionData = TransactionReceiptData(
      transactionId: txn.id,
      date: _parseDate(txn.date) as String,
      time: (txn.date),
      type: txn.type,
      amount: txn.amount,
      bankName: txn.bankName as String,
      accountNumber: txn.accountNumber ?? '72398923233',
      status: txn.status,
      description: txn.title,
    );
    context.showPopUp(
      color: Colors.transparent,
      transactionData as Widget,
      isDismissable: true,
    );
  }
}
