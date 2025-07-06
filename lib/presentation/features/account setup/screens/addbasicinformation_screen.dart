import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/presentation/features/account%20setup/notifier/basicinfo_provider.dart';
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

// class AddbasicinformationScreen extends ConsumerWidget {
//   const AddbasicinformationScreen({
//     super.key,
//     this.userAction = UserAction.create,
//   });
//   final UserAction userAction;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final global = ref.watch(globalProvider).profile;
//     final profileinfoProv = global.value?.data;
//     return BundlegramScaffold(
//       appBar: BundlegramAppbar(
//         titleText: userAction.isCreate
//             ? 'Add basic information'
//             : 'Update account details',
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(8.w),
//         children: [
//           if (userAction.isCreate) ...[
//             Text(profileinfoProv!.name!).withContainer(
//               width: context.width,
//               color: AppColors.greyD0.withOpacity(0.3),
//               padding: context.symmetricPadding(16, 12),
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: AppColors.greyD0),
//             ),
//             SizedBox(height: 24.h),
//             Text(profileinfoProv.email!).withContainer(
//               width: context.width,
//               color: AppColors.greyD0.withOpacity(0.3),
//               padding: context.symmetricPadding(16, 12),
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: AppColors.greyD0),
//             ),
//           ] else ...[
//             const AppTextField(hintText: 'First Name'),
//             SizedBox(height: 24.h),
//             const AppTextField(hintText: 'Last Name'),
//             SizedBox(height: 24.h),
//             const AppTextField(hintText: 'Email'),
//             SizedBox(height: 24.h),
//             const AppTextField(hintText: 'Phone Number'),
//           ],
//           SizedBox(height: 24.h),
//           const AppDropdown(
//             title: 'Gender',
//             options: ['Male', 'Female'],
//           ),
//           SizedBox(height: 24.h),
//           const AppTextField(hintText: 'Address'),
//           SizedBox(height: 24.h),
//           const AppDatetextfield(title: 'Date of birth'),
//           SizedBox(height: 24.h),
//           BundlegramButton(
//             text: '${userAction.isCreate ? 'Submit' : 'Update'} details',
//             onPressed: () {
//               if (userAction.isCreate) {
//                 // Create user
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (ctx) => const TransactionSuccessful(
//                       isBasicInfo: true,
//                       title: 'Basic information added!',
//                       subTitle:
//                           'The basic information you provided has been successfully added to your Bundlegram account.',
//                     ),
//                   ),
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

class AddBasicInformationScreen extends ConsumerWidget {
  final UserAction userAction;
  const AddBasicInformationScreen({
    Key? key,
    this.userAction = UserAction.create,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(basicInfoProvider(userAction));
    final notifier = ref.read(basicInfoProvider(userAction));

    // Configure title based on action
    final titleText = userAction.isCreate
        ? 'Add Basic Information'
        : 'Update Account Details';
    String phoneNumber = notifier.phone.text; // e.g., "+23490891272181"
    String localPhoneNumber =
        phoneNumber.startsWith('+234') ? phoneNumber.substring(4) : phoneNumber;
    notifier.phone.text = localPhoneNumber;

    return BundlegramScaffold(
      appBar: BundlegramAppbar(titleText: titleText),
      body: Form(
        key: provider.formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          children: [
            AppTextField(
              controller: notifier.firstName,
              hintText: 'First Name',
              validateFunction: notifier.validateName,
              readOnly: true,
              isFilled: true,
              backgroundColor: AppColors.greyD0.withOpacity(0.3),
            ),
            SizedBox(height: 24.h),
            AppTextField(
              controller: notifier.lastName,
              hintText: 'Last Name',
              validateFunction: notifier.validateName,
              isFilled: true,
              readOnly: userAction.isCreate ? false : true,
              backgroundColor: AppColors.greyD0.withOpacity(0.3),
            ),
            SizedBox(height: 24.h),
            AppTextField(
              controller: notifier.email,
              hintText: 'Email',
              readOnly: true,
              isFilled: true,
              backgroundColor: AppColors.greyD0.withOpacity(0.3),
            ),
            SizedBox(height: 24.h),
            AppTextField(
              controller: notifier.phone,
              hintText: 'Phone Number',
              prefixIcon: Padding(
                padding: context.symmetricPadding(16, 0),
                child: Text('+234', style: context.textTheme.bodyMedium),
              ),
              validateFunction: notifier.validatePhone,
              onChange: (value) {
                // Ensure the controller holds only the local part
                notifier.phone.text = value;
              },
            ),
            SizedBox(height: 24.h),
            AppDropdown(
              title: provider.gender != "" ? provider.gender : "Gender",
              options: const ['Male', 'Female'],
              selected: provider.gender,
              onChanged: notifier.setGender,
            ),
            SizedBox(height: 24.h),
            AppTextField(
              controller: notifier.address,
              hintText: 'Address',
              validateFunction: notifier.validateNotEmpty,
            ),
            SizedBox(height: 24.h),
            AppDatetextfield(
              controller: notifier.dob,
              title: 'Date of birth',
              hintText: 'DD/MM/YYYY',
              validator: notifier.validateDate,
              onTap: () => notifier.pickDob(context),
            ),
            SizedBox(height: 32.h),
            BundlegramButton(
              text: userAction.isCreate ? 'Submit' : 'Update',
              onPressed: provider.loading
                  ? null
                  : () async {
                      await provider.submit(context);
                    },
            ),
          ],
        ),
      ),
    );
  }
}
