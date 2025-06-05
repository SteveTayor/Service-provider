import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/emptytransaction_widget.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/filter_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:bundlegram/presentation/general_widget/receipt_widget.dart';
import 'package:bundlegram/presentation/general_widget/transaction_share_receipt.dart';
import 'package:bundlegram/presentation/general_widget/service_list_item.dart';

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/models/transaction_receipt/transaction_receipt_model.dart';
import 'package:bundlegram/data/models/wallet/service_model.dart';
import 'package:bundlegram/core/providers/service_provider.dart';
import 'package:go_router/go_router.dart';

class TransactionScreen extends ConsumerStatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends ConsumerState<TransactionScreen> {
  bool isDismissed = false;

  /// Local copies of filter selections
  String _sortBy = 'newest';
  String _amountBy = 'largest';
  final Set<String> _statusSet = {};
  final Set<String> _typeSet = {};

  @override
  void initState() {
    super.initState();
    // Load all underlying providers once on mount:
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bettingHistoryProvider.notifier).loadServices();
      ref.read(mobileDataHistoryProvider.notifier).loadServices();
      ref.read(educationHistoryProvider.notifier).loadServices();
      ref.read(cableTvHistoryProvider.notifier).loadServices();
      ref.read(electricityHistoryProvider.notifier).loadServices();
      ref.read(airtimeHistoryProvider.notifier).loadServices();
      ref.read(ePinHistoryProvider.notifier).loadServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(recentTransactionsProvider);
    final allTxns = state.filteredServices;
    final recent = _getRecentTransactions(allTxns);

    return BundlegramScaffold(
      appBar: BundlegramAppbar(
        showBackButton: false,
        titleText: 'Transactions',
        trailing: GestureDetector(
          onTap: () {
            context.showBottomSheet(
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

                  // Apply all filters
                  ref.read(recentTransactionsProvider.notifier).applyFilters(
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
          child: Text(
            'Filter',
            style: context.textTheme.bodySmall!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: AppTextField(
              decoration: const InputDecoration().search(),
              onChange: (value) {
                ref.read(recentTransactionsProvider.notifier).search(value);
              },
            ),
          ),
          SizedBox(height: 20.h),

          // List of filtered + recent transactions
          Expanded(
            child: recent.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: EmptytransactionWidget()),
                  )
                : ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: recent.length,
                    separatorBuilder: (ctx, idx) => Container(
                      height: 1,
                      color: AppColors.greyD0.withOpacity(0.3),
                      margin: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    itemBuilder: (ctx, index) {
                      final txn = recent[index];
                      return GestureDetector(
                        onTap: () => _showTransactionDetails(txn),
                        child: ServiceListItem(service: txn),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  List<ServiceModel> _getRecentTransactions(List<ServiceModel> all) {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    return all.where((txn) {
      try {
        final dt =
            txn.date.toDateTime() ?? now.subtract(const Duration(days: 8));
        return dt.isAfter(sevenDaysAgo);
      } catch (_) {
        return false;
      }
    }).toList();
  }

  void _showTransactionDetails(ServiceModel txn) {
    final data = TransactionReceiptData(
      transactionId: txn.id,
      date: txn.date,
      time: txn.date ?? '',
      type: txn.type,
      amount: txn.amount,
      bankName: txn.bankName ?? '',
      accountNumber: txn.accountNumber ?? '',
      status: txn.status,
    );
    context.showPopUp(
      color: Colors.transparent,
      TransactionReceiptWidget(
        data: data,
        onShareReceipt: () {
          // setState(() {
          //   isDismissed = !isDismissed;
          // });
          context.pop();
          context.showPopUp(
            color: Colors.transparent,
            generateShareableReceipt(data),
            isDismissable: isDismissed,
          );
        },
      ),
      // isDismissable: isDismissed,
    );
  }

  Widget generateShareableReceipt(TransactionReceiptData data) {
    return Container(
      color: AppColors.greyD0,
      padding: EdgeInsets.all(20.w),
      child: VisualReceiptCard(data: data),
    );
  }
}
