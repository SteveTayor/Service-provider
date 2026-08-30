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
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/model/platform_product_state.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_product_provider.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/products_provider.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/platformproduct_screen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformbills_widget.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/statisticvisual.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:bundlegram/data/models/banks/get_virtual_account_response.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
import 'package:go_router/go_router.dart';

// final platformProvider =
//     ChangeNotifierProvider.autoDispose<PlatformProvider>((ref) {
//   return PlatformProvider(ref);
// });
final platformProvider = ChangeNotifierProvider<PlatformProvider>((ref) {
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

  // void openDrawer(GlobalKey<ScaffoldState> key) {
  //   key.currentState?.openDrawer();
  // }

  void goToNotification(BuildContext context) {
    context.push('/notification');
  }

  void goToWithdrawFund(BuildContext context) {
    final profile = _ref.read(globalProvider).profile;
    final bvn = profile.value?.data?.bvn;

    if (bvn == null) {
      WalletNotifier().showLinkBVNSnackBar(
        context,
        'BVN verification required to withdraw fromÂ yourÂ wallet.',
        'Link now',
      );
    } else {
      context.push(RouteConstants.withdrawFund);
    }
  }

  Future<bool> checkServiceAvailability(
      BuildContext ctx, PlatformProductType type) async {
    // show a small loader while we check
    ctx.showLoadingDialog(message: 'Checking service availability...');

    try {
      final container = ProviderScope.containerOf(ctx, listen: false);

      // get the notifier (this will create a new instance if needed)
      final notifier = container.read(platformProductProvider(type).notifier);

      // if notifier has no products, fetch them now (await)
      if (notifier.state.products.isEmpty) {
        try {
          await notifier.fetchProducts(ctx);
        } catch (e) {
          debugPrint('fetchProducts failed on demand: $e');
          // fallback: try reading productsProvider directly (minimal)
          try {
            await container.read(productsProvider(type).future);
          } catch (_) {}
        }
      }

      // re-read state from container after fetch
      final state = container.read(platformProductProvider(type));

      // active check (reuse your helper)
      bool isEntityActive(dynamic entity) {
        try {
          if (entity == null) return true;
          final dyn = entity as dynamic;
          final cand = (() {
            try {
              return dyn.isActive;
            } catch (_) {}
            try {
              return dyn.active;
            } catch (_) {}
            try {
              return dyn.is_active;
            } catch (_) {}
            try {
              return dyn.status;
            } catch (_) {}
            try {
              return dyn.state;
            } catch (_) {}
            try {
              return dyn.statuscode;
            } catch (_) {}
            return null;
          })();
          if (cand == null) return true;
          if (cand is bool) return cand;
          if (cand is int) return cand == 1;
          if (cand is String) {
            final s = cand.toLowerCase();
            return s == 'true' || s == '1' || s == 'active' || s == 'enabled';
          }
          return true;
        } catch (_) {
          return true;
        }
      }

      final products = state.products;
      final hasActive =
          products.isNotEmpty && products.any((p) => isEntityActive(p));
      ctx.dismissDialog();

      if (!hasActive) {
        ctx.showErrorSnackBar('Service not available at the moment');
        return false;
      }

      return true;
    } catch (e, st) {
      debugPrint('checkServiceAvailability error: $e\n$st');
      ctx.dismissDialog();
      ctx.showErrorSnackBar(
          'Could not check service availability. Please try again.');
      return false;
    }
  }

  /// Then, modify goToProduct to call checkServiceAvailability first:
  Future<void> goToProduct(BuildContext ctx, PlatformProductType type) async {
    final ok = await checkServiceAvailability(ctx, type);
    if (!ok) return;

    // existing navigation logic (unchanged)
    // unawaited(Navigator.push(
    //   ctx,
    //   MaterialPageRoute(
    //     builder: (_) => PlatformproductScreen(serviceType: type),
    //   ),
    // ));

    unawaited(ctx.push(RouteConstants.platformProduct, extra: type));
  }

  // void goToProduct(BuildContext context, PlatformProductType type) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) => PlatformproductScreen(serviceType: type),
  //     ),
  //   );
  // }

  String _unavailableMessageFor(PlatformProductType type,
      [String? serverMessage]) {
    if (serverMessage != null && serverMessage.trim().isNotEmpty) {
      return serverMessage.trim();
    }

    switch (type) {
      case PlatformProductType.mobileData:
        return 'Buy data not available at the moment.';
      case PlatformProductType.airtime:
        return 'Buy airtime not available at the moment.';
      case PlatformProductType.cableTv:
        return 'Cable TV payments not available at the moment.';
      case PlatformProductType.electricity:
        return 'Electricity payments not available at the moment.';
      // case PlatformProductType.education:
      //   return 'Education payments not available at the moment.';
      // case PlatformProductType.internetServices:
      //   return 'Internet services not available at the moment.';
      // case PlatformProductType.betting:
      //   return 'Betting purchases not available at the moment.';
      // case PlatformProductType.ePinVoucher:
      // case PlatformProductType.bulkEPin:
      // return 'E-pin purchases not available at the moment.';
      default:
        return 'Service not available at the moment.';
    }
  }

  // Future<void> goToProduct(BuildContext ctx, PlatformProductType type) async {
  //   final context = ctx;
  //   unawaited(context.showLoadingDialog(
  //       message: 'Checking products availability...'));

  //   try {
  //     // Get a Riverpod container from the BuildContext (no `ref` required here)
  //     final container = ProviderScope.containerOf(context, listen: false);

  //     // Get the notifier for the requested type
  //     final notifier = container.read(platformProductProvider(type).notifier);

  //     // If nothing loaded yet, fetch products (this will auto-fetch first product's subproducts)
  //     if (notifier.state.products.isEmpty) {
  //       await notifier.fetchProducts(context);
  //     }

  //     // After fetch (or if pre-loaded), validate the result
  //     final products = notifier.state.products;
  //     final fetchError = notifier.state.error;

  //     // Use server message if available, otherwise friendly per-type fallback.
  //     final errorMsg = _unavailableMessageFor(type, fetchError);

  //     // Dismiss loader early if there's an error or no products
  //     if (fetchError != null || products.isEmpty) {
  //       context
  //         ..dismissDialog()
  //         ..showErrorSnackBar(errorMsg);
  //       return;
  //     }

  //     // Best-effort: check whether any product has sub-products (use cached-friendly helper)
  //     bool hasAnySubProduct = false;

  //     // Limit checks to first N products to avoid many network calls
  //     const int maxChecks = 3;
  //     final toCheck = products.take(maxChecks);

  //     for (final p in toCheck) {
  //       final pid = p.id;
  //       if (pid == null) continue;
  //       try {
  //         final has = await notifier.hasSubProducts(pid);
  //         if (has) {
  //           hasAnySubProduct = true;
  //           break;
  //         }
  //       } catch (_) {
  //         // ignore and continue checking other products
  //       }
  //     }

  //     context.dismissDialog();

  //     if (!hasAnySubProduct) {
  //       context.showErrorSnackBar(_unavailableMessageFor(type));
  //       return;
  //     }

  //     // All good â€” navigate to product screen (existing behaviour)
  //     unawaited(Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (_) => PlatformproductScreen(serviceType: type),
  //       ),
  //     ));
  //   } catch (e, st) {
  //     context
  //       ..dismissDialog()
  //       ..showErrorSnackBar(_unavailableMessageFor(type));
  //     debugPrint('goToProduct error: $e\n$st');
  //   }
  // }

  void openBillBottomSheet(BuildContext context) {
    context.showBottomSheet(child: const PlatformbillsWidget());
  }

  void openStatisticsBottomSheet(BuildContext context) {
    context.showBottomSheet(child: const StatisticsDashboard());
  }

  void goToAirtimeToCash(BuildContext context) {
    context.push(RouteConstants.airtimeToCash);
  }
}

