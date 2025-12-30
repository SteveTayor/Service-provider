import 'dart:async';

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/responsive_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_formatter.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_input_formatter.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/data/models/products/get_all_products_response.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/gen/fonts.gen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_product_provider.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/products_provider.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformphonenumberform_widget.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformproductitem_widget.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/productuserprice_widget.dart';
import 'package:bundlegram/presentation/features/dashboard/provider/dashboard_provider.dart';
import 'package:bundlegram/presentation/features/transaction/screens/bulk%20e-pin/bulkE-pin_screen.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/serviceProviders_history_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PlatformproductScreen extends ConsumerStatefulWidget {
  static const String routeName = '/platformProduct';
  const PlatformproductScreen({
    Key? key,
    required this.serviceType,
  }) : super(key: key);

  final PlatformProductType serviceType;

  @override
  ConsumerState<PlatformproductScreen> createState() =>
      _PlatformproductScreenState();
}

class _PlatformproductScreenState extends ConsumerState<PlatformproductScreen>
    with RestorationMixin {
  @override
  String? get restorationId => 'platform_product_${widget.serviceType.name}';

  // Restorable controllers
  final RestorableTextEditingController _restorableFirstInput =
      RestorableTextEditingController();
  final RestorableTextEditingController _restorableSecondaryInput =
      RestorableTextEditingController();
  final RestorableTextEditingController _restorableAmount =
      RestorableTextEditingController();

  // Sync guards
  bool _syncingFromProviderToRestorable = false;
  bool _syncingFromRestorableToProvider = false;
  bool _hasInitializedSync = false;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_restorableFirstInput, 'first_input');
    registerForRestoration(_restorableSecondaryInput, 'secondary_input');
    registerForRestoration(_restorableAmount, 'amount');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final notifier =
          ref.read(platformProductProvider(widget.serviceType).notifier);

      // Fetch products (existing behavior)
      await notifier.fetchProducts(context);

      // Force-refresh sub-products for first few loaded products so we don't show stale plans.
      // This will update cache & state if backend changed availability.
      await notifier.refreshSubProductsForLoadedProducts(
        context,
        force: true,
        maxChecks: 3,
      );

      //prefetch minimal beneficiaries and full beneficiaries
      unawaited(Future.microtask(() {
        ref.read(minimalBeneficiariesProvider.future).catchError((e, st) {
          debugPrint('minimalBeneficiaries prefetch error: $e');
        });

        ref.read(beneficiariesProvider.future).catchError((e, st) {
          debugPrint('beneficiaries (all) prefetch error: $e');
        });
      }));
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Initialize sync only once, after restoration has completed
    if (!_hasInitializedSync) {
      _hasInitializedSync = true;
      _initializeSync();
    }
  }

  void _initializeSync() {
    final state = ref.read(platformProductProvider(widget.serviceType));

    // Wire up text controllers
    _wireTextSync(state.firstInputController, _restorableFirstInput);
    _wireTextSync(state.secondaryInputController, _restorableSecondaryInput);
    _wireTextSync(state.amountController, _restorableAmount);

    // Seed restorable controllers if empty
    _seedRestorableIfEmpty(
        state.firstInputController.text, _restorableFirstInput);
    _seedRestorableIfEmpty(
        state.secondaryInputController.text, _restorableSecondaryInput);
    _seedRestorableIfEmpty(state.amountController.text, _restorableAmount);
  }

  void _wireTextSync(
    TextEditingController providerCtrl,
    RestorableTextEditingController restorable,
  ) {
    // When framework restores restorable, copy to provider
    restorable.value.addListener(() {
      if (_syncingFromProviderToRestorable) return;
      final restored = restorable.value.text;
      final providerText = providerCtrl.text;
      if (providerText != restored) {
        _syncingFromRestorableToProvider = true;
        providerCtrl.text = restored;
        _syncingFromRestorableToProvider = false;
      }
    });

    // When provider updates (user typing), copy to restorable
    providerCtrl.addListener(() {
      if (_syncingFromRestorableToProvider) return;
      final providerText = providerCtrl.text;
      final restorableText = restorable.value.text;
      if (restorableText != providerText) {
        _syncingFromProviderToRestorable = true;
        restorable.value.text = providerText;
        _syncingFromProviderToRestorable = false;
      }
    });
  }

  void _seedRestorableIfEmpty(
    String providerValue,
    RestorableTextEditingController restorable,
  ) {
    try {
      if (restorable.value.text.isEmpty && providerValue.isNotEmpty) {
        restorable.value.text = providerValue;
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    _restorableFirstInput.dispose();
    _restorableSecondaryInput.dispose();
    _restorableAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final serviceType = widget.serviceType;
    final state = ref.watch(platformProductProvider(serviceType));
    final notifier = ref.read(platformProductProvider(serviceType).notifier);
    final walletBalanceAsync =
        ref.watch(globalProvider.select((s) => s.walletBalance));
    final walletBalance = walletBalanceAsync.value?.wallet ?? 0.0;
    final isPhoneBased = serviceType == PlatformProductType.airtime ||
        serviceType == PlatformProductType.mobileData;
    // Require explicit subproduct selection for ePin/bulkEPin
    final bool requiresNetworkSelectedForEpin =
        serviceType == PlatformProductType.ePinVoucher ||
            serviceType == PlatformProductType.bulkEPin;

    final canContinue = requiresNetworkSelectedForEpin
        ? (state.selectedSubProduct != null &&
            (state.selectedSubProduct?.subName?.trim().isNotEmpty ?? false))
        : (!isPhoneBased ||
            (state.isPhoneInputValid && state.selectedProduct != null));

    return WillPopScope(
      onWillPop: () async {
        context.pushReplacement(RouteConstants.dashboard);
        return false;
      },
      child: BundlegramScaffold(
        useResponsive: true,
        resizeToAvoidBottomInset: true,
        appBar: BundlegramAppbar(
          titleText: serviceType.title,
          trailing: GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ServiceHistoryScreen(serviceType: serviceType),
                ),
              );
            },
            child: Text(
              'History',
              style: context.textTheme.labelSmall!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await notifier.fetchProducts(context);
            await notifier.refreshSubProductsForLoadedProducts(
              context,
              force: true,
            );
          },
          child: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: r.spacing(16), vertical: r.spacing(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PlatformPhoneNumberFormWidget(
                        serviceType: serviceType,
                        inputHint: serviceType == PlatformProductType.betting
                            ? 'Select Betting Provider'
                            : null,
                        secondaryInputHint:
                            serviceType == PlatformProductType.betting
                                ? 'Enter user ID'
                                : null,
                      ),
                      // Read-only amount field for cable TV
                      if (serviceType == PlatformProductType.cableTv &&
                          state.selectedSubProduct != null) ...[
                        24.verticalSpace,
                        AppTextField(
                          hintText: 'Amount',
                          controller: state.amountController,
                          inputFormatters: [CurrencyTextInputFormatter()],
                          keyboardType: TextInputType.number,
                          validateFunction: (val) {
                            final enteredAmount =
                                double.tryParse(val?.replaceAll(',', '') ?? '');
                            final wallet = double.tryParse(
                                walletBalance.toCurrency()); // Already a double

                            if (enteredAmount == null || enteredAmount <= 0) {
                              return 'Enter a valid amount';
                            }

                            if (enteredAmount > wallet!) {
                              context.showErrorSnackBar(
                                'Insufficient wallet balance ${walletBalance.toCurrency()} available',
                              );
                              return '';
                            }

                            return null;
                          },
                          readOnly: true,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(
                              left: r.spacing(16),
                            ),
                            child:
                                Text('₦', style: context.textTheme.bodyMedium),
                          ),
                        ),
                      ],
                      if (serviceType == PlatformProductType.betting ||
                          serviceType == PlatformProductType.airtime)
                        ProductItemGrid(
                          serviceType: serviceType,
                          amounts: const [200, 500, 1000, 2000, 5000, 10000],
                        ),
                      if (serviceType == PlatformProductType.electricity)
                        ProductItemGrid(
                          serviceType: serviceType,
                          amounts: const [
                            1000,
                            2000,
                            3000,
                            4000,
                            5000,
                            10000,
                          ],
                        ),
                      if (serviceType == PlatformProductType.mobileData &&
                          state.selectedProduct != null &&
                          state.subProducts.isNotEmpty)
                        ProductItemGrid(
                          serviceType: serviceType,
                          products: state.selectedDataType != null
                              ? state.subProducts
                                  .where((e) =>
                                      e.dataType == state.selectedDataType)
                                  .toList()
                              : state
                                  .subProducts, // show all subProducts when dataType not selected yet
                        ),
                      if (serviceType == PlatformProductType.ePinVoucher ||
                          serviceType == PlatformProductType.bulkEPin)
                        ProductuserpriceWidget(serviceType: serviceType),

                      if (serviceType == PlatformProductType.education) ...[
                        24.verticalSpace,
                        AppTextField(
                          hintText: 'Enter amount',
                          controller: state.amountController,
                          keyboardType: TextInputType.number,
                          readOnly:
                              true, // Price is set from dropdown selection
                          inputFormatters: [CurrencyTextInputFormatter()],

                          prefixIcon: Padding(
                            padding: context.symmetricPadding(24, 0),
                            child:
                                Text('₦', style: context.textTheme.bodyMedium),
                          ),
                          onChange: (_) {
                            notifier
                                .clearSelectedPresetAmount(); // Optional: deselect preset if user types
                          },
                        ),
                      ],
                      24.verticalSpace,
                      Row(
                        children: [
                          AppSvgIcon(path: Assets.svgs.balance),
                          3.horizontalSpace,
                          Text(
                            'Balance (${walletBalance.toCurrency()})',
                            style: context.textTheme.labelMedium,
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              ref
                                  .read(dashboardProvider.notifier)
                                  .onDestinationSelected(1, context);
                              context.pop();
                            },
                            child: Text(
                              'Top-up >',
                              style: context.textTheme.labelMedium!
                                  .copyWith(color: AppColors.primaryColor),
                            ),
                          ),
                        ],
                      ).withContainer(
                        color: const Color(0xffEEF3FF),
                        padding: EdgeInsets.symmetric(
                            horizontal: r.spacing(8), vertical: r.spacing(12)),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      40.verticalSpace,
                      BundlegramButton(
                        text: 'Continue',
                        isLoading: state.isValidating,
                        onPressed: canContinue
                            ? () {
                                if (serviceType ==
                                    PlatformProductType.ePinVoucher) {
                                  final isAgent = ref
                                          .read(globalProvider)
                                          .profile
                                          .value
                                          ?.data
                                          ?.userType ==
                                      "agent";
                                  if (isAgent) {
                                    // Prefer subName, otherwise productName (but we should prefer subName)
                                    final preselectedNetwork = state
                                            .selectedSubProduct?.subName
                                            ?.trim() ??
                                        state.selectedProduct?.productName
                                            ?.trim();

                                    debugPrint(
                                        '[ePin] preselectedNetwork before navigation: $preselectedNetwork');

                                    if (preselectedNetwork == null ||
                                        preselectedNetwork.isEmpty) {
                                      // Defensive: this should not happen with the updated canContinue,
                                      // but keep user-friendly safeguard.
                                      context.showErrorSnackBar(
                                          'Please select a network/biller first.');
                                      return;
                                    }

                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => BulkEpinScreen(
                                            initialNetwork: preselectedNetwork),
                                      ),
                                    );
                                  } else {
                                    notifier.showBulkEPinPrompt(context);
                                  }
                                } else if (notifier.requiresValidation) {
                                  final input = serviceType ==
                                              PlatformProductType.betting ||
                                          serviceType ==
                                              PlatformProductType.cableTv ||
                                          serviceType ==
                                              PlatformProductType.electricity
                                      ? state.secondaryInputController.text
                                          .trim()
                                      : state.firstInputController.text.trim();

                                  // if (input.isEmpty) {
                                  //   return context.showErrorSnackBar(
                                  //     'Please enter a valid ${serviceType == PlatformProductType.betting ? 'User ID' : serviceType == PlatformProductType.cableTv ? 'Smart Card Number' : 'Meter Number'}',
                                  //   );
                                  // }

                                  // Additional validation for electricity
                                  // if (serviceType ==
                                  //     PlatformProductType.electricity) {
                                  //   if (state.selectedSubProduct == null) {
                                  //     return context.showErrorSnackBar(
                                  //         'Please select Prepaid or Postpaid');
                                  //   }
                                  //   final amount = state.amountController.text.trim();
                                  //   if (amount.isEmpty ||
                                  //       double.tryParse(amount) == null ||
                                  //       double.parse(amount) <= 0) {
                                  //     return context.showErrorSnackBar(
                                  //         'Please enter a valid amount');
                                  //   }
                                  // }
                                  notifier
                                    ..validateForm()
                                    ..validateBill(
                                      context,
                                      input,
                                      state.selectedProduct?.id ??
                                          state.selectedSubProduct?.id,
                                      state.selectedSubProduct?.autoSubProdId ??
                                          state.selectedProduct?.autoProdId,
                                      onSuccess: () async {
                                        // Check wallet balance before showing transaction summary
                                        final walletBalanceStr = ref
                                            .read(globalProvider)
                                            .walletBalance
                                            .value
                                            ?.wallet;
                                        final walletBalance = double.tryParse(
                                                walletBalanceStr ?? '') ??
                                            0.0;
                                        final amount =
                                            notifier.getTransactionAmount();
                                        if (amount > walletBalance) {
                                          context.showErrorSnackBar(
                                            'Insufficient balance. You have ${walletBalance.toCurrency()}',
                                          );
                                          return;
                                        }

                                        notifier
                                            .showTransactionSummary(context);
                                      },
                                    );
                                } else {
                                  notifier.showTransactionSummary(context);
                                }
                              }
                            : null,
                      ),
                      if (serviceType == PlatformProductType.ePinVoucher)
                        Padding(
                          padding: EdgeInsets.only(top: 24.h),
                          child: BundlegramButton(
                            text: 'Print bulk e-pin voucher',
                            isOutline: true,
                            textStyle: context.textTheme.bodyMedium!.copyWith(
                              color: AppColors.grey19,
                              fontFamily: FontFamily.mabryPro,
                              // fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            onPressed: canContinue
                                ? () {
                                    final isAgent = ref
                                            .read(globalProvider)
                                            .profile
                                            .value
                                            ?.data
                                            ?.userType ==
                                        "agent";
                                    if (isAgent) {
                                      final preselectedNetwork = state
                                              .selectedSubProduct?.subName ??
                                          state.selectedProduct?.productName;
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => BulkEpinScreen(
                                                initialNetwork:
                                                    preselectedNetwork)),
                                      );
                                    } else {
                                      notifier.showBulkEPinPrompt(context);
                                    }
                                  }
                                : null,
                            color: AppColors.white,
                          ),
                        ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
