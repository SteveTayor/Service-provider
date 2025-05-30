import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/presentation/features/notifications/screens/widgets/emptynotification_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:flutter/material.dart';


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   const BundlegramScaffold(
      appBar: BundlegramAppbar(titleText: 'Notifications',),
      body: EmptynotificationWidget(),

    );
  }
}