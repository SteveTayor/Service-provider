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
        () => context.push(RouteConstants.accountSetup),
        () => context.push(RouteConstants.becomeagent),
        () => context.push(RouteConstants.accountSetup),
      ];
  static final List<Widget> payBillWidget = [
    Builder(builder: (context) {
      return AppListTile(
        assetPath: Assets.svgs.betting,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PlatformproductScreen(
                  serviceType: PlatformProductType.betting),
            ),
          );
        },
        title: 'Betting',
      );
    }),
    Builder(builder: (context) {
      return AppListTile(
        assetPath: Assets.svgs.electricity,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PlatformproductScreen(
                  serviceType: PlatformProductType.electricity),
            ),
          );
        },
        title: 'Electricity',
      );
    }),
    Builder(builder: (context) {
      return AppListTile(
        assetPath: Assets.svgs.ePin,
        title: 'E-pin voucher',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PlatformproductScreen(
                  serviceType: PlatformProductType.ePinVoucher),
            ),
          );
        },
      );
    }),
    Builder(builder: (context) {
      return AppListTile(
        assetPath: Assets.svgs.educationSvg,
        title: 'Education',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PlatformproductScreen(
                  serviceType: PlatformProductType.education),
            ),
          );
        },
      );
    }),
    Builder(builder: (context) {
      return AppListTile(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PlatformproductScreen(
                  serviceType: PlatformProductType.cableTv),
            ),
          );
        },
        assetPath: Assets.svgs.cableTv,
        title: 'Cable Tv',
      );
    }),
    Builder(builder: (context) {
      return AppListTile(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PlatformproductScreen(
                  serviceType: PlatformProductType.internetServices),
            ),
          );
        },
        assetPath: Assets.svgs.internetservice,
        title: 'Internet Provider',
      );
    }),
  ];

  static final List<Widget> serviceProviderWidget = [
    AppListTile(
      showSubtitle: true,
      // assetPath: 'assets/svgs/mtn_logo.svg',
      imagePath: Assets.images.mtn.path,
      title: 'MTN Nigeria',
      subtitle: '@mtnng',
      onPressed: () {},
    ),
    AppListTile(
      showSubtitle: true,
      // assetPath: Assets.svgs.airtel,
      imagePath: Assets.images.airtel.path,
      title: 'Airtel Nigeria',
      subtitle: '@airtelnigeria',
    ),
    AppListTile(
      showSubtitle: true,
      // assetPath: Assets.svgs.glo,
      imagePath: Assets.images.glo.path,
      title: 'Glo Nigeria',
      subtitle: '@globacomlimited',
    ),
    AppListTile(
      showSubtitle: true,
      // assetPath: Assets.svgs.a9mobile,
      imagePath: Assets.images.a9mobile.path, title: '9mobile Nigeria',
      subtitle: '@9mobileng',
    ),
  ];

  static final List<Widget> educationProviderWidget = [
    AppListTile(
      // assetPath: Assets.svgs.waec,
      imagePath: Assets.images.waec.path,
      title: 'WAEC',
      showSubtitle: true,
      subtitle: 'WAEC',
    ),
    AppListTile(
      // assetPath: Assets.svgs.jamb,
      imagePath: Assets.images.jamb.path,
      showSubtitle: true,
      title: 'JAMB',
      subtitle: 'JAMB',
    ),
  ];

  static final List<Widget> electricityProviderWidget = [
    AppListTile(
      showSubtitle: true,
      // assetPath: Assets.svgs.ekoElectricity,
      imagePath: Assets.images.ekoPhcn.path,
      title: 'Eko PHCN',
      subtitle: 'EDEDC',
    ),
    AppListTile(
      showSubtitle: true,
      // assetPath: Assets.svgs.ibedc,
      imagePath: Assets.images.ibedc.path,

      title: 'Ibadan Electricity',
      subtitle: 'IBEDC',
    ),
    AppListTile(
      showSubtitle: true,
      // assetPath: Assets.svgs.eedc,
      imagePath: Assets.images.enuguPhcn.path,

      title: 'Enugu PHCN',
      subtitle: 'EEDC',
    ),
    AppListTile(
      showSubtitle: true,
      // assetPath: Assets.svgs.ikejaElectricity,
      imagePath: Assets.images.ikejaPhcn.path,

      title: 'Ikeja Electricity',
      subtitle: 'Ikeja Electricity',
    ),
  ];

  static final List<Widget> internetServiceProviderWidget = [
    AppListTile(
      showSubtitle: true,
      // assetPath: Assets.svgs.smile,
      imagePath: Assets.images.smile.path,

      title: 'Smile Bundle',
      subtitle: 'Smile',
    ),
    AppListTile(
      showSubtitle: true,
      // assetPath: Assets.svgs.spectranet,
      imagePath: Assets.images.spectranet.path,

      title: 'Spectranet',
      subtitle: 'Spectranet',
    ),
  ];

  static final List<Widget> cableTvProviderWidget = [
    AppListTile(
      showSubtitle: true,
      // assetPath: Assets.svgs.dstv,
      imagePath: Assets.images.dstv.path,

      title: 'DSTV',
      subtitle: 'DSTV',
    ),
    AppListTile(
      showSubtitle: true,
      // assetPath: Assets.svgs.startimes,
      imagePath: Assets.images.startimes.path,

      title: 'Startimes',
      subtitle: 'Startimes',
    ),
    AppListTile(
      showSubtitle: true,
      // assetPath: Assets.svgs.gotv,
      imagePath: Assets.images.gotv.path,

      title: 'GOTV',
      subtitle: 'GoTV',
    ),
  ];

  static final List<Widget> bettingProviders = [
    AppListTile(
      showSubtitle: true,
      // assetPath: Assets.svgs.betnaija,
      imagePath: Assets.images.bet9ja.path,

      title: 'Bet9ja',
      subtitle: 'Fund wallet',
    ),
    AppListTile(
      showSubtitle: true,
      // assetPath: Assets.svgs.a1xbet,
      imagePath: Assets.images.a1xbet.path,

      title: '1xbet',
      subtitle: 'Fund wallet',
    ),
    AppListTile(
      showSubtitle: true,
      // assetPath: Assets.svgs.bangbet,
      imagePath: Assets.images.bangbet.path,

      title: 'Bangbet',
      subtitle: 'Fund wallet',
    ),
    AppListTile(
      showSubtitle: true,
      // assetPath: Assets.svgs.nairabetLogo,
      imagePath: Assets.images.nairabetLogo.path,

      title: 'NairaBet',
      subtitle: 'Make Deposit',
    ),
    AppListTile(
      showSubtitle: true,
      // assetPath: Assets.svgs.betway,
      imagePath: Assets.images.betway.path,

      title: 'Betway',
      subtitle: 'Fund your player account',
    ),
    AppListTile(
      showSubtitle: true,
      // assetPath: Assets.svgs.superbet,
      imagePath: Assets.images.superbet.path,

      title: 'SuperBet',
      subtitle: 'Fund wallet',
    ),
    AppListTile(
      showSubtitle: true,
      // assetPath: Assets.svgs.merrybet,
      imagePath: Assets.images.merrybet.path,

      title: 'MerryBet',
      subtitle: 'Fund wallet',
    ),
    AppListTile(
      showSubtitle: true,
      // assetPath: Assets.svgs.betlandLogo,
      imagePath: Assets.images.betlandLogo.path,

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
