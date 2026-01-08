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


// class AddBasicInformationScreen extends ConsumerWidget {
//   final UserAction userAction;
//   const AddBasicInformationScreen({
//     Key? key,
//     this.userAction = UserAction.create,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final provider = ref.watch(basicInfoProvider(userAction));
//     final notifier = provider;

//     final profileAsync = ref.watch(globalProvider).profile;

//     // 🔒 Handle loading / error states FIRST (very important)
//     if (profileAsync.isLoading) {
//       return const BundlegramScaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
class AddBasicInformationScreen extends ConsumerStatefulWidget {
  final UserAction userAction;
  const AddBasicInformationScreen({
    Key? key,
    this.userAction = UserAction.create,
  }) : super(key: key);

  @override
  ConsumerState<AddBasicInformationScreen> createState() =>
      _AddBasicInformationScreenState();
}

class _AddBasicInformationScreenState
    extends ConsumerState<AddBasicInformationScreen> {
  bool _didInitialFetch = false;
  
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _didInitialFetch) return;
      _didInitialFetch = true;

      final profileAsync = ref.read(globalProvider).profile;
      final profile = profileAsync.value?.data;

      if (profile != null) {
        final provider = ref.read(basicInfoProvider(widget.userAction));
        debugPrint('[WithdrawalScreen] Initial fetch');
        provider.hydrateFromProfile(profile);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(basicInfoProvider(widget.userAction));
    final notifier = provider;
    final profileAsync = ref.watch(globalProvider).profile;

    if (profileAsync.isLoading) {
      return const BundlegramScaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final profile = profileAsync.value?.data;
    if (profile == null) {
      return const BundlegramScaffold(body: SizedBox());
    }

    final titleText = widget.userAction.isCreate
        ? 'Add Basic Information'
        : 'Update Account Details';

    final bvnLinked = profile.bvn?.toString().isNotEmpty ?? false;

    final hasGender = (profile.gender?.isNotEmpty ?? false) as bool;
    final hasAddress = (profile.address?.isNotEmpty ?? false) as bool;
    final hasDob = (profile.dob != null) as bool;

    // Form fields data for cleaner rendering
    final formFields = [
      AppTextField(
        label: "First Name",
        controller: notifier.firstName,
        hintText: 'First Name',
        validateFunction: notifier.validateName,
        readOnly: true,
        isFilled: true,
        backgroundColor: AppColors.greyD0.withOpacity(0.3),
      ),
      AppTextField(
        label: 'Last Name',
        controller: notifier.lastName,
        hintText: 'Last Name',
        validateFunction: notifier.validateName,
        readOnly: true,
        isFilled: true,
        backgroundColor: AppColors.greyD0.withOpacity(0.3),
      ),
      AppTextField(
        label: "Email",
        controller: notifier.email,
        hintText: 'Email',
        readOnly: true,
        isFilled: true,
        backgroundColor: AppColors.greyD0.withOpacity(0.3),
      ),
      AppTextField(
        label: 'Phone Number',
        controller: notifier.phone,
        hintText: 'Phone Number',
        readOnly: !widget.userAction.isCreate,
        isFilled: !widget.userAction.isCreate,
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
      AppDropdown(
        title: provider.gender != "" ? provider.gender : "Gender",
        options: const ['Male', 'Female'],
        selected: provider.gender,
        onChanged: notifier.setGender,
        isFilled: widget.userAction.isCreate
            ? false
            : (bvnLinked ? hasGender : false) as bool,
      ),
      AppTextField(
        label: 'Address',
        controller: notifier.address,
        hintText: 'Enter Address',
        isFilled: widget.userAction.isCreate
            ? false
            : (bvnLinked ? hasAddress : false) as bool,
        readOnly: bvnLinked,
        backgroundColor: AppColors.greyD0.withOpacity(0.3),
        validateFunction: notifier.validateNotEmpty,
      ),
      AppDatetextfield(
        controller: notifier.dob,
        title: '',
        hintText: 'DD/MM/YYYY',
        isFilled:
            widget.userAction.isCreate ? false : (bvnLinked ? hasDob : false),
        readOnly: bvnLinked,
        validator: notifier.validateDate,
        onTap: () => notifier.pickDob(context),
      ),
    ];

    return BundlegramScaffold(
      resizeToAvoidBottomInset: true,
      appBar: BundlegramAppbar(titleText: titleText),
      body: Form(
        key: provider.formKey,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
          itemCount: formFields.length + 1, // +1 for the submit button
          itemBuilder: (context, index) {
            if (index == formFields.length) {
              // Submit button
              return Container(
                margin: EdgeInsets.only(top: 32.h),
                child: Opacity(
                  opacity: widget.userAction.isCreate ? 1 : 0.9,
                  child: BundlegramButton(
                    isEnabled: provider.loading
                        ? false
                        : widget.userAction.isCreate ||
                            (!hasGender || !hasAddress || !hasDob),
                    text: widget.userAction.isCreate
                        ? 'Submit'
                        : 'Update',
                    onPressed: provider.loading
                        ? null
                        : () async {
                            await provider.submit(context);
                          },
                  ),
                ),
              );
            }

            return Container(
              margin: EdgeInsets.only(bottom: 18.h),
              child: formFields[index],
            );
          },
        ),
      ),
    );
  }
}