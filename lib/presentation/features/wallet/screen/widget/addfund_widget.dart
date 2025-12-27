// ignore_for_file: lines_longer_than_80_chars

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/styles.dart';
import 'package:bundlegram/data/models/banks/get_virtual_account_response.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/app.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_notifier.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

// class AddfundWidget extends ConsumerStatefulWidget {
//   final Sterling? sterlingAccount;
//   final Sterling? wemaAccount;

//   const AddfundWidget({
//     super.key,
//     this.sterlingAccount,
//     this.wemaAccount,
//   });

//   @override
//   ConsumerState<AddfundWidget> createState() => _AddfundWidgetState();
// }

// class _AddfundWidgetState extends ConsumerState<AddfundWidget> {
//   int index = 0;

//   Row _bankDetailWidget(String title, String label) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               label,
//               style: context.textTheme.labelMedium!.copyWith(
//                 fontWeight: FontWeight.w500,
//                 color: AppColors.grey80,
//               ),
//             ),
//             8.verticalSpace,
//             Text(
//               title,
//               style: context.textTheme.bodyMedium!.copyWith(
//                 color: AppColors.primaryColor,
//               ),
//             ),
//           ],
//         ),
//         AppSvgIcon(
//           onTap: () {
// HapticFeedback.lightImpact() ;
//             Clipboard.setData(ClipboardData(text: title));

//             navigatorKey.currentState!.context
//                 .showCustomSnackBar("Account number Copied");
//           },
//           path: Assets.svgs.phCopySimple,
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final selectedAccount =
//         index == 0 ? widget.wemaAccount : widget.sterlingAccount;

//     // final accounts = ref.watch(globalProvider).virtualAccounts;
//     // final wema = accounts.maybeWhen(
//     //   data: (data) => data?.data?.wema,
//     //   orElse: () => null,
//     // );
//     // final sterling = accounts.maybeWhen(
//     //   data: (data) => data?.data?.sterling,
//     //   orElse: () => null,
//     // );

//     // final selectedAccount = index == 0 ? wema : sterling;

//     return Padding(
//       padding: context.symmetricPadding(16, 16),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Add money via bank transfer',
//             style: context.textTheme.displaySmall,
//           ),
//           28.verticalSpace,
//           Row(
//             children: [
//               Expanded(
//                 child: InkWell(
//                   onTap: () => setState(() => index = 0),
//                   child: Text(
//                     'Wema',
//                     style: context.textTheme.bodyMedium,
//                   ).withContainer(
//                     color: index == 0 ? AppColors.white : Colors.transparent,
//                     alignment: Alignment.center,
//                     borderRadius: BorderRadius.circular(8.r),
//                     padding: context.symmetricPadding(0, 12.h),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: InkWell(
//                   onTap: () => setState(() => index = 1),
//                   child: Text(
//                     'Sterling',
//                     style: context.textTheme.bodyMedium,
//                   ).withContainer(
//                     color: index == 1 ? AppColors.white : Colors.transparent,
//                     alignment: Alignment.center,
//                     borderRadius: BorderRadius.circular(8.r),
//                     padding: context.symmetricPadding(0, 12.h),
//                   ),
//                 ),
//               ),
//             ],
//           ).withContainer(
//             color: AppColors.greyF5,
//             borderRadius: BorderRadius.circular(8.r),
//             padding: context.symmetricPadding(4, 4),
//           ),
//           24.verticalSpace,
//           _bankDetailWidget(
//             selectedAccount?.bankName ?? 'Not available yet',
//             'Bank name',
//           ),
//           32.verticalSpace,
//           _bankDetailWidget(
//             selectedAccount?.accountNum ?? 'Not available yet',
//             'Account number',
//           ),
//           28.verticalSpace,
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               AppSvgIcon(path: Assets.svgs.infoCircle),
//               6.horizontalSpace,
//               Flexible(
//                 child: Text(
//                   'Use your bank app or USSD to top-up your wallet, wallet funding is instant and secured.',
//                   style: context.textTheme.labelMedium,
//                 ),
//               ),
//             ],
//           ).withContainer(
//             color: const Color(0xffF1F5FF),
//             padding: context.symmetricPadding(16, 16),
//             border: Border.all(color: AppColors.primaryColor),
//           ),
//           28.verticalSpace,
//           InkWell(
//             onTap: () {
// HapticFeedback.lightImpact() ;
//               context.pop();
//               // navigatorKey.currentState!.context
//               //     .showCustomSnackBar("Coming soom");
//               WalletNotifier().showAddMoneyViaDebitCard(context);
//             },
//             child: Text(
//               'Use debit card instead',
//               style: context.textTheme.bodyMedium!.copyWith(
//                 color: AppColors.grey19,
//               ),
//             ).withContainer(
//               alignment: Alignment.center,
//               width: context.width,
//               padding: context.symmetricPadding(16, 16),
//               border: Border.all(color: const Color(0xffBBC6D0)),
//             ),
//           ),
//           30.verticalSpace,
//         ],
//       ),
//     );
//   }
// }
class AddfundWidget extends ConsumerStatefulWidget {
  final Map<String, VirtualAccount?> accounts;

  const AddfundWidget({super.key, required this.accounts});

  @override
  ConsumerState<AddfundWidget> createState() => _AddfundWidgetState();
}

class _AddfundWidgetState extends ConsumerState<AddfundWidget> {
  int index = 0;

  Row _bankDetailWidget(String title, String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: context.textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.grey80,
              ),
            ),
            8.verticalSpace,
            Text(
              title,
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        AppSvgIcon(
          onTap: () {
            HapticFeedback.lightImpact();
            Clipboard.setData(ClipboardData(text: title));
            navigatorKey.currentState!.context
                .showCustomSnackBar("Account number copied");
          },
          path: Assets.svgs.phCopySimple,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final keys = widget.accounts.keys.where((k) => k.isNotEmpty).toList();

    // Pick selected account
    // final selectedAccount = widget.accounts[keys[index]];

    return Padding(
      padding: context.symmetricPadding(16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (keys.isEmpty) ...[
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        'BVN verification required to use the virtual account feature.',
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: AppColors.primaryColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    8.horizontalSpace,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColors.primaryColor,
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onPressed: () {
                        context.pop(); // close sheet
                        context.push(RouteConstants.accountSetup);
                      },
                      child: Text(
                        'Verify BVN',
                        style: context.textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                12.verticalSpace,
                Text('Or', style: context.textTheme.labelMedium),
                20.verticalSpace,
              ],
            ),
            Text(
              'Add money via bank transfer',
              style: context.textTheme.displaySmall,
            ),
            28.verticalSpace,
          ] else ...[
            Text(
              'Add money via bank transfer',
              style: context.textTheme.displaySmall,
            ),
            28.verticalSpace,

            // Show tabs only if there are multiple banks
            if (keys.length > 1)
              Row(
                children: List.generate(keys.length, (i) {
                  final bankName = keys[i];
                  return Expanded(
                    child: InkWell(
                      onTap: () => setState(() => index = i),
                      child: Text(
                        bankName,
                        style: context.textTheme.bodyMedium,
                      ).withContainer(
                        color:
                            index == i ? AppColors.white : Colors.transparent,
                        alignment: Alignment.center,
                        borderRadius: BorderRadius.circular(8.r),
                        padding: context.symmetricPadding(0, 12.h),
                      ),
                    ),
                  );
                }),
              ).withContainer(
                color: AppColors.greyF5,
                borderRadius: BorderRadius.circular(8.r),
                padding: context.symmetricPadding(4, 4),
              ),

            if (keys.length > 1) 24.verticalSpace,

            _bankDetailWidget(
              widget.accounts[keys[index]]?.bankName ?? 'Not available yet',
              'Bank name',
            ),
            32.verticalSpace,
            _bankDetailWidget(
              widget.accounts[keys[index]]?.accountNum ?? 'Not available yet',
              'Account number',
            ),
            28.verticalSpace,
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSvgIcon(path: Assets.svgs.infoCircle),
              6.horizontalSpace,
              Flexible(
                child: Text(
                  'Use your bank app or USSD to top-up your wallet, wallet funding is instant and secured.',
                  style: context.textTheme.labelMedium,
                ),
              ),
            ],
          ).withContainer(
            color: const Color(0xffF1F5FF),
            padding: context.symmetricPadding(16, 16),
            border: Border.all(color: AppColors.primaryColor),
          ),
          28.verticalSpace,
          InkWell(
            onTap: () {
              HapticFeedback.lightImpact();
              context.pop();
              WalletNotifier().showAddMoneyViaDebitCard(context);
            },
            child: Text(
              'Use debit card instead',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.grey19,
              ),
            ).withContainer(
              alignment: Alignment.center,
              width: context.width,
              padding: context.symmetricPadding(16, 16),
              border: Border.all(color: const Color(0xffBBC6D0)),
            ),
          ),
          30.verticalSpace,
        ],
      ),
    );
  }
}
