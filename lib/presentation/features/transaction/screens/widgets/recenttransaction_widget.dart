import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/emptytransaction_widget.dart';
import 'package:bundlegram/presentation/general_widget/service_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bundlegram/core/providers/service_provider.dart';

class RecentTransactionWidget extends ConsumerWidget {
  final Widget? spacing;
  const RecentTransactionWidget(this.spacing, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentState = ref.watch(recentTransactionsProvider);
    final recentTransactions = recentState.filteredServices.take(5).toList();

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
        _buildRecentTransactionsList(
            context, recentTransactions, recentState.isLoading),
      ],
    );
  }

  Widget _buildRecentTransactionsList(
    BuildContext context,
    List<UserTransactions> transactions,
    bool isLoading,
  ) {
    if (isLoading) return _buildLoadingState();

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
        return ServiceListItem(transaction: transaction);
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
