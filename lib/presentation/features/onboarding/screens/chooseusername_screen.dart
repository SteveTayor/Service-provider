import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_form.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ChooseUsernameScreen extends StatefulWidget {
  const ChooseUsernameScreen({super.key});

  @override
  State<ChooseUsernameScreen> createState() => _ChooseUsernameScreenState();
}

class _ChooseUsernameScreenState extends State<ChooseUsernameScreen> {
  final bool _isFormValid = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _username = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      appBar: const BundlegramAppbar(),
      sidePadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
      body: Column(
        children: [
          Column(
            children: [
              Text(
                'Choose username',
                style: context.textTheme.titleMedium,
              ),
              10.verticalSpace,
              Text(
                'Add a username to personalize your account.',
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall!.copyWith(
                  color: AppColors.grey33,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          40.verticalSpace,
          Expanded(
            child: AppForm(
              isExpanded: false,
              isActive: _isFormValid,
              onPressed: () {
                context.go(RouteConstants.onboardResult);
              },
              buttonText: 'Complete account set-up',
              formKey: _formKey,
              children: [
                AppTextField(
                  controller: _username,
                  hintText: 'Choose a username',
                  onChange: (val) {},
                  suffixIcon: AppSvgIcon(
                    path: _isFormValid == true
                        ? Assets.svgs.check
                        : Assets.svgs.tickCircle,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
