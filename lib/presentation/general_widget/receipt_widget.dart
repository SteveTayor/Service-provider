import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_formatter.dart';
import 'package:bundlegram/data/models/transaction_receipt/transaction_receipt_model.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/receipt_brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class VisualReceiptCard extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.r),
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
                    // fontSize: 18,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 12.h),
                Divider(color: AppColors.greyD0.withOpacity(0.3), thickness: 1),
                SizedBox(height: 12.h),
                Text(
                  data.amount.toString(),
                  style: context.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    // fontSize: 30,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                _buildStatusIndicator(),
                SizedBox(height: 10.h),
              ],
            ),
          ),

          // Transaction details
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: ListView(
                children: [
                  if (data.type?.toLowerCase() != 'electricity') ...[
                    _buildDetailRow(
                        context, 'Transaction type', getTransactionType()),
                  ] else ...[
                    _buildDetailRow(context, 'Transaction type', data.type!),
                  ],
                  if (data.accountNumber != null) ...[
                    16.verticalSpace,
                    _buildDetailRow(
                        context, 'Beneficiary', data.accountNumber!),
                  ],
                  16.verticalSpace,
                  _buildDetailRow(
                      context, 'Transaction ID', data.transactionId!),
                  16.verticalSpace,
                  _buildDetailRow(context, 'Date', data.date!),
                  16.verticalSpace,
                  _buildDetailRow(context, 'Time', data.time!),
                  if (data.token != null) ...[
                    16.verticalSpace,
                    _buildDetailRow(context, 'Token', data.token!),
                  ],
                ],
              ),
            ),
          ),

          // Branding
          ReceiptBrandingWidget(
            logoWidget: Image(
              image: Assets.images.bBundlegram.provider(),
              fit: BoxFit.contain,
            ).withContainer(
              height: 39.h,
            ),
          ),
          16.verticalSpace,
        ],
      ),
    );
  }

  String getTransactionType() {
    switch (data.type?.toLowerCase()) {
      case 'mobile_data':
        return 'Mobile Data';
      case 'electricity':
        return 'Electricity';
      case 'airtime':
        return 'Airtime';
      case 'cable_tv':
        return 'Cable TV';
      case 'internet_service':
        return 'Internet Service';
      case 'fund_wallet':
        return 'Top-up';
      case 'withdrawal':
        return 'Withdrawal';
      case 'betting':
        return 'Betting';
      default:
        return data.type!.capiTalizeFirstLast;
    }
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
            // fontSize: 14,
          ),
        ),
        SizedBox(width: 8.w),
        Flexible(
          child: Text(
            value,
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w500,
              // fontSize: 14,
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
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: statusInfo['backgroundColor'] as Color,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSvgIcon(
            width: 20,
            height: 20,
            path: statusInfo['icon'] as String,
            color: statusInfo['iconColor'] as Color,
          ),
          SizedBox(width: 8.w),
          Text(
            statusInfo['text'] as String,
            style: TextStyle(
              color: statusInfo['textColor'] as Color,
              fontWeight: FontWeight.w600,
              // fontSize: 14,
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
class ReceiptShareWrapper extends StatefulWidget {
  final TransactionReceiptData data;

  const ReceiptShareWrapper({super.key, required this.data});

  @override
  State<ReceiptShareWrapper> createState() => _ReceiptShareWrapperState();
}

class _ReceiptShareWrapperState extends State<ReceiptShareWrapper> {
  final GlobalKey _boundaryKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(
          const Duration(milliseconds: 400)); // Give the widget time to paint
      _captureAndShare();
    });
  }

  Future<void> _captureAndShare() async {
    try {
      // final boundary = _boundaryKey.currentContext?.findRenderObject()
      //     as RenderRepaintBoundary?;
      RenderRepaintBoundary? boundary;
      int attempts = 0;
      // Wait until render is complete or max attempts reached
      while ((boundary = _boundaryKey.currentContext?.findRenderObject()
                      as RenderRepaintBoundary?)
                  ?.debugNeedsPaint ==
              true &&
          attempts < 5) {
        await Future.delayed(const Duration(milliseconds: 300));
        attempts++;
      }

      if (boundary == null) {
        debugPrint("Boundary not ready");
        return;
      }

      // Ensure it's painted before capturing
      if (boundary.debugNeedsPaint) {
        await Future.delayed(const Duration(milliseconds: 300));
        return _captureAndShare(); // retry once
      }

      unawaited(context.showLoadingDialog(message: 'Downloading ...'));
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final filePath =
          '${tempDir.path}/bundlegram_receipt_${DateTime.now().millisecondsSinceEpoch}.png';

      final file = File(filePath);
      await file.writeAsBytes(pngBytes);
      context.dismissDialog();
      await SharePlus.instance.share(
        ShareParams(
          text: 'TXN_bundlegram_receipt',
          files: [XFile(file.path)],
          title: 'Transaction Receipt',
        ),
      );
      context.showCustomSnackBar('Transaction receipt downloaded successfully');
      if (mounted) Navigator.pop(context); // close the popup after sharing
    } catch (e) {
      context.dismissDialog();
      debugPrint('Share failed: ${e.toString()}');
      if (mounted) {
        context.showErrorSnackBar('Failed to share receipt');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _boundaryKey,
      child: VisualReceiptCard(data: widget.data),
    );
  }
}
