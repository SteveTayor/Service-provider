import 'package:bundlegram/core/extensions/responsive_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/provider/airtime_to_cash_history_provider.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/widgets/conversion_flow_sheet.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/widgets/transaction_list_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AirtimeToCashScreen extends ConsumerWidget {
  const AirtimeToCashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = context.responsive;
    final historyNotifier = ref.read(airtimeToCashHistoryProvider.notifier);

    return BundlegramScaffold(
      appBar: const BundlegramAppbar(titleText: 'Airtime to Cash'),
      body: RefreshIndicator(
        onRefresh: historyNotifier.refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Airtime to Cash',
                              style: context.textTheme.titleLarge),
                          SizedBox(height: 4.h),
                          Text(
                            'Convert your airtime to cash instantly',
                            style: context.textTheme.bodySmall
                                ?.copyWith(color: AppColors.grey80),
                          ),
                        ],
                      ),
                    ),
                    BundlegramButton(
                      text: 'New Conversion',
                      leading: null,
                      width: 160.w,
                      onPressed: () =>
                          showAirtimeToCashConversionSheet(context),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Recent Transactions',
                            style: context.textTheme.titleSmall),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      onChanged: historyNotifier.onSearchChanged,
                      decoration: const InputDecoration().search(),
                    ),
                    SizedBox(height: 16.h),
                    const TransactionListWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
