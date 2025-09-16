import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_formatter.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/platformproduct_screen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformbills_widget.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/statisticvisual.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bundlegram/data/models/banks/get_virtual_account_response.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
import 'package:go_router/go_router.dart';

final platformProvider =
    ChangeNotifierProvider.autoDispose<PlatformProvider>((ref) {
  return PlatformProvider(ref);
});

class PlatformProvider extends ChangeNotifier {
  final Ref _ref;

  PlatformProvider(this._ref);

  bool _isBalanceVisible = false;
  bool get isBalanceVisible => _isBalanceVisible;

  void toggleBalanceVisibility() {
    _isBalanceVisible = !_isBalanceVisible;
    notifyListeners();
  }

  String get formattedBalance {
    final wallet = _ref.read(globalProvider).walletBalance;
    final value = wallet.value?.wallet;

    return "${value.toCurrency()}";
  }

  String get formattedPromoBalance {
    final wallet = _ref.read(globalProvider).walletBalance;
    final value = wallet.value?.promoBonus ?? 0.0;
    debugPrint("[Formatted Promo Balance is ${value.toString()}]");
    return value.toCurrency();
  }

  List<VirtualAccount> get virtualAccounts {
    final va = _ref.read(globalProvider).virtualAccounts;

    if (va is AsyncData<GetVirtualAccountsResponse>) {
      final data = va.value.data;
      if (data == null) return [];

      // Convert map values to list, ignore nulls
      return data.values.whereType<VirtualAccount>().toList();
    }

    return [];
  }

  List<UserTransactions> get userTransactions {
    final transactions = _ref.read(globalProvider).usersTransactions;

    if (transactions is AsyncData<GetAllUserTransactionResponse>) {
      return transactions.value.data ?? [];
    }

    return [];
  }

  String get userName {
    final profile = _ref.read(globalProvider).profile;
    if (profile is AsyncData) {
      return profile.value?.data?.username ?? 'User';
    }
    return 'User';
  }

  // Navigation Actions

  void openDrawer(GlobalKey<ScaffoldState> key) {
    key.currentState?.openDrawer();
  }

  void goToNotification(BuildContext context) {
    context.push('/notification');
  }

  void goToWithdrawFund(BuildContext context) {
    final profile = _ref.read(globalProvider).profile;
    final bvn = profile.value?.data?.bvn;

    if (bvn == null) {
      WalletNotifier().showLinkBVNSnackBar(
        context,
        'BVN verification required to withdraw from your wallet.',
        'Link now',
      );
    } else {
      context.push(RouteConstants.withdrawFund);
    }
  }

  void goToProduct(BuildContext context, PlatformProductType type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PlatformproductScreen(serviceType: type),
      ),
    );
  }

  void openBillBottomSheet(BuildContext context) {
    context.showBottomSheet(child: const PlatformbillsWidget());
  }

  void openStatisticsBottomSheet(BuildContext context) {
    context.showBottomSheet(child: const StatisticsDashboard());
  }
}
