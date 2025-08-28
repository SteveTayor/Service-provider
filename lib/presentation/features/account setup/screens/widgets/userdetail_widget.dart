import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_listtile.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UserdetailWidget extends ConsumerWidget {
  const UserdetailWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalUserProvider = ref.watch(globalProvider).profile;
    final profileProv = globalUserProvider.value?.data;
    Row textWithIcon(String assetName, String title) {
      return Row(
        children: [
          AppSvgIcon(path: assetName),
          6.horizontalSpace,
          Text(title, style: context.textTheme.labelMedium),
        ],
      );
    }

    String moveSurnameToEnd(String? fullName) {
      if (fullName == null || fullName.trim().isEmpty) return '';

      final parts = fullName.trim().split(RegExp(r'\s+'));
      if (parts.length < 2) return fullName;

      final firstName = parts.first;
      final rest = parts.sublist(1).join(' ');

      return ('$rest $firstName').capiTalizeFirstLast;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${globalUserProvider.value?.data?.firstName?[0]}${globalUserProvider.value?.data?.lastName?[0]}",
              style: context.textTheme.titleMedium!.copyWith(
                color: AppColors.white,
              ),
            ).withContainer(
              color: AppColors.pink,
              width: 60,
              height: 60,
              alignment: Alignment.center,
              shape: BoxShape.circle,
            ),
            12.verticalSpace,
            Text(
              moveSurnameToEnd(globalUserProvider.value!.data!.name),
              style: context.textTheme.titleSmall,
            ),
            if (profileProv?.emailVerifiedAt == null ||
                profileProv?.bvn == null ||
                profileProv?.address == null ||
                profileProv?.bankName == null ||
                profileProv?.accountNumber == null) ...[
              4.verticalSpace,
              textWithIcon(
                Assets.svgs.infoCircle1,
                'Verification incomplete',
              ),
              8.verticalSpace,
            ],
            if (profileProv?.userType == "agent") ...[
              textWithIcon(
                Assets.svgs.crownRewardSocialRatingMediaQueenVipKingCrown,
                'Bundlegram agent',
              ),
              14.verticalSpace,
            ],
            if (profileProv?.emailVerifiedAt == null ||
                profileProv?.bvn == null ||
                profileProv?.bankName == null ||
                profileProv?.accountNumber == null ||
                profileProv?.gender == null ||
                profileProv?.dob == null)
              InkWell(
                onTap: () {
                  context.push(RouteConstants.accountSetup);
                },
                child: Text(
                  'Complete account set up',
                  style: context.textTheme.bodySmall!.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.black,
                  ),
                ),
              ),
          ],
        ),
        AppSvgIcon(
          onTap: () {
            context.push(RouteConstants.setting);
          },
          path: Assets.svgs.cogStreamlineCore,
        ),
      ],
    );
  }
}
