import 'package:bundlegram/data/models/beneficiaries/get_all_beneficiaries.dart';
import 'package:bundlegram/data/models/products/get_all_products_response.dart';
import 'package:bundlegram/data/models/products/get_sub_products_response.dart';
import 'package:flutter/material.dart';

class PlatformProductState {
  final Product? selectedProduct;
  final SubProduct? selectedSubProduct;
  final String? selectedProviderIcon;
  final String? selectedDataType;
  final String? selectedPaymentType;
  final int? selectedPresetAmount;
  final List<String> dropdownOptions;
  final TextEditingController firstInputController;
  final TextEditingController secondaryInputController;
  final TextEditingController amountController;
  final bool isLoading;
  final String? error;
  final bool isValidated;
  final String? validatedName;
  final List<Product> products;
  final List<SubProduct> subProducts;
  final bool isValidating;
  final bool billValidated;
  final double? discountedAmount;
  final Beneficiary? selectedBeneficiary;
  final bool isPhoneInputValid;

  PlatformProductState({
    this.selectedProduct,
    this.selectedSubProduct,
    this.selectedProviderIcon,
    this.selectedPresetAmount,
    this.selectedDataType,
    this.selectedPaymentType,
    required this.dropdownOptions,
    required this.firstInputController,
    required this.secondaryInputController,
    required this.amountController,
    this.isLoading = false,
    this.error,
    this.isValidated = false,
    this.validatedName,
    this.products = const [],
    this.subProducts = const [],
    this.isValidating = false,
    this.billValidated = false,
    this.discountedAmount,
    this.selectedBeneficiary,
    this.isPhoneInputValid = false,
  });

  factory PlatformProductState.initial() => PlatformProductState(
        firstInputController: TextEditingController(),
        secondaryInputController: TextEditingController(),
        amountController: TextEditingController(),
        dropdownOptions: [],
        isValidating: false,
        billValidated: false,
        discountedAmount: null,
        selectedBeneficiary: null,
        isPhoneInputValid: false,
      );

  PlatformProductState copyWith({
    Product? selectedProduct,
    SubProduct? selectedSubProduct,
    String? selectedProviderIcon,
    String? selectedDataType,
    String? selectedPaymentType,
    int? selectedPresetAmount,
    List<String>? dropdownOptions,
    TextEditingController? firstInputController,
    TextEditingController? secondaryInputController,
    TextEditingController? amountController,
    bool? isLoading,
    String? error,
    bool? isValidated,
    String? validatedName,
    List<Product>? products,
    List<SubProduct>? subProducts,
    bool? isValidating,
    bool? billValidated,
    double? discountedAmount,
    Beneficiary? selectedBeneficiary,
    bool? isPhoneInputValid,
  }) {
    return PlatformProductState(
      selectedProduct: selectedProduct ?? this.selectedProduct,
      selectedSubProduct: selectedSubProduct ?? this.selectedSubProduct,
      selectedProviderIcon: selectedProviderIcon ?? this.selectedProviderIcon,
      selectedDataType: selectedDataType ?? this.selectedDataType,
      selectedPresetAmount: selectedPresetAmount ?? this.selectedPresetAmount,
      selectedPaymentType: selectedPaymentType ?? this.selectedPaymentType,
      dropdownOptions: dropdownOptions ?? this.dropdownOptions,
      firstInputController: firstInputController ?? this.firstInputController,
      secondaryInputController:
          secondaryInputController ?? this.secondaryInputController,
      amountController: amountController ?? this.amountController,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isValidated: isValidated ?? this.isValidated,
      validatedName: validatedName ?? this.validatedName,
      products: products ?? this.products,
      subProducts: subProducts ?? this.subProducts,
      isValidating: isValidating ?? this.isValidating,
      billValidated: billValidated ?? this.billValidated,
      discountedAmount: discountedAmount ?? this.discountedAmount,
      selectedBeneficiary: selectedBeneficiary ?? this.selectedBeneficiary,
      isPhoneInputValid: isPhoneInputValid ?? this.isPhoneInputValid,
    );
  }
}
