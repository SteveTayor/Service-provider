// import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
// import 'package:bundlegram/core/utils/colors.dart';
// import 'package:bundlegram/core/utils/styles.dart';
// import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_screen_provider.dart';
// import 'package:bundlegram/presentation/features/setting/screens/close_account_screen.dart';
// import 'package:bundlegram/presentation/features/wallet/screen/enterpin_screen.dart';
// import 'package:bundlegram/presentation/general_widget/app_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';

// class CloseaccountWidget extends ConsumerWidget {
//   const CloseaccountWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final userName = ref.watch(platformProvider).userName;
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Close account',
//             style: context.textTheme.bodyMedium!.copyWith(
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           12.verticalSpace,
//           Text(
//             'Hi ${userName}, we work very hard to ensure all our users are happy using our services. Bundlegram offers one of the best rates for all its services from buying data, airtime and paying for bills. If you have any issue, kindly contact us, we will gladly help. However, if you want to close your account, click proceed.',
//             textAlign: TextAlign.center,
//             style: context.textTheme.bodySmall,
//           ),
//           28.verticalSpace,
//           BundlegramButton(
//               text: 'Proceed',
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => EnterPinScreen(
//                       onVerified: (pin) {
//                         // TODO: implement onVerified callback
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                             builder: (ctx) => CloseAccountScreen(),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 );
//               }),
//           24.verticalSpace,
//           BundlegramButton(
//             isOutline: true,
//             borderColor: AppColors.greyD0,
//             buttonStyle: BundlegramButtonOutline(),
//             text: 'Cancel',
//             onPressed: () {
//               context.pop();
//             },
//           ),
//           24.verticalSpace,
//         ],
//       ),
//     );
//   }
// }
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/styles.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_screen_provider.dart';
import 'package:bundlegram/presentation/features/setting/provider/close_account_notifier.dart';
import 'package:bundlegram/presentation/features/wallet/screen/enterpin_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CloseaccountWidget extends ConsumerWidget {
  const CloseaccountWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref.watch(platformProvider).userName;
    final controller = ref.watch(closeAccountProvider);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Close account',
            style: context.textTheme.bodyMedium!.copyWith(
              // fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          12.verticalSpace,
          Text(
            'Hi ${userName.toUpperCase()}, we work very hard to ensure all our users are happy using our services. Bundlegram offers one of the best rates for all its services from buying data, airtime and paying for bills. If you have any issue, kindly contact us, we will gladly help. However, if you want to close your account, click proceed.',
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall,
          ),
          28.verticalSpace,
          BundlegramButton(
            text: 'Proceed',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EnterPinScreen(
                    onVerified: (pin) {
                      controller.verifyPinAndCloseAccount(context, pin);
                    },
                  ),
                ),
              );
            },
          ),
          24.verticalSpace,
          BundlegramButton(
            isOutline: true,
            borderColor: AppColors.greyD0,
            buttonStyle: BundlegramButtonOutline(),
            text: 'Cancel',
            onPressed: () {
              context.pop();
            },
          ),
          24.verticalSpace,
        ],
      ),
    );
  }
}
