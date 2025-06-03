import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/data/models/transaction_receipt/transaction_receipt_model.dart';
import 'package:bundlegram/presentation/general_widget/transaction_share_receipt.dart';
import 'package:flutter/material.dart';

/// Extension method to show transaction receipt as a popup
extension TransactionReceiptDialog on BuildContext {
  Future<void> showTransactionReceipt({
    required TransactionReceiptData data,
    VoidCallback? onShareReceipt,
    bool showShareButton = true,
  }) {
    return showPopUp(
      TransactionReceiptWidget(
        data: data,
        onShareReceipt: onShareReceipt,
        showShareButton: showShareButton,
      ),
      isDismissable: true,
    );
  }
}
