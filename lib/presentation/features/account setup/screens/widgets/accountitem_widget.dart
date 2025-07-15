import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/setting/screens/logout_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AccountitemWidget extends ConsumerWidget {
  const AccountitemWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalUserProvider = ref.watch(globalProvider).profile;
    final profileProv = globalUserProvider.value?.data;

    Widget buildRowWidget(
      String asset,
      String title, {
      Color? titleColor,
      VoidCallback? onPressed,
    }) {
      return AppListTile(
        onPressed: onPressed ?? () {},
        assetPath: asset,
        titleColor: titleColor,
        trailingAsset: Assets.svgs.arrowFowardIos,
        title: title,
      ).withContainer(
        padding: context.symmetricPadding(0, 24),
        border: const Border(bottom: BorderSide(color: Color(0xffECECEC))),
      );
    }

    return Column(
      children: [
        buildRowWidget(
          onPressed: () => context.push(RouteConstants.updatebasicinformation),
          Assets.svgs.userIdentifierCardStreamlineCore,
          'Update account details',
        ),
        if (profileProv?.userType != "agent")
          buildRowWidget(
            Assets.svgs.uploadCircleStreamlineCore,
            onPressed: () => context.push(RouteConstants.becomeagent),
            'Become an agent',
          ),
        buildRowWidget(
          onPressed: () => context.push(RouteConstants.withdrawalAccount),
          Assets.svgs.walletAdd1,
          'Withdrawal accounts',
        ),
        buildRowWidget(
          Assets.svgs.starBadgeStreamlineCore,
          'Rate Bundlegram',
        ),
        buildRowWidget(
          Assets.svgs.customerSupport1StreamlineCore,
          onPressed: () => context.push(RouteConstants.helpSupport),
          'Help & Support',
        ),
        buildRowWidget(
          Assets.svgs.heartRewardSocialRatingMediaHeartItLikeFavoriteLove,
          'Share Bundlegram',
        ),
        buildRowWidget(
          Assets.svgs.shiftKeyShiftUpArrowKeyboard,
          'Update app',
        ),
        buildRowWidget(
          onPressed: () => context.showBottomSheet(child: const LogoutWidget()),
          titleColor: AppColors.primaryColor,
          Assets.svgs.logout1StreamlineCore,
          'Log out',
        ),
      ],
    );
  }
}
