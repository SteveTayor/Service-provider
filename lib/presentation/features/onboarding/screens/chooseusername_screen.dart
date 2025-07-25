import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/onboarding/notifier/choose_username_notifier.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_form.dart';
import 'package:bundlegram/presentation/general_widget/app_loader.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ChooseUsernameScreen extends ConsumerWidget {
  final bool fromLogin;

  const ChooseUsernameScreen({super.key, this.fromLogin = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(chooseUsernameProvider);
    final ctrl = ref.read(chooseUsernameProvider);
    // Setting the fromLogin flag in the provider after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.setFromLogin(fromLogin);
    });

    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        showBackButton: false,
      ),
      sidePadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
      body: Column(
        children: [
          Column(
            children: [
              Text(
                'Choose username',
                style: context.textTheme.titleMedium,
              ),
              10.verticalSpace,
              Text(
                'Add a username to personalize your account.',
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall!.copyWith(
                  color: AppColors.grey33,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          40.verticalSpace,
          Expanded(
            child: AppForm(
              isExpanded: false,
              formKey: ctrl.formKey,
              isActive: provider.isValid &&
                  provider.isAvailable &&
                  !provider.isSubmitting,
              onPressed: () => ctrl.submit(context),
              buttonText: provider.isSubmitting
                  ? 'Submitting...'
                  : 'Complete account set-up',
              extraWidget: Container(
                child: !provider.isChecking && provider.errorMessage != null
                    ? Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Text(
                          provider.errorMessage ??
                              'This username already exists',
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),
                      )
                    : SizedBox(),
              ),
              children: [
                AppTextField(
                  controller: ctrl.usernameController,
                  hintText: 'Choose a username',
                  suffixIcon: provider.isChecking
                      ? SizedBox(
                          height: 20.h,
                          width: 20.h,
                          child: AppLoaderSpinnerKit(
                              size: 20, color: AppColors.primaryColor),
                        )
                      : AppSvgIcon(
                          path: provider.usernameController.text.isEmpty
                              ? Assets.svgs.tickCircle // Initial state
                              : provider.isAvailable
                                  ? Assets.svgs.check // Available
                                  : Assets.svgs.closeCircle, // Taken
                          fit: BoxFit.scaleDown,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
