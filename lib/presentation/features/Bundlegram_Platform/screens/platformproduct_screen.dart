import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/currency_extension.dart';
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

class _PlatformproductScreenState extends ConsumerState<PlatformproductScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(platformProductProvider(widget.serviceType).notifier)
          .fetchProducts(context);
      //prefetch minimal beneficiaries and full beneficiaries
      Future.microtask(() {
        // minimal beneficiary list
        ref.read(minimalBeneficiariesProvider.future).catchError((e, st) {
          // optional logging,
          debugPrint('minimalBeneficiaries prefetch error: $e');
        });

        // full beneficiary list
        ref.read(beneficiariesProvider.future).catchError((e, st) {
          debugPrint('beneficiaries (all) prefetch error: $e');
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final serviceType = widget.serviceType;
    final state = ref.watch(platformProductProvider(serviceType));
    final notifier = ref.read(platformProductProvider(serviceType).notifier);
    final walletBalanceAsync =
        ref.watch(globalProvider.select((s) => s.walletBalance));
    final walletBalance = walletBalanceAsync.value?.wallet ?? 0.0;
    final isPhoneBased = serviceType == PlatformProductType.airtime ||
        serviceType == PlatformProductType.mobileData;

    final canContinue = !isPhoneBased ||
        (state.isPhoneInputValid && state.selectedProduct != null);
    return WillPopScope(
      onWillPop: () async {
        context.pushReplacement(RouteConstants.dashboard);
        return false;
      },
      child: BundlegramScaffold(
        appBar: BundlegramAppbar(
          titleText: serviceType.title,
          trailing: GestureDetector(
            onTap: () {
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
          onRefresh: () => notifier.fetchProducts(context),
          child: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
                            padding: EdgeInsets.only(left: 16.w),
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
                          state.selectedDataType != null)
                        ProductItemGrid(
                          serviceType: serviceType,
                          products: state.subProducts
                              .where(
                                  (e) => e.dataType == state.selectedDataType)
                              .toList(),
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
                            horizontal: 8.w, vertical: 12.h),
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
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BulkEpinScreen()),
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
                            onPressed: () {
                              final isAgent = ref
                                      .read(globalProvider)
                                      .profile
                                      .value
                                      ?.data
                                      ?.userType ==
                                  "agent";
                              if (isAgent) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BulkEpinScreen()),
                                );
                              } else {
                                notifier.showBulkEPinPrompt(context);
                              }
                            },
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
