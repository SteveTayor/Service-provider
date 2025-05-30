import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavBar extends ConsumerWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = [
{
  'icon':      Assets.svgs.homeinactive,
  'active': Assets.svgs.home,
  'name':'Home',

},
{
  'icon':      Assets.svgs.wallet,
    'active': Assets.svgs.walletactive,
  'name':'Wallet',
},
     {
  'icon':      Assets.svgs.receipt,
    'active': Assets.svgs.receiptactive,
  'name':'Transactions',
},
      {
  'icon':      Assets.svgs.userCircleSingleStreamlineCore,
    'active': Assets.svgs.userActive,
  'name':'Account',
},
    ];
    final v = ref.watch(currentIndexProvider);
    return Container(
      padding: EdgeInsets.fromLTRB(
        23.w,
        17.h,
        23.w,
        25.h,
      ),
      color: AppColors.background,
      width: double.infinity,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            items.length,
            (index) => InkWell(
              onTap: () {
                ref.read(currentIndexProvider.notifier).state = index;
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                transform: Matrix4.identity()..scale(index == v ? 1.0 : 1.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppSvgIcon(
                      path: index == v?
                      '${items[index]['active']}':'${items[index]['icon']}',
                    width: 24.w,height: 24.h,fit: BoxFit.scaleDown,
                    ),
                    6.verticalSpace,
                    Text('${items[index]['name']}',style: context.textTheme.bodySmall!.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.black.withOpacity(0.6),
                    ),),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final currentIndexProvider = StateProvider.autoDispose<int>((ref) => 0);
