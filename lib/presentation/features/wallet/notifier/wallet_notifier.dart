import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/models/banks/get_virtual_account_response.dart';
import 'package:bundlegram/presentation/features/wallet/screen/widget/addfund_widget.dart';
import 'package:bundlegram/presentation/features/wallet/screen/widget/addfundviadebitcard_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WalletNotifier {
  Future<void> showAddMoney(BuildContext context, WidgetRef ref) async {
    await ref.read(globalProvider.notifier).fetchVirtualAccount(context);
    ref.read(globalProvider).virtualAccounts.when(
      data: (resp) {
        final sterling = resp!.data?.sterling;
        final wema = resp.data?.wema;
        context.showBottomSheet(
          child: AddfundWidget(
            sterlingAccount: sterling,
            wemaAccount: wema,
          ),
        );
      },
      loading: () {
        // Optional: show a spinner/snackbar while it’s loading
        AppLoader();
      },
      error: (_, __) {
        context.showErrorSnackBar('Virtual accounts not available yet.');
      },
    );
  }

  Future<void> showAddMoneyViaDebitCard(BuildContext context) async {
    return context.showBottomSheet(
      child: const AddfundviadebitcardWidget(),
    );
  }

  void showLinkBVNSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text(
        'To ensure that you get a virtual account number, verify your BVN for this feature.',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: AppColors.primaryColor,
      action: SnackBarAction(
        label: 'Link now',
        textColor: Colors.white,
        onPressed: () {
          context.push(RouteConstants.accountSetup);
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
