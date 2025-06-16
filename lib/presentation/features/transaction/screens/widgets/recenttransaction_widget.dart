import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/service_provider.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/models/wallet/service_model.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/emptytransaction_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:bundlegram/presentation/general_widget/custom_listview.dart';
import 'package:bundlegram/presentation/general_widget/service_list_item.dart';
import 'package:bundlegram/presentation/general_widget/transaction_share_receipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class RecenttransactionWidget extends StatelessWidget {
//   const RecenttransactionWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           24.verticalSpace,
//           Text(
//             'Recent transaction',
//             style: context.textTheme.displayLarge!.copyWith(
//               fontSize: 20.sp,
//             ),
//           ),
//           40.verticalSpace,
//           const Center(child: EmptytransactionWidget()),
//         ],
//       ),
//     );
//   }
// }
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/providers/service_provider.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/models/transaction_receipt/transaction_receipt_model.dart';
import 'package:bundlegram/data/models/wallet/service_model.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/emptytransaction_widget.dart';
import 'package:bundlegram/presentation/general_widget/service_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RecenttransactionWidget extends ConsumerWidget {
  final Widget? spacing;
  RecenttransactionWidget(this.spacing, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentState = ref.watch(recentTransactionsProvider);
    final recentTransactions =
        _getRecentTransactions(recentState.filteredServices);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Transactions',
          style: context.textTheme.displayLarge!.copyWith(
            fontSize: 20.sp,
          ),
        ),
        spacing ?? 20.verticalSpace,
        _buildRecentTransactionsList(recentTransactions, recentState.isLoading),
      ],
    );
  }

  Widget _buildRecentTransactionsList(
      List<ServiceModel> recentTransactions, bool isLoading) {
    if (isLoading) {
      return _buildLoadingState();
    }

    if (recentTransactions.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(child: EmptytransactionWidget()),
      );
    }

    final limitedTransactions = recentTransactions.take(5).toList();

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      // padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: limitedTransactions.length,
      separatorBuilder: (context, index) => Container(
        height: 1,
        color: AppColors.greyD0.withOpacity(0.1),
        margin: EdgeInsets.symmetric(vertical: 12.h),
      ),
      itemBuilder: (context, index) {
        final transaction = limitedTransactions[index];
        return GestureDetector(
          // onTap: () => _navigateToTransactionDetails(context, transaction),
          child: ServiceListItem(service: transaction),
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 3,
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
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

  List<ServiceModel> _getRecentTransactions(
      List<ServiceModel> allTransactions) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day); // 07-06-2025
    final yesterday = today.subtract(const Duration(days: 1)); // 06-06-2025

    return allTransactions.where((transaction) {
      try {
        final dt = transaction.date.toDateTime() ?? now;
        final txnDate = DateTime(dt.year, dt.month, dt.day);
        return txnDate.isAtSameMomentAs(today) ||
            txnDate.isAtSameMomentAs(yesterday);
      } catch (e) {
        print('Error parsing date for ${transaction.id}: $e');
        return false; // Exclude transactions with invalid dates
      }
    }).toList();
  }

  String _parseTransactionDate(String dateString) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    try {
      final dt = dateString.toDateTime() ?? now;
      final txnDate = DateTime(dt.year, dt.month, dt.day);

      if (txnDate.isAtSameMomentAs(today)) {
        return 'Today';
      } else if (txnDate.isAtSameMomentAs(yesterday)) {
        return 'Yesterday';
      }
      return '${dt.day.toString().padLeft(2, '0')}-${dt.month.toString().padLeft(2, '0')}-${dt.year}';
    } catch (e) {
      final now = DateTime.now();
      return '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';
    }
  }

  // void _navigateToTransactionDetails(
  //     BuildContext context, ServiceModel transaction) {
  //   final transactionData = TransactionReceiptData(
  //     transactionId: transaction.id ?? _generateTransactionId(transaction),
  //     date: _formatTransactionDate(transaction.date),
  //     time: _formatTransactionTime(transaction.date),
  //     type: transaction.type,
  //     amount: transaction.amount,
  //     bankName: transaction.bankName ?? _getDefaultBankName(transaction.type),
  //     accountNumber: transaction.accountNumber ??
  //         _getDefaultAccountNumber(transaction.type),
  //     status: transaction.status,
  //     description: transaction.title,
  //   );

  //   context.showPopUp(
  //     color: Colors.transparent,
  //     TransactionReceiptWidget(data: transactionData),
  //     isDismissable: true,
  //   );
  // }

  String _generateTransactionId(ServiceModel transaction) {
    final prefix = transaction.type.toLowerCase().contains('betting')
        ? 'BT'
        : transaction.type.toLowerCase().contains('airtime')
            ? 'AT'
            : transaction.type.toLowerCase().contains('data')
                ? 'DT'
                : 'TR';
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    return '$prefix${timestamp.substring(timestamp.length - 5)}';
  }

  String _formatTransactionTime(String originalDate) {
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
      case 'internet':
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
      case 'internet':
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
}
