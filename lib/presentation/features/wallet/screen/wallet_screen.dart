import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/service_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/models/transaction_receipt/transaction_receipt_model.dart';
import 'package:bundlegram/data/models/wallet/service_model.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/emptytransaction_widget.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/recenttransaction_widget.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_notifier.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/receipt_widget.dart';
import 'package:bundlegram/presentation/general_widget/service_list_item.dart';
import 'package:bundlegram/presentation/general_widget/transaction_share_receipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WalletScreen extends ConsumerStatefulWidget {
  const WalletScreen({super.key});

  @override
  ConsumerState<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends ConsumerState<WalletScreen> {
  bool isDismissed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(walletHistoryProvider.notifier).loadServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      appBar: BundlegramAppbar(
        showBackButton: false,
        titleText: 'Wallet',
        trailing: GestureDetector(
          onTap: () {
            context.push('/walletHistoryScreen');
          },
          child: Text(
            'History',
            style: context.textTheme.bodySmall!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Wallet balance',
                            style: context.textTheme.bodySmall!.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          8.horizontalSpace,
                          const Icon(
                            Icons.visibility,
                            size: 20,
                            color: AppColors.white,
                          ),
                          const Spacer(),
                          Flexible(
                            child: BundlegramButton(
                              width: 105.w,
                              height: 50.h,
                              color: AppColors.white,
                              cornerRadius: 4.r,
                              text: 'Withdraw',
                              textStyle: context.textTheme.bodyMedium!
                                  .copyWith(color: AppColors.primaryColor),
                              onPressed: () {
                                context.push(RouteConstants.withdrawFund);
                              },
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'N40,000',
                        style: context.textTheme.bodyLarge!.copyWith(
                          fontSize: 40.sp,
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Assets.images.growth.image(),
                ),
              ],
            ).withContainer(
              color: AppColors.primaryColor,
              height: 328.h,
              width: context.width,
            ),
            32.verticalSpace,
            BundlegramButton(
              svgIconContainerColor: Colors.transparent,
              leading: Assets.svgs.walletAdd,
              text: 'Top-up wallet',
              onPressed: () {
                WalletNotifier().showAddMoney(context);
              },
            ),
            45.verticalSpace,
            RecenttransactionWidget(
              SizedBox(
                height: 20.h,
              ),
            ),
            // ..._buildWalletRecentTransactions(),
          ],
        ),
      ),
    );
  }

  // List<Widget> _buildWalletRecentTransactions() {
  //   final recentState = ref.watch(recentTransactionsProvider);
  //   final recentTransactions =
  //       _getRecentTransactions(recentState.filteredServices);

  //   return [
  //     40.verticalSpace,
  //     Text(
  //       'Recent transaction',
  //       style: context.textTheme.displayLarge!.copyWith(
  //         fontSize: 20.sp,
  //       ),
  //     ),
  //     16.verticalSpace,
  //     _buildRecentTransactionsList(recentTransactions, recentState.isLoading),
  //   ];
  // }

  // Widget _buildRecentTransactionsList(
  //     List<ServiceModel> recentTransactions, bool isLoading) {
  //   if (isLoading) {
  //     return _buildLoadingState();
  //   }

  //   if (recentTransactions.isEmpty) {
  //     return const Padding(
  //       padding: EdgeInsets.all(20),
  //       child: Center(child: EmptytransactionWidget()),
  //     );
  //   }

  //   final limitedTransactions = recentTransactions.take(5).toList();

  //   return ListView.separated(
  //     physics: const NeverScrollableScrollPhysics(),
  //     shrinkWrap: true,
  //     // padding: EdgeInsets.symmetric(horizontal: 20.w),
  //     itemCount: limitedTransactions.length,
  //     separatorBuilder: (context, index) => Container(
  //       height: 1,
  //       color: AppColors.greyD0.withOpacity(0.3),
  //       margin: EdgeInsets.symmetric(vertical: 12.h),
  //     ),
  //     itemBuilder: (context, index) {
  //       final transaction = limitedTransactions[index];
  //       return GestureDetector(
  //         onTap: () => _navigateToTransactionDetails(transaction),
  //         child: ServiceListItem(service: transaction),
  //       );
  //     },
  //   );
  // }

  // Widget _buildLoadingState() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 20.w),
  //     child: ListView.separated(
  //       physics: const NeverScrollableScrollPhysics(),
  //       shrinkWrap: true,
  //       itemCount: 3,
  //       separatorBuilder: (context, index) => SizedBox(height: 12.h),
  //       itemBuilder: (context, index) {
  //         return Container(
  //           height: 60.h,
  //           decoration: BoxDecoration(
  //             color: AppColors.greyD0.withOpacity(0.3),
  //             borderRadius: BorderRadius.circular(8.r),
  //           ),
  //           child: Row(
  //             children: [
  //               16.horizontalSpace,
  //               Container(
  //                 width: 40.w,
  //                 height: 40.w,
  //                 decoration: BoxDecoration(
  //                   color: AppColors.greyD0.withOpacity(0.5),
  //                   shape: BoxShape.circle,
  //                 ),
  //               ),
  //               16.horizontalSpace,
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Container(
  //                       width: 120.w,
  //                       height: 14.h,
  //                       decoration: BoxDecoration(
  //                         color: AppColors.greyD0.withOpacity(0.5),
  //                         borderRadius: BorderRadius.circular(4.r),
  //                       ),
  //                     ),
  //                     8.verticalSpace,
  //                     Container(
  //                       width: 80.w,
  //                       height: 12.h,
  //                       decoration: BoxDecoration(
  //                         color: AppColors.greyD0.withOpacity(0.5),
  //                         borderRadius: BorderRadius.circular(4.r),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Container(
  //                 width: 60.w,
  //                 height: 14.h,
  //                 decoration: BoxDecoration(
  //                   color: AppColors.greyD0.withOpacity(0.5),
  //                   borderRadius: BorderRadius.circular(4.r),
  //                 ),
  //               ),
  //               16.horizontalSpace,
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  // List<ServiceModel> _getRecentTransactions(
  //     List<ServiceModel> allTransactions) {
  //   final now = DateTime.now();
  //   final sevenDaysAgo = now.subtract(const Duration(days: 7));

  //   return allTransactions.where((transaction) {
  //     try {
  //       final transactionDate = _parseTransactionDate(transaction.date);
  //       return transactionDate.isAfter(sevenDaysAgo);
  //     } catch (e) {
  //       return false;
  //     }
  //   }).toList();
  // }

  // DateTime _parseTransactionDate(String dateString) {
  //   final now = DateTime.now();
  //   final today = DateTime(now.year, now.month, now.day);

  //   switch (dateString.toLowerCase()) {
  //     case 'today':
  //       return today;
  //     case 'yesterday':
  //       return today.subtract(const Duration(days: 1));
  //     default:
  //       if (dateString.toLowerCase().contains('days ago')) {
  //         final daysMatch = RegExp(r'(\d+)').firstMatch(dateString);
  //         if (daysMatch != null) {
  //           final days = int.parse(daysMatch.group(1)!);
  //           return today.subtract(Duration(days: days));
  //         }
  //       }
  //       if (dateString.toLowerCase().contains('day ago')) {
  //         return today.subtract(const Duration(days: 1));
  //       }
  //       final parsedDate = dateString.toDateTime();
  //       if (parsedDate != null) {
  //         return parsedDate;
  //       }
  //       return today.subtract(const Duration(days: 8));
  //   }
  // }

  // void _navigateToTransactionDetails(ServiceModel transaction) {
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
  //     TransactionReceiptWidget(
  //       data: transactionData,
  //       onShareReceipt: () {
  //         context.pop();
  //         context.showPopUp(
  //           color: Colors.transparent,
  //           generateShareableReceipt(transactionData),
  //           isDismissable: true,
  //         );
  //       },
  //     ),
  //   );
  // }

  // String _generateTransactionId(ServiceModel transaction) {
  //   final prefix = transaction.type.toLowerCase().contains('betting')
  //       ? 'BT'
  //       : transaction.type.toLowerCase().contains('airtime')
  //           ? 'AT'
  //           : transaction.type.toLowerCase().contains('data')
  //               ? 'DT'
  //               : 'TR';
  //   final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  //   return '$prefix${timestamp.substring(timestamp.length - 5)}';
  // }

  // String _formatTransactionDate(String originalDate) {
  //   try {
  //     final now = DateTime.now();
  //     final today = DateTime(now.year, now.month, now.day);

  //     switch (originalDate.toLowerCase()) {
  //       case 'today':
  //         return '${today.day.toString().padLeft(2, '0')}-${today.month.toString().padLeft(2, '0')}-${today.year}';
  //       case 'yesterday':
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
  //         return '${today.day.toString().padLeft(2, '0')}-${today.month.toString().padLeft(2, '0')}-${today.year}';
  //     }
  //   } catch (e) {
  //     final now = DateTime.now();
  //     return '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';
  //   }
  // }

  // String _formatTransactionTime(String originalDate) {
  //   final now = DateTime.now();
  //   if (originalDate.toLowerCase() == 'today') {
  //     final hour = now.hour;
  //     final minute = now.minute;
  //     final period = hour >= 12 ? 'pm' : 'am';
  //     final displayHour = hour > 12
  //         ? hour - 12
  //         : hour == 0
  //             ? 12
  //             : hour;
  //     return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}$period';
  //   }
  //   final hours = [9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8];
  //   final minutes = [10, 15, 20, 25, 30, 35, 40, 45, 50, 55];
  //   final periods = ['am', 'pm'];
  //   final randomHour = hours[DateTime.now().microsecond % hours.length];
  //   final randomMinute = minutes[DateTime.now().microsecond % minutes.length];
  //   final randomPeriod = periods[DateTime.now().microsecond % periods.length];
  //   return '${randomHour.toString().padLeft(2, '0')}:${randomMinute.toString().padLeft(2, '0')}$randomPeriod';
  // }

  // String _getDefaultBankName(String transactionType) {
  //   switch (transactionType.toLowerCase()) {
  //     case 'betting':
  //       return 'Sportybet';
  //     case 'mobile data':
  //     case 'internet':
  //       return 'MTN Nigeria';
  //     case 'airtime':
  //     case 'top-up':
  //       return 'Airtel Nigeria';
  //     case 'electricity':
  //       return 'EKEDC';
  //     case 'cable tv':
  //       return 'DSTV';
  //     case 'education':
  //       return 'JAMB';
  //     case 'e-pin voucher':
  //       return 'Recharge Card';
  //     default:
  //       return 'Bundlegram Wallet';
  //   }
  // }

  // String _getDefaultAccountNumber(String transactionType) {
  //   switch (transactionType.toLowerCase()) {
  //     case 'betting':
  //       return '********';
  //     case 'mobile data':
  //     case 'internet':
  //     case 'airtime':
  //     case 'top-up':
  //       return '080********';
  //     case 'electricity':
  //       return '12345678';
  //     case 'cable tv':
  //       return '1234567890';
  //     case 'education':
  //       return 'JAMB2025';
  //     case 'e-pin voucher':
  //       return '********';
  //     default:
  //       return '0821971234';
  //   }
  // }
}
