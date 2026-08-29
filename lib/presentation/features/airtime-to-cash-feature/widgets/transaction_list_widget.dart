import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/provider/airtime_to_cash_history_provider.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/widgets/transaction_card.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/widgets/transaction_detail_dialog.dart';
import 'package:bundlegram/presentation/general_widget/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionListWidget extends ConsumerWidget {
  const TransactionListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(airtimeToCashHistoryProvider);
    final notifier = ref.read(airtimeToCashHistoryProvider.notifier);

    if (state.isLoading && state.transactions.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: Center(child: AppLoader()),
      );
    }

    if (state.error != null && state.transactions.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: AppColors.error, size: 28.sp),
            SizedBox(height: 8.h),
            Text(
              state.error!,
              style: context.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            TextButton(
                onPressed: notifier.refresh, child: const Text('Try Again')),
          ],
        ),
      );
    }

    if (state.transactions.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined, color: AppColors.grey80, size: 32.sp),
            SizedBox(height: 8.h),
            Text('No transactions yet', style: context.textTheme.bodySmall),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: notifier.refresh,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.transactions.length,
        itemBuilder: (context, index) {
          final txn = state.transactions[index];
          return TransactionCard(
            transaction: txn,
            onTap: () => TransactionDetailDialog.show(context, txn),
          );
        },
      ),
    );
  }
}
