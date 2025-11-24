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
import 'package:bundlegram/presentation/general_widget/app_form.dart';
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
//             SizedBox(height: 18.h),
//             Text(profileinfoProv.email!).withContainer(
//               width: context.width,
//               color: AppColors.greyD0.withOpacity(0.3),
//               padding: context.symmetricPadding(16, 12),
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: AppColors.greyD0),
//             ),
//           ] else ...[
//             const AppTextField(hintText: 'First Name'),
//             SizedBox(height: 18.h),
//             const AppTextField(hintText: 'Last Name'),
//             SizedBox(height: 18.h),
//             const AppTextField(hintText: 'Email'),
//             SizedBox(height: 18.h),
//             const AppTextField(hintText: 'Phone Number'),
//           ],
//           SizedBox(height: 18.h),
//           const AppDropdown(
//             title: 'Gender',
//             options: ['Male', 'Female'],
//           ),
//           SizedBox(height: 18.h),
//           const AppTextField(hintText: 'Address'),
//           SizedBox(height: 18.h),
//           const AppDatetextfield(title: 'Date of birth'),
//           SizedBox(height: 18.h),
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

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

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
    final globalUserProvider = ref.watch(globalProvider).profile;
    final profileProv = globalUserProvider.value?.data;

    // Configure title based on action
    final titleText = userAction.isCreate
        ? 'Add Basic Information'
        : 'Update Account Details';

    String phoneNumber = notifier.phone.text;
    String localPhoneNumber =
        phoneNumber.startsWith('+234') ? phoneNumber.substring(4) : phoneNumber;

    // If it's 11 digits and starts with "0", drop the leading "0"
    if (localPhoneNumber.length == 11 && localPhoneNumber.startsWith('0')) {
      localPhoneNumber = localPhoneNumber.substring(1);
    }

    // Put back into controller
    notifier.phone.text = localPhoneNumber;

    String fullName = profileProv!.name!;
    final bvnLinked = profileProv.bvn?.toString().isNotEmpty ?? false;

    List<String> parts = fullName.trim().split(' ');
    String firstName = parts.isNotEmpty ? parts.first : '';
    String lastName = parts.length > 1 ? parts.last : '';

    // Set values into the controllers
    notifier.firstName.text = profileProv.firstName!;

    // Helpers
    bool hasGender = (profileProv.gender?.toString().isNotEmpty ?? false);
    bool hasAddress = (profileProv.address?.toString().isNotEmpty ?? false);
    bool hasDob = (profileProv.dob != null);

    // Form fields data for cleaner animation mapping
    final formFields = [
      {
        'widget': AppTextField(
          label: "First Name",
          controller: notifier.firstName,
          hintText: 'First Name',
          validateFunction: notifier.validateName,
          readOnly: true,
          isFilled: true,
          backgroundColor: AppColors.greyD0.withOpacity(0.3),
        ),
        'delay': 0,
      },
      {
        'widget': AppTextField(
          label: 'Last Name',
          controller: notifier.lastName,
          hintText: 'Last Name',
          validateFunction: notifier.validateName,
          readOnly: true,
          isFilled: true,
          backgroundColor: AppColors.greyD0.withOpacity(0.3),
        ),
        'delay': 100,
      },
      {
        'widget': AppTextField(
          label: "Email",
          controller: notifier.email,
          hintText: 'Email',
          readOnly: true,
          isFilled: true,
          backgroundColor: AppColors.greyD0.withOpacity(0.3),
        ),
        'delay': 200,
      },
      {
        'widget': AppTextField(
          label: 'Phone Number',
          controller: notifier.phone,
          hintText: 'Phone Number',
          readOnly: !userAction.isCreate,
          isFilled: !userAction.isCreate,
          backgroundColor: AppColors.greyD0.withOpacity(0.3),
          prefixIcon: Padding(
            padding: context.symmetricPadding(16, 0),
            child: Text('+234', style: context.textTheme.bodyMedium),
          ),
          validateFunction: notifier.validatePhone,
          onChange: (value) {
            notifier.phone.text = value;
          },
        ),
        'delay': 300,
      },
      {
        'widget': AppDropdown(
          title: provider.gender != "" ? provider.gender : "Gender",
          options: const ['Male', 'Female'],
          selected: provider.gender,
          onChanged: notifier.setGender,
          isFilled:
              userAction.isCreate ? false : (bvnLinked ? hasGender : false),
        ),
        'delay': 400,
      },
      {
        'widget': AppTextField(
          label: 'Address',
          controller: notifier.address,
          hintText: 'Enter Address',
          isFilled:
              userAction.isCreate ? false : (bvnLinked ? hasAddress : false),
          readOnly: bvnLinked,
          backgroundColor: AppColors.greyD0.withOpacity(0.3),
          validateFunction: notifier.validateNotEmpty,
        ),
        'delay': 500,
      },
      {
        'widget': AppDatetextfield(
          controller: notifier.dob,
          title: '',
          hintText: 'DD/MM/YYYY',
          isFilled: userAction.isCreate ? false : (bvnLinked ? hasDob : false),
          readOnly: bvnLinked,
          validator: notifier.validateDate,
          onTap: () => notifier.pickDob(context),
        ),
        'delay': 600,
      },
    ];

    return BundlegramScaffold(
      resizeToAvoidBottomInset: true,
      appBar: BundlegramAppbar(titleText: titleText),
      body: Form(
        key: provider.formKey,
        child: AnimationLimiter(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
            itemCount: formFields.length + 1, // +1 for the submit button
            itemBuilder: (context, index) {
              if (index == formFields.length) {
                // Submit button with its own animation
                return AnimationConfiguration.staggeredList(
                  position: index,
                  delay: const Duration(milliseconds: 100),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Container(
                        margin: EdgeInsets.only(top: 32.h),
                        child: ScaleAnimation(
                          scale: 0.8,
                          child: Opacity(
                            opacity: userAction.isCreate ? 1 : 0.9,
                            child: BundlegramButton(
                              isEnabled: provider.loading
                                  ? false
                                  : userAction.isCreate ||
                                      (!hasGender || !hasAddress || !hasDob),
                              text: userAction.isCreate ? 'Submit' : 'Update',
                              onPressed: provider.loading
                                  ? null
                                  : () async {
                                      await provider.submit(context);
                                    },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }

              final field = formFields[index];
              return AnimationConfiguration.staggeredList(
                position: index,
                delay: Duration(milliseconds: field['delay'] as int),
                child: SlideAnimation(
                  verticalOffset: 30.0,
                  child: FadeInAnimation(
                    duration: const Duration(milliseconds: 600),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 18.h),
                      child: field['widget'] as Widget,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
