import 'package:bundlegram/data/models/products/get_all_products_response.dart';
import 'package:bundlegram/data/models/products/get_sub_products_response.dart';
import 'package:flutter/material.dart';

class BulkEpinState {
  final TextEditingController agentNameController;
  final TextEditingController agentEmailController;
  final TextEditingController agentPhoneController;
  final TextEditingController businessNameController;
  final TextEditingController amountController;
  final String? selectedNetwork;
  final String? selectedQuantity;
  final List<Product> products;
  final bool isLoading;
  final String? error;
  final List<String>
      networkOptions; // flattened list of subName (or productName fallback)
  final Map<int, List<SubProduct>>
      productSubProducts; // productId -> list of subProducts
  final int?
      selectedNetworkProductId; // product id for the current selectedNetwork
  final int? selectedNetworkSubProductId;

  BulkEpinState({
    required this.agentNameController,
    required this.agentEmailController,
    required this.agentPhoneController,
    required this.businessNameController,
    required this.amountController,
    this.selectedNetwork,
    this.selectedQuantity,
    this.products = const [],
    this.isLoading = false,
    this.error,
    this.networkOptions = const [],
    this.productSubProducts = const {},
    this.selectedNetworkProductId,
    this.selectedNetworkSubProductId,
  });

  BulkEpinState copyWith({
    TextEditingController? agentNameController,
    TextEditingController? agentEmailController,
    TextEditingController? agentPhoneController,
    TextEditingController? businessNameController,
    TextEditingController? amountController,
    String? selectedNetwork,
    String? selectedQuantity,
    List<Product>? products,
    bool? isLoading,
    String? error,
    List<String>? networkOptions,
    Map<int, List<SubProduct>>? productSubProducts,
    int? selectedNetworkProductId,
    int? selectedNetworkSubProductId,
  }) {
    return BulkEpinState(
      agentNameController: agentNameController ?? this.agentNameController,
      agentEmailController: agentEmailController ?? this.agentEmailController,
      agentPhoneController: agentPhoneController ?? this.agentPhoneController,
      businessNameController:
          businessNameController ?? this.businessNameController,
      amountController: amountController ?? this.amountController,
      selectedNetwork: selectedNetwork ?? this.selectedNetwork,
      selectedQuantity: selectedQuantity ?? this.selectedQuantity,
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      networkOptions: networkOptions ?? this.networkOptions,
      productSubProducts: productSubProducts ?? this.productSubProducts,
      selectedNetworkProductId:
          selectedNetworkProductId ?? this.selectedNetworkProductId,
      selectedNetworkSubProductId:
          selectedNetworkSubProductId ?? this.selectedNetworkSubProductId,
          
    );
  }
}
