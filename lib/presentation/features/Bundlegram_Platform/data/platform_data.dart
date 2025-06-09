// ignore_for_file: inference_failure_on_instance_creation, inference_failure_on_function_invocation

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/platformproduct_screen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformbills_widget.dart';
import 'package:bundlegram/presentation/features/transaction/screens/transaction_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_listtile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlatFormData {
  static final List<String> advert = [
    Assets.svgs.accountsetup,
    Assets.svgs.bundlegramagent,
    Assets.svgs.completesetup,
  ];
  static List<VoidCallback> advertFunction(BuildContext context) => [
        () {
          context.push(RouteConstants.accountSetup);
        },
        () {
          context.push(RouteConstants.becomeagent);
        },
        () {
          context.push(RouteConstants.accountSetup);
        },
      ];

  static final List<Widget> payBillWidget = [
    Builder(
      builder: (context) {
        return AppListTile(
          assetPath: Assets.svgs.betting,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PlatformproductScreen(
                  serviceType: PlatformProductType.betting,
                ),
              ),
            );
          },
          title: 'Betting',
        );
      },
    ),
    Builder(
      builder: (context) {
        return AppListTile(
          assetPath: Assets.svgs.electricity,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PlatformproductScreen(
                  serviceType: PlatformProductType.electricity,
                ),
              ),
            );
          },
          title: 'Electricity',
        );
      },
    ),
    Builder(
      builder: (context) {
        return AppListTile(
          assetPath: Assets.svgs.ePin,
          title: 'E-pin voucher',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PlatformproductScreen(
                  serviceType: PlatformProductType.ePinVoucher,
                ),
              ),
            );
          },
        );
      },
    ),
    Builder(
      builder: (context) {
        return AppListTile(
          assetPath: Assets.svgs.educationSvg,
          title: 'Education',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PlatformproductScreen(
                  serviceType: PlatformProductType.education,
                ),
              ),
            );
          },
        );
      },
    ),
    Builder(
      builder: (context) {
        return AppListTile(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PlatformproductScreen(
                  serviceType: PlatformProductType.cableTv,
                ),
              ),
            );
          },
          assetPath: Assets.svgs.cableTv,
          title: 'Cable Tv',
        );
      },
    ),
    Builder(
      builder: (context) {
        return AppListTile(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PlatformproductScreen(
                    serviceType: PlatformProductType.internetServices,
                  ),
                ),
              );
            },
            assetPath: Assets.svgs.internetservice,
            title: 'Internet Provider');
      },
    ),
  ];

  static final List<Widget> serviceProviderWidget = [
    AppListTile(
      showSubtitle: true,
      imagePath: Assets.images.mtn.path,
      onPressed: () {},
      title: 'MTN Nigeria',
      subtitle: '@mtnng',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.airtel,
      onPressed: () {},
      title: 'Airtel Nigeria',
      subtitle: '@airtelnigeria',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.glo,
      onPressed: () {},
      title: 'Glo Nigeria',
      subtitle: '@globacomlimited',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.a9mobile,
      onPressed: () {},
      title: '9mobile Nigeria',
      subtitle: '@9mobileng',
    ),
  ];

  static final List<Widget> educationProviderWidget = educationProvider.values
      .map((provider) => AppListTile(
            showSubtitle: true,
            imagePath: provider.imagePath,
            onPressed: () {},
            title: '${provider.name.toUpperCase()} ',
            subtitle: '${provider.name}',
          ))
      .toList();
  static final List<Widget> electricityProviderWidget =
      electricityProvider.values
          .map((provider) => AppListTile(
                showSubtitle: true,
                imagePath: provider.imagePath,
                onPressed: () {},
                title: '${provider.name.toUpperCase()} ',
                subtitle: '${provider.name.initials.toUpperCase()}',
              ))
          .toList();

  static final List<Widget> internetServiceProviderWidget =
      internetServiceProvider.values
          .map((provider) => AppListTile(
                showSubtitle: true,
                imagePath: provider.imagePath,
                onPressed: () {},
                title: '${provider.name.toUpperCase()} ',
                subtitle: '${provider.name.initials.toUpperCase()}',
              ))
          .toList();

  static final List<Widget> cableTvProviderWidget = cableTvProvider.values
      .map((provider) => AppListTile(
            showSubtitle: true,
            imagePath: provider.imagePath,
            onPressed: () {},
            title: '${provider.name.toUpperCase()} ',
            subtitle: '${provider.name.initials.toUpperCase()}',
          ))
      .toList();
  static final List<Widget> bettingProviders = [
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.betnaija,
      onPressed: () {},
      title: 'Bet9ja',
      subtitle: 'Fund wallet',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.a1xbet,
      onPressed: () {},
      title: '1xbet',
      subtitle: 'Fund wallet',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.bangbet,
      onPressed: () {},
      title: 'Bangbet',
      subtitle: 'Fund wallet',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.nairabetLogo,
      onPressed: () {},
      title: 'NairaBet',
      subtitle: 'Make Deposit',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.betway,
      onPressed: () {},
      title: 'Betway',
      subtitle: 'Fund your player account',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.superbet,
      onPressed: () {},
      title: 'SuperBet',
      subtitle: 'Fund wallet',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.merrybet,
      onPressed: () {},
      title: 'MerryBet',
      subtitle: 'Fund wallet',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.betlandLogo,
      onPressed: () {},
      title: 'BetLand',
      subtitle: 'Fund Wallet',
    ),
  ];
  static final List<Widget> platformDrawerItem = [
    Builder(
      builder: (context) {
        return AppListTile(
          onPressed: () {
            context.pop();
          },
          assetPath: Assets.svgs.overview,
          title: 'Overview',
        );
      },
    ),
    Builder(
      builder: (context) {
        return AppListTile(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PlatformproductScreen(
                  serviceType: PlatformProductType.mobileData,
                ),
              ),
            );
          },
          assetPath: Assets.svgs.buydata,
          title: 'Buy data',
        );
      },
    ),
    Builder(
      builder: (context) {
        return AppListTile(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PlatformproductScreen(
                    serviceType: PlatformProductType.airtime,
                  ),
                ),
              );
            },
            assetPath: Assets.svgs.simcard21,
            title: 'Buy airtime');
      },
    ),
    Builder(
      builder: (context) {
        return AppListTile(
            onPressed: () {
              context
                ..pop()
                ..showBottomSheet(
                  child: const PlatformbillsWidget(),
                );
            },
            assetPath: Assets.svgs.paybills,
            title: 'Pay bills');
      },
    ),
    Builder(
      builder: (context) {
        return AppListTile(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TransactionScreen(),
                ),
              );
            },
            assetPath: Assets.svgs.transaction,
            title: 'Transactions');
      },
    ),
    Builder(
      builder: (context) {
        return AppListTile(
            onPressed: () {
              context.push(RouteConstants.becomeagent);
            },
            assetPath: Assets.svgs.becomeagent,
            title: 'Become an agent');
      },
    ),
    Builder(
      builder: (context) {
        return AppListTile(
            onPressed: () {
              context.push(RouteConstants.accountSetup);
            },
            assetPath: Assets.svgs.setting,
            title: 'Account');
      },
    ),
    Builder(
      builder: (context) {
        return AppListTile(
          onPressed: () {
            context.push(RouteConstants.setting);
          },
          assetPath: Assets.svgs.logout1ArrowExitFrameLeaveLogoutRectangleRight,
          title: 'Settings',
        );
      },
    ),
  ];
}
