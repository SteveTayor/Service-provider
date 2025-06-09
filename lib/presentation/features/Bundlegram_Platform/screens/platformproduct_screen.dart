import 'package:bundlegram/core/config/service_config.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/productuserprice_widget.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformphonenumberform_widget.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformproductitem_widget.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transactionsummary_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
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
  String? selectedProvider;

  @override
  Widget build(BuildContext context) {
    final serviceType = widget.serviceType; //?? PlatformProductType.mobileData;
    final config = ServiceConfigs.configs[serviceType]; //??
//        ServiceConfigs.configs[PlatformProductType.mobileData]!;

    bool isProviderApplicable = [
      PlatformProductType.mobileData,
      PlatformProductType.airtime,
      PlatformProductType.ePinVoucher,
      PlatformProductType.bulkEPin,
    ].contains(serviceType);

    return BundlegramScaffold(
      appBar: BundlegramAppbar(
        titleText: config!.title,
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
            //   default:
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
      body: Column(
        children: [
          PlatformphonenumberformWidget(
            serviceType: serviceType!,
            inputHint: config.inputHint,
            secondaryInputHint: config.secondaryInputHint,
            dropdownHint: config.dropdownHint,
            imagePaths: config.imagePaths,
            onProviderSelected: isProviderApplicable
                ? (provider) {
                    setState(() {
                      selectedProvider = provider;
                    });
                  }
                : null,
            initialProviderImage:
                isProviderApplicable ? config.imagePaths?.first : null,
          ),
          // if (serviceType == PlatformProductType.ePinVoucher)
          //   const ProductuserpriceWidget()
          if (config.bundles.isNotEmpty)
            ProductItemGrid(
              bundles: config.bundles,
              selectedBundle: selectedBundle,
              onBundleSelected: (bundle) {
                setState(() {
                  selectedBundle = bundle;
                });
              },
            ),
          Row(
            children: [
              AppSvgIcon(path: Assets.svgs.balance),
              16.horizontalSpace,
              Text(
                'Balance (₦20,000)',
                style: context.textTheme.bodySmall,
              ),
              const Spacer(),
              Text(
                'Top-up >',
                style: context.textTheme.bodySmall!.copyWith(
                  color: AppColors.primaryColor,
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
              if (serviceType == PlatformProductType.ePinVoucher)
                isValid = isValid && selectedBundle != null;
              if (isValid && serviceType != PlatformProductType.ePinVoucher) {
                String? imagePath = config.imagePaths?.firstWhere(
                  (path) => path.contains(selectedProvider ?? ''),
                  orElse: () => config.imagePaths?.first ?? '',
                );
                context.showBottomSheet(
                  showIcon: true,
                  child: TransactionSummary(
                    imagePath: imagePath,
                    transactionType: config.title,
                    amount: selectedBundle != null
                        ? selectedBundle!.values.first
                        : 'N0.00',
                    paymentMethod: 'Wallet',
                    beneficiary: config.inputHint ?? 'beneficiary',
                    onPay: () {},
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
                onPressed: () {
                  context.showBottomSheet(
                    showIcon: false,
                    child: TransactionSummary(
                      transactionType: config.title,
                      amount: selectedBundle != null
                          ? selectedBundle!.values.first
                          : 'N0.00',
                      paymentMethod: 'paymentMethod',
                      beneficiary: config.inputHint ?? 'beneficiary',
                      onPay: () {},
                    ),
                  );
                },
                color: AppColors.greyD0,
              ),
            ),
        ],
      ),
    );
  }
}
