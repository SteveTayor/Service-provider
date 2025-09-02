import 'dart:async';

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/models/products/get_all_products_response.dart';
import 'package:bundlegram/data/models/transaction/initiate_transactcion_requests.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/products_provider.dart';
import 'package:bundlegram/presentation/features/transaction/screens/bulk%20e-pin/model/bulk_epin_state.dart';
import 'package:bundlegram/presentation/features/transaction/screens/bulk%20e-pin/widget/bulk_pin_success.dart';
import 'package:bundlegram/presentation/features/wallet/screen/enterpin_screen.dart';
import 'package:bundlegram/presentation/features/wallet/screen/topup_failed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      agentPhoneController: TextEditingController(text: profile?.phone ?? ''),
      businessNameController: TextEditingController(text: profile?.phone ?? ''),
      // Optionally populate businessNameController if available in profile
    );
  }
  double getTransactionAmount() {
    final quantity = int.tryParse(state.selectedQuantity ?? '0') ?? 0;
    final amountPerPin = double.tryParse(state.amountController.text) ?? 0.0;
    return quantity * amountPerPin;
  }

  Future<void> fetchNetworks(BuildContext context) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _ref
        .read(productsProvider(PlatformProductType.ePinVoucher).future);
    state = state.copyWith(
      isLoading: false,
      products: result.data ?? [],
      error: result.status != 'success' ? result.message : null,
    );
    if (result.status != 'success') {
      context.showErrorSnackBar(result.message ?? 'Failed to load networks');
    }
  }

  void selectNetwork(String network) {
    state = state.copyWith(selectedNetwork: network);
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
            await purchase(ctx, pin: pin, amount: amount.toString());
          },
        ),
      ),
    );
  }

  Future<void> purchase(BuildContext context,
      {required String pin, required String amount}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final token = await _ref.read(authTokenProvider.future);
      unawaited(
          context.showLoadingDialog(message: 'Retrieving device info...'));
      final deviceInfo =
          await _ref.read(secureStorageHelperProvider).getDeviceInfo();
      final macAddress = deviceInfo['macAddress']!;
      final ipAddress = deviceInfo['ipAddress']!;
      final latitude = deviceInfo['latitude']!;
      final longitude = deviceInfo['longitude']!;
      final platform = deviceInfo['platform']!;
// state.selectedProduct?.serviceId
      unawaited(context.showLoadingDialog(message: "Initiating payment..."));
      // final request = InitiateTransactionRequest(
      //   amount: amount,
      //   macAddress: macAddress,
      //   ipAddress: ipAddress,
      //   latitude: latitude,
      //   longitude: longitude,
      //   crAcc: '',
      //   platform: platform,
      //   subProdId: state.products
      //           .firstWhere((p) => p.productName == state.selectedNetwork,
      //               orElse: () => Product(id: 0, productName: ''))
      //           .id ??
      //       0,
      //   serviceId: 'bulk_epin',
      //   pin: pin,
      //   name: state.agentNameController.text,
      //   quantity: state.selectedQuantity, // Include quantity for bulk
      // );

      // // Placeholder for bulk e-pin endpoint
      // final result = await _ref
      //     .read(apiServiceProvider)
      //     .initiateBillPayment(token, request);

      // context.dismissDialog();
      // result.fold(
      //   (failure) {
      //     final message = failure.properties.join('\n');
      //     Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //         builder: (ctx) => FailedResultScreen(
      //           serviceContent: 'E-pin voucher',
      //           errorMessage: message,
      //           onRetry: () =>
      //               context.pushReplacement(RouteConstants.dashboard),
      //         ),
      //       ),
      //     );
      //   },
      //   (response) {
      //     if (response.success) {
      //       Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(
      //             builder: (ctx) => const BulkPinSuccessResultScreen()),
      //       );
      //     } else {
      //       Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(
      //           builder: (ctx) => FailedResultScreen(
      //             serviceContent: 'E-pin voucher',
      //             errorMessage: response.message ?? 'Please try again later',
      //             onRetry: () =>
      //                 context.pushReplacement(RouteConstants.dashboard),
      //           ),
      //         ),
      //       );
      //     }
      //   },
      // );
    } catch (e) {
      context.dismissDialog();
      state = state.copyWith(isLoading: false, error: e.toString());
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (ctx) => FailedResultScreen(
      //       serviceContent: 'Bulk E-pin Voucher',
      //       errorMessage: e.toString(),
      //       onRetry: () => context.pushReplacement(RouteConstants.dashboard),
      //     ),
      //   ),
      // );
    } finally {
      state = state.copyWith(isLoading: false);
    }
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
