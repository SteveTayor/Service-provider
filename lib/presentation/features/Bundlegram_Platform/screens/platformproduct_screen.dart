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
                                'Insufficient wallet balance: ${walletBalance.toCurrency()} available',
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
                        onPressed: () {
                          if (serviceType == PlatformProductType.ePinVoucher) {
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
                            final input =
                                serviceType == PlatformProductType.betting ||
                                        serviceType ==
                                            PlatformProductType.cableTv ||
                                        serviceType ==
                                            PlatformProductType.electricity
                                    ? state.secondaryInputController.text.trim()
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

                            notifier.validateBill(
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
                                final walletBalance =
                                    double.tryParse(walletBalanceStr ?? '') ??
                                        0.0;
                                final amount = notifier.getTransactionAmount();
                                if (amount > walletBalance) {
                                  context.showErrorSnackBar(
                                    'Insufficient balance. You have ${walletBalance.toCurrency()}',
                                  );
                                  return;
                                }

                                notifier.showTransactionSummary(context);
                              },
                            );
                          } else {
                            notifier.showTransactionSummary(context);
                          }
                        },
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

// import 'package:bundlegram/core/config/service_config.dart';
// import 'package:bundlegram/core/extensions/context_extensions.dart';
// import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
// import 'package:bundlegram/core/extensions/widget_extensions.dart';
// import 'package:bundlegram/core/utils/colors.dart';
// import 'package:bundlegram/core/utils/enums.dart';
// import 'package:bundlegram/core/utils/styles.dart';
// import 'package:bundlegram/gen/assets.gen.dart';
// import 'package:bundlegram/gen/fonts.gen.dart';
// import 'package:bundlegram/presentation/features/Bundlegram_Platform/data/platform_data.dart';
// import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/productuserprice_widget.dart';
// import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformphonenumberform_widget.dart';
// import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformproductitem_widget.dart';
// import 'package:bundlegram/presentation/features/transaction/screens/airtime/widget/airtime_success.dart';
// import 'package:bundlegram/presentation/features/transaction/screens/betting/betting_transaction_screen.dart';
// import 'package:bundlegram/presentation/features/transaction/screens/betting/widget/betting_success.dart';
// import 'package:bundlegram/presentation/features/transaction/screens/cabletv/widget/cabletvsuccess.dart';
// import 'package:bundlegram/presentation/features/transaction/screens/e-pin/bulkE-pin_screen.dart';
// import 'package:bundlegram/presentation/features/transaction/screens/e-pin/widget/bulk_pin_success.dart';
// import 'package:bundlegram/presentation/features/transaction/screens/e-pin/widget/epin_success.dart';
// import 'package:bundlegram/presentation/features/transaction/screens/education/widget/education_success.dart';
// import 'package:bundlegram/presentation/features/transaction/screens/electricity/widget/electricity_success.dart';
// import 'package:bundlegram/presentation/features/transaction/screens/internet-services/widget/internetservice_success.dart';
// import 'package:bundlegram/presentation/features/transaction/screens/mobile-data/mobile_data_transaction_screen.dart';
// import 'package:bundlegram/presentation/features/transaction/screens/mobile-data/widget/mobiledata_success.dart';
// import 'package:bundlegram/presentation/features/transaction/screens/widgets/serviceProviders_history_screen.dart';
// import 'package:bundlegram/presentation/features/transaction/screens/widgets/transactionsummary_widget.dart';
// import 'package:bundlegram/presentation/features/wallet/screen/enterpin_screen.dart';
// import 'package:bundlegram/presentation/features/wallet/screen/topup_failed_screen.dart';
// import 'package:bundlegram/presentation/features/wallet/screen/wallet_screen.dart';
// import 'package:bundlegram/presentation/general_widget/app_bar.dart';
// import 'package:bundlegram/presentation/general_widget/app_button.dart';
// import 'package:bundlegram/presentation/general_widget/app_listtile.dart';
// import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
// import 'package:bundlegram/presentation/general_widget/app_svg.dart';
// import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:bundlegram/core/router/route_constants.dart';
// import 'package:go_router/go_router.dart';

// class PlatformproductScreen extends StatefulWidget {
//   const PlatformproductScreen({
//     this.serviceType,
//     super.key,
//   });
//   final PlatformProductType? serviceType;

//   @override
//   State<PlatformproductScreen> createState() => _PlatformproductScreenState();
// }

// class _PlatformproductScreenState extends State<PlatformproductScreen> {
//   Map<String, String>? selectedBundle;
//   final TextEditingController _secondaryInputFieldController =
//       TextEditingController();
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController _firstInputController = TextEditingController();

//   String? selectedProvider;

//   // Map service types to their success and failure screens
//   final Map<PlatformProductType, Map<String, Widget>> _serviceRoutes = {
//     PlatformProductType.mobileData: {
//       'success': const DataSubscriptionSuccessResultScreen(
//         dataValue: '',
//         beneficiary: '',
//       ),
//       'failure': const FailedResultScreen(serviceContent: 'data subscription'),
//     },
//     PlatformProductType.airtime: {
//       'success': const AirtimeSuccessResultScreen(amount: '', beneficiary: ''),
//       'failure': const FailedResultScreen(serviceContent: 'airtime recharge '),
//     },
//     PlatformProductType.ePinVoucher: {
//       'success': const EpinSuccessResultScreen(
//         amount: '',
//       ),
//       'failure': const FailedResultScreen(serviceContent: 'payment for e-pin'),
//     },
//     PlatformProductType.bulkEPin: {
//       'success': const BulkPinSuccessResultScreen(),
//     },
//     PlatformProductType.betting: {
//       'success': const BettingSuccessResultScreen(amount: '', biller: ''),
//       'failure': const FailedResultScreen(
//         serviceContent: 'payment to your betting account ',
//       ),
//     },
//     PlatformProductType.cableTv: {
//       'success': const CableTvSuccessResultScreen(
//         amount: '',
//       ),
//       'failure':
//           const FailedResultScreen(serviceContent: 'payment for cable TV '),
//     },
//     PlatformProductType.education: {
//       'success':
//           const EducationProviderSuccessResultScreen(amount: '', biller: ''),
//       'failure':
//           const FailedResultScreen(serviceContent: 'payment for education'),
//     },
//     PlatformProductType.electricity: {
//       'success': const ElectricitySuccessResultScreen(amount: '', biller: ''),
//       'failure':
//           const FailedResultScreen(serviceContent: 'payment for electricity '),
//     },
//     PlatformProductType.internetServices: {
//       'success':
//           const InternetServicesSuccessResultScreen(amount: '', biller: ''),
//       'failure': const FailedResultScreen(
//         serviceContent: 'payment for internet service',
//       ),
//     },
//   };

//   @override
//   void dispose() {
//     _secondaryInputFieldController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final serviceType = widget.serviceType ?? PlatformProductType.mobileData;
//     final config = ServiceConfigs.configs[serviceType] ??
//         ServiceConfigs.configs[PlatformProductType.mobileData]!;

//     bool isProviderApplicable = [
//       PlatformProductType.mobileData,
//       PlatformProductType.airtime,
//       PlatformProductType.ePinVoucher,
//       PlatformProductType.bulkEPin,
//       PlatformProductType.betting,
//       PlatformProductType.cableTv,
//       PlatformProductType.education,
//       PlatformProductType.electricity,
//       PlatformProductType.internetServices,
//     ].contains(serviceType);

//     return BundlegramScaffold(
//       appBar: BundlegramAppbar(
//         titleText: config.title,
//         trailing: GestureDetector(
//           onTap: () {
//             switch (serviceType) {
//               case PlatformProductType.mobileData:
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const ServiceHistoryScreen(
//                       serviceType: PlatformProductType.mobileData,
//                     ),
//                   ),
//                 );

//               case PlatformProductType.airtime:
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const ServiceHistoryScreen(
//                       serviceType: PlatformProductType.airtime,
//                     ),
//                   ),
//                 );

//               case PlatformProductType.betting:
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const ServiceHistoryScreen(
//                       serviceType: PlatformProductType.betting,
//                     ),
//                   ),
//                 );

//               case PlatformProductType.electricity:
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const ServiceHistoryScreen(
//                       serviceType: PlatformProductType.electricity,
//                     ),
//                   ),
//                 );

//               case PlatformProductType.education:
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const ServiceHistoryScreen(
//                       serviceType: PlatformProductType.education,
//                     ),
//                   ),
//                 );

//               case PlatformProductType.cableTv:
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const ServiceHistoryScreen(
//                       serviceType: PlatformProductType.cableTv,
//                     ),
//                   ),
//                 );

//               case PlatformProductType.internetServices:
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const ServiceHistoryScreen(
//                       serviceType: PlatformProductType.internetServices,
//                     ),
//                   ),
//                 );

//               case PlatformProductType.ePinVoucher:
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const ServiceHistoryScreen(
//                       serviceType: PlatformProductType.ePinVoucher,
//                     ),
//                   ),
//                 );

//               case PlatformProductType.bulkEPin:
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const ServiceHistoryScreen(
//                       serviceType: PlatformProductType.bulkEPin,
//                     ),
//                   ),
//                 );
//             }
//           },
//           child: Text(
//             'History',
//             style: context.textTheme.bodySmall!
//                 .copyWith(fontWeight: FontWeight.w500),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // 80.verticalSpace,
//             PlatformphonenumberformWidget(
//               firstInputfieldController: _firstInputController,
//               secondaryInputfieldController: _secondaryInputFieldController,
//               serviceType: serviceType,
//               inputHint: config.inputHint,
//               secondaryInputHint: config.secondaryInputHint,
//               dropdownHint: config.dropdownHint,
//               onProviderSelected: isProviderApplicable
//                   ? (provider) => setState(() => selectedProvider = provider)
//                   : null,
//               // initialProviderImage: Assets.svgs.mtnnw,
//               dropdownOptions: config.dropdownOptions ?? [],
//             ),
//             if (selectedProvider != null && config.bundles!.isNotEmpty)
//               ProductItemGrid(
//                 bundles: config.bundles!,
//                 selectedBundle: selectedBundle,
//                 onBundleSelected: (bundle) {
//                   setState(() {
//                     selectedBundle = bundle;
//                     // If this service uses an “amount” key, push it into the textfield:
//                     if (bundle.containsKey('amount')) {
//                       amountController.text =
//                           bundle['amount']!.replaceAll('₦', '');
//                     }
//                   });
//                 },
//                 serviceType: serviceType,
//               ),
//             if (serviceType == PlatformProductType.ePinVoucher ||
//                 serviceType == PlatformProductType.bulkEPin)
//               ProductuserpriceWidget(serviceType: serviceType),

//             if (serviceType != PlatformProductType.mobileData &&
//                 serviceType != PlatformProductType.internetServices)
//               Padding(
//                 padding: EdgeInsets.only(top: 24.h),
//                 child: AppTextField(
//                   hintText: "Amount",
//                   controller: amountController,
//                   onChange: (val) {
//                     // Forget any old bundle selection so summary uses this new text
//                     if (selectedBundle != null) {
//                       setState(() => selectedBundle = null);
//                     }
//                   },
//                   prefixIcon: Padding(
//                     padding: context.symmetricPadding(24, 0),
//                     child: Text('₦', style: context.textTheme.bodyMedium),
//                   ),
//                 ),
//               ),

//             24.verticalSpace,
//             Row(
//               children: [
//                 AppSvgIcon(path: Assets.svgs.balance),
//                 16.horizontalSpace,
//                 Text('Balance (₦20,000)', style: context.textTheme.bodySmall),
//                 const Spacer(),
//                 Flexible(
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const WalletScreen(),
//                         ),
//                       );
//                     },
//                     child: Text(
//                       'Top-up >',
//                       style: context.textTheme.bodySmall!
//                           .copyWith(color: AppColors.primaryColor),
//                     ),
//                   ),
//                 ),
//               ],
//             ).withContainer(
//               color: const Color(0xffEEF3FF),
//               padding: context.symmetricPadding(16, 12),
//               borderRadius: BorderRadius.circular(6),
//             ),
//             40.verticalSpace,
//             BundlegramButton(
//               text: 'Continue',
//               onPressed: () {
//                 bool isValid = true;
//                 if (isProviderApplicable) isValid = selectedProvider != null;
//                 // if (serviceType == PlatformProductType.ePinVoucher ||
//                 //     serviceType == PlatformProductType.bulkEPin)
//                 //   isValid = isValid && selectedBundle != null;
//                 if (isValid) {
//                   String? discountedPriceString;
//                   if (serviceType != PlatformProductType.betting) {
//                     final rawPrice = selectedBundle?['price'] ??
//                         amountController.text.trim();
//                     // strip out everything but digits
//                     final numeric = int.tryParse(
//                             rawPrice.replaceAll(RegExp(r'[^\d]'), '')) ??
//                         0;
//                     final discounted = numeric - 20;
//                     discountedPriceString = '₦$discounted.00';
//                   }
//                   context.showBottomSheet(
//                     showIcon: true,
//                     child: TransactionSummary(
//                       assetPath: _getImagePath(serviceType, selectedProvider),
//                       transactionType: selectedProvider,
//                       amount: summaryAmount(serviceType),
//                       discountedPrice: discountedPriceString,
//                       paymentMethod: 'Wallet',
//                       beneficiary:
//                           (serviceType != PlatformProductType.mobileData &&
//                                   serviceType != PlatformProductType.airtime)
//                               ? _secondaryInputFieldController.text
//                               : _firstInputController.text,
//                       onPay: () {
//                         context.pop(); // Close the bottom sheet
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (ctx) => EnterPinScreen(onVerified: (pin) {
//                               String size = '';
//                               String amount = '';

//                               // For mobile data and internet services, use the data size
//                               if (serviceType ==
//                                       PlatformProductType.mobileData ||
//                                   serviceType ==
//                                       PlatformProductType.internetServices) {
//                                 size = selectedBundle?['data'] ?? '';
//                                 amount = selectedBundle?['price'] ?? '';
//                               } else {
//                                 // For other services, use amount from bundle or text field
//                                 if (selectedBundle?.containsKey('amount') ==
//                                     true) {
//                                   amount = selectedBundle!['amount']!;
//                                 } else if (selectedBundle
//                                         ?.containsKey('price') ==
//                                     true) {
//                                   amount = selectedBundle!['price']!;
//                                 } else {
//                                   amount = '₦${amountController.text}';
//                                 }
//                               }

//                               // Ensure amount has proper formatting
//                               if (amount.isNotEmpty &&
//                                   !amount.startsWith('₦')) {
//                                 amount = '₦$amount';
//                               }

//                               final beneficiary = (serviceType !=
//                                           PlatformProductType.mobileData &&
//                                       serviceType !=
//                                           PlatformProductType.airtime)
//                                   ? _secondaryInputFieldController.text
//                                   : _firstInputController.text;

//                               final biller = selectedProvider ?? '';

//                               Navigator.of(context).pushReplacement(
//                                 MaterialPageRoute(
//                                   builder: (context) {
//                                     // Handle different success screen parameters
//                                     switch (serviceType) {
//                                       case PlatformProductType.mobileData:
//                                         return DataSubscriptionSuccessResultScreen(
//                                           dataValue: size,
//                                           beneficiary: beneficiary,
//                                         );
//                                       case PlatformProductType.airtime:
//                                         return AirtimeSuccessResultScreen(
//                                           amount: amount,
//                                           beneficiary: beneficiary,
//                                         );
//                                       case PlatformProductType.ePinVoucher:
//                                         return EpinSuccessResultScreen(
//                                           amount: amount,
//                                         );
//                                       case PlatformProductType.bulkEPin:
//                                         return const BulkPinSuccessResultScreen();
//                                       case PlatformProductType.betting:
//                                         return BettingSuccessResultScreen(
//                                           amount: amount,
//                                           biller: biller,
//                                         );
//                                       case PlatformProductType.cableTv:
//                                         return CableTvSuccessResultScreen(
//                                           amount: amount,
//                                         );
//                                       case PlatformProductType.education:
//                                         return EducationProviderSuccessResultScreen(
//                                           amount: amount,
//                                           biller: biller,
//                                         );
//                                       case PlatformProductType.electricity:
//                                         return ElectricitySuccessResultScreen(
//                                           amount: amount,
//                                           biller: biller,
//                                         );
//                                       case PlatformProductType.internetServices:
//                                         return InternetServicesSuccessResultScreen(
//                                           amount:
//                                               size.isNotEmpty ? size : amount,
//                                           biller: biller,
//                                         );
//                                       default:
//                                         // Fallback - this shouldn't happen but provides safety
//                                         return const FailedResultScreen(
//                                             serviceContent: 'transaction');
//                                     }
//                                   },
//                                 ),
//                               );
//                             }),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 }
//               },
//             ),
//             if (serviceType == PlatformProductType.ePinVoucher)
//               Padding(
//                 padding: EdgeInsets.only(top: 24.h),
//                 child: BundlegramButton(
//                   text: 'Print bulk e-pin voucher',
//                   isOutline: true,
//                   textStyle: context.textTheme.bodyMedium?.copyWith(
//                     color: AppColors.grey19,
//                     fontFamily: FontFamily.mabryPro,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500,
//                   ),
//                   onPressed: () {
//                     context.showBottomSheet(
//                       color: AppColors.background,
//                       showIcon: false,
//                       // showDragHandle: true,
//                       child: Padding(
//                         padding: context.symmetricPadding(16, 16),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             24.verticalSpace,
//                             Text(
//                               'Print bulk e-pin voucher',
//                               style: context.textTheme.displaySmall,
//                             ),
//                             24.verticalSpace,
//                             RichText(
//                               textAlign: TextAlign.center,
//                               text: TextSpan(
//                                 text:
//                                     'Do you want to print E-PIN in bulk? You will make money selling E-PIN to people in your community.\n',
//                                 style: context.textTheme.bodySmall,
//                                 children: [
//                                   TextSpan(
//                                     text: 'Note:',
//                                     style: const TextStyle(
//                                       color: Color(0xFFAA0B27),
//                                     ),
//                                   ),
//                                   const TextSpan(
//                                       text: 'This feature is available to all'),
//                                   TextSpan(
//                                     text: ' Bundlegram agents only.',
//                                     style:
//                                         context.textTheme.bodySmall!.copyWith(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   const TextSpan(
//                                       text:
//                                           ' Our agents enjoy bulk E-PIN at discounted prices.'),
//                                 ],
//                               ),
//                             ),
//                             40.verticalSpace,
//                             BundlegramButton(
//                               text: 'Continue',
//                               onPressed: () {
//                                 context.pop();
//                                 Navigator.of(context).push(
//                                   MaterialPageRoute(
//                                     builder: (context) => BulkEpinScreen(),
//                                   ),
//                                 );
//                               },
//                             ),
//                             18.verticalSpace,
//                             BundlegramButton(
//                               text: 'Cancel',
//                               isOutline: true,
//                               color: AppColors.background,
//                               textStyle: context.textTheme.bodyMedium?.copyWith(
//                                 color: AppColors.grey19,
//                                 fontFamily: FontFamily.mabryPro,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               onPressed: () {
//                                 context.pop();
//                               },
//                             ),
//                             20.verticalSpace,
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                   color: AppColors.white,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   String summaryAmount(PlatformProductType serviceType) {
//     //for data bundles use the size string
//     if (serviceType == PlatformProductType.mobileData ||
//         serviceType == PlatformProductType.internetServices) {
//       return selectedBundle!['price']! + '.00' ?? '';
//     }
//     // bundles that define a ‘price’ field use that
//     if (selectedBundle?.containsKey('price') ?? false) {
//       return selectedBundle!['price']! + '.00';
//     }
//     // bundles that define an ‘amount’ field use that
//     if (selectedBundle?.containsKey('amount') ?? false) {
//       return selectedBundle!['amount']! + '.00';
//     }
//     // fallback to whatever the user typed
//     final text = amountController.text.trim();
//     return text.isNotEmpty || text.contains('₦')
//         ? text.replaceAll('₦', '₦$text.00')
//         : '';
//   }

//   String? _getImagePath(PlatformProductType serviceType, String? provider) {
//     // if (provider == null) return Assets.svgs.mtnnw;
//     switch (serviceType) {
//       case PlatformProductType.mobileData:
//       case PlatformProductType.airtime:
//       case PlatformProductType.ePinVoucher:
//       case PlatformProductType.bulkEPin:
//         return _findProviderImage(
//             PlatFormData.serviceProviderWidget, provider!);
//       case PlatformProductType.education:
//         return _findProviderImage(
//           PlatFormData.educationProviderWidget,
//           'Education',
//         );
//       case PlatformProductType.betting:
//         return _findProviderImage(PlatFormData.bettingProviders, provider!);
//       case PlatformProductType.cableTv:
//         return _findProviderImage(
//             PlatFormData.cableTvProviderWidget, provider!);
//       case PlatformProductType.internetServices:
//         return _findProviderImage(
//           PlatFormData.internetServiceProviderWidget,
//           'Internet service',
//         );
//       case PlatformProductType.electricity:
//         return _findProviderImage(
//           PlatFormData.electricityProviderWidget,
//           'Electricity',
//         );
//     }
//   }

//   String? _findProviderImage(List<Widget> providers, String provider) {
//     final tile = providers.firstWhere(
//       (widget) =>
//           (widget as AppListTile).title.toLowerCase().contains(provider),
//       orElse: () => providers[0],
//     ) as AppListTile;
//     return tile.imagePath ?? tile.assetPath;
//   }
// }
