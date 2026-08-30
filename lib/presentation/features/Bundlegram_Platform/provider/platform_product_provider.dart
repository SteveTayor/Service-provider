import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bundlegram/core/error/error_sanitixed_users.dart';
import 'package:bundlegram/core/error/errors.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
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
import 'package:bundlegram/data/models/beneficiaries/get_all_beneficiaries.dart';
import 'package:bundlegram/data/models/products/get_all_products_response.dart';
import 'package:bundlegram/data/models/products/get_sub_products_response.dart';
import 'package:bundlegram/data/models/transaction/initiate_transactcion_requests.dart';
import 'package:bundlegram/data/models/transaction/validate_bill_request.dart';
import 'package:bundlegram/data/models/transaction/validate_bill_response.dart';
import 'package:bundlegram/data/models/transaction_receipt/transaction_receipt_model.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/gen/fonts.gen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/data/platform_data.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/data/transaction_helper.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/model/platform_product_state.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/products_provider.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/choosebiller.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/purchase_bill_wrapper.dart';
import 'package:bundlegram/presentation/features/biometric/providers/biometric_service.dart';
import 'package:bundlegram/presentation/features/dashboard/provider/dashboard_provider.dart';
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
import 'package:bundlegram/services/notification_services/notification_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:network_info_plus/network_info_plus.dart';
// import 'package:permission_handler/permission_handler.dart';

const List<PlatformProductType> kValidationRequiredServices = [
  PlatformProductType.betting,
  PlatformProductType.cableTv,
  PlatformProductType.electricity,
  // PlatformProductType.education,
  PlatformProductType.internetServices,
];

// TextEditingController _rehydrate(
//   TextEditingController controller, {
//   String? text,
// }) {
//   // If controller lost its attachment, recreate it
//   try {
//     // Try to access the controller to check if it's still valid
//     controller.text;
//     return controller;
//   } catch (_) {
//     return TextEditingController(text: text);
//   }
// }

final platformProductProvider = StateNotifierProvider.family<
    PlatformProductNotifier, PlatformProductState, PlatformProductType>(
  (ref, serviceType) =>
      PlatformProductNotifier(ref.read(apiServiceProvider), serviceType, ref),
);

class PlatformProductNotifier extends StateNotifier<PlatformProductState> {
  final ApiService _apiService;
  final PlatformProductType _serviceType;
  final Ref _ref;
  final Map<int, List<SubProduct>> _subProductsCache = {};

  // timestamp when each product's subProducts were last fetched
  final Map<int, DateTime> _subProductsFetchedAt = {};

  /// TTL for cached subproducts (5 minutes)
  static const Duration _subProductsCacheTtl = Duration(minutes: 5);

  String? _lastDetectedPhone;

  /// whether cache for a product is still fresh
  bool _isSubProductsCacheFresh(int productId) {
    final ts = _subProductsFetchedAt[productId];
    if (ts == null) return false;
    return DateTime.now().difference(ts) < _subProductsCacheTtl;
  }

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

    // // Auto-select first product only when none is selected yet
    // if (result.data != null &&
    //     result.data!.isNotEmpty &&
    //     state.selectedProduct == null) {
    //   final firstProduct = result.data!.first;
    //   final providerIcon = normalizeAssetName(
    //     firstProduct.productName,
    //     serviceType: _serviceType,
    //   );
    // selectProduct(firstProduct, providerIcon ?? '');
    // await fetchSubProducts(context, firstProduct.id!);
    // await fetchSubProducts(
    //   context,
    //   firstProduct.id!,
    // );
    // }

    if (result.status != 'success') {
      context.showErrorSnackBar(result.message ?? 'Failed to load products');
    }
  }

  void setLoading() {
    state = state.copyWith(isLoading: true);
  }

  /// Refreshing sub-products.
  /// Set force = true to bypass cache.
  Future<void> refreshSubProductsForLoadedProducts(
    BuildContext context, {
    bool force = true,
    int maxChecks = 3,
  }) async {
    final products = state.products;
    if (products.isEmpty) return;
    final toCheck = products.take(maxChecks);
    for (final p in toCheck) {
      final pid = p.id;
      if (pid == null) continue;
      // reducing parallel requests.
      await fetchSubProducts(context, pid, force: force);
    }
  }

  // void rehydrateControllers() {
  //   state = state.copyWith(
  //     firstInputController: _rehydrate(state.firstInputController),
  //     secondaryInputController: _rehydrate(state.secondaryInputController),
  //     amountController: _rehydrate(state.amountController),
  //   );
  // }

  // Future<bool> hasSubProducts(int productId) async {
  //   if (_subProductsCache.containsKey(productId)) {
  //     return _subProductsCache[productId]!.isNotEmpty;
  //   }
  //   final result = await _ref.read(subProductsProvider(productId).future);
  //   final subs = result.data ?? [];
  //   _subProductsCache[productId] = subs; // Cache the result
  //   return subs.isNotEmpty;
  // }
  Future<bool> hasSubProducts(int productId, {bool force = false}) async {
    // Use cache if available and not forced and still fresh
    if (!force &&
        _subProductsCache.containsKey(productId) &&
        _isSubProductsCacheFresh(productId)) {
      return _subProductsCache[productId]!.isNotEmpty;
    }

    // Invalidate Riverpod cache when forcing or stale
    if (force) {
      _ref.invalidate(subProductsProvider(productId));
    }

    try {
      final result = await _ref.read(subProductsProvider(productId).future);
      final subs = result.data ?? [];
      // Cache the result (even if empty) and timestamp it
      _subProductsCache[productId] = subs;
      _subProductsFetchedAt[productId] = DateTime.now();
      return subs.isNotEmpty;
    } catch (e) {
      // cached fall back value if present (even if stale)
      if (_subProductsCache.containsKey(productId)) {
        return _subProductsCache[productId]!.isNotEmpty;
      }
      return false;
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
  //         : TextEditingController(),
  //     error: result.status != 'success' ? result.message : null,
  //   );
  //   if (result.status != 'success') {
  //     context.showErrorSnackBar(result.message ?? 'Failed to load subproducts');
  //   }
  // }
  Future<void> fetchSubProducts(
    BuildContext context,
    int productId, {
    bool force = false,
  }) async {
    if (!_serviceType.hasSubProducts) return;

    // If forced, invalidate BOTH the local cache AND the Riverpod provider
    // so a fresh network request is always made
    if (force || !_isSubProductsCacheFresh(productId)) {
      _subProductsCache.remove(productId);
      _subProductsFetchedAt.remove(productId);
      _ref.invalidate(subProductsProvider(productId)); // â† key addition
    }

    // If we have fresh cache and not forced, return immediately with cached data
    if (!force &&
        _subProductsCache.containsKey(productId) &&
        _isSubProductsCacheFresh(productId)) {
      final subs = _subProductsCache[productId]!;
      final options =
          subs.map((e) => e.dataType).whereType<String>().toSet().toList();
      final defaultSub = subs.isNotEmpty ? subs.first : null;
      state = state.copyWith(
        isLoading: false,
        subProducts: subs,
        dropdownOptions: options,
        selectedDataType: options.isNotEmpty ? options.first : null,
        selectedSubProduct: defaultSub,
        amountController: _serviceType == PlatformProductType.electricity
            ? state.amountController
            : TextEditingController(),
        // amountController: _rehydrate(
        //   state.amountController,
        //   text: _serviceType == PlatformProductType.electricity
        //       ? state.amountController.text
        //       : '',
        // ),

        error: null,
      );
      return;
    }

    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _ref.read(subProductsProvider(productId).future);
      final subs = result.data ?? [];

      // Cache and timestamp (even empty list)
      _subProductsCache[productId] = subs;
      _subProductsFetchedAt[productId] = DateTime.now();

      final options =
          subs.map((e) => e.dataType).whereType<String>().toSet().toList();

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
            : TextEditingController(),
        // amountController: _rehydrate(
        //   state.amountController,
        //   text: _serviceType == PlatformProductType.electricity
        //       ? state.amountController.text
        //       : TextEditingController(),
        // ),

        error: result.status != 'success' ? result.message : null,
      );

      if (result.status != 'success') {
        context.showErrorSnackBar(
            result.message ?? 'Error occurred loading services');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      // user to pull-to-refresh
      context.showErrorSnackBar('Could not fetch services â€” pull to refresh');
    }
  }

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

  Future<void> ensureFreshData(BuildContext context) async {
    // If we already have products, don't touch loading state
    if (state.products.isNotEmpty) {
      // refresh quietly in background
      unawaited(fetchProducts(context));
      return;
    }

    // If empty, THEN load visibly
    await fetchProducts(context);
  }

  /// Set or clear the selected beneficiary in state.
  /// Pass `null` to explicitly clear.
  void setSelectedBeneficiary(Beneficiary? b) {
    // If clearing, empty the phone field so user can manually type
    if (b == null) {
      state.firstInputController.clear();
    }
    state = state.copyWith(selectedBeneficiary: b);
  }

  void selectProduct(Product product, String providerIcon) {
    state = state.copyWith(
      selectedProduct: product,
      selectedProviderIcon: providerIcon,
      // selectedSubProduct: null,
      // selectedDataType: null,
      selectedPaymentType: null,
      // subProducts: [],
      // dropdownOptions: [],
      // amountController: _rehydrate(
      //   state.amountController,
      //   text: "",
      // ),
      // amountController: TextEditingController(),
      isValidated: false,
      validatedName: null,
    );
  }

  void resetForNewProduct() {
    state = state.copyWith(
      selectedSubProduct: null,
      selectedDataType: null,
      selectedPresetAmount: null,
      subProducts: [],
      dropdownOptions: [],
      // amountController: TextEditingController(),
      amountController: state.amountController,

      isValidated: false,
      validatedName: null,
    );
  }

  Future<void> selectProductAndLoadSubProducts(
    BuildContext context,
    Product product,
    String providerIcon, {
    bool force = true,
    bool invalidateCache = false,
  }) async {
    resetForNewProduct();
    // 1. Pure selection
    selectProduct(product, providerIcon);

    // 2. Cache invalidation (CRITICAL for phone changes)
    if (invalidateCache && product.id != null) {
      _subProductsCache.remove(product.id);
      _subProductsFetchedAt.remove(product.id);
      _ref.invalidate(subProductsProvider(product.id!));
    }

    // 3. Explicit side-effect
    if (_serviceType.hasSubProducts && product.id != null) {
      await fetchSubProducts(context, product.id!, force: force);
    }
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
    state.amountController.clear();
    state = state.copyWith(
      selectedDataType: dataType,
      selectedSubProduct: null, // Clear selected subproduct
      selectedPresetAmount: null, // Clear preset amount
      // amountController: TextEditingController(),
      amountController: state.amountController,
    );
  }

  void selectPaymentType(String type) {
    state = state.copyWith(selectedPaymentType: type);
  }

  void selectSubProduct(SubProduct subProduct) {
    state = state.copyWith(
      selectedSubProduct: subProduct,
      selectedPresetAmount: null,
      amountController: _serviceType == PlatformProductType.electricity
          ? state.amountController // Retain the current user-entered amount
          : TextEditingController(text: subProduct.subPrice ?? ''),
    );
  }

  /// Call when the user types a phone number or when pre-filled.
  ///  to auto-detect the network provider and select the matching product.
  /// /// If allowPrefill == true, we treat this as "initial prefill from profile"
  /// and we will attempt to select a matching product and fetch subProducts
  /// so the UI (grid) can show bundles without an explicit beneficiary selection.
  void detectAndSelectFromPhone(BuildContext ctx, String rawPhone,
      {bool allowPrefill = false}) {
    _debounce?.cancel();
    // small debounce so we don't run detection on every keystroke
    _debounce = Timer(const Duration(milliseconds: 600), () async {
      if (state.selectedBeneficiary != null && !allowPrefill) {
        // beneficiary already applied; skip auto-detect
        return;
      }
      try {
        final phone = rawPhone.trim();
        // normalize +234 -> 0 form for easier prefix checks
        final normalized =
            phone.startsWith('+234') ? '0${phone.substring(4)}' : phone;

        // quick validity check: we expect local 11-digit numbers for NG
        final isValidPhone = normalized.length == 11 &&
            RegExp(r'^0\d{10}$').hasMatch(normalized);

        // mark input validity in state so UI can enable/disable controls
        state = state.copyWith(isPhoneInputValid: isValidPhone);

        if (!isValidPhone) {
          // If invalid, don't try to auto-select. Keep existing product if user had chosen it manually.
          debugPrint('Phone not valid for auto-detect: $normalized');
          return;
        }

        // before auto-selecting:
        // if (state.selectedProduct != null) {
        //   debugPrint(
        //       'User has already selected a provider; skipping auto-select from phone.');
        //   return;
        // }

// if phone changed since last time, clear dependent selections to avoid mismatches
        if (_lastDetectedPhone != normalized) {
          _lastDetectedPhone = normalized;
          state = state.copyWith(
            selectedSubProduct: null,
            selectedPresetAmount: null,
          );
        }
        final detected = _detectNetworkFromPhone(normalized);
        debugPrint('Auto-detected network: $detected');

        // Look for active products first (filter out deactivated ones)
        Product? matchingProduct;
        for (final p in state.products) {
          // if your Product model uses `status` as '1' for active:
          if (!_isEntityActive(p)) continue; // reuse _isEntityActive helper
          final prodName = p.productName ?? '';
          if (_matches(prodName, detected)) {
            matchingProduct = p;
            break;
          }
        }
        if (matchingProduct != null &&
            matchingProduct.id == state.selectedProduct?.id) {
          debugPrint(
              'Detected same provider (${matchingProduct.productName}), skipping reset/refetch');
          return; // Nothing to do â€” keep existing subProducts/grid
        }

        // fallback: brand match by extracting brand
        if (matchingProduct == null) {
          for (final p in state.products) {
            if (!_isEntityActive(p)) continue;
            if (_extractBrand(p.productName ?? '') == _extractBrand(detected)) {
              matchingProduct = p;
              break;
            }
          }
        }

        if (matchingProduct == null) {
          // No provider auto-found â€” clear any auto selection, keep manual selection if present
          debugPrint(
              'No auto match for $detected, leaving UI for manual selection.');
          // state = state.copyWith(error: 'Could not auto-detect provider for this number.');
          return;
        }

        // Found a product â€” select + fetch subproducts (same flow as applyBeneficiary)
        final providerIcon = normalizeAssetName(matchingProduct.productName,
            serviceType: _serviceType);
        // selectProduct(matchingProduct, providerIcon ?? '');
        await selectProductAndLoadSubProducts(
          ctx,
          matchingProduct,
          providerIcon ?? '',
          force: true,
          invalidateCache: true,
        );

        // await fetchSubProducts(ctx, matchingProduct.id!, force: true);
        debugPrint(
            'Auto-selected product ${matchingProduct.productName} for phone $normalized');
      } catch (e, st) {
        debugPrint('Error in detectAndSelectFromPhone: $e');
        debugPrintStack(stackTrace: st);
        // don't throw â€” just keep UI stable
      }
    });
  }

  Future<void> applyBeneficiary(BuildContext ctx, Beneficiary b) async {
    // only for airtime & mobileData
    if (!(_serviceType == PlatformProductType.airtime ||
        _serviceType == PlatformProductType.mobileData)) {
      debugPrint('applyBeneficiary ignored for serviceType=$_serviceType');
      return;
    }

    debugPrint('applyBeneficiary: ${b.phoneNumber} (${b.network})');

    // 1) populate phone controller
    state.firstInputController.text = b.phoneNumber ?? '';

// persist beneficiary in state so UI knows it is applied
    setSelectedBeneficiary(b);

    // 2) detect/decide network (prefer backend value)
    final detectedNetwork = (b.network != null && b.network!.isNotEmpty)
        ? b.network!
        : _detectNetworkFromPhone(b.phoneNumber!);

    debugPrint('Detected network: $detectedNetwork');

    // 3) find matching product in loaded products
    Product? matchingProduct;
    for (final p in state.products) {
      final prodName = p.productName ?? '';
      if (_matches(prodName, detectedNetwork)) {
        matchingProduct = p;
        break;
      }
    }

    // fallback: brand exact match
    if (matchingProduct == null) {
      for (final p in state.products) {
        if (_extractBrand(p.productName ?? '') ==
            _extractBrand(detectedNetwork)) {
          matchingProduct = p;
          break;
        }
      }
    }

    if (matchingProduct == null) {
      debugPrint('No product matched for $detectedNetwork');
      ctx.showErrorSnackBar(
        'Provider not available for this beneficiary. Please select a biller manually.',
      );
      return;
    }

    // 4) select product + fetch subproducts (same flow as manual selection)
    final providerIcon = normalizeAssetName(
      matchingProduct.productName,
      serviceType: _serviceType,
    );
    // selectProduct(matchingProduct, providerIcon ?? '');
    await selectProductAndLoadSubProducts(
      ctx,
      matchingProduct,
      providerIcon ?? '',
      force: true,
      invalidateCache: true,
    );

    // await fetchSubProducts(ctx, matchingProduct.id!, force: true);
    debugPrint(
        'applyBeneficiary: selected product ${matchingProduct.productName} (${matchingProduct.id})');
  }

  /// Try to detect a common network name from phone prefix (Nigerian prefixes)
  String _detectNetworkFromPhone(String phone) {
    final clean = phone.replaceAll(RegExp(r'\s+'), '');
    if (clean.startsWith('+234')) {
      // convert to local 0-starting number
      final local = '0' + clean.substring(4);
      return _detectNetworkFromPhone(local);
    }
    final prefix = clean.length >= 4 ? clean.substring(0, 4) : clean;

    const mtnPrefixes = [
      '0803',
      '0806',
      '0703',
      '0706',
      '0813',
      '0816',
      '0810',
      '0814',
      '0903',
      '0906',
      '0913',
      '0916'
    ];
    const airtelPrefixes = [
      '0802',
      '0808',
      '0708',
      '0701',
      '0812',
      '0901',
      '0902',
      '0904',
      '0907',
      '0912'
    ];
    const gloPrefixes = [
      '0705',
      '0805',
      '0807',
      '0815',
      '0811',
      '0905',
      '0915',
    ];
    const nineMobilePrefixes = [
      '0809',
      '0817',
      '0818',
      '0909',
      '0908',
    ];

    if (mtnPrefixes.any((p) => clean.startsWith(p))) return 'MTN';
    if (airtelPrefixes.any((p) => clean.startsWith(p))) return 'Airtel';
    if (gloPrefixes.any((p) => clean.startsWith(p))) return 'Glo';
    if (nineMobilePrefixes.any((p) => clean.startsWith(p))) return '9mobile';

    // fallback: try to use last 3 digits or first 3
    if (clean.length >= 3) return clean.substring(0, 3);
    return clean;
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

  void showBillerPicker(BuildContext ctx) {
    ctx.showBottomSheet(
      child: ChoosebillerWidget(
        serviceType: _serviceType,
        onProviderSelected: (path, name, id) {
          if (_serviceType == PlatformProductType.betting) {
            // 'id' is a subproduct ID
            SubProduct? selectedSubProduct;
            for (final s in state.subProducts) {
              if (s.id == id) {
                selectedSubProduct = s;
                break;
              }
            }
            // final selectedSubProduct = state.subProducts.firstWhere(
            //   (s) => s.id == id,
            //   orElse: () => null,
            // );
            if (selectedSubProduct == null) {
              debugPrint('[BETTING] subproduct not found for id=$id');
              return;
            }

            debugPrint(
                "âœ… Found subProduct: ${selectedSubProduct.subName} (id: ${selectedSubProduct.id})");

            if (selectedSubProduct != null && state.selectedProduct != null) {
              selectSubProduct(selectedSubProduct);
              // fetchSubProducts(ctx, selectedSubProduct.id!);
            }
          } else {
            // 'id' is a product ID

            final product = state.products.firstWhere((p) => p.id == id);

            // 1. Select the product visually
            selectProduct(product, path!);

            // 2. Trigger fetchSubProducts based on product.id
            fetchSubProducts(ctx, product.id!);
          }
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
        if (_parseAmountString(state.amountController.text) <= 0) {
          return 'Please enter a valid amount';
        }
        if (_parseAmountString(state.amountController.text) <= 49) {
          return 'Minimum airtime amount is 50 naira';
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
        if (state.secondaryInputController.text == null) {
          return 'User ID is required';
        }
        if (_parseAmountString(state.amountController.text) <= 0) {
          return 'Please enter a valid amount';
        }
        if (!state.isValidated) {
          return 'Please validate your user ID';
        }
        break;

      case PlatformProductType.cableTv:
        if (state.secondaryInputController.text == null) {
          return 'Smart Card Number is required';
        }
        if (state.selectedSubProduct == null) {
          return 'Please select a cable TV package';
        }
        if (!state.isValidated) {
          return 'Please validate your smart card number';
        }
        break;

      case PlatformProductType.electricity:
        if (state.secondaryInputController.text == null) {
          return 'Meter Number is required';
        }
        // if (state.selectedSubProduct == null) {
        //   return 'Please select Prepaid or Postpaid';
        // }
        if (_parseAmountString(state.amountController.text) <= 0) {
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
        // if (state.secondaryInputController.text.isEmpty) {
        //   return 'Please enter a valid Transaction ID';
        // }
        if (state.selectedSubProduct == null) {
          return 'Please select an education package';
        }
        // if (!state.isValidated) {
        //   return 'Please validate your account number';
        // }
        break;

      case PlatformProductType.internetServices:
        if (state.secondaryInputController.text == null) {
          return 'Beneficiary number is required';
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

  bool _matches(String a, String b) {
    final cleanA = a.toLowerCase().replaceAll(RegExp(r'\s+'), '');
    final cleanB = b.toLowerCase().replaceAll(RegExp(r'\s+'), '');
    final brandA = _extractBrand(a).replaceAll(RegExp(r'\s+'), '');
    final brandB = _extractBrand(b).replaceAll(RegExp(r'\s+'), '');
    return cleanA.contains(cleanB) ||
        cleanB.contains(cleanA) ||
        brandA == brandB; // Add exact brand match
  }

  String _extractBrand(String name) {
    final lower = name.toLowerCase();
    // print('Extracting brand from: $name');
    if (lower.contains("mtn")) {
      print('Brand: mtn');
      return "mtn";
    }
    if (lower.contains("glo")) return "glo";
    if (lower.contains("airtel")) return "airtel";
    if (lower.contains("9mobile") || lower.contains("etisalat"))
      return "9mobile";
    // print('Brand: ${name.split(" ").first.toLowerCase()}');
    return name.split(" ").first.toLowerCase();
  }

  // Map sub-product or product names to asset paths from PlatFormData
  String? normalizeAssetName(String? raw, {PlatformProductType? serviceType}) {
    print('Raw input: $raw, ServiceType: $serviceType');
    if (raw == null || raw.isEmpty) {
      print(
          'Returning fallback due to null/empty raw: ${_getFallbackAsset(serviceType ?? _serviceType)}');
      return _getFallbackAsset(serviceType ?? _serviceType);
    }

    final lowerName = raw.toLowerCase();
    print('Lowercase raw: $lowerName');
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
        print(
            'Providers for airtime: ${providers.map((p) => (p as AppListTile).title).toList()}');
        // break;
        break;
      case PlatformProductType.mobileData:
        providers = PlatFormData.serviceProviderWidget;
        print(
            'Providers for data purchase: ${providers.map((p) => (p as AppListTile).title).toList()}');

        break;
      case PlatformProductType.ePinVoucher:
      case PlatformProductType.bulkEPin:
        // Use a generic e-pin asset or specific providers if available
        providers = PlatFormData.serviceProviderWidget;
        break;
      // return Assets.svgs.ePin; // Adjust if you have specific e-pin providers
      default:
        print(
            'Returning fallback for unknown service type: ${_getFallbackAsset(serviceType ?? _serviceType)}');
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
        final match = _matches(raw, title);
        print('Comparing raw: $rawKey with title: $titleKey -> Match: $match');
        return match;
      },
      orElse: () {
        print(
            'No match found, using fallback: ${_getFallbackAsset(serviceType ?? _serviceType)}');
        return AppListTile(
          title: state.selectedProduct?.productName ?? '',
          // color: getFallbackColor ,
          imagePath: _getFallbackAsset(serviceType ?? _serviceType),
          assetPath: _getFallbackAsset(serviceType ?? _serviceType),
        );
      },
    );
    final result = (matchingProvider as AppListTile).assetPath ??
        matchingProvider.imagePath ??
        _getFallbackAsset(serviceType ?? _serviceType);

    print('normalizeAssetName: Final asset path: $result');
    return result;

    // final result = (matchingProvider as AppListTile).assetPath ??
    //     _getFallbackAsset(serviceType ?? _serviceType);
    // print('normalizeAssetName: Final asset path: $result');
    // return result;
    // return (matchingProvider as AppListTile).imagePath ??
    //     _getFallbackAsset(serviceType ?? _serviceType);
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

  // Parse amounts tolerant of commas and spaces
  double _parseAmountString(String? raw) {
    if (raw == null || raw.trim().isEmpty) return 0.0;
    final cleaned = raw.replaceAll(RegExp(r'[,\s]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  // Robust active-check using dynamic access with fallbacks
  bool _isEntityActive(dynamic entity) {
    try {
      if (entity == null) return true;
      // Try boolean fields first
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
        state.secondaryInputController.text.trim() != null;
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
        'Please enter a valid ${_serviceType == PlatformProductType.airtime || _serviceType == PlatformProductType.mobileData ? 'phone number' : _serviceType == PlatformProductType.betting ? 'user ID' : _serviceType == PlatformProductType.cableTv ? 'smart card number' : _serviceType == PlatformProductType.electricity ? 'meter number' : 'number'}',
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
            final userMsg = userFacingMessageFromFailure(failure);
            context.showErrorSnackBar(userMsg);
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
              context.showSuccessSnackBar('Validated: ${response.data}');
              debugPrint('Validation successful, calling onSuccess callback');
              onSuccess
                  ?.call(); // Call onSuccess to proceed to transaction summary
            } else {
              debugPrint('Validation failed: message=${response.message}');
              final userMsg = sanitizeErrorMessage(response.message);
              context.showErrorSnackBar(userMsg);
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
        final msg = kDebugMode
            ? sanitizeErrorMessage(e)
            : 'Something went wrong while submitting. Please try again.';
        context.showErrorSnackBar(msg);
      }
    });
  }

  bool _subProductMatchesProduct() {
    final p = state.selectedProduct;
    final s = state.selectedSubProduct;
    if (p == null || s == null) return true;

    return _extractBrand(s.subName ?? '') == _extractBrand(p.productName ?? '');
  }

  double getTransactionAmount() {
    if (_serviceType == PlatformProductType.airtime ||
        _serviceType == PlatformProductType.betting ||
        _serviceType == PlatformProductType.electricity) {
      return _parseAmountString(state.amountController.text);
    }
    if (_serviceType.hasSubProducts && state.selectedSubProduct != null) {
      return _parseAmountString(state.selectedSubProduct!.subPrice ?? '');
    }
    return _parseAmountString(state.amountController.text);
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
    final amount = getTransactionAmount();
    if (amount <= 0) {
      context
          .showErrorSnackBar('Please enter a valid amount greater than zero');
      return;
    }
    if (amount > walletBalance) {
      context.showErrorSnackBar(
          'Insufficient wallet balance ${walletBalance.toCurrency()} available');
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
        billValidatedName: state.validatedName,
        // transactionType: state.selectedSubProduct?.subName ??
        //     state.selectedProduct?.productName,
        transactionType: _serviceType == PlatformProductType.airtime ||
                _serviceType == PlatformProductType.mobileData
            ? state.selectedProduct?.productName
            : state.selectedSubProduct?.subName ??
                state.selectedProduct?.productName,
        amount: amount.toCurrency(),
        discountedPrice: discountedAmount.toCurrency(),
        beneficiary: beneficiary,
        onPay: () {
          // if (!_subProductMatchesProduct()) {
          //   context.showErrorSnackBar(
          //     'Selected data plan does not match provider. Please reselect.',
          //   );
          //   return;
          // }

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
    final biometricService = _ref.read(biometricServiceProvider);

    // Check if biometric for transactions is enabled
    final isBiometricEnabled =
        await biometricService.isBiometricTransactionEnabled;

    if (isBiometricEnabled) {
      final didAuth = await biometricService.authenticate(
        type: BiometricAuthType.transaction,
      );

      if (didAuth) {
        // Get the stored PIN
        final email =
            await _ref.read(secureStorageHelperProvider).getRememberedEmail();
        if (email == null) {
          debugPrint("No stored account found, please login again");
          // context.go(RouteConstants.login);
          return;
        }

        final storedPin =
            await _ref.read(secureStorageHelperProvider).getPin(email);
        if (storedPin == null) {
          debugPrint("No stored PIN found, please set up your PIN");
          return;
        }

        // Call purchase directly with stored PIN
        await purchase(
          context,
          pin: storedPin,
          originalAmount: originalAmount,
          discountedAmount: discountedAmount,
          beneficiary: beneficiary,
          validatedName: state.validatedName,
        );
        return;
      } else {
        debugPrint("Biometric authentication failed");
        // fallback â†’ open PIN screen
      }
    }
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
                validatedName: state.validatedName,
              );
            },
          ),
        ),
      ),
    );
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
                context
                  ..pop()
                  ..push(RouteConstants.becomeagent);
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
                // fontSize: 18,
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

  Future<dynamic> purchase(
    BuildContext context, {
    required String originalAmount,
    required String pin,
    required String discountedAmount,
    required String beneficiary,
    String? validatedName,
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
      final packageInfo = await PackageInfo.fromPlatform();
      final appVersion = packageInfo.version;

      unawaited(context.showLoadingDialog(message: "Initiating payment..."));
      final request = InitiateTransactionRequest(
        amount: _serviceType == PlatformProductType.mobileData
            ? originalAmount
            : originalAmount,
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
        name: _serviceType != PlatformProductType.airtime ||
                _serviceType != PlatformProductType.mobileData
            ? validatedName
            : null,
        appVersion: appVersion,
      );

      final result = _serviceType == PlatformProductType.mobileData ||
              _serviceType == PlatformProductType.airtime
          ? await _apiService.initiateDataAirtimeTransaction(token, request)
          : await _apiService.initiateBillTransaction(token, request);

      return result.fold(
        (failure) {
          context.dismissDialog();
          // final sanitizedParts = failure.properties
          //     .map((p) => sanitizeErrorMessage(p))
          //     .where((s) => s.isNotEmpty)
          //     .toList();

          // final sanitizedJoined = sanitizedParts.join('\n');

          // // Decide what to show on the failed result screen:
          // // final lower = sanitizedJoined.toLowerCase();
          // // final shouldShowSpecific =
          // //     lower.contains('insufficient') || lower.contains('incorrect pin');

          // // If specific sensitive/meaningful text exists, use it; otherwise, fallback.
          // final displayMessage =
          //     // shouldShowSpecific &&
          //     sanitizedJoined.isNotEmpty
          //         ? sanitizedJoined
          //         : 'Transaction failed. Please try again later.';

          // // For snackbars use the centralized mapper (respects kDebugMode)
          // final userMsg = userFacingMessageFromFailure(failure);
          // debugPrint(userMsg.toString());

          // // Debug print sanitized content only
          // debugPrint(sanitizedJoined.isNotEmpty
          //     ? sanitizedJoined
          //     : 'Transaction failed');
          final userMsg = userFacingMessageFromFailure(failure);
          final displayMessage = sanitizeErrorMessage(userMsg);
          debugPrint('Display message: $displayMessage');
          // context.showErrorSnackBar(displayMessage);
          if (kDebugMode) {
            debugPrint('Transaction failed: $userMsg');
            debugPrint('Display message: $displayMessage');
          }
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
            final isMobileData = _serviceType == PlatformProductType.mobileData;
            final dataValue = state.selectedSubProduct?.subName ??
                state.selectedDataType ??
                ''; // your plan name (e.g. "GloCG 200MB")
            final displayTarget = isMobileData && dataValue.isNotEmpty
                ? dataValue
                : originalAmount.toCurrency();

            final successBody = isMobileData
                ? '${_serviceType.title} subscription of $displayTarget for $beneficiary was successful.'
                : '${_serviceType.title} subscription of $displayTarget for $beneficiary was successful.';

            // final successBody =
            //     '${_serviceType.title} purchase of ${originalAmount.toCurrency()} for $beneficiary was successful.';
            final notifPayload = jsonEncode({
              'route': '/transactions/detail', //  to transaction/detail route
              'type': 'transaction_success',
              'service': _serviceType.title,
              'amount': originalAmount,
              'beneficiary': beneficiary,
              // optionally include an id from 'response' if available:
              // 'transactionId': response.data ?? '',
            });
            final notifId = DateTime.now().millisecondsSinceEpoch % 100000;
            unawaited(NotificationService().showNotification(
              id: notifId,
              title: 'Payment Successful',
              body: successBody,
              payload: notifPayload,
            ));

            InAppBanner.show(
              context,
              title:
                  '${_serviceType.title.capiTalizeFirstLast} Purchase Successful',
              body: successBody,
            );
            final Map<String, dynamic>? respData =
                response.data is Map<String, dynamic>
                    ? response.data as Map<String, dynamic>
                    : (response.data != null
                        ? Map<String, dynamic>.from(
                            response.data as Map<dynamic, dynamic>)
                        : null);

// build receipt using helper
            final receipt = extractReceiptFromPurchaseResponse(
              respData,
              serviceType: _serviceType,
              selectedSubProduct: state.selectedSubProduct,
              selectedProduct: state.selectedProduct,
              originalAmount: originalAmount,
              beneficiary: beneficiary,
            );

            final screen = _buildSuccessScreen(
              originalAmount.toCurrency(),
              beneficiary,
              receipt,
            );
            context.dismissDialog();
            _ref.read(dashboardProvider.notifier).initialize();
            _ref
                .read(globalProvider.notifier)
                .initializeWalletandAccounts(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (ctx) => screen),
            );
          } else {
            context.dismissDialog();
            final userMsg = sanitizeErrorMessage(response.message);
            // context.showErrorSnackBar(userMsg);

            // : 'Please try again later.';
            final notifId = DateTime.now().millisecondsSinceEpoch % 100000;
            final notifPayload = jsonEncode({
              'route': RouteConstants.dashboard,
              'type': 'transaction_failed',
              'service': _serviceType.title,
              'message': userMsg,
            });

            unawaited(NotificationService().showNotification(
              id: notifId,
              title: 'Payment Failed',
              body: userMsg,
              payload: notifPayload,
            ));
            debugPrint("[This is the error message diaplayed] $userMsg");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (ctx) => FailedResultScreen(
                  serviceContent: _serviceType.title.toLowerCase(),
                  errorMessage: userMsg,
                  onRetry: () {
                    context.pushReplacement(RouteConstants.dashboard);
                  },
                ),
              ),
            );
          }
        },
      );
    } catch (e, st) {
      state = state.copyWith(isLoading: false, error: e.toString());
      debugPrint("Error occuring during transaction is $e and stacktrace $st");
      context.dismissDialog();
      final msg = kDebugMode
          ? sanitizeErrorMessage(e)
          : 'Something went wrong while submitting. Please try again.';
      debugPrint(msg.toString());
      unawaited(
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
        ),
      );
    }
  }

  Widget _buildSuccessScreen(
    String amount,
    String beneficiary,
    TransactionReceiptData receipt,
  ) {
    switch (_serviceType) {
      case PlatformProductType.mobileData:
        return DataSubscriptionSuccessResultScreen(
          dataValue: state.selectedSubProduct?.subName ?? '',
          beneficiary: beneficiary,
          receipt: receipt,
        );
      case PlatformProductType.airtime:
        return AirtimeSuccessResultScreen(
          amount: amount,
          beneficiary: beneficiary,
          receipt: receipt,
        );
      case PlatformProductType.ePinVoucher:
        return EpinSuccessResultScreen(amount: amount);
      case PlatformProductType.bulkEPin:
        return BulkPinSuccessResultScreen();
      case PlatformProductType.betting:
        return BettingSuccessResultScreen(
          amount: amount,
          biller: state.selectedProduct?.productName ?? '',
          receipt: receipt,
        );
      case PlatformProductType.cableTv:
        return CableTvSuccessResultScreen(amount: amount, receipt: receipt);
      case PlatformProductType.education:
        return EducationProviderSuccessResultScreen(
          amount: amount,
          biller: state.selectedProduct?.productName ?? '',
        );
      case PlatformProductType.electricity:
        return ElectricitySuccessResultScreen(
          amount: amount,
          biller: state.selectedProduct?.productName ?? '',
          receipt: receipt,
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

