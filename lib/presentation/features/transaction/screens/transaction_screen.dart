import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/service_provider.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/models/transaction_receipt/transaction_receipt_model.dart';
import 'package:bundlegram/data/models/wallet/service_model.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/emptytransaction_widget.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/filter_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:bundlegram/presentation/general_widget/receipt_widget.dart';
import 'package:bundlegram/presentation/general_widget/service_list_item.dart';
import 'package:bundlegram/presentation/general_widget/transaction_share_receipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TransactionScreen extends ConsumerStatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends ConsumerState<TransactionScreen> {
  bool isDismissed = false;
  String _sortBy = 'newest';
  String _amountBy = 'largest';
  final Set<String> _statusSet = {};
  final Set<String> _typeSet = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(transactionHistoryProvider.notifier).loadServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(transactionHistoryProvider);
    final allTxns = state.filteredServices;
    print('Displayed Transactions: ${allTxns.length}'); // Debug

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
                  print(
                      'Applied Filters: typeSet=$_typeSet, statusSet=$_statusSet');

                  ref.read(transactionHistoryProvider.notifier).applyFilters(
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: AppTextField(
              decoration: const InputDecoration().search(),
              onChange: (value) {
                ref.read(transactionHistoryProvider.notifier).search(value);
              },
            ),
          ),
          20.horizontalSpace,
          Expanded(
            child: allTxns.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: EmptytransactionWidget()),
                  )
                : ListView.separated(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 25),
                    itemCount: allTxns.length,
                    separatorBuilder: (ctx, idx) => Container(
                      height: 1,
                      color: AppColors.greyD0.withOpacity(0.1),
                      margin: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    itemBuilder: (ctx, index) {
                      final txn = allTxns[index];
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

  void _showTransactionDetails(ServiceModel txn) {
    final data = TransactionReceiptData(
      transactionId: txn.id,
      date: _formatDate(txn.date),
      time: _formatTime(txn.date),
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
        data: data,
        onShareReceipt: () {
          context.pop();
          context.showPopUp(
            color: Colors.transparent,
            generateShareableReceipt(data),
            isDismissable: true,
          );
        },
      ),
      isDismissable: true,
    );
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

  String _formatTime(String date) {
    final now = DateTime.now();
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

  String _getDefaultBankName(String transactionType) {
    switch (transactionType.toLowerCase()) {
      case 'betting':
        return 'Sportybet';
      case 'mobile data':
      case 'internet service':
        return 'MTN Nigeria';
      case 'airtime':
      case 'top-up':
        return 'Airtel Nigeria';
      case 'electricity':
        return 'EKEDC';
      case 'cable tv':
        return 'DSTV';
      case 'education':
        return 'JAMB';
      case 'e-pin voucher':
        return 'Recharge Card';
      default:
        return 'Bundlegram Wallet';
    }
  }

  String _getDefaultAccountNumber(String transactionType) {
    switch (transactionType.toLowerCase()) {
      case 'betting':
        return '********';
      case 'mobile data':
      case 'internet service':
      case 'airtime':
      case 'top-up':
        return '080********';
      case 'electricity':
        return '12345678';
      case 'cable tv':
        return '1234567890';
      case 'education':
        return 'JAMB2025';
      case 'e-pin voucher':
        return '********';
      default:
        return '0821971234';
    }
  }

  Widget generateShareableReceipt(TransactionReceiptData data) {
    return Container(
      child: VisualReceiptCard(data: data),
    );
  }
}
