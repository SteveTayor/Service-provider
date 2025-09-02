import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/presentation/features/setting/provider/change_password_notifier.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_form.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangepasswordScreen extends ConsumerStatefulWidget {
  final String email;
  const ChangepasswordScreen({super.key, required this.email});

  @override
  ConsumerState<ChangepasswordScreen> createState() =>
      _ChangepasswordScreenState();
}

class _ChangepasswordScreenState extends ConsumerState<ChangepasswordScreen> {
  @override
  void initState() {
    super.initState();

    // ✅ Use ref.read instead of ref.watch here
    final controller = ref.read(changePasswordProvider(widget.email));
    controller.confirmPasswordController.addListener(() {
      controller.formKey.currentState?.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(changePasswordProvider(widget.email));

    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        titleText: 'Change password',
      ),
      body: Column(
        children: [
          Flexible(
            child: AppForm(
              isExpanded: false,
              isActive: controller.isFormValid,
              onPressed: () => controller.submit(context),
              buttonText:
                  controller.isLoading ? 'Updating...' : 'Update password',
              formKey: controller.formKey,
              children: [
                AppTextField(
                  controller: controller.currentPasswordController,
                  obscureText: controller.showCurrentPassword,
                  hintText: 'Current password',
                  label: 'Current password',
                  suffixIcon: GestureDetector(
                    onTap: controller.toggleCurrentPasswordVisibility,
                    child: Icon(
                      controller.showCurrentPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.grey33,
                      size: 24,
                    ),
                  ),
                ),
                AppTextField(
                  controller: controller.newPasswordController,
                  obscureText: controller.showNewPassword,
                  hintText: controller.enableNewPasswordFields
                      ? 'New Password'
                      : 'Enter current password first',
                  label: 'New Password',
                  enabled: controller
                      .enableNewPasswordFields, // ✅ Use the getter from controller
                  validateFunction: controller.enableNewPasswordFields
                      ? Validators.password()
                      : null,
                  suffixIcon: GestureDetector(
                    onTap: controller.enableNewPasswordFields
                        ? controller.toggleNewPasswordVisibility
                        : null,
                    child: Icon(
                      controller.showNewPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: controller.enableNewPasswordFields
                          ? AppColors.grey33
                          : AppColors.greyb3,
                      size: 24,
                    ),
                  ),
                ),
                AppTextField(
                  controller: controller.confirmPasswordController,
                  obscureText: controller.showConfirmPassword,
                  hintText: controller.enableNewPasswordFields
                      ? 'Confirm New Password'
                      : 'Enter current password first',
                  label: 'Confirm New Password',
                  onChange: (value) => controller.validateForm(),
                  enabled: controller
                      .enableNewPasswordFields, // ✅ Use the getter from controller
                  validateFunction: controller.enableNewPasswordFields
                      ? Validators.confirmPass(
                          controller.newPasswordController.text)
                      : null,
                  suffixIcon: GestureDetector(
                    onTap: controller.enableNewPasswordFields
                        ? controller.toggleConfirmPasswordVisibility
                        : null,
                    child: Icon(
                      controller.showConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: controller.enableNewPasswordFields
                          ? AppColors.grey33
                          : AppColors.greyb3,
                      size: 24,
                    ),
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
