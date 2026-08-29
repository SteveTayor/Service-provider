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
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: networks.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 12.w,
        crossAxisSpacing: 12.w,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        final network = networks[index];
        final isSelected = selectedNetwork?.id == network.id;
        return _NetworkTile(
          network: network,
          isSelected: isSelected,
          onTap: network.isAvailable ? () => onSelected(network) : null,
        );
      },
    );
  }
}

class _NetworkTile extends StatelessWidget {
  const _NetworkTile({
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
      opacity: network.isAvailable ? 1 : 0.6,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.success.withOpacity(0.08)
                : AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected ? AppColors.success : AppColors.greyEE,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8.w),
                child: AppSvgIcon(
                  path: network.logoAsset,
                  width: 36.w,
                  height: 36.w,
                  fit: BoxFit.contain,
                ),
              ),
              if (!network.isAvailable) ...[
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    'Unavailable',
                    style: TextStyle(fontSize: 8.sp, color: AppColors.warning),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
