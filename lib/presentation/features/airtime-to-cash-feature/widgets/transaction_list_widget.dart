import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/provider/airtime_to_cash_history_provider.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/widgets/transaction_card.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/widgets/transaction_detail_dialog.dart';
import 'package:bundlegram/presentation/general_widget/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionListWidget extends ConsumerWidget {
  const TransactionListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(airtimeToCashHistoryProvider);
    final notifier = ref.read(airtimeToCashHistoryProvider.notifier);

    if (state.isLoading && state.transactions.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 34.h),
        child: const Center(child: AppLoader()),
      );
    }

    if (state.error != null && state.transactions.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                color: AppColors.error,
                size: 26.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              state.error!,
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.grey80,
                height: 1.45,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            TextButton(
              onPressed: notifier.refresh,
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    if (state.transactions.isEmpty) {
      // Polished fintech empty state — custom SVG illustration (phone
      // signal -> arrow -> cash wallet, in the brand green/neutral
      // palette) rather than a generic Material inbox icon. No button
      // here per spec — the "+ Convert Airtime" FAB above the screen
      // remains the single primary action.
      return Padding(
        padding: EdgeInsets.fromLTRB(8.w, 20.h, 8.w, 22.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/airtime_to_cash_empty.svg',
              width: 122.w,
              height: 92.h,
            ),
            SizedBox(height: 12.h),
            Text(
              'No conversions yet',
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              'Your Airtime-to-Cash transactions will appear here after your first conversion.',
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.grey80,
                height: 1.45,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
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
    );
  }
}
