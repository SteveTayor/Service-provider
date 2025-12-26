import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_formatter.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
import 'package:bundlegram/data/models/transaction_receipt/transaction_receipt_model.dart';
import 'package:bundlegram/presentation/features/transaction/notifier/recent_transaction_state.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/emptytransaction_widget.dart';
import 'package:bundlegram/presentation/general_widget/receipt_widget.dart';
import 'package:bundlegram/presentation/general_widget/service_list_item.dart';
import 'package:bundlegram/presentation/general_widget/transaction_share_receipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bundlegram/core/providers/service_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class RecentTransactionWidget extends ConsumerWidget {
  final StateNotifierProvider<StateNotifier<RecentTransactionsState>,
      RecentTransactionsState> transactionProvider;
  final Widget? spacing;
  final String? title;
  const RecentTransactionWidget(this.spacing,
      {required this.transactionProvider,
      this.title = 'Recent Transactions',
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final recentState = ref.watch(recentTransactionsProvider);
    final recentState = ref.watch(transactionProvider);
    // Wait until loading is done before rendering anything
    if (recentState.isLoading) {
      return _buildLoadingState();
    }
    final recentTransactions = recentState.filteredServices.take(5).toList();
    if (recentTransactions.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: EmptytransactionWidget(),
      );
    }
    if (recentState.error != null) return ErrorWidget('Something went wrong');
    if (recentState.filteredServices.isEmpty) return EmptytransactionWidget();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: context.textTheme.titleSmall!.copyWith(fontSize: 18.sp),
        ),
        spacing ?? 20.verticalSpace,
        _buildRecentTransactionsList(
          context,
          recentTransactions,
          recentState.isLoading,
          ref,
        ),
      ],
    );
  }

  Widget _buildRecentTransactionsList(
    BuildContext context,
    List<UserTransactions> transactions,
    bool isLoading,
    WidgetRef ref,
  ) {
    // only show the skeleton if we're loading *and* have no items yet
    if (isLoading && transactions.isEmpty) {
      return _buildLoadingState();
    }

    if (transactions.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(child: EmptytransactionWidget()),
      );
    }

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: transactions.length,
      separatorBuilder: (_, __) => Container(
        height: 1,
        color: AppColors.greyD0.withOpacity(0.1),
        margin: EdgeInsets.symmetric(vertical: 12.h),
      ),
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return InkWell(
          highlightColor: Colors.transparent,
          onTap: () {
            HapticFeedback.selectionClick();
            _showTransactionDetails(context, transaction);
          },
          child: ServiceListItem(useResponsive: true, transaction: transaction),
        );
      },
    );
  }

  void _showTransactionDetails(BuildContext context, UserTransactions txn) {
    TransactionReceiptData data;
    final transTypeLower = (txn.transType ?? '').toLowerCase();

    if (transTypeLower.contains('airtime')) {
      // Handle airtime transaction
      data = TransactionReceiptData(
        transactionId: txn.transRef ?? 'BNG-${txn.id}',
        date: _formatDate(txn.createdAt),
        time: _formatTime(txn.createdAt),
        type: getTransactionType(txn),
        amount: txn.deductAmount.toCurrency(),
        status: txn.status ?? 'Unknown',
        description: txn.subProduct?.subName ??
            txn.subProduct?.product?.productName ??
            '',
        network: txn.subProduct?.product?.productName,
        phoneNumber: txn.crAcc,
        balanceBefore: txn.balanceBefore?.toCurrency(),
        userBalance: txn.balanceAfter?.toCurrency(),
      );
    } else if (transTypeLower.contains('data')) {
      // Handle data transaction
      data = TransactionReceiptData(
        transactionId: txn.transRef ?? 'BNG-${txn.id}',
        date: _formatDate(txn.createdAt),
        time: _formatTime(txn.createdAt),
        type: getTransactionType(txn),
        amount: txn.deductAmount.toCurrency(),
        status: txn.status ?? 'Unknown',
        description: txn.subProduct?.subName ??
            txn.subProduct?.product?.productName ??
            '',
        network: txn.subProduct?.product?.productName,
        dataBundle: txn.subProduct?.subName,
        phoneNumber: txn.crAcc,
        balanceBefore: txn.balanceBefore?.toCurrency(),
        userBalance: txn.balanceAfter?.toCurrency(),
      );
    } else if (transTypeLower.contains('withdrawal')) {
      // Handle withdrawal transaction
      data = TransactionReceiptData(
        transactionId: txn.transRef ?? 'BNG-${txn.id}',
        date: _formatDate(txn.createdAt),
        time: _formatTime(txn.createdAt),
        type: getTransactionType(txn),
        amount: txn.amount.toCurrency(),
        accountNumber:
            txn.crAcc ?? _getDefaultAccountNumber(txn.transType ?? ''),
        status: txn.status ?? 'Unknown',
        description: txn.subProduct?.subName ??
            txn.subProduct?.product?.productName ??
            '',
        userBalance: txn.balanceAfter?.toCurrency(),
        balanceBefore: txn.balanceBefore?.toCurrency(),
      );
    } else if (transTypeLower.contains('fund_wallet')) {
      // Handle fund wallet transaction
      data = TransactionReceiptData(
        transactionId: txn.transRef ?? 'BNG-${txn.id}',
        date: _formatDate(txn.createdAt),
        time: _formatTime(txn.createdAt),
        type: getTransactionType(txn),
        amount: txn.amount.toCurrency(),
        accountNumber:
            txn.crAcc ?? _getDefaultAccountNumber(txn.transType ?? ''),
        status: txn.status ?? 'Unknown',
        description: txn.subProduct?.subName ??
            txn.subProduct?.product?.productName ??
            '',
        paymentMethod: txn.paymentType ?? '',
        userBalance: txn.balanceAfter?.toCurrency(),
        balanceBefore: txn.balanceBefore?.toCurrency(),
      );
    } else if (transTypeLower.contains('cable')) {
      // Handle data transaction
      data = TransactionReceiptData(
        transactionId: txn.transRef ?? 'BNG-${txn.id}',
        date: _formatDate(txn.createdAt),
        time: _formatTime(txn.createdAt),
        type: getTransactionType(txn),
        amount: txn.amount.toCurrency(),
        // accountNumber:
        //     txn.crAcc ?? _getDefaultAccountNumber(txn.transType ?? ''),
        status: txn.status ?? 'Unknown',
        description: txn.subProduct?.subName ??
            txn.subProduct?.product?.productName ??
            '',
        smartCardNumber: txn.crAcc,
        balanceBefore: txn.balanceBefore?.toCurrency(),
        userBalance: txn.balanceAfter?.toCurrency(),
      );
    } else if (transTypeLower.contains('electricity')) {
      // Handle data transaction
      data = TransactionReceiptData(
        transactionId: txn.transRef ?? 'BNG-${txn.id}',
        date: _formatDate(txn.createdAt),
        time: _formatTime(txn.createdAt),
        type: getTransactionType(txn),

        amount: txn.amount.toCurrency(),
        // accountNumber:
        //     txn.crAcc ?? _getDefaultAccountNumber(txn.transType ?? ''),
        status: txn.status ?? 'Unknown',
        description: txn.subProduct?.subName ??
            txn.subProduct?.product?.productName ??
            '',

        meterNumber: txn.crAcc,
        token: txn.token,
        balanceBefore: txn.balanceBefore?.toCurrency(),
        userBalance: txn.balanceAfter?.toCurrency(),
      );
    } else {
      // Default case for other transaction types
      data = TransactionReceiptData(
        transactionId: txn.transRef ?? 'BNG-${txn.id}',
        date: _formatDate(txn.createdAt),
        time: _formatTime(txn.createdAt),
        type: getTransactionType(txn) ?? 'N/A',
        amount: txn.transType != 'fund_wallet' && txn.transType != 'withdrawal'
            ? txn.deductAmount.toCurrency()
            : txn.amount.toCurrency(),
        accountNumber:
            txn.crAcc ?? _getDefaultAccountNumber(txn.transType ?? ''),
        status: txn.status ?? 'Unknown',
        description: txn.subProduct?.subName ??
            txn.subProduct?.product?.productName ??
            '',
        balanceBefore: txn.balanceBefore?.toCurrency(),
        userBalance: txn.balanceAfter?.toCurrency(),
      );
    }
    context.showPopUp(
      color: Colors.transparent,
      TransactionReceiptWidget(
        data: data,
        onShareReceipt: () {
          context
            ..pop()
            ..showPopUp(
              color: Colors.transparent,
              ReceiptShareWrapper(data: data),
              isDismissable: true,
            );
        },
      ),
      isDismissable: true,
    );
  }

  String getTransactionType(UserTransactions data) {
    switch (data.transType?.toLowerCase()) {
      case 'mobile_data':
        return 'Mobile Data';
      case 'electricity':
        return 'Electricity';
      case 'airtime':
        return 'Airtime';
      case 'cable_tv':
        return 'Cable TV';
      case 'internet_service':
        return 'Internet Service';
      case 'fund_wallet':
        return 'Top-up';
      case 'withdrawal':
        return 'Withdrawal';
      case 'betting':
        return 'Betting';
      default:
        return data.transType!.capiTalizeFirstLast;
    }
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

  String _getDefaultAccountNumber(String type) {
    switch (type.toLowerCase()) {
      case 'airtime':
      case 'data':
        return '080********';
      case 'electricity':
        return '1234567890';
      case 'withdrawal':
        return '305**********';
      case 'betting':
        return '********';
      default:
        return '0821971234';
    }
  }

  Widget _buildLoadingState() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 3,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (_, __) {
          return Container(
            height: 60.h,
            decoration: BoxDecoration(
              color: AppColors.greyD0.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                16.horizontalSpace,
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: AppColors.greyD0.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120.w,
                        height: 14.h,
                        decoration: BoxDecoration(
                          color: AppColors.greyD0.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      8.verticalSpace,
                      Container(
                        width: 80.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: AppColors.greyD0.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 60.w,
                  height: 14.h,
                  decoration: BoxDecoration(
                    color: AppColors.greyD0.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                16.horizontalSpace,
              ],
            ),
          );
        },
      ),
    );
  }
}
