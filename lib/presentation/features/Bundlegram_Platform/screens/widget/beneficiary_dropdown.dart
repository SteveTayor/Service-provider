import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_product_provider.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/products_provider.dart';
import 'package:bundlegram/presentation/features/transaction/screens/beneficiary/beneficiary_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeneficiaryDropdown extends ConsumerStatefulWidget {
  const BeneficiaryDropdown({
    super.key,
    required this.serviceType,
  });

  final PlatformProductType serviceType;

  @override
  ConsumerState<BeneficiaryDropdown> createState() =>
      _BeneficiaryDropdownState();
}

class _BeneficiaryDropdownState extends ConsumerState<BeneficiaryDropdown> {
  bool expanded = false;

  void _safeSetState(VoidCallback fn) {
    if (mounted) setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final shouldShow = widget.serviceType == PlatformProductType.airtime ||
        widget.serviceType == PlatformProductType.mobileData;
    if (!shouldShow) return const SizedBox.shrink();

    final minimalAsync = ref.watch(minimalBeneficiariesProvider);
    final notifier =
        ref.read(platformProductProvider(widget.serviceType).notifier);
    final state = ref.watch(platformProductProvider(widget.serviceType));

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEEF3FF),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          // HEADER (always visible)
          InkWell(
            onTap: () => _safeSetState(() => expanded = !expanded),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
              child: Row(
                children: [
                  Text(
                    // state.selectedBeneficiary == null
                    //     ?
                    'Beneficiaries',
                    // : "${state.selectedBeneficiary!.network} - ${state.selectedBeneficiary!.phoneNumber}",
                    style: context.textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.black,
                  )
                ],
              ),
            ),
          ),

          // EXPANDED CONTENT
          if (expanded)
            minimalAsync.when(
              loading: () => Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: const Center(child: CircularProgressIndicator()),
              ),
              error: (_, __) => const SizedBox.shrink(),
              data: (list) {
                // If list empty → show a simple message
                if (list.isEmpty) {
                  return Column(
                    children: [
                      Divider(color: AppColors.divider.withOpacity(.8)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 12.w),
                        child: Center(
                          child: Text(
                            'No beneficiaries added yet',
                            style: context.textTheme.bodySmall!.copyWith(
                              color: AppColors.grey5B,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return Column(
                  children: [
                    Divider(color: AppColors.divider.withOpacity(.8)),
                    ...list.map((b) {
                      final network = (b.network ?? '').trim();
                      final asset = notifier.normalizeAssetName(
                            network,
                            serviceType: widget.serviceType,
                          ) ??
                          '';

                      // final isSvg = asset?.toLowerCase().endsWith('.svg');

                      // Widget leading;
                      // if (asset != null && asset.endsWith('.svg')) {
                      //   leading = CircleAvatar(
                      //     radius: 14.r,
                      //     backgroundColor: Colors.white,
                      //     child: AppSvgIcon(path: asset),
                      //   );
                      // } else if (asset != null && asset.isNotEmpty) {
                      //   leading = CircleAvatar(
                      //     radius: 14.r,
                      //     backgroundColor: Colors.white,
                      //     child: Image.asset(
                      //       asset,
                      //       width: 24.w,
                      //       height: 24.h,
                      //     ),
                      //   );
                      // } else {
                      //   leading = CircleAvatar(
                      //     radius: 14.r,
                      //     child: Text(
                      //       network.isNotEmpty ? network[0] : '?',
                      //     ),
                      //   );
                      // }

                      return InkWell(
                        onTap: () async {
                          _safeSetState(() => expanded = false);

                          notifier.setSelectedBeneficiary(b);

                          // Guard context before passing into async call
                          if (!context.mounted) return;
                          await notifier.applyBeneficiary(context, b);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 12.w),
                          child: Row(
                            children: [
                              // AppSvgIcon(
                              //   useCircleAvatar: true,
                              //   path: asset,
                              //   width: 40,
                              //   height: 40,
                              //   fit: BoxFit.scaleDown,
                              // ),
                              _buildLeading(asset, network),
                              12.horizontalSpace,
                              Expanded(
                                child: Text(
                                  b.phoneNumber ?? '',
                                  style: context.textTheme.bodySmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

                    Divider(color: AppColors.divider.withOpacity(.8)),

                    // VIEW ALL
                    InkWell(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => AllBeneficiariesScreen(
                              serviceType: widget.serviceType,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 12.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'View all',
                              style: context.textTheme.bodyMedium!.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            6.horizontalSpace,
                            Icon(Icons.arrow_forward_ios,
                                size: 14, color: AppColors.primaryColor)
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  // Extracted safe leading builder — no force-unwrap, handles all asset states
  Widget _buildLeading(String asset, String network) {
    if (asset.endsWith('.svg')) {
      return AppSvgIcon(
        useCircleAvatar: true,
        path: asset,
        width: 40,
        height: 40,
        fit: BoxFit.scaleDown,
      );
    }
    if (asset.isNotEmpty) {
      return CircleAvatar(
        radius: 20.r,
        backgroundColor: Colors.white,
        child: Image.asset(
          asset,
          width: 24.w,
          height: 24.h,
          errorBuilder: (_, __, ___) => Text(
            network.isNotEmpty ? network[0].toUpperCase() : '?',
          ),
        ),
      );
    }
    // Fallback: initial letter avatar
    return CircleAvatar(
      radius: 20.r,
      backgroundColor: AppColors.primaryColor.withOpacity(0.1),
      child: Text(
        network.isNotEmpty ? network[0].toUpperCase() : '?',
        style: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
