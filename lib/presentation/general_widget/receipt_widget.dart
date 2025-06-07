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
        spacing: 40,
        children: [
          // Receipt header
          Container(
            width: double.infinity,
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
                Container(
                  height: 1,
                  color: AppColors.greyD0.withOpacity(0.3),
                  margin: EdgeInsets.symmetric(vertical: 12.h),
                ),
                // SizedBox(height: 10.h),
                Text(
                  data.amount,
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
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: ListView(
                children: [
                  _buildDetailRow(
                    context,
                    'Transaction type',
                    data.type,
                  ),
                  SizedBox(height: 16.h),
                  if (data.accountNumber != null)
                    _buildDetailRow(
                      context,
                      'Beneficiary',
                      data.accountNumber!,
                    ),
                  SizedBox(height: 16.h),
                  _buildDetailRow(
                    context,
                    'Transaction ID',
                    data.transactionId,
                  ),
                  SizedBox(height: 16.h),
                  _buildDetailRow(
                    context,
                    'Date',
                    data.date,
                  ),
                  SizedBox(height: 16.h),
                  _buildDetailRow(
                    context,
                    'Time',
                    data.time,
                  ),
                ],
              ),
            ),
          ),

          // Bottom branding
          ReceiptBrandingWidget(
            logoWidget: Image(
              image: Assets.images.bBundlegram.provider(),
              fit: BoxFit.cover,
            ).withContainer(
              width: 160.w,
              height: 39.h,
              // borderRadius: BorderRadius.circular(4.r),
            ),
            // brandName: 'bundlegram',
            // brandColor: const Color(0xFFE53E3E),
          ),

          16.verticalSpace
        ],
      ),
    );
  }

  Widget _buildStatusIndicator() {
    final status = _getStatusInfo();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        // color: status['backgroundColor'] as Color,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24.w,
            height: 24.h,
            decoration: BoxDecoration(
              // color: status['iconColor'] as Color,
              shape: BoxShape.circle,
            ),
            child: _getStatusIcon(),
          ),
          SizedBox(width: 8.w),
          Text(
            status['text'] as String,
            style: TextStyle(
              color: status['textColor'] as Color,
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            color: AppColors.grey33,
            fontSize: 14.sp,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _getStatusIcon() {
    switch (data.status.toLowerCase()) {
      case 'successful':
      case 'completed':
      case 'success':
        return AppSvgIcon(
          path: Assets.svgs.check,
          // color: Colors.white,
        );
      case 'failed':
      case 'declined':
      case 'error':
        return AppSvgIcon(
          path: Assets.svgs.closeCircle,
          // color: Colors.white,
        );
      case 'pending':
      case 'processing':
        return AppSvgIcon(
          path: Assets.svgs.pending,
          // color: Colors.white,
        );
      default:
        return AppSvgIcon(
          path: Assets.svgs.infoCircle,
          // color: Colors.white,
        );
    }
  }

  Map<String, dynamic> _getStatusInfo() {
    switch (data.status.toLowerCase()) {
      case 'successful':
      case 'completed':
      case 'success':
        return {
          'text': 'Successful',
          'backgroundColor': const Color(0xFFE8F5E8),
          'textColor': AppColors.success,
          'iconColor': const Color(0xFFFFFFF),
        };
      case 'failed':
      case 'declined':
      case 'error':
        return {
          'text': 'Failed',
          'backgroundColor': const Color(0xFFFFEBEE),
          'textColor': AppColors.errorText,
          'iconColor': AppColors.error,
        };
      case 'pending':
      case 'processing':
        return {
          'text': 'Pending',
          'backgroundColor': const Color(0xFFF5F5F5),
          'textColor': AppColors.pending,
          'iconColor': AppColors.pending,
        };
      default:
        return {
          'text': data.status,
          'backgroundColor': const Color(0xFFF5F5F5),
          'textColor': const Color(0xFF616161),
          'iconColor': const Color(0xFF9E9E9E),
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
