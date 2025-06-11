// ignore_for_file: inference_failure_on_instance_creation

import 'package:bundlegram/core/config/service_config.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/core/utils/styles.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/gen/fonts.gen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/data/platform_data.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/productuserprice_widget.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformphonenumberform_widget.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformproductitem_widget.dart';
import 'package:bundlegram/presentation/features/transaction/screens/airtime/widget/airtime_success.dart';
import 'package:bundlegram/presentation/features/transaction/screens/betting/betting_transaction_screen.dart';
import 'package:bundlegram/presentation/features/transaction/screens/betting/widget/betting_success.dart';
import 'package:bundlegram/presentation/features/transaction/screens/cabletv/widget/cabletvsuccess.dart';
import 'package:bundlegram/presentation/features/transaction/screens/e-pin/bulkE-pin_screen.dart';
import 'package:bundlegram/presentation/features/transaction/screens/e-pin/widget/bulk_pin_success.dart';
import 'package:bundlegram/presentation/features/transaction/screens/e-pin/widget/epin_success.dart';
import 'package:bundlegram/presentation/features/transaction/screens/education/widget/education_success.dart';
import 'package:bundlegram/presentation/features/transaction/screens/electricity/widget/electricity_success.dart';
import 'package:bundlegram/presentation/features/transaction/screens/internet-services/widget/internetservice_success.dart';
import 'package:bundlegram/presentation/features/transaction/screens/mobile-data/mobile_data_transaction_screen.dart';
import 'package:bundlegram/presentation/features/transaction/screens/mobile-data/widget/mobiledata_success.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/serviceProviders_history_screen.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transactionsummary_widget.dart';
import 'package:bundlegram/presentation/features/wallet/screen/topup_failed_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_listtile.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:go_router/go_router.dart';

class PlatformproductScreen extends StatefulWidget {
  const PlatformproductScreen({
    this.serviceType,
    super.key,
  });
  final PlatformProductType? serviceType;

  @override
  State<PlatformproductScreen> createState() => _PlatformproductScreenState();
}

class _PlatformproductScreenState extends State<PlatformproductScreen> {
  Map<String, String>? selectedBundle;
  final TextEditingController _secondaryInputFieldController =
      TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String? selectedProvider;

  // Map service types to their success and failure screens
  final Map<PlatformProductType, Map<String, Widget>> _serviceRoutes = {
    PlatformProductType.mobileData: {
      'success': const DataSubscriptionSuccessResultScreen(
        dataValue: '',
        beneficiary: '',
      ),
      'failure': const FailedResultScreen(serviceContent: 'data subscription'),
    },
    PlatformProductType.airtime: {
      'success': const AirtimeSuccessResultScreen(amount: '', beneficiary: ''),
      'failure': const FailedResultScreen(serviceContent: 'airtime recharge '),
    },
    PlatformProductType.ePinVoucher: {
      'success': const EpinSuccessResultScreen(
        amount: '',
      ),
      'failure': const FailedResultScreen(serviceContent: 'payment for e-pin'),
    },
    PlatformProductType.bulkEPin: {
      'success': const BulkPinSuccessResultScreen(),
    },
    PlatformProductType.betting: {
      'success': const BettingSuccessResultScreen(amount: '', biller: ''),
      'failure': const FailedResultScreen(
        serviceContent: 'payment to your betting account ',
      ),
    },
    PlatformProductType.cableTv: {
      'success': const CableTvSuccessResultScreen(
        amount: '',
      ),
      'failure':
          const FailedResultScreen(serviceContent: 'payment for cable TV '),
    },
    PlatformProductType.education: {
      'success':
          const EducationProviderSuccessResultScreen(amount: '', biller: ''),
      'failure':
          const FailedResultScreen(serviceContent: 'payment for education'),
    },
    PlatformProductType.electricity: {
      'success': const ElectricitySuccessResultScreen(amount: '', biller: ''),
      'failure':
          const FailedResultScreen(serviceContent: 'payment for electricity '),
    },
    PlatformProductType.internetServices: {
      'success':
          const InternetServicesSuccessResultScreen(amount: '', biller: ''),
      'failure': const FailedResultScreen(
        serviceContent: 'payment for internet service',
      ),
    },
  };

  @override
  void dispose() {
    _secondaryInputFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final serviceType = widget.serviceType ?? PlatformProductType.mobileData;
    final config = ServiceConfigs.configs[serviceType] ??
        ServiceConfigs.configs[PlatformProductType.mobileData]!;

    bool isProviderApplicable = [
      PlatformProductType.mobileData,
      PlatformProductType.airtime,
      PlatformProductType.ePinVoucher,
      PlatformProductType.bulkEPin,
      PlatformProductType.betting,
      PlatformProductType.cableTv,
      PlatformProductType.education,
      PlatformProductType.electricity,
      PlatformProductType.internetServices,
    ].contains(serviceType);

    return BundlegramScaffold(
      appBar: BundlegramAppbar(
        titleText: config.title,
        trailing: GestureDetector(
          onTap: () {
            switch (serviceType) {
              case PlatformProductType.mobileData:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ServiceHistoryScreen(
                      serviceType: PlatformProductType.mobileData,
                    ),
                  ),
                );

              case PlatformProductType.airtime:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ServiceHistoryScreen(
                      serviceType: PlatformProductType.airtime,
                    ),
                  ),
                );

              case PlatformProductType.betting:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ServiceHistoryScreen(
                      serviceType: PlatformProductType.betting,
                    ),
                  ),
                );

              case PlatformProductType.electricity:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ServiceHistoryScreen(
                      serviceType: PlatformProductType.electricity,
                    ),
                  ),
                );

              case PlatformProductType.education:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ServiceHistoryScreen(
                      serviceType: PlatformProductType.education,
                    ),
                  ),
                );

              case PlatformProductType.cableTv:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ServiceHistoryScreen(
                      serviceType: PlatformProductType.cableTv,
                    ),
                  ),
                );

              case PlatformProductType.internetServices:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ServiceHistoryScreen(
                      serviceType: PlatformProductType.internetServices,
                    ),
                  ),
                );

              case PlatformProductType.ePinVoucher:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ServiceHistoryScreen(
                      serviceType: PlatformProductType.ePinVoucher,
                    ),
                  ),
                );

              case PlatformProductType.bulkEPin:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ServiceHistoryScreen(
                      serviceType: PlatformProductType.bulkEPin,
                    ),
                  ),
                );
            }
          },
          child: Text(
            'History',
            style: context.textTheme.bodySmall!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 80.verticalSpace,
            PlatformphonenumberformWidget(
              secondaryInputfieldController: _secondaryInputFieldController,
              serviceType: serviceType,
              inputHint: config.inputHint,
              secondaryInputHint: config.secondaryInputHint,
              dropdownHint: config.dropdownHint,
              onProviderSelected: isProviderApplicable
                  ? (provider) => setState(() => selectedProvider = provider)
                  : null,
              initialProviderImage: Assets.svgs.mtnnw,
            ),
            if (config.bundles != null && config.bundles!.isNotEmpty)
              ProductItemGrid(
                bundles: config.bundles!,
                selectedBundle: selectedBundle,
                onBundleSelected: (bundle) =>
                    setState(() => selectedBundle = bundle),
                serviceType: serviceType,
              ),
            if (serviceType == PlatformProductType.ePinVoucher ||
                serviceType == PlatformProductType.bulkEPin)
              const ProductuserpriceWidget(serviceType: serviceType),
            
            if (serviceType != PlatformProductType.mobileData &&
                serviceType != PlatformProductType.internetServices)
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: AppTextField(
                  hintText: "Amount",
                  controller: amountController ??
                      selectedBundle?.values.first as TextEditingController,
                  prefixIcon: Padding(
                    padding: context.symmetricPadding(24, 0),
                    child: Text(
                      '₦',
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
            Row(
              children: [
                AppSvgIcon(path: Assets.svgs.balance),
                16.horizontalSpace,
                Text('Balance (₦20,000)', style: context.textTheme.bodySmall),
                const Spacer(),
                Flexible(
                  child: Text(
                    'Top-up >',
                    style: context.textTheme.bodySmall!
                        .copyWith(color: AppColors.primaryColor),
                  ),
                ),
              ],
            ).withContainer(
              color: const Color(0xffEEF3FF),
              padding: context.symmetricPadding(16, 12),
              borderRadius: BorderRadius.circular(6),
            ),
            40.verticalSpace,
            BundlegramButton(
              text: 'Continue',
              onPressed: () {
                bool isValid = true;
                if (isProviderApplicable) isValid = selectedProvider != null;
                if (serviceType == PlatformProductType.ePinVoucher ||
                    serviceType == PlatformProductType.bulkEPin)
                  isValid = isValid && selectedBundle != null;
                if (isValid) {
                  context.showBottomSheet(
                    showIcon: true,
                    child: TransactionSummary(
                      assetPath: _getImagePath(serviceType, selectedProvider),
                      transactionType: selectedProvider,
                      amount:
                          selectedBundle?.values.first ?? amountController.text,
                      paymentMethod: 'Wallet',
                      beneficiary:
                          _secondaryInputFieldController.text ?? 'beneficiary',
                      onPay: () {
                        context
                          ..pop() // Close the bottom sheet
                          ..push(
                            RouteConstants.enterPin,
                            extra: {
                              'onVerified': () {
                                final amount = (amountController.text ??
                                    selectedBundle?.values.first) as String;
                                final beneficiary =
                                    _secondaryInputFieldController.text ??
                                        'beneficiary';
                                final successScreen =
                                    _serviceRoutes[serviceType]!['success']!;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      // Handle different success screen parameters
                                      switch (serviceType) {
                                        case PlatformProductType.mobileData:
                                          return DataSubscriptionSuccessResultScreen(
                                            dataValue: amount,
                                            beneficiary: beneficiary,
                                          );
                                        case PlatformProductType.airtime:
                                          return AirtimeSuccessResultScreen(
                                            amount: amount,
                                            beneficiary: beneficiary,
                                          );
                                        case PlatformProductType.ePinVoucher:
                                          return EpinSuccessResultScreen(
                                            amount: amount,
                                          );
                                        case PlatformProductType.betting:
                                          return BettingSuccessResultScreen(
                                            amount: amount,
                                            biller: beneficiary,
                                          );
                                        case PlatformProductType.cableTv:
                                          return CableTvSuccessResultScreen(
                                            amount: amount,
                                          );
                                        case PlatformProductType.education:
                                          return EducationProviderSuccessResultScreen(
                                            amount: amount,
                                            biller: beneficiary,
                                          );
                                        case PlatformProductType.electricity:
                                          return ElectricitySuccessResultScreen(
                                            amount: amount,
                                            biller: beneficiary,
                                          );
                                        case PlatformProductType
                                              .internetServices:
                                          return InternetServicesSuccessResultScreen(
                                            amount: amount,
                                            biller: beneficiary,
                                          );
                                        default:
                                          return successScreen;
                                      }
                                    },
                                  ),
                                );
                              },
                            },
                          );
                      },
                    ),
                  );
                }
              },
            ),
            if (serviceType == PlatformProductType.ePinVoucher)
              Padding(
                padding: EdgeInsets.only(top: 24.h),
                child: BundlegramButton(
                  text: 'Print bulk e-pin voucher',
                  borderColor: AppColors.grey5B,
                  textStyle: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.grey19,
                    fontFamily: FontFamily.mabryPro,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  onPressed: () {
                    context.showBottomSheet(
                      showIcon: false,
                      showDragHandle: true,
                      child: Padding(
                        padding: context.symmetricPadding(16, 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            18.verticalSpace,
                            Text(
                              'Print bulk e-pin voucher',
                              style: context.textTheme.displayLarge,
                            ),
                            12.verticalSpace,
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text:
                                    'Do you want to print E-PIN in bulk? You will make money selling E-PIN to people in your community.\n',
                                style: context.textTheme.displaySmall,
                                children: [
                                  TextSpan(
                                    text: 'Note:',
                                    style: const TextStyle(
                                      color: Color(0xFFAA0B27),
                                    ),
                                  ),
                                  const TextSpan(
                                      text: 'This feature is available to all'),
                                  TextSpan(
                                    text: ' Bundlegram agents only.',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
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
                                  MaterialPageRoute(
                                    builder: (context) => BulkEpinScreen(),
                                  ),
                                );
                              },
                            ),
                            18.verticalSpace,
                            BundlegramButton(
                              text: 'Cancel',
                              borderColor: AppColors.grey5B,
                              textStyle: context.textTheme.bodyMedium?.copyWith(
                                color: AppColors.grey19,
                                fontFamily: FontFamily.mabryPro,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              onPressed: () {
                                context.pop();
                              },
                            ),
                            20.verticalSpace,
                          ],
                        ),
                      ),
                    );
                  },
                  color: AppColors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }

  String? _getImagePath(PlatformProductType serviceType, String? provider) {
    if (provider == null) return Assets.svgs.mtnnw;
    switch (serviceType) {
      case PlatformProductType.mobileData:
      case PlatformProductType.airtime:
      case PlatformProductType.ePinVoucher:
      case PlatformProductType.bulkEPin:
        return _findProviderImage(PlatFormData.serviceProviderWidget, provider);
      case PlatformProductType.education:
        return _findProviderImage(
          PlatFormData.educationProviderWidget,
          provider,
        );
      case PlatformProductType.betting:
        return _findProviderImage(PlatFormData.bettingProviders, provider);
      case PlatformProductType.cableTv:
        return _findProviderImage(PlatFormData.cableTvProviderWidget, provider);
      case PlatformProductType.internetServices:
        return _findProviderImage(
          PlatFormData.internetServiceProviderWidget,
          provider,
        );
      case PlatformProductType.electricity:
        return _findProviderImage(
          PlatFormData.electricityProviderWidget,
          provider,
        );
      default:
        return Assets.svgs.mtnnw;
    }
  }

  String? _findProviderImage(List<Widget> providers, String provider) {
    final tile = providers.firstWhere(
      (widget) =>
          (widget as AppListTile).title.toLowerCase().contains(provider),
      orElse: () => providers[0],
    ) as AppListTile;
    return tile.imagePath ?? tile.assetPath;
  }
}
