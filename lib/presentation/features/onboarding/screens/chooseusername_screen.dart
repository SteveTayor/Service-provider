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
  const ChooseUsernameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(chooseUsernameProvider);
    final ctrl = ref.read(chooseUsernameProvider);
    return BundlegramScaffold(
      appBar: const BundlegramAppbar(),
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
              children: [
                AppTextField(
                  controller: ctrl.usernameController,
                  hintText: 'Choose a username',
                  suffixIcon: provider.isChecking
                      ? SizedBox(
                          height: 20.h,
                          width: 20.h,
                          child: AppLoader(
                              size: 20, color: AppColors.primaryColor),
                        )
                      : AppSvgIcon(
                          path: provider.isAvailable
                              ? Assets.svgs.check
                              : Assets.svgs.closeCircle,
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
