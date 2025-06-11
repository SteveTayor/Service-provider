// import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
// import 'package:bundlegram/core/utils/colors.dart';
// import 'package:bundlegram/core/utils/styles.dart';
// import 'package:bundlegram/data/models/transaction_receipt/transaction_receipt_model.dart';
// import 'package:bundlegram/presentation/general_widget/app_button.dart';
// import 'package:bundlegram/presentation/general_widget/repaint_canvas.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class TransactionReceiptWidget extends StatelessWidget {
//   const TransactionReceiptWidget({
//     super.key,
//     required this.data,
//     this.onShareReceipt,
//     this.onClose,
//     this.showShareButton = true,
//   });

//   final TransactionReceiptData data;
//   final VoidCallback? onShareReceipt;
//   final VoidCallback? onClose;
//   final bool showShareButton;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // Main receipt container with fixed height
//         Container(
//           width: MediaQuery.of(context).size.width,
//           height: 573.h,
//           clipBehavior: Clip.hardEdge,
//           decoration: BoxDecoration(
//             // color: AppColors.white,
//             color: Colors.transparent,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(16.r),
//               topRight: Radius.circular(16.r),
//             ),
//           ),
//           child: Column(
//             children: [
//               // Fixed header with title and close button
//               Container(
//                 padding: EdgeInsets.fromLTRB(24.w, 24.h, 16.w, 0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         'Transaction details',
//                         style: context.textTheme.headlineMedium,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: onClose ?? () => Navigator.of(context).pop(),
//                       child: Container(
//                         padding: EdgeInsets.all(8.w),
//                         child: Icon(
//                           Icons.close,
//                           size: 20.w,
//                           color: AppColors.grey33,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: 24.h),

//               // Scrollable transaction details section
//               Expanded(
//                 child: SingleChildScrollView(
//                   padding: EdgeInsets.symmetric(horizontal: 24.w),
//                   child: Column(
//                     children: [
//                       ..._buildTransactionDetails(context),
//                       SizedBox(height: 16.h), // Extra space at bottom
//                     ],
//                   ),
//                 ),
//               ),

//               // Fixed bottom section with divider and button
//               Column(
//                 children: [
//                   // _buildDashedDivider(context),
//                   if (showShareButton) ...[
//                     Padding(
//                       padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 16.h),
//                       child: BundlegramButton(
//                         text: 'Share receipt',
//                         width: double.infinity,
//                         height: 48.h,
//                         onPressed: onShareReceipt ?? () {},
//                         buttonStyle: BundlegramButtonStyle.primary(),
//                       ),
//                     ),
//                   ] else ...[
//                     SizedBox(height: 16.h),
//                   ],
//                 ],
//               ),
//             ],
//           ),
//         ),

//         // Receipt cut/tear effect at the bottom
//         _buildReceiptCutEdge(),
//       ],
//     );
//   }

//   /// Builds a dashed divider line
//   Widget _buildDashedDivider(BuildContext context) {
//     return Container(
//       width: 100,
//       height: 1,
//       child: Row(
//         children: List.generate(
//           (context.size!.width / 8).floor(),
//           (index) => Expanded(
//             child: Container(
//               height: 1.h,
//               margin: EdgeInsets.symmetric(horizontal: 2.w),
//               color: index.isEven ? AppColors.divider : Colors.transparent,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// Builds the characteristic receipt cut/tear edge at the bottom
//   Widget _buildReceiptCutEdge() {
//     return Container(
//       height: 20.h,
//       width: double.infinity,
//       child: CustomPaint(
//         foregroundPainter: ReceiptCutPainter(),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildTransactionDetails(BuildContext context) {
//     final details = [
//       _TransactionDetailItem(
//         label: 'Transaction ID',
//         value: data.transactionId,
//         showCopyIcon: true,
//       ),
//       _TransactionDetailItem(
//         label: 'Date',
//         value: data.date,
//       ),
//       _TransactionDetailItem(
//         label: 'Time',
//         value: data.time,
//       ),
//       _TransactionDetailItem(
//         label: 'Type',
//         value: data.type,
//       ),
//       _TransactionDetailItem(
//         label: 'Amount',
//         value: data.amount,
//         valueStyle: context.textTheme.bodyMedium?.copyWith(
//           fontWeight: FontWeight.w600,
//           color: AppColors.black,
//         ),
//       ),
//       _TransactionDetailItem(
//         label: 'Bank name',
//         value: data.bankName,
//       ),
//       _TransactionDetailItem(
//         label: 'Account number',
//         value: data.accountNumber,
//       ),
//       _TransactionDetailItem(
//         label: 'Transaction status',
//         value: data.status,
//         valueColor: _getStatusColor(),
//       ),
//     ];

//     // Add optional fields if they exist
//     if (data.description != null) {
//       details.add(
//         _TransactionDetailItem(
//           label: 'Description',
//           value: data.description!,
//         ),
//       );
//     }

//     if (data.reference != null) {
//       details.add(
//         _TransactionDetailItem(
//           label: 'Reference',
//           value: data.reference!,
//         ),
//       );
//     }

//     return details
//         .map(
//           (detail) => Padding(
//             padding: EdgeInsets.only(bottom: 40.h),
//             child: detail,
//           ),
//         )
//         .toList();
//   }

//   Color _getStatusColor() {
//     switch (data.status.toLowerCase()) {
//       case 'successful':
//       case 'completed':
//       case 'success':
//         return AppColors.success;
//       case 'failed':
//       case 'declined':
//         return AppColors.errorText;
//       case 'pending':
//       case 'processing':
//         return AppColors.pending;
//       default:
//         return AppColors.grey33;
//     }
//   }
// }

// class _TransactionDetailItem extends StatelessWidget {
//   const _TransactionDetailItem({
//     required this.label,
//     required this.value,
//     this.showCopyIcon = false,
//     this.valueColor,
//     this.valueStyle,
//   });

//   final String label;
//   final String value;
//   final bool showCopyIcon;
//   final Color? valueColor;
//   final TextStyle? valueStyle;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           flex: 2,
//           child: Text(
//             label,
//             style: context.textTheme.bodySmall?.copyWith(
//               color: AppColors.grey33,
//               fontSize: 14.sp,
//             ),
//           ),
//         ),
//         SizedBox(width: 16.w),
//         Expanded(
//           flex: 3,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Flexible(
//                 child: Text(
//                   value,
//                   style: valueStyle ??
//                       context.textTheme.bodyMedium?.copyWith(
//                         color: valueColor ?? AppColors.black,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 14.sp,
//                       ),
//                   textAlign: TextAlign.right,
//                 ),
//               ),
//               if (showCopyIcon) ...[
//                 SizedBox(width: 8.w),
//                 GestureDetector(
//                   onTap: () => _copyToClipboard(value),
//                   child: Icon(
//                     Icons.copy_all_rounded,
//                     size: 16.w,
//                     color: AppColors.black,
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   void _copyToClipboard(String text) {
//     Clipboard.setData(ClipboardData(text: text));
//   }
// }
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/styles.dart';
import 'package:bundlegram/data/models/transaction_receipt/transaction_receipt_model.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/customizable.row.dart';
import 'package:bundlegram/presentation/general_widget/dash_paint.dart';
import 'package:bundlegram/presentation/general_widget/repaint_canvas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionReceiptWidget extends StatelessWidget {
  const TransactionReceiptWidget({
    super.key,
    required this.data,
    this.onShareReceipt,
    this.onClose,
    this.showShareButton = true,
  });

  final TransactionReceiptData data;
  final VoidCallback? onShareReceipt;
  final VoidCallback? onClose;
  final bool showShareButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Main receipt container with fixed height
        Container(
          width: MediaQuery.of(context).size.width,
          height: 573.h,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
          ),
          child: Column(
            children: [
              // Fixed header with title and close button
              Container(
                padding: EdgeInsets.fromLTRB(24.w, 24.h, 16.w, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomizableRow(
                        flexValues: [10, 1],
                        children: [
                          Center(
                            child: Text(
                              'Transaction details',
                              style: context.textTheme.headlineMedium!.copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClose ?? () => Navigator.of(context).pop(),
                            child: Container(
                                padding: EdgeInsets.all(4.w),
                                child: AppSvgIcon(path: Assets.svgs.close)),
                          ),
                        ],
                      ),
                    ),
                    // Expanded(
                    //   child: Text(
                    //     'Transaction details',
                    //     style: context.textTheme.headlineMedium,
                    //   ),
                    // ),
                    // GestureDetector(
                    //   onTap: onClose ?? () => Navigator.of(context).pop(),
                    //   child: Container(
                    //     padding: EdgeInsets.all(8.w),
                    //     child: Icon(
                    //       Icons.close,
                    //       size: 20.w,
                    //       color: AppColors.grey33,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),

              SizedBox(height: 40.h),

              // Scrollable transaction details section
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      ..._buildTransactionDetails(context),
                      SizedBox(height: 16.h), // Extra space at bottom
                    ],
                  ),
                ),
              ),

              // Fixed bottom section with divider and button
              Column(
                children: [
                  _buildDashedDivider(),
                  8.verticalSpace,
                  if (showShareButton) ...[
                    Padding(
                      padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 40.h),
                      child: BundlegramButton(
                        text: 'Share receipt',
                        width: double.infinity,
                        height: 48.h,
                        onPressed: onShareReceipt ?? () {},
                        buttonStyle: BundlegramButtonStyle.primary(),
                      ),
                    ),
                  ] else ...[
                    SizedBox(height: 40.h),
                  ],
                ],
              ),
            ],
          ),
        ),

        // Receipt cut/tear effect at the bottom
        _buildReceiptCutEdge(),
      ],
    );
  }

  /// Builds a dashed divider line
  Widget _buildDashedDivider() {
    return Container(
      width: double.infinity,
      height: 1.h,
      child: CustomPaint(
        painter: DashedLinePainter(),
      ),
    );
  }

  /// Builds the characteristic receipt cut/tear edge at the bottom
  Widget _buildReceiptCutEdge() {
    return Container(
      height: 10.h,
      width: double.infinity,
      child: CustomPaint(
        painter: ReceiptCutPainter(),
        size: Size(double.infinity, 20.h),
      ),
    );
  }

  List<Widget> _buildTransactionDetails(BuildContext context) {
    final details = [
      _TransactionDetailItem(
        label: 'Transaction ID',
        value: data.transactionId,
        showCopyIcon: true,
      ),
      _TransactionDetailItem(
        label: 'Date',
        value: data.date,
      ),
      _TransactionDetailItem(
        label: 'Time',
        value: data.time,
      ),
      _TransactionDetailItem(
        label: 'Type',
        value: data.type,
      ),
      _TransactionDetailItem(
        label: 'Amount',
        value: data.amount,
        valueStyle: context.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
      ),
      if (data.bankName != null)
        _TransactionDetailItem(
          label: 'Bank name',
          value: data.bankName!,
        ),
      if (data.accountNumber != null)
        _TransactionDetailItem(
          label: 'Account number',
          value: data.accountNumber!,
        ),
      _TransactionDetailItem(
        label: 'Transaction status',
        value: data.status,
        valueColor: _getStatusColor(),
      ),
    ];

    // Add optional fields if they exist
    if (data.description != null) {
      details.add(
        _TransactionDetailItem(
          label: 'Description',
          value: data.description!,
        ),
      );
    }

    if (data.reference != null) {
      details.add(
        _TransactionDetailItem(
          label: 'Reference',
          value: data.reference!,
        ),
      );
    }

    return details
        .map(
          (detail) => Padding(
            padding: EdgeInsets.only(bottom: 24.h),
            child: detail,
          ),
        )
        .toList();
  }

  Color _getStatusColor() {
    switch (data.status.toLowerCase()) {
      case 'successful':
      case 'completed':
      case 'success':
        return AppColors.success;
      case 'failed':
      case 'declined':
        return AppColors.errorText;
      case 'pending':
      case 'processing':
        return AppColors.pending;
      default:
        return AppColors.grey33;
    }
  }
}

class _TransactionDetailItem extends StatelessWidget {
  const _TransactionDetailItem({
    required this.label,
    required this.value,
    this.showCopyIcon = false,
    this.valueColor,
    this.valueStyle,
  });

  final String label;
  final String value;
  final bool showCopyIcon;
  final Color? valueColor;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.grey33,
              fontSize: 14.sp,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  value,
                  style: valueStyle ??
                      context.textTheme.bodyMedium?.copyWith(
                        color: valueColor ?? AppColors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                  textAlign: TextAlign.right,
                ),
              ),
              if (showCopyIcon) ...[
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: () => _copyToClipboard(value),
                  child: AppSvgIcon(path: Assets.svgs.copy),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
