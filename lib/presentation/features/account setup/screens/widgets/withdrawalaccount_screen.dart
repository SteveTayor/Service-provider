import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/features/account%20setup/notifier/withdrawal_accounts_provider.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/widgets/bankdetail_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WithdrawalaccountScreen extends ConsumerStatefulWidget {
  const WithdrawalaccountScreen({super.key});

  @override
  ConsumerState<WithdrawalaccountScreen> createState() =>
      _WithdrawalaccountScreenState();
}

class _WithdrawalaccountScreenState
    extends ConsumerState<WithdrawalaccountScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch data when the screen loads
    ref.read(withdrawalAccountProvider).fetchData(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(withdrawalAccountProvider);

    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        titleText: 'Withdrawal accounts',
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display user name and wallet balance
                // Padding(
                //   padding:
                //       EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         provider.userName ?? 'Loading...',
                //         style: context.textTheme.titleLarge,
                //       ),
                //       8.verticalSpace,
                //       Text(
                //         'Wallet Balance: ₦${provider.formattedBalance}',
                //         style: context.textTheme.bodyMedium!.copyWith(
                //           color: AppColors.grey5B,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Display bank details
                ...provider.userBanks.asMap().entries.map((entry) {
                  final index = entry.key;
                  final bank = entry.value;
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    child: BankdetailWidget(
                      bank: bank,
                      accountNumber:
                          index + 1, // Account number (1-based index)
                      onDelete: provider.isDeleting
                          ? null
                          : () async {
                              final success =
                                  await provider.deleteBank(context, bank!.id);
                              if (!success) return; // Handle failure
                            },
                    ),
                  );
                }).toList(),
                40.verticalSpace,
                InkWell(
                  onTap: () async {
                    context.showLoadingDialog(message: 'Fetching details...');

                    await Future.wait([
                      ref.read(globalProvider.notifier).fetchBanks(context),
                      ref.read(globalProvider.notifier).fetchProfile(context),
                    ]);

                    context.dismissDialog();
                    context.push(RouteConstants.addbankdetail);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      '+ Add another account',
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
