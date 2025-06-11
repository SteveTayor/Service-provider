import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/transaction/screens/e-pin/widget/bulk_pin_success.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_dropdown.dart';
import 'package:bundlegram/presentation/general_widget/app_form.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BulkEpinScreen extends StatefulWidget {
  const BulkEpinScreen({super.key});

  @override
  State<BulkEpinScreen> createState() => _BulkEpinScreenState();
}

class _BulkEpinScreenState extends State<BulkEpinScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      sidePadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
      appBar: const BundlegramAppbar(),
      body: Column(
        children: [
          Flexible(
            child: AppForm(
              isActive: true,
              formKey: _formKey,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => BulkPinSuccessResultScreen(),
                  ),
                );
              },
              buttonText: 'Continue',
              children: [
                AppTextField(
                  hintText: 'Agent name',
                  validateFunction: Validators.name(),
                ),
                AppTextField(
                  hintText: 'Agent email',
                  validateFunction: Validators.email(),
                ),
                AppTextField(
                  hintText: 'Agent phone number',
                  validateFunction: Validators.phone(),
                ),
                AppTextField(
                  hintText: 'Business name',
                  validateFunction: Validators.name(),
                ),
                AppTextField(
                  hintText: 'Amount',
                  prefixIcon: Padding(
                    padding: context.symmetricPadding(24, 0),
                    child: Text(
                      '₦',
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
              extraWidget: ListView(
                shrinkWrap: true,
                children: [
                  AppDropdown(
                    title: 'Network',
                  ),
                  AppDropdown(
                    title: 'Quantity',
                  ),
                  16.verticalSpace,
                  Row(
                    children: [
                      AppSvgIcon(path: Assets.svgs.balance),
                      16.horizontalSpace,
                      Text('Balance (₦20,000)',
                          style: context.textTheme.bodySmall),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
