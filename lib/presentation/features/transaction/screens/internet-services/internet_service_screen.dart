import 'package:bundlegram/core/config/service_config.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/data/platform_data.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformphonenumberform_widget.dart';
import 'package:bundlegram/presentation/features/transaction/screens/internet-services/widget/internetservice_success.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/serviceProviders_history_screen.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transactionsummary_widget.dart';
import 'package:bundlegram/presentation/features/wallet/screen/enterpin_screen.dart';
import 'package:bundlegram/presentation/features/wallet/screen/wallet_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_listtile.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class InternetServiceProviderScreen extends StatefulWidget {
  const InternetServiceProviderScreen({super.key});

  @override
  State<InternetServiceProviderScreen> createState() =>
      _InternetServiceProviderScreenState();
}

class _InternetServiceProviderScreenState
    extends State<InternetServiceProviderScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController _secondaryInputFieldController =
      TextEditingController();
  String? selectedProvider;
  @override
  Widget build(BuildContext context) {
    final serviceType = PlatformProductType.internetServices;
    final config = ServiceConfigs.configs[serviceType]!;
    bool isProviderApplicable =
        [PlatformProductType.internetServices].contains(serviceType);

    return BundlegramScaffold(
      appBar: BundlegramAppbar(
        titleText: 'Internet Services',
        trailing: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ServiceHistoryScreen(
                  serviceType: PlatformProductType.internetServices,
                ),
              ),
            );
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
            PlatformphonenumberformWidget(
              serviceType: PlatformProductType.internetServices,
              secondaryInputHint: config.secondaryInputHint,
              secondaryInputfieldController: _secondaryInputFieldController,
              inputHint: config.inputHint,
              dropdownHint: config.dropdownHint,
              onProviderSelected: isProviderApplicable
                  ? (provider) => setState(() => selectedProvider = provider)
                  : null,
              initialProviderImage: Assets.images.smile.path,
              dropdownOptions: config.dropdownOptions ?? [],
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.h),
              child: AppTextField(
                hintText: "Amount",
                controller: amountController,
                prefixIcon: Padding(
                  padding: context.symmetricPadding(24, 0),
                  child: Text('₦', style: context.textTheme.bodyMedium),
                ),
              ),
            ),
            24.verticalSpace,
            Row(
              children: [
                AppSvgIcon(path: Assets.svgs.balance),
                16.horizontalSpace,
                Text('Balance (₦20,000)', style: context.textTheme.bodySmall),
                const Spacer(),
                Flexible(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WalletScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Top-up >',
                      style: context.textTheme.bodySmall!
                          .copyWith(color: AppColors.primaryColor),
                    ),
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
                if (isValid) {
                  String? discountedPriceString;

                  final rawPrice = amountController.text.trim();
                  final numeric =
                      int.tryParse(rawPrice.replaceAll(RegExp(r'[^\d]'), '')) ??
                          0;
                  final discounted = numeric - 500;
                  discountedPriceString = '₦$discounted.00';

                  context.showBottomSheet(
                    showIcon: true,
                    child: TransactionSummary(
                      assetPath: _getImage(selectedProvider!),
                      transactionType: selectedProvider,
                      amount: '₦' + amountController.text.trim(),
                      discountedPrice: discountedPriceString,
                      paymentMethod: 'Wallet',
                      beneficiary: _secondaryInputFieldController.text,
                      onPay: () {
                        context.pop(); // Close the bottom sheet
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => EnterPinScreen(onVerified: () {
                              final amount =
                                  '₦' + amountController.text + '.00';
                              final beneficiary =
                                  _secondaryInputFieldController.text.trim();
                              final biller = selectedProvider!;
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      InternetServicesSuccessResultScreen(
                                    amount: amount,
                                    biller: biller,
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  String? _getImage(String provider) {
    final serviceProvider = PlatFormData.internetServiceProviderWidget;
    final tile = serviceProvider.firstWhere(
      (widget) =>
          (widget as AppListTile).title.toLowerCase().contains(provider),
      orElse: () => serviceProvider[0],
    ) as AppListTile;
    final imgPath = tile.imagePath ?? tile.assetPath;
    return (imgPath);
  }
}
