

// ignore_for_file: inference_failure_on_instance_creation

import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/platformproduct_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_listtile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlatFormData{
static final List<String> advert = [
  Assets.svgs.accountsetup,
  Assets.svgs.bundlegramagent,
  Assets.svgs.completesetup,
];
static List<VoidCallback> advertFunction(BuildContext context) => [
  (){
   context.push(RouteConstants.accountSetup);
  },
  (){
      context.push(RouteConstants.becomeagent);
  },
  (){
          context.push(RouteConstants.accountSetup);

  },
 
];

static final List<Widget> payBillWidget = [
  Builder(
    builder: (context) {
      return AppListTile(assetPath: Assets.svgs.betting,
      onPressed: (){
               Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const PlatformproductScreen(
    title: 'Betting',
  ),),
);
      },
       title: 'Betting',);
    },
  ),
  Builder(
    builder: (context) {
      return AppListTile(assetPath: Assets.svgs.electricity,
         onPressed: (){
                   Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PlatformproductScreen(
        title: 'Electricity',
      ),),
      );
          },
       title: 'Electricity',);
    },
  ),
  AppListTile(assetPath: Assets.svgs.ePin,
   title: 'E-pin voucher',),
  AppListTile(assetPath: Assets.svgs.educationSvg,
   title: 'Education',),
  Builder(
    builder: (context) {
      return AppListTile(
                 onPressed: (){
                   Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PlatformproductScreen(
        title: 'Cable Tv',
        type: PlatformProductType.userPrice,
      ),),
      );
          },

        assetPath: Assets.svgs.cabletv,
       title: 'Cable Tv',);
    },
  ),
  AppListTile(assetPath: Assets.svgs.internetservice, title: 'Internet Provider'),
];
static final List<Widget> platformDrawerItem = [
  AppListTile(assetPath: Assets.svgs.overview, title: 'Overview'),
  AppListTile(assetPath: Assets.svgs.buydata, title: 'Buy data'),
  AppListTile(assetPath: Assets.svgs.simcard21, title: 'Buy airtime'),
  AppListTile(assetPath: Assets.svgs.paybills, title: 'Pay bills'),
  AppListTile(assetPath: Assets.svgs.transaction, title: 'Transactions'),
  AppListTile(assetPath: Assets.svgs.becomeagent, title: 'Become an agent'),
  AppListTile(assetPath: Assets.svgs.setting, title: 'Account'),
  AppListTile(assetPath: Assets.svgs.logout1ArrowExitFrameLeaveLogoutRectangleRight,
   title: 'Settings',),
];


}
