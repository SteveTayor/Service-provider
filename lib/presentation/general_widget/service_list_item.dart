import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/models/wallet/service_model.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceListItem extends StatelessWidget {
  const ServiceListItem({
    super.key,
    required this.service,
  });

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Service Icon
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: _getServiceColor().withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: service.iconUrl != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20.w),
                  child: Image.network(
                    service.iconUrl!,
                    width: 24.w,
                    height: 24.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: _getServiceIcon(),
                    ),
                  ),
                )
              : SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: _getServiceIcon(),
                ),
        ),
        SizedBox(width: 12.w),

        // Service Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                service.title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Text(
                    service.status,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: _getStatusColor(),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    ' • ${service.date}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.grey8E,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Service Amount
        Text(
          service.amount,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }

  Color _getServiceColor() {
    switch (service.type.toLowerCase()) {
      case 'top-up':
      case 'airtime':
        return const Color(0xFFE53E3E); // Red
      case 'cable tv':
        return const Color(0xFF2D3748); // Dark gray
      case 'betting':
        return const Color(0xFF553C9A); // Purple
      case 'education':
        return const Color(0xFF9F7AEA); // Light purple
      case 'mobile data':
      case 'internet':
        return const Color(0xFF3182CE); // Blue
      case 'electricity':
        return const Color(0xFFD69E2E); // Orange/Yellow
      case 'e-pin voucher':
        return const Color(0xFF38A169); // Green
      default:
        return AppColors.primaryColor;
    }
  }

  Widget _getServiceIcon() {
    switch (service.type.toLowerCase()) {
      case 'top-up':
        return AppSvgIcon(path: Assets.svgs.topup);
      case 'airtime':
        return AppSvgIcon(path: Assets.svgs.mobile);
      case 'cable tv':
        return AppSvgIcon(path: Assets.svgs.cabletv);
      case 'betting':
        return AppSvgIcon(path: Assets.svgs.betting);
      case 'education':
        return AppSvgIcon(path: Assets.svgs.educationSvg);
      case 'mobile data':
      case 'internet':
        return AppSvgIcon(path: Assets.svgs.internetservice);
      case 'electricity':
        return AppSvgIcon(path: Assets.svgs.electricity);
      case 'e-pin voucher':
        return AppSvgIcon(path: Assets.svgs.ePin);
      case 'withdrawal':
        return AppSvgIcon(path: Assets.svgs.walletAdd);
      default:
        return AppSvgIcon(path: Assets.svgs.wallet);
    }
  }

  Color _getStatusColor() {
    switch (service.status.toLowerCase()) {
      case 'successful':
        return Colors.green;
      case 'failed':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return AppColors.grey8E;
    }
  }
}
