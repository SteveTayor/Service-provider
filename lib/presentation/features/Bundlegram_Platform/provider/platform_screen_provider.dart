import 'dart:async';

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_formatter.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_product_provider.dart';
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

  // void goToProduct(BuildContext context, PlatformProductType type) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) => PlatformproductScreen(serviceType: type),
  //     ),
  //   );
  // }

  Future<void> goToProduct(BuildContext ctx, PlatformProductType type) async {
    final context = ctx;
    unawaited(context.showLoadingDialog(
        message: 'Checking products availability...'));

    try {
      // Get a Riverpod container from the BuildContext (no `ref` required here)
      final container = ProviderScope.containerOf(context, listen: false);

      // Get the notifier for the requested type
      final notifier = container.read(platformProductProvider(type).notifier);

      // If nothing loaded yet, fetch products (this will auto-fetch first product's subproducts)
      if (notifier.state.products.isEmpty) {
        await notifier.fetchProducts(context);
      }

      // After fetch (or if pre-loaded), validate the result
      final products = notifier.state.products;
      final fetchError = notifier.state.error;

      // Dismiss loader early if there's an error or no products
      if (fetchError != null || products.isEmpty) {
        context
          ..dismissDialog()
          ..showErrorSnackBar('Buy data not available at the moment.');
        return;
      }

      // Best-effort: check whether any product has sub-products (use cached-friendly helper)
      bool hasAnySubProduct = false;

      // Limit checks to first N products to avoid many network calls
      const int maxChecks = 3;
      final toCheck = products.take(maxChecks);

      for (final p in toCheck) {
        final pid = p.id;
        if (pid == null) continue;
        try {
          final has = await notifier.hasSubProducts(pid);
          if (has) {
            hasAnySubProduct = true;
            break;
          }
        } catch (_) {
          // ignore and continue checking other products
        }
      }

      context.dismissDialog();

      if (!hasAnySubProduct) {
        context.showErrorSnackBar('Buy data not available at the moment.');
        return;
      }

      // All good — navigate to product screen (existing behaviour)
      unawaited(Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PlatformproductScreen(serviceType: type),
        ),
      ));
    } catch (e, st) {
      context
        ..dismissDialog()
        ..showErrorSnackBar('Buy data not available at the moment.');
      debugPrint('goToProduct error: $e\n$st');
    }
  }

  void openBillBottomSheet(BuildContext context) {
    context.showBottomSheet(child: const PlatformbillsWidget());
  }

  void openStatisticsBottomSheet(BuildContext context) {
    context.showBottomSheet(child: const StatisticsDashboard());
  }
}
