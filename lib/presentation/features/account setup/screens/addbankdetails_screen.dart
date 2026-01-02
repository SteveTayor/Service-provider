import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/features/account%20setup/notifier/add_bank_details.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transaction_success_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_dropdown.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddBankDetailsScreen extends ConsumerWidget {
  const AddBankDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(addBankProvider);
    final notifier = ref.read(addBankProvider.notifier);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (ref.read(globalProvider).banks is AsyncLoading ||
    //       ref.read(globalProvider).banks is AsyncError) {
    //     ref.read(globalProvider.notifier).fetchBanks(context);
    //   }
    // });
    // final banksAsync = ref.watch(globalProvider.select((s) => s.banks));
    Future.microtask(() async {
      ref.listen(globalProvider.select((s) => s.banks), (_, next) {
        if (next is AsyncError || next is AsyncLoading) {
          ref.read(globalProvider.notifier).fetchBanks(context);
        }
      });
    });

    final banksAsync = ref.watch(globalProvider.select((s) => s.banks));
    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        titleText: 'Add bank details',
      ),
      body: banksAsync.when(
        data: (banks) => Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: provider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppDropdown(
                  title: provider.selectedBankName.isEmpty
                      ? "Bank Name"
                      : provider.selectedBankName,
                  options: provider.bankOptions,
                  selected: provider.selectedBankName.isEmpty
                      ? null
                      : provider.selectedBankName,
                  onChanged: notifier.setBank,
                ),
                SizedBox(height: 24.h),
                AppTextField(
                  label: 'Account Number',
                  controller: provider.acct,
                  hintText: 'Account number',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  onChange: notifier.onAccountNumberChanged,
                  validateFunction: notifier.validateAccount,
                ),
                if (provider.fetchingName) ...[
                  SizedBox(height: 16.h),
                  const Center(child: CircularProgressIndicator()),
                ],
                SizedBox(height: 16.h),
                AppTextField(
                  label: 'Account Name',
                  controller: TextEditingController(text: provider.acctName),
                  hintText: 'Account name',
                  readOnly: true,
                ),
                SizedBox(height: 32.h),
                BundlegramButton(
                  text: provider.loading ? 'Submitting...' : 'Submit',
                  onPressed:
                      provider.loading ? null : () => notifier.submit(context),
                ),
              ],
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(
          child: Text('Something went wrong'),
        ),
      ),
    );
  }
}



// class AddbankdetailsScreen extends StatelessWidget {
//   const AddbankdetailsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BundlegramScaffold(
//       appBar: const BundlegramAppbar(
//         titleText: 'Add bank details',
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const AppDropdown(title: 'Bank name'),
//             24.verticalSpace,
//             const AppTextField(
//               hintText: 'Account number',
//             ),
//             24.verticalSpace,
//             const Text('Account Name').withContainer(
//               width: context.width,
//               color: AppColors.greyD0.withOpacity(0.3),
//               padding: context.symmetricPadding(16, 12),
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: AppColors.greyD0),
//             ),
//             40.verticalSpace,
//             BundlegramButton(
//               text: 'Submit detail',
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (ctx) => const TransactionSuccessful(
//                       title: 'Bank details added!',
//                       subTitle:
//                           'The bank details you provided has been successfully added to your Bundlegram account.',
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