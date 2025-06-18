import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_notifier.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletoutlookWidget extends StatefulWidget {
  const WalletoutlookWidget({super.key});

  @override
  State<WalletoutlookWidget> createState() => _WalletoutlookWidgetState();
}

class _WalletoutlookWidgetState extends State<WalletoutlookWidget> {
  bool _isBalanceVisible = false;
  final String _actualBalance =
      '₦0.00'; // You can make this dynamic based on actual wallet balance

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Wallet balance ',
              style: context.textTheme.bodySmall!
                  .copyWith(fontSize: 16.sp, color: AppColors.white),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isBalanceVisible = !_isBalanceVisible;
                });
              },
              child: Icon(
                _isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                color: AppColors.white,
                size: 24,
              ),
            ),
          ],
        ),
        16.verticalSpace,
        Text(
          _isBalanceVisible ? _actualBalance : '⁕⁕⁕⁕',
          style: context.textTheme.bodyMedium!.copyWith(
            fontSize: _isBalanceVisible ? 40.sp : 24.sp,
            color: AppColors.white,
          ),
        ),
        16.verticalSpace,
        BundlegramButton(
          width: 130.w,
          height: 50.h,
          color: AppColors.white,
          cornerRadius: 4.r,
          text: 'Fund wallet',
          textStyle: context.textTheme.bodyMedium!
              .copyWith(color: AppColors.primaryColor),
          onPressed: () {
            WalletNotifier().showAddMoney(context);
          },
        ),
      ],
    );
  }
}
