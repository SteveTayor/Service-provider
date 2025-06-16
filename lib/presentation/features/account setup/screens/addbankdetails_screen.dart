import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transaction_success_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_dropdown.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddbankdetailsScreen extends StatelessWidget {
  const AddbankdetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        titleText: 'Add bank details',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppDropdown(title: 'Bank name'),
            24.verticalSpace,
            const AppTextField(
              hintText: 'Account number',
            ),
            24.verticalSpace,
            const Text('Account Name').withContainer(
              width: context.width,
              color: AppColors.greyD0.withOpacity(0.3),
              padding: context.symmetricPadding(24, 22),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.greyD0),
            ),
            40.verticalSpace,
            BundlegramButton(
              text: 'Submit detail',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const TransactionSuccessful(
                      title: 'Bank details added!',
                      subTitle:
                          'The bank details you provided has been successfully added to your Bundlegram account.',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
