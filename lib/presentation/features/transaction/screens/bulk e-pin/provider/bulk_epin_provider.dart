import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/data/models/products/get_all_products_response.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/products_provider.dart';
import 'package:bundlegram/presentation/features/transaction/screens/bulk%20e-pin/model/bulk_epin_state.dart';
import 'package:bundlegram/presentation/features/transaction/screens/bulk%20e-pin/widget/bulk_pin_success.dart';
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
        ));

  Future<void> fetchNetworks(BuildContext context) async {
    state = state.copyWith(isLoading: true, error: null);
    final result =
        await _ref.read(productsProvider(PlatformProductType.bulkEPin).future);
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

    // Navigate to success screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const BulkPinSuccessResultScreen(),
      ),
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
