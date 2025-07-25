import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/presentation/features/setting/provider/change_password_notifier.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_form.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChangepasswordScreen extends ConsumerWidget {
  const ChangepasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(changePasswordProvider);

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
              onPressed: () {
                controller.validateForm(context);
              },
              buttonText: 'Update password',
              formKey: controller.formKey,
              children: [
                AppTextField(
                  controller: controller.currentPasswordController,
                  obscureText: true,
                  hintText: 'Current password',
                  // validateFunction: Validators.required(),
                ),
                AppTextField(
                  controller: controller.newPasswordController,
                  obscureText: true,
                  hintText: 'New Password',
                  validateFunction: Validators.password(),
                ),
                AppTextField(
                  controller: controller.confirmPasswordController,
                  obscureText: true,
                  hintText: 'New Password again',
                  validateFunction: Validators.confirmPass(
                      controller.newPasswordController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
