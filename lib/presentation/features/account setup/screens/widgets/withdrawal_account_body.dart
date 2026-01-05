import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platfprm_prouct_screen_shimmers.dart';
import 'package:bundlegram/presentation/features/account%20setup/notifier/withdrawal_accounts_provider.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/widgets/bankdetail_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WithdrawalAccountBody extends ConsumerWidget {
  final Future<void> Function() onRefresh;

  const WithdrawalAccountBody({
    super.key,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(withdrawalAccountProvider);

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...provider.userBanks.asMap().entries.map((entry) {
              final index = entry.key;
              final bank = entry.value;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: BankdetailWidget(
                  bank: bank,
                  accountNumber: index + 1,
                  onDelete: provider.isDeleting
                      ? null
                      : () async {
                          final success =
                              await provider.deleteBank(context, bank!.id);
                          if (!success) return;
                        },
                ),
              );
            }).toList(),
            20.verticalSpace,
            InkWell(
              onTap: () async {
                context.showLoadingDialog(message: 'Fetching details...');

                await Future.wait([
                  ref.read(globalProvider.notifier).fetchBanks(context),
                  ref.read(globalProvider.notifier).fetchProfile(context),
                ]);

                context
                  ..dismissDialog()
                  ..push(RouteConstants.addbankdetail);
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
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
