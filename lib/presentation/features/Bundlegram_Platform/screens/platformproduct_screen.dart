import 'package:bundlegram/core/config/service_config.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/gen/fonts.gen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/data/platform_data.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/productuserprice_widget.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformphonenumberform_widget.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformproductitem_widget.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transactionsummary_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_listtile.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
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
  TextEditingController _secondaryInputFieldController =
      TextEditingController();
  String? selectedProvider;

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
            // switch (serviceType) {
            //   case PlatformProductType.mobileData:
            //     context.push('${RouteConstants.history}/mobileData');
            //     break;
            //   case PlatformProductType.airtime:
            //     context.push('${RouteConstants.history}/airtime');
            //     break;
            //   case PlatformProductType.betting:
            //     context.push('${RouteConstants.history}/betting');
            //     break;
            //   case PlatformProductType.electricity:
            //     context.push('${RouteConstants.history}/electricity');
            //     break;
            //   case PlatformProductType.education:
            //     context.push('${RouteConstants.history}/education');
            //     break;
            //   case PlatformProductType.cableTv:
            //     context.push('${RouteConstants.history}/cableTv');
            //     break;
            //   case PlatformProductType.internetServices:
            //     context.push('${RouteConstants.history}/internetServices');
            //     break;
            //   case PlatformProductType.ePinVoucher:
            //     context.push('${RouteConstants.history}/ePinVoucher');
            //     break;
            //   case PlatformProductType.bulkEPin:
            //     context.push('${RouteConstants.history}/bulkEPin');
            //     break;
            // }
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
              initialProviderImage: Assets.svgs.mtnLogo,
            ),
            if (config.bundles != null && config.bundles!.isNotEmpty)
              ProductItemGrid(
                bundles: config.bundles!,
                selectedBundle: selectedBundle,
                onBundleSelected: (bundle) =>
                    setState(() => selectedBundle = bundle),
              ),
            if (serviceType == PlatformProductType.ePinVoucher ||
                serviceType == PlatformProductType.bulkEPin)
              const ProductuserpriceWidget(),
            Row(
              children: [
                AppSvgIcon(path: Assets.svgs.balance),
                16.horizontalSpace,
                Text('Balance (₦20,000)', style: context.textTheme.bodySmall),
                const Spacer(),
                Text(
                  'Top-up >',
                  style: context.textTheme.bodySmall!
                      .copyWith(color: AppColors.primaryColor),
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
                      amount: selectedBundle?.values.first ?? 'N0.00',
                      paymentMethod: 'Wallet',
                      beneficiary:
                          _secondaryInputFieldController.text ?? 'beneficiary',
                      onPay: () {
                        context.push(RouteConstants.enterPin);
                      },
                    ),
                  );
                }
              },
            ),
            if (serviceType == PlatformProductType.ePinVoucher)
              Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: BundlegramButton(
                  text: 'Print bulk e-pin voucher',
                  textStyle: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.grey19,
                    fontFamily: FontFamily.mabryPro,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  onPressed: () {
                    context.showBottomSheet(
                      showIcon: false,
                      child: TransactionSummary(
                        transactionType: selectedProvider,
                        amount: selectedBundle?.values.first ?? 'N0.00',
                        paymentMethod: 'Wallet',
                        beneficiary: _secondaryInputFieldController.text ??
                            'beneficiary',
                        onPay: () {
                          context.push(RouteConstants.enterPin);
                        },
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
    if (provider == null) return Assets.svgs.mtnLogo;
    switch (serviceType) {
      case PlatformProductType.mobileData:
      case PlatformProductType.airtime:
      case PlatformProductType.ePinVoucher:
      case PlatformProductType.bulkEPin:
        return _findProviderImage(PlatFormData.serviceProviderWidget, provider);
      case PlatformProductType.education:
        return _findProviderImage(
            PlatFormData.educationProviderWidget, provider);
      case PlatformProductType.betting:
        return _findProviderImage(PlatFormData.bettingProviders, provider);
      case PlatformProductType.cableTv:
        return _findProviderImage(PlatFormData.cableTvProviderWidget, provider);
      case PlatformProductType.internetServices:
        return _findProviderImage(
            PlatFormData.internetServiceProviderWidget, provider);
      case PlatformProductType.electricity:
        return _findProviderImage(
            PlatFormData.electricityProviderWidget, provider);
      default:
        return Assets.svgs.mtnLogo;
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
