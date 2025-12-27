import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_formatter.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_input_formatter.dart';
import 'package:bundlegram/core/utils/phone_number_formatter.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/gen/fonts.gen.dart';
import 'package:bundlegram/presentation/features/transaction/screens/bulk%20e-pin/provider/bulk_epin_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_dropdown.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BulkEpinScreen extends ConsumerWidget {
  const BulkEpinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bulkEpinProvider);
    final notifier = ref.read(bulkEpinProvider.notifier);
    final walletBalanceAsync =
        ref.watch(globalProvider.select((s) => s.walletBalance));
    final walletBalance = walletBalanceAsync.value?.wallet ?? 0.0;

    // Fetch networks on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifier.fetchNetworks(context);
    });

    // Quantity options (1 to 100)
    final quantityOptions =
        List.generate(100, (index) => (index + 1).toString());

    return BundlegramScaffold(
      sidePadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
      appBar: BundlegramAppbar(
        titleText: 'Bulk E-PIN',
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Form(
                key: GlobalKey<FormState>(),
                child: Column(
                  spacing: 24,
                  children: [
                    10.verticalSpace,
                    AppTextField(
                      hintText: 'Agent name',
                      controller: state.agentNameController,
                      validateFunction: Validators.name(),
                    ),
                    AppTextField(
                      hintText: 'Agent email',
                      controller: state.agentEmailController,
                      validateFunction: Validators.email(),
                    ),
                    AppTextField(
                      hintText: 'Agent phone number',
                      controller: state.agentPhoneController,
                      validateFunction:
                          Validators.validateNigerianPhoneNumber(),
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [NumberInputFormatter()],
                      prefixIcon: Padding(
                        padding: context.symmetricPadding(24, 12),
                        child:
                            Text('+234', style: context.textTheme.bodyMedium),
                      ),
                    ),
                    AppTextField(
                      hintText: 'Business name',
                      controller: state.businessNameController,
                      validateFunction: Validators.name(),
                    ),
                    AppDropdown(
                      title: 'Network',
                      options: state.products
                          .where((p) => p.productName != null)
                          .map((p) => p.productName!)
                          .toList(),
                      selected: state.selectedNetwork,
                      onChanged: (value) => notifier.selectNetwork(value!),
                    ),
                    AppTextField(
                      hintText: 'Amount',
                      controller: state.amountController,
                      inputFormatters: [CurrencyTextInputFormatter()],
                      prefixIcon: Padding(
                        padding: context.symmetricPadding(24, 0),
                        child: Text(
                          '₦',
                          style: context.textTheme.bodyMedium,
                        ),
                      ),
                    ),
                    AppDropdown(
                      title: 'Quantity',
                      options: quantityOptions,
                      selected: state.selectedQuantity,
                      onChanged: (value) => notifier.selectQuantity(value!),
                    ),
                    Row(
                      children: [
                        AppSvgIcon(path: Assets.svgs.balance),
                        16.horizontalSpace,
                        Text(
                          'Balance (${CurrencyFormatter.format(walletBalance)})',
                          style: context.textTheme.bodySmall,
                        ),
                        const Spacer(),
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              context.go(RouteConstants.dashboard);
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
                    20.verticalSpace,
                    BundlegramButton(
                      text: 'Continue',
                      isLoading: state.isLoading,
                      onPressed: () => notifier.submitForm(context),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
