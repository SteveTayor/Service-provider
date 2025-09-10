import 'dart:async';
import 'dart:developer';

import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_input_formatter.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/squad_notifier.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_notifier.dart';
import 'package:bundlegram/presentation/features/wallet/payment_webview/squad_payment_webiew_screen.dart/squad_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_squad_sdk/flutter_squad_sdk.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

// class AddfundviadebitcardWidget extends StatefulWidget {
//   const AddfundviadebitcardWidget({super.key});

//   @override
//   State<AddfundviadebitcardWidget> createState() =>
//       _AddfundviadebitcardWidgetState();
// }

// class _AddfundviadebitcardWidgetState extends State<AddfundviadebitcardWidget> {
//   final TextEditingController _amountController = TextEditingController();

//   int _calculateAmountWithCharge(int amount) {
//     const feeRate = 0.012; // 1.2%
//     return (amount + (amount * feeRate).ceil());
//   }

//   final String public_Key = "pk_0c74e1b0f577868d1f279e2fb972e1a6692eb433";

//   Future<void> _startSquadPayment({
//     required int amountWithCharge,
//     required String email,
//   }) async {
//     const String publicKey = 'pk_0c74e1b0f577868d1f279e2fb972e1a6692eb433';
//     final String transactionRef =
//         'BDG_${DateTime.now().millisecondsSinceEpoch}';

//     SquadPayment().initialize(
//       context: context,
//       email: email,
//       amount: amountWithCharge * 100, // Kobo
//       currencyCode: 'NGN',
//       publicKey: publicKey,
//       transactionReference: transactionRef,
//       onSuccess: (result) {
//         context.go(RouteConstants.dashboard);
//       },
//       onClose: () {
//         context.showSnackBar('Payment cancelled');
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: context.symmetricPadding(16, 16),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Add money via debit card',
//             style: context.textTheme.displaySmall,
//           ),
//           28.verticalSpace,
//           AppTextField(
//             controller: _amountController,
//             hintText: 'Amount to top-up',
//             keyboardType: TextInputType.number,
//           ),
//           20.verticalSpace,
//           BundlegramButton(
//             text: 'Continue',
//             onPressed: () {
//               final result = ref.read(walletProvider).prepareSquadPaymentData(
//                     ref: ref,
//                     rawAmount: _amountController.text,
//                   );

//               if (result == null) {
//                 context.showErrorSnackBar("Enter a valid amount");
//                 return;
//               }

//               final (amountWithCharge, email) = result;
//               _startSquadPayment(
//                 amountWithCharge: amountWithCharge,
//                 email: email!,
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// // }
// class AddfundviadebitcardWidget extends ConsumerStatefulWidget {
//   const AddfundviadebitcardWidget({super.key});

//   @override
//   ConsumerState<AddfundviadebitcardWidget> createState() =>
//       _AddfundviadebitcardWidgetState();
// }

// class _AddfundviadebitcardWidgetState
//     extends ConsumerState<AddfundviadebitcardWidget> {
//   final TextEditingController _amountController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: context.symmetricPadding(16, 16),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text('Add money via debit card',
//               style: context.textTheme.displaySmall),
//           28.verticalSpace,
//           AppTextField(
//             controller: _amountController,
//             hintText: 'Amount to top-up',
//             keyboardType: TextInputType.number,
//             inputFormatters: [CurrencyTextInputFormatter()],
//           ),
//           20.verticalSpace,
//           BundlegramButton(
//             text: 'Continue',
//             onPressed: () async {
//               final context = this.context;
//               final profile = ref.read(globalProvider).profile.value?.data;
//               final email = profile?.email;

//               final rawAmount = _amountController.text.trim();
//               final cleanedAmount = rawAmount.replaceAll(RegExp(r'[^\d]'), '');
//               final enteredAmount = int.tryParse(cleanedAmount);

//               if (enteredAmount == null ||
//                   enteredAmount <= 0 ||
//                   email == null) {
//                 context.showErrorSnackBar("Please enter a valid amount.");
//                 return;
//               }
//               unawaited(
//                   context.showLoadingDialog()); // ✅ Show loader before starting

//               try {
//                 const double chargeRate = 0.012;
//                 final amountWithCharge =
//                     enteredAmount + (enteredAmount * chargeRate).ceil();
//                 log("Users email: ${email}");
//                 log("Users amount with charges: ${amountWithCharge}");
//                 final _storage = ref.read(secureStorageHelperProvider);
//                 final token = await _storage.getAuthToken();

//                 if (token == null) {
//                   context.showErrorSnackBar('No token found.');
//                   return;
//                 }

//                 final transactionRef = SquadPay.generateTransactionRef(16);
//                 final publicKey = dotenv.env['SQUAD_PUBLIC_KEY'] ?? '';
//                 final secretKey = dotenv.env['SQUAD_SECRET_KEY'] ?? '';

//                 unawaited(SquadPay.initializeAndCheckout(
//                   context,
//                   Environment
//                       .prod, // 🔁 Replace with `Environment.live` if in production
//                   secretKey,
//                   InitialPayload(
//                     amount: amountWithCharge,
//                     email: email,
//                     currency: "NGN",
//                     initiateType: "redirect",
//                     transactionRef: transactionRef,
//                     callbackUrl: "https://google.com",
//                   ),
//                 ));
//                 log("Checkout called");

//                 // final result = await SquadPay.verifyTransaction(
//                 //   Environment.prod,
//                 //   secretKey,
//                 //   transactionRef,
//                 // );

//                 context.dismissDialog(); // ✅ Always dismiss loader first

//                 // if (result.data?.transactionStatus?.toLowerCase() ==
//                 //     "success") {
//                 //   if (context.mounted) {
//                 //     Navigator.of(context).pushNamedAndRemoveUntil(
//                 //       RouteConstants.dashboard,
//                 //       (route) => false,
//                 //     );
//                 //   }
//                 // } else {
//                 //   context.showErrorSnackBar("Payment failed or was cancelled.");
//                 // }
//               } catch (e, st) {
//                 context.dismissDialog(); // ✅ Dismiss before showing error
//                 log("Unexpected SquadPay error: $e\n$st");
//                 context.showErrorSnackBar(e.toString());
//               }
//             },
//             // onPressed: () async {
//             // final result = WalletNotifier().prepareSquadPaymentData(
//             //   ref: ref,
//             //   rawAmount: _amountController.text,
//             //   context: context,
//             // );
//             // if (result == null) {
//             //   context.showErrorSnackBar("Enter a valid amount");
//             //   return;
//             // }
//             // final (amountWithCharge, email) = result;

//             // await WalletNotifier().handleSquadPayment(
//             //   context: context,
//             //   amount: amountWithCharge * 100, // amount in kobo
//             //   email: email!,
//             // );
//             // },
//           ),
//         ],
//       ),
//     );
//   }
// }

class AddfundviadebitcardWidget extends ConsumerStatefulWidget {
  const AddfundviadebitcardWidget({super.key});

  @override
  ConsumerState<AddfundviadebitcardWidget> createState() =>
      _AddfundviadebitcardWidgetState();
}

class _AddfundviadebitcardWidgetState
    extends ConsumerState<AddfundviadebitcardWidget> {
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.symmetricPadding(16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add money via debit card',
            style: context.textTheme.displaySmall,
          ),
          28.verticalSpace,
          AppTextField(
            controller: _amountController,
            hintText: 'Amount to top-up',
            keyboardType: TextInputType.number,
            inputFormatters: [CurrencyTextInputFormatter()],
          ),
          24.verticalSpace,
          BundlegramButton(
              text: 'Continue',
              onPressed: () async {
                try {
                  final context = this.context;
                  final profile = ref.read(globalProvider).profile.value?.data;
                  final email = profile?.email;
                  final rawAmount = _amountController.text.trim();
                  final cleanedAmount =
                      rawAmount.replaceAll(RegExp(r'[^\d]'), '');
                  final enteredAmount = int.tryParse(cleanedAmount);

                  if (enteredAmount == null ||
                      enteredAmount <= 0 ||
                      email == null) {
                    context.showErrorSnackBar("Please enter a valid amount.");
                    return;
                  }

                  context.showLoadingDialog();

                  final response = await ref
                      .read(squadPaymentProvider.notifier)
                      .initializeCardPayment(
                          amount: ((enteredAmount * 1.012).ceil()),
                          email: email);
                  await Future.delayed(const Duration(milliseconds: 600));
                  context.dismissDialog();

                  // context.pop();
                  log('11111checkout url:: ${response?.data?.checkoutUrl}');
                  if (response?.data?.checkoutUrl != null) {
                    final uri = Uri.parse(response!.data!.checkoutUrl!);
                    log('checkout url:: ${uri.toString()}');
                    // final didLaunch =
                    //     await launchUrl(uri, mode: LaunchMode.inAppWebView);

                    // if (!didLaunch) {
                    //   // context.pop();
                    //   context.showErrorSnackBar("Could not open payment page.");
                    // }
                    final success = await Navigator.of(context).push<bool>(
                      MaterialPageRoute(
                        builder: (_) => SquadWebViewPage(
                          paymentUrl: response.data!.checkoutUrl!,
                          redirectUrlSubstring:
                              "success", // customize based on Squad redirect
                          transactionRef: response.data!.transactionRef!,
                        ),
                      ),
                    );

                    if (success == true) {
                      await ref
                          .read(globalProvider.notifier)
                          .fetchWalletBalance(context);
                      context
                          .showSuccessSnackBar("Wallet funded successfully!");
                    } else {
                      // context.showErrorSnackBar("Payment was not completed.");
                    }
                  } else {
                    // context.pop();
                    context.showErrorSnackBar("Payment URL not received.");
                  }
                } catch (e, st) {
                  context.pop();
                  context.dismissDialog();
                  print("💥 UI Error: $e");
                  print("🧵 StackTrace: $st");
                  context.showErrorSnackBar(
                      "Something went wrong in the payment flow.");
                }
              }),
          50.verticalSpace
        ],
      ),
    );
  }
}
