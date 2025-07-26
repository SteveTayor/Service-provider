import 'dart:async';
import 'dart:io';

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_formatter.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/models/base/base_response.dart';
import 'package:bundlegram/data/models/products/get_all_products_response.dart';
import 'package:bundlegram/data/models/products/get_sub_products_response.dart';
import 'package:bundlegram/data/models/transaction/initiate_transactcion_requests.dart';
import 'package:bundlegram/data/models/transaction/validate_bill_request.dart';
import 'package:bundlegram/data/models/transaction/validate_bill_response.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/gen/fonts.gen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/data/platform_data.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/model/platform_product_state.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/products_provider.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/choosebiller.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/purchase_bill_wrapper.dart';
import 'package:bundlegram/presentation/features/transaction/screens/airtime/widget/airtime_success.dart';
import 'package:bundlegram/presentation/features/transaction/screens/betting/widget/betting_success.dart';
import 'package:bundlegram/presentation/features/transaction/screens/bulk%20e-pin/bulkE-pin_screen.dart';
import 'package:bundlegram/presentation/features/transaction/screens/bulk%20e-pin/widget/bulk_pin_success.dart';
import 'package:bundlegram/presentation/features/transaction/screens/bulk%20e-pin/widget/epin_success.dart';
import 'package:bundlegram/presentation/features/transaction/screens/cabletv/widget/cabletvsuccess.dart';
import 'package:bundlegram/presentation/features/transaction/screens/education/widget/education_success.dart';
import 'package:bundlegram/presentation/features/transaction/screens/electricity/widget/electricity_success.dart';
import 'package:bundlegram/presentation/features/transaction/screens/internet-services/widget/internetservice_success.dart';
import 'package:bundlegram/presentation/features/transaction/screens/mobile-data/widget/mobiledata_success.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transactionsummary_widget.dart';
import 'package:bundlegram/presentation/features/wallet/screen/enterpin_screen.dart';
import 'package:bundlegram/presentation/features/wallet/screen/topup_failed_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

const List<PlatformProductType> kValidationRequiredServices = [
  PlatformProductType.betting,
  PlatformProductType.cableTv,
  PlatformProductType.electricity,
  PlatformProductType.education,
  PlatformProductType.internetServices,
];

final platformProductProvider = StateNotifierProvider.family<
    PlatformProductNotifier, PlatformProductState, PlatformProductType>((ref,
        serviceType) =>
    PlatformProductNotifier(ref.read(apiServiceProvider), serviceType, ref));

class PlatformProductNotifier extends StateNotifier<PlatformProductState> {
  final ApiService _apiService;
  final PlatformProductType _serviceType;
  final Ref _ref;

  Timer? _debounce;

  PlatformProductNotifier(this._apiService, this._serviceType, this._ref)
      : super(PlatformProductState.initial());

  Future<void> fetchProducts(BuildContext context) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _ref.read(productsProvider(_serviceType).future);
    state = state.copyWith(
      isLoading: false,
      products: result.data ?? [],
      error: result.status != 'success' ? result.message : null,
    );

    // Auto-select first product and fetch subproducts
    if (result.data != null && result.data!.isNotEmpty) {
      final firstProduct = result.data!.first;
      final providerIcon = normalizeAssetName(
        firstProduct.productName,
        serviceType: _serviceType,
      );
      selectProduct(firstProduct, providerIcon ?? '');
      await fetchSubProducts(context, firstProduct.id!);
    }

    if (result.status != 'success') {
      context.showErrorSnackBar(result.message ?? 'Failed to load products');
    }
  }

  Future<void> fetchSubProducts(BuildContext context, int productId) async {
    if (!_serviceType.hasSubProducts) return;
    state = state.copyWith(isLoading: true, error: null);
    final result = await _ref.read(subProductsProvider(productId).future);
    final subs = result.data ?? [];

    // Extract unique non-null data types
    final options =
        subs.map((e) => e.dataType).whereType<String>().toSet().toList();

    // Auto-select first subproduct
    SubProduct? defaultSubProduct;
    if (subs.isNotEmpty) {
      defaultSubProduct = subs.first;
    }

    state = state.copyWith(
      isLoading: false,
      subProducts: subs,
      dropdownOptions: options,
      selectedDataType: options.isNotEmpty ? options.first : null,
      selectedSubProduct: defaultSubProduct,
      amountController: _serviceType == PlatformProductType.electricity
          ? state.amountController
          : TextEditingController(text: defaultSubProduct?.subPrice ?? ''),
      error: result.status != 'success' ? result.message : null,
    );

    if (result.status != 'success') {
      context.showErrorSnackBar(result.message ?? 'Failed to load subproducts');
    }
  }

  // Future<void> fetchSubProducts(BuildContext context, int productId) async {
  //   if (!_serviceType.hasSubProducts) return;
  //   state = state.copyWith(isLoading: true, error: null);
  //   final result = await _ref.read(subProductsProvider(productId).future);
  //   final subs = result.data ?? [];

  //   // Extract unique non-null data types
  //   final options =
  //       subs.map((e) => e.dataType).whereType<String>().toSet().toList();

  //   // Auto-select first subproduct
  //   SubProduct? defaultSubProduct;
  //   if (subs.isNotEmpty) {
  //     defaultSubProduct = subs.first;
  //   }

  //   state = state.copyWith(
  //     isLoading: false,
  //     subProducts: subs,
  //     dropdownOptions: options,
  //     selectedDataType: options.isNotEmpty ? options.first : null,
  //     selectedSubProduct: defaultSubProduct,
  //     amountController: _serviceType == PlatformProductType.electricity
  //         ? state.amountController
  //         : TextEditingController(text: defaultSubProduct?.subPrice ?? ''),
  //     error: result.status != 'success' ? result.message : null,
  //   );

  //   if (result.status != 'success') {
  //     context.showErrorSnackBar(result.message ?? 'Failed to load subproducts');
  //   }
  // }
  // Future<void> fetchSubProducts(BuildContext context, int productId) async {
  //   if (!_serviceType.hasSubProducts) return;
  //   state = state.copyWith(isLoading: true, error: null);
  //   final result = await _ref.read(subProductsProvider(productId).future);
  //   final subs = result.data ?? [];

  //   // Extract unique non-null data types
  //   final options =
  //       subs.map((e) => e.dataType).whereType<String>().toSet().toList();
  //   // For airtime, betting always select the subproduct (even if multiple exist)
  //   if (_serviceType == PlatformProductType.airtime ||
  //       _serviceType == PlatformProductType.betting) {
  //     state = state.copyWith(
  //       selectedSubProduct: subs.first,
  //       amountController: state.amountController, // Preserve existing amount
  //     );
  //   } else if (subs.length == 1) {
  //     state = state.copyWith(
  //       selectedSubProduct: subs.first,
  //       amountController:
  //           TextEditingController(text: subs.first.subPrice ?? ''),
  //     );
  //   }

  //   state = state.copyWith(
  //     isLoading: false,
  //     subProducts: subs,
  //     dropdownOptions: options,
  //     selectedDataType: options.isNotEmpty ? options.first : null,
  //     error: result.status != 'success' ? result.message : null,
  //   );
  //   if (result.status != 'success') {
  //     context.showErrorSnackBar(result.message ?? 'Failed to load subproducts');
  //   }
  // }

  Future<void> fetchSubProductsByCategory(
      BuildContext context, int productId, String category) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _ref
        .read(subProductsByCategoryProvider((productId, category)).future);
    final subs = result.data ?? [];
    // derive dropdown options from subProducts (unique dataType)
    // final options =
    //     subs.map((s) => s.dataType).whereType<String>().toSet().toList();
    state = state.copyWith(
      isLoading: false,
      subProducts: subs,
      // dropdownOptions: options,
      selectedDataType:
          state.selectedDataType == null ? null : state.selectedDataType,
      error: result.status != 'success' ? result.message : null,
    );
    if (result.status != 'success') {
      context.showErrorSnackBar(
          result.message ?? 'Failed to load subproducts by category');
    }
  }

  void selectProduct(Product product, String providerIcon) {
    state = state.copyWith(
      selectedProduct: product,
      selectedProviderIcon: providerIcon,
      selectedSubProduct: null,
      selectedDataType: null,
      selectedPaymentType: null,
      subProducts: [],
      dropdownOptions: [],
      amountController: TextEditingController(),
      isValidated: false,
      validatedName: null,
    );
  }

  void selectPresetAmount(int amount) {
    state = state.copyWith(
      selectedPresetAmount: amount,
    );
    state.amountController.text = amount.toString();
  }

  void clearSelectedPresetAmount() {
    state = state.copyWith(selectedPresetAmount: null);
  }

  void selectDataType(String dataType) {
    state = state.copyWith(selectedDataType: dataType);
  }

  void selectPaymentType(String type) {
    state = state.copyWith(selectedPaymentType: type);
  }

  void selectSubProduct(SubProduct subProduct) {
    state = state.copyWith(
      selectedSubProduct: subProduct,
      amountController: _serviceType == PlatformProductType.electricity
          ? state.amountController // Retain the current user-entered amount
          : TextEditingController(text: subProduct.subPrice),
    );
  }

  double calculateDiscountedPrice(double amount, SubProduct? subProduct) {
    if (subProduct == null) return amount;

    final profile = _ref.read(globalProvider).profile.value?.data;
    final isAgent = profile?.userType == "agent";

    double discountPercent;

    if (isAgent) {
      discountPercent = (subProduct.agentPercent ?? 0).toDouble();
    } else {
      discountPercent = double.tryParse(subProduct.userPercent ?? '') ?? 0.0;
    }

    return amount - (amount * (discountPercent / 100));
  }

  /// Given a raw productIcon string from the server, normalize it down to
  /// just the filename i have under assets/images/, or return null.
  // String? normalizeAssetName(String? raw) {
  //   if (raw == null || raw.isEmpty) return null;
  //   // 1. Remove any directory parts
  //   final fileName = raw.split(RegExp(r'[\\/]+')).last;
  //   //    e.g. "upload/images/mtn.png" → "mtn.png"
  //   // 2. Ensure it has a known extension (png, jpg, jpeg, webp, svg)
  //   final lower = fileName.toLowerCase();
  //   final validExt = ['.png', '.jpg', '.jpeg', '.webp', '.svg'];
  //   final hasValid = validExt.any((ext) => lower.endsWith(ext));
  //   if (!hasValid) return null;
  //   // 3.verify that this file actually exists in your assets/
  //   //    — you can maintain a Set<String> of your bundled filenames,
  //   //      or rely on pubspec.yaml audits.
  //   //    For simplicity, we assume it’s there.
  //   return fileName;
  // }

  void showBillerPicker(BuildContext ctx) {
    ctx.showBottomSheet(
      child: ChoosebillerWidget(
        serviceType: _serviceType,
        onProviderSelected: (path, name, id) {
          final product = state.products.firstWhere((p) => p.id == id);

          // 1. Select the product visually
          selectProduct(product, path!);

          // 2. Trigger fetchSubProducts based on product.id
          fetchSubProducts(ctx, product.id!);
        },
      ),
    );
  }

  bool get requiresValidation {
    return kValidationRequiredServices.contains(_serviceType);
  }

  // Validation conditions for each bill type
  String? validateForm() {
    // Common validation
    if (state.selectedProduct == null) {
      return 'Please select a biller';
    }

    // Service-specific validations
    switch (_serviceType) {
      case PlatformProductType.airtime:
        if (state.firstInputController.text.length != 11) {
          return 'Phone number must be 11 digits';
        }
        if (state.amountController.text.isEmpty ||
            double.tryParse(state.amountController.text) == null ||
            double.parse(state.amountController.text) <= 0) {
          return 'Please enter a valid amount';
        }
        break;

      case PlatformProductType.mobileData:
        if (state.firstInputController.text.length != 11) {
          return 'Phone number must be 11 digits';
        }
        if (state.selectedSubProduct == null) {
          return 'Please select a data plan';
        }
        break;

      case PlatformProductType.betting:
        if (state.secondaryInputController.text.length != 10) {
          return 'User ID must be 10 digits';
        }
        if (state.amountController.text.isEmpty ||
            double.tryParse(state.amountController.text) == null ||
            double.parse(state.amountController.text) <= 0) {
          return 'Please enter a valid amount';
        }
        if (!state.isValidated) {
          return 'Please validate your user ID';
        }
        break;

      case PlatformProductType.cableTv:
        if (state.secondaryInputController.text.length != 10) {
          return 'Smart Card Number must be 10 digits';
        }
        if (state.selectedSubProduct == null) {
          return 'Please select a cable TV package';
        }
        if (!state.isValidated) {
          return 'Please validate your smart card number';
        }
        break;

      case PlatformProductType.electricity:
        if (state.secondaryInputController.text.length != 10) {
          return 'Meter Number must be 10 digits';
        }
        // if (state.selectedSubProduct == null) {
        //   return 'Please select Prepaid or Postpaid';
        // }
        if (state.amountController.text.isEmpty ||
            double.tryParse(state.amountController.text) == null ||
            double.parse(state.amountController.text) <= 0) {
          return 'Please enter a valid amount';
        }
        if (!state.isValidated) {
          return 'Please validate your meter number';
        }
        break;

      case PlatformProductType.ePinVoucher:
      case PlatformProductType.bulkEPin:
        if (state.selectedSubProduct == null) {
          return 'Please select an e-pin package';
        }
        break;

      case PlatformProductType.education:
        if (state.secondaryInputController.text.isEmpty) {
          return 'Please enter a valid account number';
        }
        if (state.selectedSubProduct == null) {
          return 'Please select an education package';
        }
        if (!state.isValidated) {
          return 'Please validate your account number';
        }
        break;

      case PlatformProductType.internetServices:
        if (state.secondaryInputController.text.length != 10) {
          return 'Account number must be 10 digits';
        }
        if (state.selectedSubProduct == null) {
          return 'Please select an internet package';
        }
        if (!state.isValidated) {
          return 'Please validate your account number';
        }
        break;
    }

    return null;
  }

  // String? validateForm() {
  //   // Check biller
  //   if (state.selectedProduct == null) {
  //     return 'Please select a biller';
  //   }

  //   // Check subproduct (if required)
  //   if (_serviceType.hasSubProducts && state.selectedSubProduct == null) {
  //     return 'Please select a package or plan';
  //   }

  //   // Check amount for airtime, betting, or electricity
  //   if (_serviceType == PlatformProductType.airtime ||
  //       _serviceType == PlatformProductType.betting ||
  //       _serviceType == PlatformProductType.electricity) {
  //     if (state.amountController.text.isEmpty) {
  //       return 'Please enter or select an amount';
  //     }
  //     final amount = double.tryParse(state.amountController.text) ?? 0.0;
  //     if (amount <= 0) {
  //       return 'Please enter a valid amount greater than zero';
  //     }
  //   }

  //   // Check input field
  //   final inputController = _serviceType == PlatformProductType.airtime ||
  //           _serviceType == PlatformProductType.mobileData
  //       ? state.firstInputController
  //       : state.secondaryInputController;
  //   if (inputController.text.isEmpty) {
  //     return _serviceType == PlatformProductType.airtime ||
  //             _serviceType == PlatformProductType.mobileData
  //         ? 'Please enter a phone number'
  //         : _serviceType == PlatformProductType.betting
  //             ? 'Please enter a user ID'
  //             : _serviceType == PlatformProductType.cableTv
  //                 ? 'Please enter a smart card number'
  //                 : _serviceType == PlatformProductType.electricity
  //                     ? 'Please enter a meter number'
  //                     : 'Please enter an account number';
  //   }

  //   // Check validation for services requiring it
  //   if (requiresValidation && !state.isValidated) {
  //     return 'Please validate your ${_serviceType == PlatformProductType.betting ? 'user ID' : _serviceType == PlatformProductType.cableTv ? 'smart card number' : _serviceType == PlatformProductType.electricity ? 'meter number' : 'account number'}';
  //   }

  //   return null;
  // }
  // bool validateForm() {
  //   final inputController = _serviceType == PlatformProductType.airtime ||
  //           _serviceType == PlatformProductType.mobileData
  //       ? state.firstInputController
  //       : state.secondaryInputController;

  //   final baseValidation = state.selectedProduct != null &&
  //       (_serviceType.hasSubProducts
  //           ? state.selectedSubProduct != null
  //           : true) &&
  //       (_serviceType == PlatformProductType.airtime ||
  //               _serviceType == PlatformProductType.betting ||
  //               _serviceType == PlatformProductType.electricity
  //           ? state.amountController.text.isNotEmpty
  //           : true) &&
  //       inputController.text.isNotEmpty &&
  //       (!requiresValidation || (requiresValidation && state.isValidated));

  //   if (_serviceType == PlatformProductType.electricity) {
  //     final amount = double.tryParse(state.amountController.text) ?? 0;
  //     return baseValidation && state.selectedSubProduct != null && amount > 0;
  //   }

  //   return baseValidation;
  // }

  bool _matches(String a, String b) {
    final cleanA = a.toLowerCase().replaceAll(RegExp(r'\s+'), '');
    final cleanB = b.toLowerCase().replaceAll(RegExp(r'\s+'), '');
    return cleanA.contains(cleanB) || cleanB.contains(cleanA);
  }

  String _extractBrand(String name) {
    final lower = name.toLowerCase();
    if (lower.contains("mtn")) return "mtn";
    if (lower.contains("glo")) return "glo";
    if (lower.contains("airtel")) return "airtel";
    if (lower.contains("9mobile") || lower.contains("etisalat"))
      return "9mobile";
    return name.split(" ").first.toLowerCase();
  }

  // Map sub-product or product names to asset paths from PlatFormData
  String? normalizeAssetName(String? raw, {PlatformProductType? serviceType}) {
    if (raw == null || raw.isEmpty) {
      return _getFallbackAsset(serviceType ?? _serviceType);
    }

    final lowerName = raw.toLowerCase();
    List<Widget> providers;

    // Select provider list based on service type
    switch (serviceType ?? _serviceType) {
      case PlatformProductType.betting:
        providers = PlatFormData.bettingProviders;
        break;
      case PlatformProductType.electricity:
        providers = PlatFormData.electricityProviderWidget;
        break;
      case PlatformProductType.cableTv:
        providers = PlatFormData.cableTvProviderWidget;
        break;
      case PlatformProductType.internetServices:
        providers = PlatFormData.internetServiceProviderWidget;
        break;
      case PlatformProductType.education:
        providers = PlatFormData.educationProviderWidget;
        break;
      case PlatformProductType.airtime:
        providers = PlatFormData.serviceProviderWidget;
        break;
      case PlatformProductType.mobileData:
        providers = PlatFormData.serviceProviderWidget;
        break;
      case PlatformProductType.ePinVoucher:
      case PlatformProductType.bulkEPin:
        // Use a generic e-pin asset or specific providers if available
        return Assets.svgs.ePin; // Adjust if you have specific e-pin providers
      default:
        return _getFallbackAsset(serviceType ?? _serviceType);
    }

    // Find matching provider based on title
    final matchingProvider = providers.firstWhere(
      (provider) {
        final title = (provider as AppListTile).title;
        if (title.isEmpty) return false;
        final rawKey = _extractBrand(raw);
        final titleKey = _extractBrand(title);
        // return rawKey == titleKey;
        return _matches(raw, title);
      },
      orElse: () => AppListTile(
        title: state.selectedProduct?.productName ?? '',
        imagePath: _getFallbackAsset(serviceType ?? _serviceType),
      ),
    );

    return (matchingProvider as AppListTile).imagePath ??
        _getFallbackAsset(serviceType ?? _serviceType);
  }

  // Get fallback asset based on service type
  String _getFallbackAsset(PlatformProductType serviceType) {
    switch (serviceType) {
      case PlatformProductType.betting:
        return Assets.svgs.betting;
      case PlatformProductType.electricity:
        return Assets.svgs.electricity;
      case PlatformProductType.cableTv:
        return Assets.svgs.cableTv;
      case PlatformProductType.internetServices:
        return Assets.svgs.internetservice;
      case PlatformProductType.education:
        return Assets.svgs.educationSvg;
      case PlatformProductType.airtime:
        return Assets.svgs.mtnnw;
      case PlatformProductType.mobileData:
        return Assets.svgs.mtnnw; // Generic for airtime/data
      case PlatformProductType.ePinVoucher:
      case PlatformProductType.bulkEPin:
        return Assets.svgs.ePin;
      default:
        return Assets.images.logo.path; // Generic fallback
    }
  }

  void validateBill(
    BuildContext context,
    String number,
    int? productId,
    String? autoSubProdId, {
    VoidCallback? onSuccess, // Added for automatic progression
  }) {
    debugPrint(
        'validateBill called: serviceType=${_serviceType}, number=$number, '
        'productId=$productId, autoSubProdId=$autoSubProdId');

    _debounce?.cancel();

    final isPrimaryInputReady = number.trim().length == 11;
    final isSecondaryInputReady =
        state.secondaryInputController.text.trim().length == 10;
    final isBillTypeWithSecondary =
        _serviceType == PlatformProductType.betting ||
            _serviceType == PlatformProductType.cableTv ||
            _serviceType == PlatformProductType.electricity;
    final shouldValidate =
        isBillTypeWithSecondary ? isSecondaryInputReady : isPrimaryInputReady;

    debugPrint('Validation checks: isPrimaryInputReady=$isPrimaryInputReady, '
        'isSecondaryInputReady=$isSecondaryInputReady, '
        'isBillTypeWithSecondary=$isBillTypeWithSecondary, '
        'shouldValidate=$shouldValidate, '
        'selectedProduct=${state.selectedProduct?.id}');

    if (!shouldValidate || state.selectedProduct == null) {
      debugPrint('Validation aborted: shouldValidate=$shouldValidate, '
          'selectedProduct=${state.selectedProduct == null ? 'null' : state.selectedProduct!.id}');
      context.showErrorSnackBar(
        'Please enter a valid ${_serviceType == PlatformProductType.airtime || _serviceType == PlatformProductType.mobileData ? 'phone number' : _serviceType == PlatformProductType.betting ? 'user ID' : _serviceType == PlatformProductType.cableTv ? 'smart card number' : 'meter number'}',
      );
      return;
    }

    state =
        state.copyWith(isValidating: true, billValidated: false, error: null);
    debugPrint(
        'State updated: isValidating=true, billValidated=false, error=null');

    _debounce = Timer(const Duration(milliseconds: 700), () async {
      try {
        debugPrint('Starting bill validation API call');
        unawaited(context.showLoadingDialog(message: 'Validating...'));
        final token = await _ref.read(authTokenProvider.future);
        debugPrint(
            'Auth token retrieved: ${token.substring(0, 10)}...'); // Log partial token for security

        final request = ValidateBillRequest(
          number: number,
          productEntityId: productId,
          serviceType: autoSubProdId,
        );
        debugPrint('API request: number=${request.number}, '
            'productEntityId=${request.productEntityId}, '
            'serviceType=${request.serviceType}');

        final result = await _apiService.validateBill(token, request);
        debugPrint(
            'API response: status=${result.fold((l) => 'failure', (r) => r.status)}, '
            'message=${result.fold((l) => l.properties.join('\n'), (r) => r.message)}');

        context.dismissDialog();

        result.fold(
          (failure) {
            state = state.copyWith(
              isValidating: false,
              billValidated: false,
              error: failure.properties.join('\n'),
            );
            debugPrint('Validation failed: error=${state.error}');
            context.showErrorSnackBar(failure.properties.join('\n'));
          },
          (response) {
            final validated = response.status == 'success';
            state = state.copyWith(
              isValidating: false,
              billValidated: validated,
              isValidated: validated,
              validatedName: response.data,
            );
            debugPrint('Validation result: validated=$validated, '
                'validatedName=${response.data}, '
                'state.isValidated=${state.isValidated}');

            if (validated) {
              context.showCustomSnackBar('Validated: ${response.data}');
              debugPrint('Validation successful, calling onSuccess callback');
              onSuccess
                  ?.call(); // Call onSuccess to proceed to transaction summary
            } else {
              debugPrint('Validation failed: message=${response.message}');
              context
                  .showErrorSnackBar(response.message ?? 'Validation failed');
            }
          },
        );
      } catch (e) {
        context.dismissDialog();
        state = state.copyWith(
          isValidating: false,
          billValidated: false,
          error: e.toString(),
        );
        debugPrint('Exception during validation: $e');
        context.showErrorSnackBar(e.toString());
      }
    });
  }

  // void validateBill(
  //   BuildContext context,
  //   String userIdOrNumber,
  //   int? prodEntityId,
  //   String? autoSubProdId,
  // ) {
  //   // Cancel any previous debounce
  //   _debounce?.cancel();

  //   // Prevent validation if inputs are not yet complete
  //   final isPrimaryInputReady = userIdOrNumber.trim().length == 11;
  //   final isSecondaryInputReady =
  //       state.secondaryInputController.text.trim().length == 10;

  //   final isBillTypeWithSecondary = requiresValidation &&
  //       (state.selectedProduct?.productName?.toLowerCase().contains("bet") ??
  //           false);

  //   final shouldValidate =
  //       isBillTypeWithSecondary ? isSecondaryInputReady : isPrimaryInputReady;

  //   if (!shouldValidate || state.selectedProduct == null) return;

  //   // Show loading state
  //   state = state.copyWith(
  //     isValidating: true,
  //     billValidated: false,
  //     error: null,
  //   );

  //   // Debounce 700ms
  //   _debounce = Timer(const Duration(milliseconds: 700), () async {
  //     try {
  //       final token = await _ref.read(authTokenProvider.future);
  //       final request = ValidateBillRequest(
  //         number: userIdOrNumber,
  //         productEntityId: prodEntityId,
  //         serviceType: autoSubProdId,
  //       );

  //       final result = await _apiService.validateBill(token, request);
  //       result.fold(
  //         (failure) {
  //           state = state.copyWith(
  //             isValidating: false,
  //             billValidated: false,
  //             error: failure.properties.join('\n'),
  //           );
  //           context.showErrorSnackBar(failure.properties.join('\n'));
  //         },
  //         (response) {
  //           final validated = response.status == 'success';
  //           state = state.copyWith(
  //             isValidating: false,
  //             billValidated: validated,
  //             isValidated: validated,
  //             validatedName: response.data,
  //           );
  //           if (validated) {
  //             context.showCustomSnackBar('Validated: ${response.data}');
  //           }
  //         },
  //       );
  //     } catch (e) {
  //       state = state.copyWith(
  //         isValidating: false,
  //         billValidated: false,
  //         error: e.toString(),
  //       );
  //       context.showErrorSnackBar(e.toString());
  //     }
  //   });
  // }

  double _getTransactionAmount() {
    if (_serviceType == PlatformProductType.airtime ||
        _serviceType == PlatformProductType.betting ||
        _serviceType == PlatformProductType.electricity) {
      return double.tryParse(state.amountController.text) ?? 0.0;
    }
    if (_serviceType.hasSubProducts && state.selectedSubProduct != null) {
      return double.tryParse(state.selectedSubProduct!.subPrice ?? '') ?? 0.0;
    }
    return double.tryParse(state.amountController.text) ?? 0.0;
  }

  void showTransactionSummary(BuildContext context) {
    final validationError = validateForm();
    if (validationError != null) {
      context.showErrorSnackBar(validationError);
      return;
    }

    // Fetch and validate wallet balance
    _ref.read(globalProvider.notifier).fetchWalletBalance(context);
    final walletBalanceString =
        _ref.read(globalProvider).walletBalance.value?.wallet;

    // Parse wallet balance
    final walletBalance = double.tryParse(walletBalanceString ?? '') ?? 0.0;
    if (walletBalanceString == null || walletBalanceString.isEmpty) {
      context.showErrorSnackBar('Unable to retrieve wallet balance');
      return;
    }
    if (walletBalance < 0) {
      context.showErrorSnackBar('Invalid wallet balance');
      return;
    }

    // Get and validate amount
    final amount = _getTransactionAmount();
    if (amount <= 0) {
      context
          .showErrorSnackBar('Please enter a valid amount greater than zero');
      return;
    }
    if (amount > walletBalance) {
      context.showErrorSnackBar(
          'Insufficient wallet balance: ${CurrencyFormatter.format(walletBalance)} available');
      return;
    }
    final discountedAmount =
        calculateDiscountedPrice(amount, state.selectedSubProduct);

    // Update state with discounted amount
    state = state.copyWith(discountedAmount: discountedAmount);

    final beneficiary = (_serviceType == PlatformProductType.mobileData ||
            _serviceType == PlatformProductType.airtime)
        ? state.firstInputController.text
        : state.secondaryInputController.text;

    context.showBottomSheet(
      showIcon: true,
      child: TransactionSummary(
        assetPath: state.selectedProviderIcon,
        transactionType: state.selectedSubProduct?.subName ??
            state.selectedProduct?.productName,
        amount: CurrencyFormatter.format(amount),
        discountedPrice: CurrencyFormatter.format(discountedAmount),
        beneficiary: beneficiary,
        onPay: () {
          initiatePurchase(
            context,
            amount.toString(),
            discountedAmount.toString(),
            beneficiary,
          );
        },
        paymentMethod: 'Wallet',
      ),
    );
  }

  Future<void> initiatePurchase(BuildContext context, String originalAmount,
      String discountedAmount, String beneficiary) async {
    context.pop(); // Close the bottom sheet
    unawaited(
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => EnterPinScreen(
            onVerified: (pin) async {
              // final result =
              await purchase(
                ctx,
                pin: pin,
                originalAmount: originalAmount,
                discountedAmount: discountedAmount,
                beneficiary: beneficiary,
              );
            },
          ),
        ),
      ),
    );
  }

  Future<dynamic> purchase(
    BuildContext context, {
    required String originalAmount,
    required String pin,
    required String discountedAmount,
    required String beneficiary,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final token = await _ref.read(authTokenProvider.future);

      // Retrieve device info from secure storage
      unawaited(
          context.showLoadingDialog(message: 'Retrieving device info...'));
      final deviceInfo =
          await _ref.read(secureStorageHelperProvider).getDeviceInfo();
      final macAddress = deviceInfo['macAddress']!;
      final ipAddress = deviceInfo['ipAddress']!;
      final latitude = deviceInfo['latitude']!;
      final longitude = deviceInfo['longitude']!;
      final platform = deviceInfo['platform']!;

      unawaited(context.showLoadingDialog(message: "Initiating payment..."));
      final request = InitiateTransactionRequest(
        amount: _serviceType == PlatformProductType.mobileData
            ? originalAmount
            : discountedAmount,
        macAddress: macAddress,
        ipAddress: ipAddress,
        latitude: latitude,
        longitude: longitude,
        crAcc:
            _serviceType == PlatformProductType.ePinVoucher ? '' : beneficiary,
        platform: platform,
        subProdId: state.selectedSubProduct?.id ?? 0,
        serviceId: state.selectedProduct?.serviceId ?? '',
        pin: pin,
      );

      final result = _serviceType == PlatformProductType.mobileData ||
              _serviceType == PlatformProductType.airtime
          ? await _apiService.initiateDataAirtimeTransaction(token, request)
          : await _apiService.initiateBillTransaction(token, request);

      return result.fold(
        (failure) {
          context.dismissDialog();
          final message = failure.properties.join('\n');
          final displayMessage =
              message.toLowerCase().contains('insufficient') ||
                      message.toLowerCase().contains('incorrect pin')
                  ? message
                  : 'Transaction failed. Please try again later.';
          context.showErrorSnackBar(
              message.isNotEmpty ? message : 'Transaction failed');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (ctx) => FailedResultScreen(
                serviceContent: _serviceType.title.toLowerCase(),
                errorMessage: displayMessage,
                onRetry: () {
                  context.pushReplacement(RouteConstants.dashboard);
                },
              ),
            ),
          );
        },
        (response) {
          if (response.success) {
            final screen = _buildSuccessScreen(
                CurrencyFormatter.format(originalAmount), beneficiary);
            context.dismissDialog();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (ctx) => screen),
            );
          } else {
            context.dismissDialog();
            final displayMessage =
                response.message.toLowerCase().contains('insufficient') ||
                        response.message.toLowerCase().contains('incorrect pin')
                    ? response.message
                    : 'Please try again later.';
            context.showErrorSnackBar(displayMessage);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (ctx) => FailedResultScreen(
                  serviceContent: _serviceType.title.toLowerCase(),
                  errorMessage: displayMessage,
                  onRetry: () {
                    context.pushReplacement(RouteConstants.dashboard);
                  },
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      context
        ..dismissDialog()
        ..showErrorSnackBar(e.toString());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (ctx) => FailedResultScreen(
            serviceContent: _serviceType.title.toLowerCase(),
            errorMessage: "The purchase was not successful, Try again later",
            onRetry: () {
              context.pushReplacement(RouteConstants.dashboard);
            },
          ),
        ),
      );
    }
  }

  void showBulkEPinPrompt(BuildContext context) {
    if (_serviceType != PlatformProductType.ePinVoucher) return;
    context.showBottomSheet(
      color: AppColors.background,
      showIcon: false,
      child: Padding(
        padding: context.symmetricPadding(16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            24.verticalSpace,
            Text(
              'Print bulk e-pin voucher',
              style: context.textTheme.displaySmall,
            ),
            24.verticalSpace,
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text:
                    'Do you want to print E-PIN in bulk? You will make money selling E-PIN to people in your community.\n',
                style: context.textTheme.bodySmall,
                children: [
                  TextSpan(
                    text: 'Note:',
                    style: const TextStyle(color: Color(0xFFAA0B27)),
                  ),
                  const TextSpan(text: 'This feature is available to all'),
                  TextSpan(
                    text: ' Bundlegram agents only.',
                    style: context.textTheme.bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                      text:
                          ' Our agents enjoy bulk E-PIN at discounted prices.'),
                ],
              ),
            ),
            40.verticalSpace,
            BundlegramButton(
              text: 'Continue',
              onPressed: () {
                context.pop();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => BulkEpinScreen()),
                );
              },
            ),
            18.verticalSpace,
            BundlegramButton(
              text: 'Cancel',
              isOutline: true,
              color: AppColors.background,
              textStyle: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.grey19,
                fontFamily: FontFamily.mabryPro,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              onPressed: () => context.pop(),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessScreen(String amount, String beneficiary) {
    switch (_serviceType) {
      case PlatformProductType.mobileData:
        return DataSubscriptionSuccessResultScreen(
          dataValue: state.selectedSubProduct?.subName ?? '',
          beneficiary: beneficiary,
        );
      case PlatformProductType.airtime:
        return AirtimeSuccessResultScreen(
          amount: amount,
          beneficiary: beneficiary,
        );
      case PlatformProductType.ePinVoucher:
        return EpinSuccessResultScreen(amount: amount);
      case PlatformProductType.bulkEPin:
        return const BulkPinSuccessResultScreen();
      case PlatformProductType.betting:
        return BettingSuccessResultScreen(
          amount: amount,
          biller: state.selectedProduct?.productName ?? '',
        );
      case PlatformProductType.cableTv:
        return CableTvSuccessResultScreen(amount: amount);
      case PlatformProductType.education:
        return EducationProviderSuccessResultScreen(
          amount: amount,
          biller: state.selectedProduct?.productName ?? '',
        );
      case PlatformProductType.electricity:
        return ElectricitySuccessResultScreen(
          amount: amount,
          biller: state.selectedProduct?.productName ?? '',
        );
      case PlatformProductType.internetServices:
        return InternetServicesSuccessResultScreen(
          amount: state.selectedSubProduct?.subName ?? amount,
          biller: state.selectedProduct?.productName ?? '',
        );
      default:
        return const FailedResultScreen(serviceContent: 'transaction');
    }
  }

  @override
  void dispose() {
    state.firstInputController.dispose();
    state.secondaryInputController.dispose();
    state.amountController.dispose();
    super.dispose();
  }
}
