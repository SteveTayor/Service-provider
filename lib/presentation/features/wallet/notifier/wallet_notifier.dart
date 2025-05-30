import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/presentation/features/wallet/screen/widget/addfund_widget.dart';
import 'package:bundlegram/presentation/features/wallet/screen/widget/addfundviadebitcard_widget.dart';
import 'package:flutter/material.dart';

class WalletNotifier {
  Future<void> showAddMoney(BuildContext context) async {
    return context.showBottomSheet(
      child: const AddfundWidget(),
    );
  }

  Future<void> showAddMoneyViaDebitCard(BuildContext context) async {
    return context.showBottomSheet(
      child: const AddfundviadebitcardWidget(),
    );
  }
}
