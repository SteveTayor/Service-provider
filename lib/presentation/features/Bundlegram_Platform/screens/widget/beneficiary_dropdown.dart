import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_product_provider.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/products_provider.dart';
import 'package:bundlegram/presentation/features/transaction/screens/beneficiary/beneficiary_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
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
            onTap: () => setState(() => expanded = !expanded),
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
                    ...list.map((b) {
                      final network = (b.network ?? '').trim();
                      final asset = notifier.normalizeAssetName(
                        network,
                        serviceType: widget.serviceType,
                      );

                      Widget leading;
                      if (asset != null && asset.endsWith('.svg')) {
                        leading = CircleAvatar(
                          radius: 14.r,
                          backgroundColor: Colors.white,
                          child: AppSvgIcon(path: asset),
                        );
                      } else if (asset != null && asset.isNotEmpty) {
                        leading = CircleAvatar(
                          radius: 14.r,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            asset,
                            width: 24.w,
                            height: 24.h,
                          ),
                        );
                      } else {
                        leading = CircleAvatar(
                          radius: 14.r,
                          child: Text(
                            network.isNotEmpty ? network[0] : '?',
                          ),
                        );
                      }

                      return InkWell(
                        onTap: () async {
                          notifier.setSelectedBeneficiary(b);
                          await notifier.applyBeneficiary(context, b);

                          setState(() => expanded = false);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 12.w),
                          child: Row(
                            children: [
                              leading,
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

                    Divider(color: AppColors.grey5B.withOpacity(.5)),

                    // VIEW ALL
                    InkWell(
                      onTap: () {
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
                              style: context.textTheme.bodySmall!.copyWith(
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
}
