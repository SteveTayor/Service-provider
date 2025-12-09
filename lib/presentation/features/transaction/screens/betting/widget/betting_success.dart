import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/data/models/transaction_receipt/transaction_receipt_model.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/presentation/general_widget/receipt_widget.dart';
import 'package:bundlegram/presentation/general_widget/result_widget.dart';
import 'package:bundlegram/presentation/general_widget/transaction_share_receipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BettingSuccessResultScreen extends StatelessWidget {
  final String amount;
  final String biller;

  final TransactionReceiptData? receipt;
  const BettingSuccessResultScreen({
    super.key,
    required this.amount,
    required this.biller,
    this.receipt,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pushReplacement(RouteConstants.dashboard);
        return false;
      },
      child: BundlegramScaffold(
        sidePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 40.h),
        body: ResultWidget(
          isReceipt: true,
          viewRecieptOnPressed: receipt == null
              ? null
              : () {
                  context.showPopUp(
                    color: Colors.transparent,
                    TransactionReceiptWidget(
                      data: receipt!,
                      onShareReceipt: () {
                        context
                          ..pop()
                          ..showPopUp(
                            color: Colors.transparent,
                            ReceiptShareWrapper(data: receipt!),
                            isDismissable: true,
                          );
                      },
                      onClose: () => context.pop(),
                    ),
                    isDismissable: true,
                  );
                },
          appIcon: AppSvgIcon(
            path: Assets.svgs.successfulIllustration,
          ),
          title: 'Payment successful!',
          subText:
              'Your payment of ${amount} to your ${biller} account wallet was successful.',
          buttonText: 'Go to home',
          onPressed: () {
            context.pushReplacement(RouteConstants.dashboard);
          },
        ),
      ),
    );
  }
}
