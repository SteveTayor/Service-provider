import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/models/airtime_2_cash/network_config.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NetworkSelectorGrid extends StatelessWidget {
  const NetworkSelectorGrid({
    super.key,
    required this.networks,
    required this.selectedNetwork,
    required this.onSelected,
  });

  final List<NetworkConfig> networks;
  final NetworkConfig? selectedNetwork;
  final ValueChanged<NetworkConfig> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < networks.length; i++) ...[
          _NetworkCard(
            network: networks[i],
            isSelected: selectedNetwork?.id == networks[i].id,
            onTap: networks[i].isAvailable
                ? () => onSelected(networks[i])
                : null,
          ),
          if (i != networks.length - 1) SizedBox(height: 12.h),
        ],
      ],
    );
  }
}

class _NetworkCard extends StatelessWidget {
  const _NetworkCard({
    required this.network,
    required this.isSelected,
    required this.onTap,
  });

  final NetworkConfig network;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: network.isAvailable ? 1 : 0.55,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.success.withOpacity(0.06)
                : AppColors.white,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: isSelected ? AppColors.success : AppColors.greyEE,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.greyF5,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: AppSvgIcon(
                  path: network.logoAsset,
                  width: 24.w,
                  height: 24.w,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      network.name,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (!network.isAvailable) ...[
                      SizedBox(height: 2.h),
                      Text(
                        'Unavailable',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.warning,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Selection indicator: clear filled check when selected,
              // neutral outline circle otherwise — no ambiguity about
              // which network is currently chosen.
              Container(
                width: 22.w,
                height: 22.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppColors.success : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? AppColors.success : AppColors.greyD0,
                    width: 1.5,
                  ),
                ),
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.white, size: 14)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
