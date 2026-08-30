import 'dart:async';

import 'package:bundlegram/core/error/error_sanitixed_users.dart';
import 'package:bundlegram/core/error/errors.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/models/products/epin/epin_request_response.dart';
import 'package:bundlegram/data/models/products/get_all_products_response.dart';
import 'package:bundlegram/data/models/products/get_sub_products_response.dart';
import 'package:bundlegram/data/models/transaction/initiate_transactcion_requests.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/products_provider.dart';
import 'package:bundlegram/presentation/features/transaction/screens/bulk%20e-pin/model/bulk_epin_state.dart';
import 'package:bundlegram/presentation/features/transaction/screens/bulk%20e-pin/widget/bulk_pin_success.dart';
import 'package:bundlegram/presentation/features/wallet/screen/enterpin_screen.dart';
import 'package:bundlegram/presentation/features/wallet/screen/topup_failed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';

String normalizeAgentPhone(String? phone) {
  if (phone == null) return '';

  final trimmed = phone.trim();

  // Check: exactly 11 digits and starts with 0
  if (RegExp(r'^0\d{10}$').hasMatch(trimmed)) {
    return trimmed.substring(1); // remove leading 0
  }

  return trimmed;
}

final bulkEpinProvider = StateNotifierProvider<BulkEpinNotifier, BulkEpinState>(
    (ref) => BulkEpinNotifier(ref));

class BulkEpinNotifier extends StateNotifier<BulkEpinState> {
  final Ref _ref;

  BulkEpinNotifier(this._ref)
      : super(BulkEpinState(
          agentNameController: TextEditingController(),
          agentEmailController: TextEditingController(),
          agentPhoneController: TextEditingController(),
          businessNameController: TextEditingController(),
          amountController: TextEditingController(),
        )) {
    final profile = _ref.read(globalProvider).profile.value?.data;
    state = state.copyWith(
      agentNameController: TextEditingController(text: profile?.name ?? ''),
      agentEmailController: TextEditingController(text: profile?.email ?? ''),
      agentPhoneController: TextEditingController(
        text: normalizeAgentPhone(profile?.phone),
      ),

      businessNameController: TextEditingController(text: profile?.name ?? ''),
      // Optionally populate businessNameController if available in profile
    );
  }
  double getTransactionAmount() {
    // final quantity = int.tryParse(state.selectedQuantity ?? '0') ?? 0;
    // final amountPerPin = double.tryParse(state.amountController.text) ?? 0.0;
    final amount = double.tryParse(state.amountController.text) ?? 0.0;

    return amount;
  }

  // Future<void> fetchNetworks(BuildContext context) async {
  //   state = state.copyWith(isLoading: true, error: null);
  //   final result = await _ref
  //       .read(productsProvider(PlatformProductType.ePinVoucher).future);
  //   state = state.copyWith(
  //     isLoading: false,
  //     products: result.data ?? [],
  //     error: result.status != 'success' ? result.message : null,
  //   );
  //   if (result.status != 'success') {
  //     context.showErrorSnackBar(result.message ?? 'Failed to load networks');
  //   }
  // }

  Future<void> fetchNetworks(BuildContext context,
      {String? initialNetwork}) async {
    state = state.copyWith(isLoading: true, error: null);

    // 1) fetch products
    final result = await _ref
        .read(productsProvider(PlatformProductType.ePinVoucher).future);
    final networks = result.data ?? [];

    // 2) fetch subProducts for each product in parallel
    final Map<int, List<SubProduct>> productSubs = {};
    try {
      final futures = networks.map((p) async {
        if (p.id == null) return <SubProduct>[];
        final resp = await _ref.read(subProductsProvider(p.id!).future);
        return resp.data ?? <SubProduct>[];
      }).toList();

      final allSubs = await Future.wait(futures);

      for (var i = 0; i < networks.length; i++) {
        final pid = networks[i].id;
        if (pid != null) {
          productSubs[pid] = allSubs[i];
        }
      }
    } catch (e) {
      // If subproduct requests fail, we still proceed with the products we have.
      debugPrint('Warning: failed to fetch some subProducts: $e');
    }

    // 3) build flattened dropdown options (prefer subName list per product)
    final List<String> options = [];
    for (final p in networks) {
      final subs = productSubs[p.id] ?? [];
      if (subs.isNotEmpty) {
        for (final s in subs) {
          if (s.subName != null && s.subName!.trim().isNotEmpty) {
            // ensure uniqueness
            if (!options.contains(s.subName!.trim())) {
              options.add(s.subName!.trim());
            }
          }
        }
      } else {
        // fallback to productName if there are no subproducts
        final pn = p.productName?.trim();
        if (pn != null && pn.isNotEmpty && !options.contains(pn)) {
          options.add(pn);
        }
      }
    }

    // 4) determine preselected item (try subName match first, else productName match)
    String? selected;
    int? selectedProdId;
    int? selectedSubId;

    if (initialNetwork != null && initialNetwork.trim().isNotEmpty) {
      final normalized = initialNetwork.trim().toLowerCase();

// try containment in subNames
      if (selected == null) {
        for (final entry in productSubs.entries) {
          for (final s in entry.value) {
            if ((s.subName ?? '').toLowerCase().contains(normalized)) {
              selected = s.subName?.trim();
              selectedProdId = entry.key;
              selectedSubId = s.id;
              break;
            }
          }
          if (selected != null) break;
        }
      }

// try containment in product names too
      if (selected == null) {
        for (final p in networks) {
          final pn = (p.productName ?? '').toLowerCase();
          if (pn.contains(normalized)) {
            final subs = productSubs[p.id] ?? [];
            if (subs.isNotEmpty && subs.first.subName != null) {
              selected = subs.first.subName!.trim();
              selectedProdId = p.id;
              selectedSubId = subs.first.id;
            } else {
              selected = p.productName?.trim();
              selectedProdId = p.id;
              selectedSubId = null;
            }
            break;
          }
        }
      }
    }

    // 5) append new state
    state = state.copyWith(
      isLoading: false,
      products: networks,
      productSubProducts: productSubs,
      networkOptions: options,
      selectedNetwork: selected ?? state.selectedNetwork,
      selectedNetworkProductId:
          selectedProdId ?? state.selectedNetworkProductId,
      selectedNetworkSubProductId:
          selectedSubId ?? state.selectedNetworkSubProductId,
      error: result.status != 'success' ? result.message : null,
    );

    if (result.status != 'success') {
      context.showErrorSnackBar(result.message ?? 'Failed to load networks');
    }
  }

  void selectNetwork(String network) {
    final normalized = network.trim();
    int? foundProductId;
    int? foundSubId;

    // try to find matching subProduct first
    for (final entry in state.productSubProducts.entries) {
      for (final s in entry.value) {
        if ((s.subName ?? '').trim() == normalized) {
          foundProductId = entry.key;
          foundSubId = s.id;
          break;
        }
      }
      if (foundProductId != null) break;
    }

    // If not found in subProducts, try matching product name
    if (foundProductId == null) {
      final p = state.products.firstWhere(
        (p) => (p.productName ?? '').trim() == normalized,
        orElse: () => Product(id: -1, productName: null),
      );
      if (p.id != null && p.id != -1) {
        foundProductId = p.id;
        // pick first subProduct if any
        final subs = state.productSubProducts[p.id] ?? [];
        foundSubId = subs.isNotEmpty ? subs.first.id : null;
      }
    }

    state = state.copyWith(
      selectedNetwork: normalized,
      selectedNetworkProductId: foundProductId,
      selectedNetworkSubProductId: foundSubId,
    );
  }

  void selectQuantity(String quantity) {
    state = state.copyWith(selectedQuantity: quantity);
  }

  bool validateForm() {
    return state.agentNameController.text.isNotEmpty &&
        state.agentEmailController.text.isNotEmpty &&
        state.agentPhoneController.text.isNotEmpty &&
        state.businessNameController.text.isNotEmpty &&
        state.selectedNetwork != null &&
        state.amountController.text.isNotEmpty &&
        state.selectedQuantity != null;
  }

  void submitForm(BuildContext context) {
    if (!validateForm()) {
      context.showErrorSnackBar('Please fill all required fields');
      return;
    }

    final amount = getTransactionAmount();
    if (amount <= 0) {
      context.showErrorSnackBar('Please enter a valid amount and quantity');
      return;
    }

    final walletBalance = double.tryParse(
            _ref.read(globalProvider).walletBalance.value?.wallet.toString() ??
                '0.0') ??
        0.0;
    if (amount > walletBalance) {
      context.showErrorSnackBar(
          'Insufficient wallet balance: ${walletBalance.toCurrency()} available');
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => EnterPinScreen(
          onVerified: (pin) async {
            await purchase(ctx, amount: amount.toString());
          },
        ),
      ),
    );
  }

//TODO: implement an extraction of the selectedNetwork and remove the word "EPIN" and convert to lower case remove all space, from it before sending to the backend if needed.
  String extractNetworkName(String? network) {
    if (network == null) return '';
    return network.replaceAll('EPIN', '').replaceAll(' ', '').toLowerCase();
  }

  Future<void> purchase(BuildContext context, {required String amount}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final token = await _ref.read(authTokenProvider.future);
      unawaited(
          context.showLoadingDialog(message: 'Retrieving device info...'));

      unawaited(context.showLoadingDialog(message: "Initiating payment..."));
      final req = EpinRequest(
        agentName: state.agentNameController.text.trim(),
        agentEmail: state.agentEmailController.text.trim(),
        agentPhone: state.agentPhoneController.text.trim(),
        businessName: state.businessNameController.text.trim(),
        network: extractNetworkName(state.selectedNetwork),
        amount: amount,
        email: state.agentEmailController.text.trim(),
        quantity: state.selectedQuantity?.trim(),
      );

      final api = _ref.read(apiServiceProvider);
      final result = await api.purchaseEpin(token, req);
      context.dismissDialog();
      result.fold(
        (failure) {
          clearForm();
          final userMsg = userFacingMessageFromFailure(failure);
          final displayMsg = sanitizeErrorMessage(userMsg);
          // context.showErrorSnackBar(displayMsg);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (ctx) => FailedResultScreen(
                serviceContent: 'E-pin voucher',
                errorMessage: displayMsg,
                onRetry: () =>
                    context.pushReplacement(RouteConstants.dashboard),
              ),
            ),
          );
        },
        (response) {
          if (response.status == 'success') {
            clearForm();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (ctx) => BulkPinSuccessResultScreen(
                  subtitle: response.message,
                ),
              ),
            );
          } else {
            clearForm();
            final displayMsg = sanitizeErrorMessage(response.message ??
                'E-pin purchase failed. Please try again later.');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (ctx) => FailedResultScreen(
                  serviceContent: 'E-pin voucher',
                  errorMessage: displayMsg,
                  onRetry: () =>
                      context.pushReplacement(RouteConstants.dashboard),
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      clearForm();
      context.dismissDialog();
      state = state.copyWith(isLoading: false, error: e.toString());
      final displayMsg = sanitizeErrorMessage(e);
      debugPrint('E-pin purchase error: $displayMsg');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void clearForm() {
    state.agentNameController.clear();
    state.agentEmailController.clear();
    state.agentPhoneController.clear();
    state.businessNameController.clear();
    state.amountController.clear();

    state = state.copyWith(
      selectedNetwork: null,
      selectedNetworkProductId: null,
      selectedNetworkSubProductId: null,
      selectedQuantity: null,
    );
  }

  @override
  void dispose() {
    state.agentNameController.dispose();
    state.agentEmailController.dispose();
    state.agentPhoneController.dispose();
    state.businessNameController.dispose();
    state.amountController.dispose();
    super.dispose();
  }
}

