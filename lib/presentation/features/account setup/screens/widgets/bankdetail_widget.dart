import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/models/banks/get_all_users_banks_response.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BankdetailWidget extends StatelessWidget {
  final UserBanksDetails? bank;
  final int accountNumber;
  final VoidCallback? onDelete;

  const BankdetailWidget({
    super.key,
    required this.bank,
    required this.accountNumber,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Account $accountNumber',
              style: context.textTheme.bodySmall,
            ),
            GestureDetector(
              onTap: onDelete,
              child: AppSvgIcon(path: Assets.svgs.recycleBin2StreamlineCore),
            ),
          ],
        ),
        12.verticalSpace,
        Text(
          bank?.accountNumber ?? 'N/A',
          style: context.textTheme.titleLarge!.copyWith(
            fontSize: 26.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          bank?.bankName ?? 'N/A',
          style: context.textTheme.bodyMedium!.copyWith(
            color: AppColors.grey5B,
          ),
        ),
      ],
    ).withContainer(
      padding: context.symmetricPadding(20, 12),
      borderRadius: BorderRadius.circular(6.r),
      color: const Color(0xffF1F5FF),
    );
  }
}
