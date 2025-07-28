import 'dart:async';

import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/presentation/features/setting/provider/create_pin_provider.dart';
import 'package:bundlegram/presentation/features/setting/screens/pin_screen.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transaction_success_widget.dart';
import 'package:bundlegram/presentation/features/wallet/screen/enterpin_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_form.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChangeaccountpinScreen extends ConsumerWidget {
  const ChangeaccountpinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pinCtrl = ref.watch(pinControllerProvider);

    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        titleText: 'Enter your password',
        showBackButton: true,
      ),
      body: Column(
        children: [
          Flexible(
            child: AppForm(
              isExpanded: false,
              isActive: pinCtrl.isFormValid,
              formKey: pinCtrl.formKey,
              onPressed: () async {
                final error = await pinCtrl.validatePasswordAsync();
                if (error != null) {
                  context.showErrorSnackBar(error);
                  return;
                }

                unawaited(Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => EnterPinScreen(
                      isChangedAccountPin: true,
                      onVerified: (pin) {
                        // pinCtrl.start(PinScreenMode.create, initialPin: pin,
                        //     onComplete: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          context.go(RouteConstants.pinScreen);
                        });
                        // });
                      },
                    ),
                  ),
                ));
              },
              buttonText: 'Continue',
              children: [
                AppTextField(
                  controller: pinCtrl.passwordController,
                  obscureText: true,
                  hintText: 'Password',
                  onChange: (val) => pinCtrl.validateForm(),
                  validateFunction: pinCtrl.validatePassword,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
