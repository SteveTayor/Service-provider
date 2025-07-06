import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/models/transaction_receipt/transaction_receipt_model.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/receipt_brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VisualReceiptCard extends StatelessWidget {
  const VisualReceiptCard({
    super.key,
    required this.data,
    this.width = 390,
    this.height = 500.53,
  });

  final TransactionReceiptData data;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header section
          Padding(
            padding: EdgeInsets.all(15.w),
            child: Column(
              children: [
                Text(
                  'Transaction receipt',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 12.h),
                Divider(color: AppColors.greyD0.withOpacity(0.3), thickness: 1),
                SizedBox(height: 12.h),
                Text(
                  data.amount.toCurrency(),
                  style: context.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 40.sp,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                _buildStatusIndicator(),
              ],
            ),
          ),

          // Transaction details
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: ListView(
                children: [
                  _buildDetailRow(context, 'Transaction type', data.type!),
                  16.verticalSpace,
                  if (data.accountNumber != null)
                    _buildDetailRow(
                        context, 'Beneficiary', data.accountNumber!),
                  16.verticalSpace,
                  _buildDetailRow(
                      context, 'Transaction ID', data.transactionId!),
                  16.verticalSpace,
                  _buildDetailRow(context, 'Date', data.date!),
                  16.verticalSpace,
                  _buildDetailRow(context, 'Time', data.time!),
                ],
              ),
            ),
          ),

          // Branding
          ReceiptBrandingWidget(
            logoWidget: Image(
              image: Assets.images.bBundlegram.provider(),
              fit: BoxFit.cover,
            ).withContainer(
              width: 160.w,
              height: 39.h,
            ),
          ),
          16.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            color: AppColors.grey33,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(width: 8.w),
        Flexible(
          child: Text(
            value,
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.right,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusIndicator() {
    final statusInfo = _getStatusInfo();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: statusInfo['backgroundColor'] as Color,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSvgIcon(
            path: statusInfo['icon'] as String,
            color: statusInfo['iconColor'] as Color,
          ),
          SizedBox(width: 8.w),
          Text(
            statusInfo['text'] as String,
            style: TextStyle(
              color: statusInfo['textColor'] as Color,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getStatusInfo() {
    final status = data.status.toLowerCase();

    if (['success', 'successful', 'completed'].contains(status)) {
      return {
        'text': 'Successful',
        'icon': Assets.svgs.check,
        'iconColor': AppColors.success,
        'textColor': AppColors.success,
        'backgroundColor': const Color(0xFFE8F5E8),
      };
    } else if (['failed', 'declined', 'error'].contains(status)) {
      return {
        'text': 'Failed',
        'icon': Assets.svgs.closeCircle,
        'iconColor': AppColors.error,
        'textColor': AppColors.errorText,
        'backgroundColor': const Color(0xFFFFEBEE),
      };
    } else if (['pending', 'processing'].contains(status)) {
      return {
        'text': 'Pending',
        'icon': Assets.svgs.pending,
        'iconColor': AppColors.pending,
        'textColor': AppColors.pending,
        'backgroundColor': const Color(0xFFF5F5F5),
      };
    } else {
      return {
        'text': data.status,
        'icon': Assets.svgs.infoCircle,
        'iconColor': AppColors.grey33,
        'textColor': AppColors.grey33,
        'backgroundColor': const Color(0xFFF5F5F5),
      };
    }
  }
}

// Helper function to generate receipt image/widget for sharing
Widget generateShareableReceipt(TransactionReceiptData data) {
  return Container(
    height: 500,
    // color: AppColors.greyD0,
    // padding: EdgeInsets.all(20.w),
    child: VisualReceiptCard(data: data),
  );
}
