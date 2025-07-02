import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/data/models/profile/profile_response.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/widgets/verifyemail_widget.dart';
import 'package:bundlegram/presentation/features/account%20setup/state/account_setup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final accountSetupProvider = ChangeNotifierProvider<AccountSetupProvider>(
  (ref) => AccountSetupProvider(ref),
);

class AccountSetupProvider extends ChangeNotifier {
  final Ref _ref;

  AccountSetupProvider(this._ref);

  /// Compute which steps are complete based on the global profile
  List<AccountSetupStep> get steps {
    final profileAsync = _ref.watch(globalProvider).profile;
    bool emailVerified = false;
    bool basicInfo = false;
    bool bvnLinked = false;
    bool bankAdded = false;

    if (profileAsync is AsyncData<ProfileResponse>) {
      final p = profileAsync.value.data!;
      emailVerified = p.emailVerifiedAt != null;
      basicInfo = (p.firstName?.isNotEmpty == true) &&
          (p.lastName?.isNotEmpty == true) &&
          p.dob != null &&
          (p.gender?.isNotEmpty == true) &&
          (p.address?.isNotEmpty == true);
      bvnLinked = p.bvn?.isNotEmpty == true;
      bankAdded = (p.bankName?.isNotEmpty == true) &&
          (p.accountNumber?.isNotEmpty == true);
    }

    return [
      AccountSetupStep(
        asset: Assets.svgs.createaccount,
        title: 'Create account',
        label: 'Create a Bundlegram account',
        done: true, // always done
      ),
      AccountSetupStep(
        asset: Assets.svgs.verifyemail,
        title: 'Verify email',
        label: 'Verify your email for security purpose',
        done: emailVerified,
        isBottomSheet: true,
        bottomSheet: const VerifyemailWidget(),
      ),
      AccountSetupStep(
        asset: Assets.svgs.addbasicinfo,
        title: 'Add basic information',
        label: 'Let’s know more about you',
        done: basicInfo,
        route: RouteConstants.addbasicinformation,
      ),
      AccountSetupStep(
        asset: Assets.svgs.linkyourbvn,
        title: 'Link your BVN',
        label: 'Link BVN to be able to withdraw',
        done: bvnLinked,
        route: RouteConstants.linkyourbvn,
      ),
      AccountSetupStep(
        asset: Assets.svgs.addbankdetail,
        title: 'Add bank details',
        label: 'Save bank details to withdraw later',
        done: bankAdded,
        route: RouteConstants.addbankdetail,
      ),
    ];
  }

  /// Handle tap on a step: either show a bottom sheet or navigate
  void onStepTap(AccountSetupStep step, BuildContext context) {
    if (step.isBottomSheet && step.bottomSheet != null) {
      context.showBottomSheet(child: step.bottomSheet!);
    } else if (step.route != null) {
      context.push(step.route!);
    }
  }
}
