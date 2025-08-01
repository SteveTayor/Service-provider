// lib/presentation/features/setting/screens/change_password_screen.dart
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
                  hintText: 'New Password',
                  label: 'New Password',
                  validateFunction: Validators.password(),
                  suffixIcon: GestureDetector(
                    onTap: controller.toggleNewPasswordVisibility,
                    child: Icon(
                      controller.showNewPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.grey33,
                      size: 24,
                    ),
                  ),
                ),
                AppTextField(
                  controller: controller.confirmPasswordController,
                  obscureText: controller.showConfirmPassword,
                  hintText: 'Confirm New Password',
                  label: 'Confirm New Password',
                  validateFunction: Validators.confirmPass(
                    controller.newPasswordController.text,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: controller.toggleConfirmPasswordVisibility,
                    child: Icon(
                      controller.showConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.grey33,
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
