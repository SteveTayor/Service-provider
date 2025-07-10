import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_formatter.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/data/models/products/get_all_products_response.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/gen/fonts.gen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_product_provider.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformphonenumberform_widget.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformproductitem_widget.dart';
import 'package:bundlegram/presentation/features/transaction/screens/internet-services/widget/internetservice_success.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/serviceProviders_history_screen.dart';
import 'package:bundlegram/presentation/features/wallet/screen/enterpin_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_formatter.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/data/models/products/get_all_products_response.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/gen/fonts.gen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_product_provider.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformphonenumberform_widget.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformproductitem_widget.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/serviceProviders_history_screen.dart';
import 'package:bundlegram/presentation/features/wallet/screen/enterpin_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class InternetServiceProviderScreen extends ConsumerStatefulWidget {
  const InternetServiceProviderScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<InternetServiceProviderScreen> createState() =>
      _InternetServiceProviderScreenState();
}

class _InternetServiceProviderScreenState
    extends ConsumerState<InternetServiceProviderScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(platformProductProvider(PlatformProductType.internetServices)
              .notifier)
          .fetchProducts(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final serviceType = PlatformProductType.internetServices;
    final state = ref.watch(platformProductProvider(serviceType));
    final notifier = ref.read(platformProductProvider(serviceType).notifier);
    final walletBalance = ref
            .watch(globalProvider.select((s) => s.walletBalance))
            .value
            ?.wallet ??
        0.0;

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
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: context.symmetricPadding(16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Phone/Meter + Provider picker + dropdown
                  PlatformPhoneNumberFormWidget(
                    serviceType: serviceType,
                    inputHint: state.selectedProduct?.instruct1 ??
                        'Enter phone number',
                    secondaryInputHint: state.selectedProduct?.instruct2 ??
                        'Enter account number',
                    dropdownHint: 'Select plan',
                  ),

                  // Bundle grid (data plans)
                  if (serviceType.hasSubProducts &&
                      state.selectedProduct != null &&
                      state.subProducts.isNotEmpty)
                    ProductItemGrid(
                      serviceType: PlatformProductType.internetServices,
                      products: state.subProducts
                          .where((e) => e.dataType == state.selectedDataType)
                          .toList(),
                    ),

                  // Amount field for non-subproduct services
                  if (!serviceType.hasSubProducts) ...[
                    24.verticalSpace,
                    AppTextField(
                      hintText: 'Amount',
                      controller: state.amountController,
                      prefixIcon: Padding(
                        padding: context.symmetricPadding(24, 0),
                        child: Text('₦', style: context.textTheme.bodyMedium),
                      ),
                    ),
                  ],

                  24.verticalSpace,

                  // Wallet balance & top-up link
                  Row(
                    children: [
                      AppSvgIcon(path: Assets.svgs.balance),
                      16.horizontalSpace,
                      Text(
                        'Balance (${CurrencyFormatter.format(walletBalance)})',
                        style: context.textTheme.bodySmall,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => context.go(RouteConstants.dashboard),
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

                  // Continue / Validate
                  BundlegramButton(
                    text: 'Continue',
                    isLoading: state.isLoading,
                    onPressed: () {
                      if (serviceType.requiresValidation) {
                        // notifier.validateBill(context);
                      } else {
                        notifier.showTransactionSummary(context);
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
