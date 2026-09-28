import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/provider/airtime_to_cash_provider.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/widgets/airtime_share_pin_info_dialog.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AirtimeSharePinDialog extends ConsumerWidget {
  const AirtimeSharePinDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(airtimeToCashProvider);
    final notifier = ref.read(airtimeToCashProvider.notifier);
    final network = state.selectedNetwork;

    return PopScope(
      canPop: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Airtime Share PIN',
                    style: context.textTheme.titleMedium,
                  ),
                  SizedBox(width: 6.w),
                  if (network != null)
                    GestureDetector(
                      onTap: () =>
                          AirtimeSharePinInfoDialog.show(context, [network]),
                      child: Icon(
                        Icons.info_outline,
                        size: 16.sp,
                        color: AppColors.info,
                      ),
                    ),
                ],
              ),
              SizedBox(height: 16.h),
              AppTextField(
                controller: state.pinController,
                hintText: 'Enter your Airtime Share PIN',
                obscureText: true,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
              ),
              if (state.pinError != null) ...[
                SizedBox(height: 8.h),
                Text(
                  state.pinError!,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.errorText,
                  ),
                ),
              ],
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: notifier.goToManual,
                child: Text(
                  'Forgot PIN? Call 300 to reset it.',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: AppColors.errorText,
                    fontSize: 10.sp,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: BundlegramButton(
                      text: 'Cancel',
                      color: AppColors.greyEE,
                      textStyle: const TextStyle(color: AppColors.black),
                      onPressed: notifier.cancelFlow,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    flex: 2,
                    child: BundlegramButton(
                      text: 'Continue',
                      onPressed: notifier.submitPin,
                    ),
                  ),
                ],
              ),
              36.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
