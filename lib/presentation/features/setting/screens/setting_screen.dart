import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/setting/screens/closeaccount_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_listtile.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
        Widget buildRowWidget(String asset, String title,{VoidCallback? onPressed}){
      return AppListTile(
 onPressed: onPressed,
        assetPath: asset,
    trailingAsset:Assets.svgs.arrowFowardIos,
     title: title,).withContainer(
      padding: context.symmetricPadding(0, 24),
      border: const Border(bottom: BorderSide(color: Color(0xffECECEC))),
    );
    }
    return     BundlegramScaffold(
      appBar: const BundlegramAppbar(titleText: 'Settings',),
      body: 
    Column(
      children: [
        buildRowWidget(Assets.svgs.userProtection2StreamlineCore,
         'Change password',
         onPressed: (){
          context.push(RouteConstants.changePassword);
         },
         ),
        buildRowWidget(
             onPressed: (){
          context.push(RouteConstants.changeAccountPin);
         },
          Assets.svgs.browserLockStreamlineCore,
         'Change account pin',),
        buildRowWidget(Assets.svgs.lockRotationStreamlineCore,
                     onPressed: (){
          context.push(RouteConstants.resetAccountPin);
         },
         'Reset account pin',),
        buildRowWidget(Assets.svgs.ringingBellNotificationStreamlineCore,
             onPressed: (){
          context.push(RouteConstants.notificationsetting);
         },


         'Notifications settings',),
        buildRowWidget(Assets.svgs.vpnConnectionStreamlineCore,
        onPressed: (){
          context.push(RouteConstants.privacySecurity);
        },
         'Privacy & Security',),
        
         AppListTile(
          onPressed: (){
            context.showBottomSheet(child: const CloseaccountWidget());
          },
 titleColor: AppColors.errorText,
        assetPath: Assets.svgs.browserDeleteStreamlineCore,
    trailingAsset:Assets.svgs.arrowFowardIos,
     title: 'Close account',).withContainer(
      padding: context.symmetricPadding(0, 24),
      border: const Border(bottom: BorderSide(color: Color(0xffECECEC))),
    ),
      ],
    ),
    );
  }
}