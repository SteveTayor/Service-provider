import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/widgets/bankdetail_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WithdrawalaccountScreen extends StatelessWidget {
  const WithdrawalaccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        titleText: 'Withdrawal accounts',
      ),
      body: Column(
        children: [
          const BankdetailWidget(),
          40.verticalSpace,
          InkWell(
            onTap: () {
              context.push(RouteConstants.addbankdetail);
            },
            child: Text(
              '+ Add another account',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
