// ignore_for_file: inference_failure_on_instance_creation, inference_failure_on_function_invocation

import 'dart:async';

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/app.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_screen_provider.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/platformproduct_screen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformbills_widget.dart';
import 'package:bundlegram/presentation/features/account%20setup/notifier/help_and_support_provider.dart';
import 'package:bundlegram/presentation/features/transaction/screens/internet-services/internet_service_screen.dart';
import 'package:bundlegram/presentation/features/transaction/screens/transaction_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

export 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_screen_provider.dart';

class BillWidgetItem {
  final String title;
  final Widget Function(BuildContext) builder;

  BillWidgetItem({required this.title, required this.builder});
}

class PlatFormData {
  static final List<String> advert = [
    Assets.svgs.accountsetup,
    Assets.svgs.bundlegramagent,
  ];
  static List<VoidCallback> advertFunction(BuildContext context) => [
    () => context.push(RouteConstants.accountSetup),
    () => context.push(RouteConstants.becomeagent),
  ];
  static final List<BillWidgetItem> billWidgets = [
    BillWidgetItem(
      title: 'Betting',
      builder: (context) {
        return AppListTile(
          assetPath: Assets.svgs.betting,
          onPressed: () {
            context.push(
              RouteConstants.platformProduct,
              extra: PlatformProductType.betting,
            );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const PlatformproductScreen(
            //         serviceType: PlatformProductType.betting),
            //   ),
            // );
          },
          title: 'Betting',
        );
      },
    ),
    BillWidgetItem(
      title: 'Electricity',
      builder: (context) {
        return AppListTile(
          assetPath: Assets.svgs.electricity,
          onPressed: () {
            context.push(
              RouteConstants.platformProduct,
              extra: PlatformProductType.electricity,
            );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const PlatformproductScreen(
            //         serviceType: PlatformProductType.electricity),
            //   ),
            // );
          },
          title: 'Electricity',
        );
      },
    ),
    BillWidgetItem(
      title: 'E-pin voucher',
      builder: (context) {
        return AppListTile(
          assetPath: Assets.svgs.ePin,
          title: 'E-pin voucher',
          onPressed: () {
            // context
            //   ..pop()
            //   ..showCustomSnackBar("coming soon");

            context.push(
              RouteConstants.platformProduct,
              extra: PlatformProductType.ePinVoucher,
            );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const PlatformproductScreen(
            //       serviceType: PlatformProductType.ePinVoucher,
            //     ),
            //   ),
            // );
          },
        );
      },
    ),
    BillWidgetItem(
      title: 'Education',
      builder: (context) {
        return AppListTile(
          assetPath: Assets.svgs.educationSvg,
          title: 'Education',
          onPressed: () {
            // context
            //   ..pop()
            //   ..showCustomSnackBar("coming soon");

            context.push(
              RouteConstants.platformProduct,
              extra: PlatformProductType.education,
            );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const PlatformproductScreen(
            //         serviceType: PlatformProductType.education),
            //   ),
            // );
          },
        );
      },
    ),
    BillWidgetItem(
      title: 'Cable Tv',
      builder: (context) {
        return AppListTile(
          onPressed: () {
            context.push(
              RouteConstants.platformProduct,
              extra: PlatformProductType.cableTv,
            );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const PlatformproductScreen(
            //         serviceType: PlatformProductType.cableTv),
            //   ),
            // );
          },
          assetPath: Assets.svgs.cableTv,
          title: 'Cable Tv',
        );
      },
    ),
    BillWidgetItem(
      title: 'Internet Provider',
      builder: (context) {
        return AppListTile(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const PlatformproductScreen(
            //         serviceType: PlatformProductType.internetServices),
            //   ),
            // );
            // context
            //   ..pop()
            //   ..showCustomSnackBar("coming soon");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => InternetServiceProviderScreen(),
              ),
            );
          },
          assetPath: Assets.svgs.internetservice,
          title: 'Internet Provider',
        );
      },
    ),
  ];

  static final List<Widget> serviceProviderWidget = [
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.mtnnw,
      // imagePath: Assets.images.mtn.path,
      title: 'MTN',
      subtitle: '@mtnng',
      onPressed: () {},
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.airtel,
      // imagePath: Assets.images.airtel.path,
      color: AppColors.error,
      title: 'Airtel',
      subtitle: '@airtelnigeria',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.glo,
      // imagePath: Assets.images.glo.path,
      title: 'Glo',
      subtitle: '@globacomlimited',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.a9mobile,
      // imagePath: Assets.images.a9mobile.path,
      title: '9mobile',
      subtitle: '@9mobileng',
    ),
  ];

  static final List<Widget> educationProviderWidget = [
    AppListTile(
      assetPath: Assets.svgs.waec,
      // imagePath: Assets.images.waec.path,
      title: 'WAEC',
      showSubtitle: true,
      subtitle: 'WAEC',
    ),
    AppListTile(
      assetPath: Assets.svgs.jamb,
      // imagePath: Assets.images.jamb.path,
      showSubtitle: true,
      title: 'JAMB',
      subtitle: 'JAMB',
    ),
  ];

  static final List<Widget> electricityProviderWidget = [
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.ekoElectricity,
      // imagePath: Assets.images.ekoPhcn.path,
      title: 'Eko ',
      subtitle: 'EDEDC',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.ibadanElectricity,

      // imagePath: Assets.images.ibedc.path,
      title: 'Ibadan ',
      subtitle: 'IBEDC',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.enuguElectricity,

      // imagePath: Assets.images.enuguPhcn.path,
      title: 'Enugu ',
      subtitle: 'EEDC',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.ikejaElectricity,

      // imagePath: Assets.images.ikejaPhcn.path,
      title: 'Ikeja',
      subtitle: 'Ikeja Electricity',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.kadunaElectricity,

      // imagePath: Assets.images.kadunaPhcn.path,
      title: 'Kaduna',
      subtitle: 'KEDC',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.beninElectricityIcon,

      // imagePath: Assets.images.phcnElectricity.path,
      title: 'Benin ',
      subtitle: 'BEDC',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.josElectricityIcon,

      // imagePath: Assets.images.ekedc.path,
      title: 'Jos',
      subtitle: 'Jos Electricity',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.yolaElectricityIcon,

      // imagePath: Assets.images.ekedc.path,
      title: 'Yola',
      subtitle: 'YEDC',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.portharcourtElectricity,

      // imagePath: Assets.images.ekedc.path,
      title: 'Portharcourt',
      subtitle: 'PHED',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.abujaElectricity,

      // imagePath: Assets.images.ekedc.path,
      title: 'Abuja',
      subtitle: 'AEDC',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.kanoElectricity,

      // imagePath: Assets.images.ekedc.path,
      title: 'Kano',
      subtitle: 'KEDCO',
    ),
  ];

  static final List<Widget> internetServiceProviderWidget = [
    AppListTile(
      showSubtitle: true,
      // assetPath: Assets.svgs.smile,
      imagePath: Assets.images.smile.path,

      title: 'Smile',
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
      assetPath: Assets.svgs.dstv,

      // imagePath: Assets.images.dstv.path,
      title: 'DSTV',
      subtitle: 'DSTV',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.startimes,

      // imagePath: Assets.images.startimes.path,
      title: 'Startimes',
      subtitle: 'Startimes',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.gotv,

      // imagePath: Assets.images.gotv.path,
      title: 'GOTV',
      subtitle: 'GoTV',
    ),
  ];

  static final List<Widget> bettingProviders = [
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.bet9ja,

      // imagePath: Assets.images.bet9ja.path,
      title: 'Bet9ja',
      subtitle: 'Fund wallet',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.naijabet,

      // imagePath: Assets.images.bet9ja.path,
      title: 'NaijaBet',
      subtitle: 'Fund wallet',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.livescorebet,

      // imagePath: Assets.images.bet9ja.path,
      title: 'LivescoreBet',
      subtitle: 'Fund wallet',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.betking,

      // imagePath: Assets.images.bet9ja.path,
      title: 'Betking',
      subtitle: 'Fund wallet',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.a1xbet,

      // imagePath: Assets.images.a1xbet.path,
      title: '1xbet',
      subtitle: 'Fund wallet',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.bangbet,

      // imagePath: Assets.images.bangbet.path,
      title: 'Bangbet',
      subtitle: 'Fund wallet',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.nairabet,

      // imagePath: Assets.images.nairabetLogo.path,
      title: 'NairaBet',
      subtitle: 'Make Deposit',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.betway,

      // imagePath: Assets.images.betway.path,
      title: 'Betway',
      subtitle: 'Fund your player account',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.supabet,

      // imagePath: Assets.images.superbet.path,
      title: 'SupaBet',
      subtitle: 'Fund wallet',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.merrybet,

      // imagePath: Assets.images.merrybet.path,
      title: 'MerryBet',
      subtitle: 'Fund wallet',
    ),
    AppListTile(
      showSubtitle: true,
      assetPath: Assets.svgs.betland,

      // imagePath: Assets.images.betlandLogo.path,
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
            // 1️⃣ Close drawer
            context.pop();

            // 2️⃣ Use ROOT context, not drawer context
            final rootContext = navigatorKey.currentContext;
            if (rootContext == null) return;

            final container = ProviderScope.containerOf(
              rootContext,
              listen: false,
            );

            container
                .read(platformProvider)
                .goToProduct(rootContext, PlatformProductType.mobileData);
          },
          color: AppColors.black,
          assetPath: Assets.svgs.mobile,
          title: 'Buy data',
        );
      },
    ),
    Builder(
      builder: (context) {
        return AppListTile(
          onPressed: () {
            context.pop();
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const PlatformproductScreen(
            //       serviceType: PlatformProductType.airtime,
            //     ),
            //   ),
            // );
            // final container = ProviderScope.containerOf(context, listen: false);
            // final platform = container.read(platformProvider)
            //   ..goToProduct(context, PlatformProductType.airtime);

            // 2️⃣ Use ROOT context, not drawer context
            final rootContext = navigatorKey.currentContext;
            if (rootContext == null) return;

            final container = ProviderScope.containerOf(
              rootContext,
              listen: false,
            );

            container
                .read(platformProvider)
                .goToProduct(rootContext, PlatformProductType.airtime);
          },
          assetPath: Assets.svgs.simcard21,
          title: 'Buy airtime',
        );
      },
    ),
    Builder(
      builder: (context) {
        return AppListTile(
          onPressed: () {
            context
              ..pop()
              ..showBottomSheet(child: const PlatformbillsWidget());
          },
          assetPath: Assets.svgs.paybills,
          title: 'Pay bills',
        );
      },
    ),
    Builder(
      builder: (context) {
        return AppListTile(
          onPressed: () {
            context.pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TransactionScreen(),
              ),
            );
          },
          assetPath: Assets.svgs.transaction,
          title: 'Transactions',
        );
      },
    ),
    Builder(
      builder: (context) {
        return AppListTile(
          onPressed: () {
            context
              ..pop()
              ..push(RouteConstants.becomeagent);
          },
          assetPath: Assets.svgs.uploadCircleStreamlineCore,
          title: 'Become an agent',
        );
      },
    ),
    // NEW: WhatsApp Channel
    Builder(
      builder: (context) {
        return AppListTile(
          onPressed: () {
            context.pop();
            final rootContext = navigatorKey.currentContext;
            if (rootContext == null) return;
            final container = ProviderScope.containerOf(
              rootContext,
              listen: false,
            );
            container.read(helpSupportProvider).openWhatsappChannel();
          },
          assetPath: Assets.svgs.whatsappColorIcon,
          title: 'WhatsApp Channel',
        );
      },
    ),

    Builder(
      builder: (context) {
        return AppListTile(
          onPressed: () {
            context
              ..pop()
              ..push(RouteConstants.accountSetup);
          },
          assetPath: Assets.svgs.userCircleSingleStreamlineCore,
          title: 'Account',
        );
      },
    ),
    Builder(
      builder: (context) {
        return AppListTile(
          onPressed: () {
            context
              ..pop()
              ..push(RouteConstants.setting);
          },
          assetPath: Assets.svgs.cogStreamlineCore,
          title: 'Settings',
        );
      },
    ),
  ];
}
