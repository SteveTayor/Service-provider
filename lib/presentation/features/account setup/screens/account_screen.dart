import 'package:bundlegram/presentation/features/account%20setup/screens/widgets/accountitem_widget.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/widgets/userdetail_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
            children: [
              const UserdetailWidget(),
              40.verticalSpace,
             const AccountitemWidget(),
            ],
                ),
          ),
        ),
      ),);
  }
}
