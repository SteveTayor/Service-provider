import 'dart:async';
import 'dart:developer';

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/models/banks/get_virtual_account_response.dart';
import 'package:bundlegram/presentation/features/wallet/screen/widget/addfund_widget.dart';
import 'package:bundlegram/presentation/features/wallet/screen/widget/addfundviadebitcard_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_squad_sdk/flutter_squad_sdk.dart';
import 'package:go_router/go_router.dart';

class WalletNotifier {
  Future<void> showAddMoney(BuildContext context, WidgetRef ref) async {
    await ref.read(globalProvider.notifier).fetchVirtualAccount(context);

    ref.read(globalProvider).virtualAccounts.when(
          data: (resp) {
            final accounts = resp?.data ?? {};
            if (accounts.isEmpty) {
              showAddMoneyViaDebitCard(context);
              context.showErrorSnackBar('No virtual accounts available yet.');
              return;
            } else {
              context.showBottomSheet(
                child: AddfundWidget(accounts: accounts),
              );
            }
          },
          loading: () => AppLoader(),
          error: (_, __) {
            context.showErrorSnackBar('Virtual accounts not available yet.');
          },
        );
  }

  // Future<void> showAddMoney(BuildContext context, WidgetRef ref) async {
  //   await ref.read(globalProvider.notifier).fetchVirtualAccount(context);
  //   ref.read(globalProvider).virtualAccounts.when(
  //     data: (resp) {
  //       final sterling = resp!.data?.sterling;
  //       final wema = resp.data?.wema;
  //       context.showBottomSheet(
  //         child: AddfundWidget(
  //           sterlingAccount: sterling,
  //           wemaAccount: wema,
  //         ),
  //       );
  //     },
  //     loading: () {
  //       AppLoader();
  //     },
  //     error: (_, __) {
  //       context.showErrorSnackBar('Virtual accounts not available yet.');
  //     },
  //   );
  // }

  Future<void> showAddMoneyViaDebitCard(BuildContext context) async {
    return context.showBottomSheet(
      child: const AddfundviadebitcardWidget(),
    );
  }

  void showLinkBVNSnackBar(BuildContext context, String? msg, String? label) {
    final snackBar = SnackBar(
      content: Text(
        msg!,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: AppColors.primaryColor,
      action: SnackBarAction(
        label: label!,
        textColor: Colors.white,
        onPressed: () {
          context.push(RouteConstants.accountSetup);
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Future<void> handleSquadPayment({
  //   required BuildContext context,
  //   required int amount,
  //   required String email,
  // }) async {
  //   final transactionRef = SquadPay.generateTransactionRef(16);
  //   final publicKey = dotenv.env['SQUAD_PUBLIC_KEY'] ?? '';
  //   final secretKey = dotenv.env['SQUAD_SECRET_KEY'] ?? '';

  //   try {
  //     // ✅ Close the bottom sheet first
  //     // context.pop(); // <-- This closes bottomsheet

  //     await SquadPay.initializeAndCheckout(
  //       context,
  //       Environment.test,
  //       publicKey,
  //       InitialPayload(
  //         amount: amount,
  //         email: email,
  //         currency: "NGN",
  //         initiateType: "redirect",
  //         transactionRef: transactionRef,
  //         callbackUrl: '',
  //       ),
  //     );

  //     final result = await SquadPay.verifyTransaction(
  //       Environment.test,
  //       secretKey,
  //       transactionRef,
  //     );

  //     if (result.data?.transactionStatus?.toLowerCase() == "success") {
  //       if (context.mounted) {
  //         unawaited(Navigator.of(context).pushNamedAndRemoveUntil(
  //           RouteConstants.dashboard,
  //           (route) => false,
  //         ));
  //       }
  //     } else {
  //       context.showErrorSnackBar("Payment failed or was cancelled.");
  //     }
  //   } catch (e, st) {
  //     log("Payment error: $e\n$st");
  //     context.showErrorSnackBar("An error occurred. Please try again.");
  //   }
  // }

  // (int amountWithCharge, String? email)? prepareSquadPaymentData({
  //   required WidgetRef ref,
  //   required String rawAmount,
  //   BuildContext? context,
  // }) {
  //   context?.showLoadingDialog();

  //   final profile = ref.read(globalProvider).profile.value?.data;
  //   final email = profile?.email;
  //   log("Users email: ${email}");

  //   final cleanedAmount = rawAmount.replaceAll(RegExp(r'[^\d]'), '');
  //   final enteredAmount = int.tryParse(cleanedAmount);
  //   log("Users amount: ${enteredAmount}");

  //   if (enteredAmount == null || enteredAmount <= 0 || email == null) {
  //     context?.dismissDialog();
  //     return null;
  //   }

  //   const double chargeRate = 0.012;
  //   final amountWithCharge =
  //       (enteredAmount + (enteredAmount * chargeRate).ceil());
  //   log("Users amount with charges: ${amountWithCharge}");

  //   context?.dismissDialog(); // Optional early cancel
  //   return (amountWithCharge, email);
  // }
}
