import 'package:bundlegram/presentation/features/account%20setup/notifier/link_bvn_provider.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transaction_success_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_datetextfield.dart';
import 'package:bundlegram/presentation/general_widget/app_dropdown.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class LinkyourbvnScreen extends StatelessWidget {
//   const LinkyourbvnScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BundlegramScaffold(
//       appBar: const BundlegramAppbar(
//         titleText: 'Link your BVN',
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const AppTextField(
//               hintText: 'Bank Verification Number (BVN)',
//             ),
//             24.verticalSpace,
//             const AppTextField(
//               hintText: 'Phone Number linked to BVN',
//             ),
//             24.verticalSpace,
//             const AppTextField(
//               hintText: 'Date of birth (DD/MM/YY)',
//             ),
//             24.verticalSpace,
//             const Text('Add bank details of a linked account'),
//             18.verticalSpace,
//             const AppDropdown(title: 'Bank name'),
//             24.verticalSpace,
//             const AppTextField(
//               hintText: 'Account number',
//             ),
//             24.verticalSpace,
//             const AppTextField(
//               hintText: 'Account name',
//             ),
//             40.verticalSpace,
//             BundlegramButton(
//               text: 'Submit detail',
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (ctx) => const TransactionSuccessful(
//                       isBasicInfo: true,
//                       title: 'BVN Linked!',
//                       subTitle:
//                           'Your BVN has been successfully linked to your Bundlegram account. We will notify you once verified.',
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class LinkYourBvnScreen extends ConsumerWidget {
  const LinkYourBvnScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(linkBvnProvider);
    final notifier = ref.read(linkBvnProvider);

    // assume banks list comes from globalProvider via notifier.bankOptions
    final banks = notifier.bankOptions;

    return BundlegramScaffold(
      appBar: const BundlegramAppbar(titleText: 'Link your BVN'),
      body: Form(
        key: provider.formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            children: [
              AppTextField(
                controller: notifier.bvn,
                hintText: 'Bank Verification Number (BVN)',
                validateFunction: notifier.validateBVN,
              ),
              SizedBox(height: 24.h),
              AppTextField(
                controller: notifier.phone,
                hintText: 'Phone Number linked to BVN',
                validateFunction: notifier.validatePhone,
              ),
              SizedBox(height: 24.h),
              AppDatetextfield(
                controller: notifier.dob,
                title: 'Date of birth',
                hintText: 'DD/MM/YYYY',
                validator: notifier.validateDate,
                onTap: () => notifier.pickDob(context),
              ),
              SizedBox(height: 24.h),
              AppDropdown(
                title: provider.selectedBankName == ""
                    ? "Bank Name"
                    : provider.selectedBankName,
                options: banks,
                selected: provider.selectedBankName,
                onChanged: notifier.setBank,
              ),
              SizedBox(height: 24.h),
              AppTextField(
                controller: notifier.acct,
                hintText: 'Account number',
                validateFunction: notifier.validateAccount,
                onChange: notifier.onAccountNumberChanged,
              ),
              if (provider.fetchingName) ...[
                SizedBox(height: 16.h),
                const CircularProgressIndicator(),
              ],
              SizedBox(height: 16.h),
              AppTextField(
                controller: TextEditingController(text: provider.acctName),
                hintText: 'Account name',
                readOnly: true,
              ),
              SizedBox(height: 32.h),
              BundlegramButton(
                text: 'Submit detail',
                onPressed:
                    provider.loading ? null : () => notifier.submit(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
