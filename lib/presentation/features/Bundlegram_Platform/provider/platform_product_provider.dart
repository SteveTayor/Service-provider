import 'dart:async';

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
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

    state = state.copyWith(
      isLoading: false,
      subProducts: subs,
      dropdownOptions: options,
      selectedDataType: options.isNotEmpty ? options.first : null,
      error: result.status != 'success' ? result.message : null,
    );
    if (result.status != 'success') {
      context.showErrorSnackBar(result.message ?? 'Failed to load subproducts');
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
      amountController: TextEditingController(text: subProduct.subPrice),
    );
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
    return [
      PlatformProductType.betting,
      PlatformProductType.electricity,
      PlatformProductType.cableTv,
    ].contains(_serviceType);
  }

  bool validateForm() {
    return state.selectedProduct != null &&
        (_serviceType.hasSubProducts
            ? state.selectedSubProduct != null
            : state.amountController.text.isNotEmpty) &&
        state.firstInputController.text.isNotEmpty &&
        (!requiresValidation || (requiresValidation && state.isValidated));
  }

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
        return Assets.svgs.airtime;
      case PlatformProductType.mobileData:
        return Assets.svgs.mobileData; // Generic for airtime/data
      case PlatformProductType.ePinVoucher:
      case PlatformProductType.bulkEPin:
        return Assets.svgs.ePin;
      default:
        return Assets.images.logo.path; // Generic fallback
    }
  }

  // void onUserIdChanged(BuildContext context, String value) {
  //   state = state.copyWith(isValidated: true);

  //   _debounce?.cancel();
  //   _debounce = Timer(const Duration(milliseconds: 600), () async {
  //     if (value.trim().isEmpty) {
  //       state = state.copyWith(isValidated: false);
  //       return;
  //     }

  //     final productId =
  //         state.selectedSubProduct?.id ?? state.selectedProduct?.id;
  //     final autoSubProdId = state.selectedSubProduct?.autoSubProdId;

  //     final isValid = await validateBill(
  //       context,
  //       value,
  //       productId,
  //       autoSubProdId,
  //     );

  //     state = state.copyWith(
  //       isValidated: false,
  //     );
  //   });
  // }

  void validateBill(BuildContext context, String userIdOrNumber,
      int? prodEntityId, String? autoSubProdId) {
    // Cancel any previous debounce timer
    _debounce?.cancel();

    // Set loading state immediately
    state = state.copyWith(
      isValidating: true,
      billValidated: false,
      error: null,
    );

    // Start a new debounce timer (e.g., 700ms delay)
    _debounce = Timer(const Duration(milliseconds: 700), () async {
      // If validation not required or missing input, cancel
      if (userIdOrNumber.length != 10 && !requiresValidation ||
          state.selectedProduct == null) {
        state = state.copyWith(isValidating: false);
        return;
      }

      try {
        final token = await _ref.read(authTokenProvider.future);
        final request = ValidateBillRequest(
          number: userIdOrNumber,
          productEntityId: prodEntityId,
          serviceType: autoSubProdId,
        );

        final result = await _apiService.validateBill(token, request);
        result.fold(
          (failure) {
            state = state.copyWith(
              isValidating: false,
              billValidated: false,
              error: failure.properties.join('\n'),
            );
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

            if (validated) {
              context.showCustomSnackBar('Validated: ${response.data}');
            }
          },
        );
      } catch (e) {
        state = state.copyWith(
          isValidating: false,
          billValidated: false,
          error: e.toString(),
        );
        context.showErrorSnackBar(e.toString());
      }
    });
  }

  void showTransactionSummary(BuildContext context) {
    if (!validateForm()) {
      context.showCustomSnackBar('Please fill all required fields');
      return;
    }

    final amount = _serviceType.hasSubProducts
        ? state.selectedSubProduct!.subPrice
        : state.amountController.text;
    final beneficiary = (_serviceType == PlatformProductType.mobileData ||
            _serviceType == PlatformProductType.airtime)
        ? state.firstInputController.text
        : state.secondaryInputController.text;

    context.showBottomSheet(
      showIcon: true,
      child: TransactionSummary(
        assetPath: state.selectedProviderIcon,
        transactionType: state.selectedProduct!.productName,
        amount: '₦$amount',
        beneficiary: beneficiary,
        // customerName: state.validatedName,
        onPay: () => initiatePurchase(context, amount.toString(), beneficiary),
        paymentMethod: '',
      ),
    );
  }

  Future<void> initiatePurchase(
      BuildContext context, String amount, String beneficiary) async {
    context.pop(); // Close the bottom sheet
    unawaited(Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => EnterPinScreen(
          onVerified: (pin) async {
            final result = await purchase(context,
                pin: pin, amount: amount, beneficiary: beneficiary);
            // unawaited(Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //     builder: (context) => result.fold(
            //       (failure) => FailedResultScreen(
            //         title: _serviceType.title.toLowerCase(),
            //         serviceContent: failure.properties.join('\n').toString(),
            //       ),
            //       (response) => _buildSuccessScreen(amount, beneficiary),
            //     ),
            //   ),
            // ));
          },
        ),
      ),
    ));
  }

  Future<dynamic> purchase(
    BuildContext context, {
    required String pin,
    required String amount,
    required String beneficiary,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final token = await _ref.read(authTokenProvider.future);
      // Fetch device info and location
      final deviceInfo = await DeviceInfoPlugin().deviceInfo;
      final macAddress = deviceInfo is AndroidDeviceInfo
          ? deviceInfo.id
          : 'unknown'; // Adjust as needed
      final ipAddress = '192.168.23.1'; // Replace with actual IP retrieval
      final position = await Geolocator.getCurrentPosition();
      final latitude = position.latitude.toString();
      final longitude = position.longitude.toString();

      final request = InitiateTransactionRequest(
        amount: amount,
        macAddress: macAddress,
        ipAddress: ipAddress,
        latitude: latitude,
        longitude: longitude,
        crAcc:
            _serviceType == PlatformProductType.ePinVoucher ? '' : beneficiary,
        platform: 'APP',
        subProdId: state.selectedSubProduct?.id ?? 0,
        serviceId: state.selectedProduct?.serviceId ?? '',
        pin: pin,
      );

      final result = _serviceType == PlatformProductType.mobileData ||
              _serviceType == PlatformProductType.airtime
          ? await _apiService.initiateDataAirtimeTransaction(token, request)
          : await _apiService.initiateBillTransaction(token, request);

      state = state.copyWith(isLoading: false);
      return result;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      context.showErrorSnackBar(e.toString());
      // context.showCustomSnackBar((
      //   SnackBar(content: Text(e.toString())),
      // );
      return null; // Or handle as per your ApiService's failure case
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
                fontSize: 18.sp,
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
