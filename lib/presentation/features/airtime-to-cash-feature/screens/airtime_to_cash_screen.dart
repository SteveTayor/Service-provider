import 'package:bundlegram/core/extensions/responsive_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/provider/airtime_to_cash_history_provider.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/widgets/conversion_flow_sheet.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/widgets/transaction_list_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AirtimeToCashScreen extends ConsumerWidget {
  const AirtimeToCashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyNotifier = ref.read(airtimeToCashHistoryProvider.notifier);

    return BundlegramScaffold(
      sidePadding: EdgeInsets.zero,
      appBar: const BundlegramAppbar(titleText: 'Airtime to Cash'),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: historyNotifier.refresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              // Bottom padding clears the FAB so the last transaction card
              // is never hidden behind it.
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 104.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _IntroCard(),
                  SizedBox(height: 20),
                  _RecentConversionsCard(),
                ],
              ),
            ),
          ),
          Positioned(
            right: 16.w,
            bottom: 20.h,
            child: SafeArea(
              top: false,
              left: false,
              child: _ConvertFab(
                onPressed: () => showAirtimeToCashConversionSheet(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Compact informative section — deliberately not a big button-heavy
/// card. The "New Conversion" call to action now lives entirely in the FAB.
class _IntroCard extends StatelessWidget {
  const _IntroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.greyEE),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Turn Airtime into Cash',
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Convert your unused airtime to cash securely and conveniently.',
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.grey80,
              height: 1.45,
            ),
          ),
          SizedBox(height: 18.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.greyF5,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: const Row(
              children: [
                _FlowPill(label: 'Airtime', highlighted: true),
                _FlowArrow(),
                _FlowPill(label: 'Conversion'),
                _FlowArrow(),
                _FlowPill(label: 'Cash', highlighted: true),
              ],
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            'Fast processing • Secure • Transparent rates',
            style: context.textTheme.labelSmall?.copyWith(
              color: AppColors.grey80,
            ),
          ),
        ],
      ),
    );
  }
}

class _FlowPill extends StatelessWidget {
  const _FlowPill({required this.label, this.highlighted = false});

  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 6.w),
        decoration: BoxDecoration(
          color: highlighted
              ? AppColors.success.withOpacity(0.08)
              : AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: highlighted
                ? AppColors.success.withOpacity(0.18)
                : AppColors.greyEE,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: context.textTheme.labelSmall?.copyWith(
            color: highlighted ? AppColors.success : AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _FlowArrow extends StatelessWidget {
  const _FlowArrow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Icon(
        Icons.arrow_forward_rounded,
        size: 16.sp,
        color: AppColors.grey80,
      ),
    );
  }
}

class _RecentConversionsCard extends StatelessWidget {
  const _RecentConversionsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.greyEE),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Recent Conversions',
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              // TODO(airtime-to-cash): wire this to a dedicated full-history
              // screen/route once one exists. Left disabled rather than
              // navigating nowhere.
              TextButton(
                onPressed: null,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('See all'),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Consumer(
            builder: (context, ref, _) {
              final notifier = ref.read(airtimeToCashHistoryProvider.notifier);
              return TextField(
                onChanged: notifier.onSearchChanged,
                decoration: const InputDecoration().search(),
              );
            },
          ),
          SizedBox(height: 14.h),
          const TransactionListWidget(),
        ],
      ),
    );
  }
}

class _ConvertFab extends StatelessWidget {
  const _ConvertFab({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      elevation: 5,
      icon: const Icon(Icons.add_rounded),
      label: const Text('Convert Airtime'),
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.white,
      extendedPadding: EdgeInsets.symmetric(horizontal: 18.w),
    );
  }
}
