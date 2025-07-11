import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bundlegram/presentation/general_widget/app_loader.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';

extension DialogLoaderExtension on BuildContext {
  Future<void> showLoadingDialog({String? message}) async {
    await showCupertinoDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: Material(
          color: Colors.black.withOpacity(0.2),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(24.w),
              margin: EdgeInsets.symmetric(horizontal: 32.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppLoader(size: 30),
                  if (message != null) ...[
                    SizedBox(height: 16.h),
                    Text(
                      message,
                      style: Theme.of(this).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void dismissDialog() {
    Navigator.of(this, rootNavigator: true).pop();
  }
}
