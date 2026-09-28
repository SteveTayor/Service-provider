import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/phone_mask.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/model/airtime_to_cash_state.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/provider/airtime_to_cash_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AirtimeOtpDialog extends ConsumerWidget {
  const AirtimeOtpDialog({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(airtimeToCashProvider);
    final notifier = ref.read(airtimeToCashProvider.notifier);
    final verifying = state.step == AirtimeToCashStep.verifyingOtp;
    final masked = maskPhoneNumber(state.phoneController.text.trim());

    return PopScope(
      canPop: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verify your phone number',
                style: context.textTheme.titleMedium,
              ),
              SizedBox(height: 6.h),
              Text.rich(
                TextSpan(
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.grey80,
                  ),
                  children: [
                    const TextSpan(text: "We've sent a verification code to "),
                    TextSpan(
                      text: masked,
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              AppTextField(
                controller: controller,
                hintText: 'Enter OTP',
                keyboardType: TextInputType.number,
                enabled: !verifying,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              if (state.otpVerifyError != null) ...[
                SizedBox(height: 8.h),
                Text(
                  state.otpVerifyError!,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.errorText,
                  ),
                ),
              ],
              SizedBox(height: 16.h),
              Center(
                child: state.isResendingOtp
                    ? Text('Resending...', style: context.textTheme.bodySmall)
                    : state.canResendOtp
                    ? TextButton(
                        onPressed: () async {
                          await notifier.resendOtp();
                          if (ref.read(airtimeToCashProvider).otpSendError ==
                              null) {
                            controller.clear();
                          }
                        },
                        child: Text(
                          'Resend OTP',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    : Text(
                        'Resend OTP in ${state.otpResendCountdown}s',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.grey80,
                        ),
                      ),
              ),
              if (state.otpSendError != null && !state.isResendingOtp)
                Center(
                  child: Text(
                    state.otpSendError!,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.errorText,
                    ),
                  ),
                ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: BundlegramButton(
                      text: 'Cancel',
                      color: AppColors.greyEE,
                      textStyle: const TextStyle(color: AppColors.black),
                      onPressed: verifying ? null : notifier.cancelFlow,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    flex: 2,
                    child: BundlegramButton(
                      text: verifying ? 'Verifying...' : 'Verify',
                      isLoading: verifying,
                      isEnabled: !verifying,
                      onPressed: () =>
                          notifier.verifyOtp(controller.text.trim()),
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
