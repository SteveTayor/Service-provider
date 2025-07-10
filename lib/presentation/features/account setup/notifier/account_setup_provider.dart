import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
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
  bool bvnLinked = false;

  /// Compute which steps are complete based on the global profile
  List<AccountSetupStep> get steps {
    final profileAsync = _ref.watch(globalProvider).profile;
    bool emailVerified = false;
    bool basicInfo = false;
    bool bankAdded = false;

    if (profileAsync is AsyncData<ProfileResponse?>) {
      final p = profileAsync.value?.data!;
      emailVerified = p!.emailVerifiedAt != null;
      basicInfo = (p.firstName?.isNotEmpty ?? false) &&
          (p.lastName?.isNotEmpty ?? false) &&
          p.dob != null &&
          (p.gender?.toString().isNotEmpty ?? false) &&
          (p.address?.toString().isNotEmpty ?? false);
      bvnLinked = p.bvn?.toString().isNotEmpty ?? false;
      bankAdded = (p.bankName?.toString().isNotEmpty ?? false) &&
          (p.accountNumber?.toString().isNotEmpty ?? false);
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
        bottomSheet: const VerifyEmailWidget(),
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
    final profile = _ref.read(globalProvider).profile.value?.data;

    // Allow email verification anytime
    if (step.title.toLowerCase().contains('verify email')) {
      if (step.isBottomSheet && step.bottomSheet != null) {
        context.showBottomSheet(child: step.bottomSheet!);
      } else if (step.route != null) {
        context.push(step.route!);
      }
      return;
    }

    final isBvnLinked = (profile?.bvn?.isNotEmpty ?? false);

    // Prevent navigation if BVN not linked, except for Verify Email and Link BVN
    if (!bvnLinked &&
        step.title != 'Link your BVN' &&
        step.title != 'Verify email') {
      context.showErrorSnackBar("Please link your BVN before continuing.");
      return;
    }

    // Navigate or show bottom sheet if BVN is linked or if it's the BVN step
    if (step.isBottomSheet && step.bottomSheet != null) {
      context.showBottomSheet(child: step.bottomSheet!);
    } else if (step.route != null) {
      context.push(step.route!);
    }
  }

  /// Handle: function to check if the accountsetup is complete to remove from the carousel in dashboard
  bool get isAccountSetupComplete {
    final profileAsync = _ref.watch(globalProvider).profile;
    if (profileAsync is AsyncData<ProfileResponse?>) {
      final p = profileAsync.value?.data!;
      return (p?.emailVerifiedAt != null) &&
          (p?.firstName?.isNotEmpty == true) &&
          (p?.lastName?.isNotEmpty == true) &&
          (p?.dob != null) &&
          (p?.gender != null) &&
          (p?.address != null) &&
          (p?.bvn != null) &&
          (p?.bankName != null) &&
          (p?.accountNumber != null);
    }
    return false;
  }
}
