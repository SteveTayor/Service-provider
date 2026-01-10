// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
// import 'package:bundlegram/core/utils/colors.dart';

// class CustomSnackBar {
//   static void show(
//     BuildContext context,
//     String message, {
//     Duration duration = const Duration(seconds: 3),
//   }) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           message,
//           style: context.textTheme.bodySmall?.copyWith(
//             color: AppColors.white,
//           ),
//         ),
//         backgroundColor: AppColors.primaryColor,
//         duration: duration,
//         behavior: SnackBarBehavior.floating,
//         margin: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom + 16.w,
//           left: 16.w,
//           right: 16.w,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.r),
//         ),
//         elevation: 4,
//       ),
//     );
//   }

//   static void showError(
//     BuildContext context,
//     String message, {
//     Duration duration = const Duration(seconds: 3),
//   }) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             Icon(
//               Icons.error_outline,
//               color: AppColors.white,
//               size: 20,
//             ),
//             12.horizontalSpace,
//             Expanded(
//               child: Text(
//                 message,
//                 style: context.textTheme.bodySmall?.copyWith(
//                   color: AppColors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: Colors.red,
//         duration: duration,
//         behavior: SnackBarBehavior.floating,
//         margin: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom + 16.w,
//           left: 16.w,
//           right: 16.w,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.r),
//         ),
//         elevation: 4,
//       ),
//     );
//   }

//   static void showSuccess(
//     BuildContext context,
//     String message, {
//     Duration duration = const Duration(seconds: 3),
//   }) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             Icon(
//               Icons.check_circle_outline,
//               color: AppColors.white,
//               size: 20,
//             ),
//             12.horizontalSpace,
//             Expanded(
//               child: Text(
//                 message,
//                 style: context.textTheme.bodySmall?.copyWith(
//                   color: AppColors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: Colors.green,
//         duration: duration,
//         behavior: SnackBarBehavior.floating,
//         margin: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom + 16.w,
//           left: 16.w,
//           right: 16.w,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.r),
//         ),
//         elevation: 4,
//       ),
//     );
//   }

//   static void showWarning(
//     BuildContext context,
//     String message, {
//     Duration duration = const Duration(seconds: 3),
//   }) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             Icon(
//               Icons.warning_amber_outlined,
//               color: AppColors.white,
//               size: 20,
//             ),
//             12.horizontalSpace,
//             Expanded(
//               child: Text(
//                 message,
//                 style: context.textTheme.bodySmall?.copyWith(
//                   color: AppColors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: Colors.orange,
//         duration: duration,
//         behavior: SnackBarBehavior.floating,
//         margin: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom + 16.w,
//           left: 16.w,
//           right: 16.w,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.r),
//         ),
//         elevation: 4,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
// import 'package:bundlegram/core/utils/colors.dart';

// class CustomSnackBar {
//   static void _showToast(
//     String message, {
//     required Color bgColor,
//     IconData? icon,
//     Duration duration = const Duration(seconds: 3),
//   }) {
//     Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: bgColor,
//       textColor: AppColors.white,
//       fontSize: 14.sp,
//     );
//   }

//   static void show(
//     BuildContext context,
//     String message, {
//     Duration duration = const Duration(seconds: 3),
//   }) {
//     _showToast(message, bgColor: AppColors.primaryColor, duration: duration);
//   }

//   static void showError(
//     BuildContext context,
//     String message, {
//     Duration duration = const Duration(seconds: 3),
//   }) {
//     _showToast(message, bgColor: AppColors.errorText, duration: duration);
//   }

//   static void showSuccess(
//     BuildContext context,
//     String message, {
//     Duration duration = const Duration(seconds: 3),
//   }) {
//     _showToast(message, bgColor: AppColors.primaryColor, duration: duration);
//   }

//   static void showWarning(
//     BuildContext context,
//     String message, {
//     Duration duration = const Duration(seconds: 3),
//   }) {
//     _showToast(message, bgColor: Colors.orange, duration: duration);
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';

class CustomSnackBar {
  static void _showToast(
    BuildContext context,
    String message, {
    required Color bgColor,
    required Color textColor,
    Widget? icon,
    Duration duration = const Duration(seconds: 3),
    ToastificationType type = ToastificationType.info,
  }) {
    toastification.show(
      dismissDirection: DismissDirection.down,
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        // vertical: 8.h,
      ),
      context: context,
      type: type,
      style: ToastificationStyle.flat,
      title: Text(
        message,
        style: TextStyle(
          color: textColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      icon: icon,
      backgroundColor: bgColor,
      // foregroundColor: textColor,
      autoCloseDuration: duration,
      alignment: Alignment.bottomCenter,
      borderRadius: BorderRadius.circular(12.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
      showProgressBar: false,
      closeButtonShowType: CloseButtonShowType.none,
      pauseOnHover: false,
    );
  }

  static void show(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    _showToast(
      context,
      message,
      bgColor: AppColors.primaryColor,
      textColor: AppColors.white,
      icon: Icon(
        Icons.info_outline,
        color: AppColors.white,
        size: 24.sp,
      ),
      duration: duration,
      type: ToastificationType.info,
    );
  }

  static void showError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    _showToast(
      context,
      message,
      bgColor: AppColors.errorText,
      textColor: AppColors.white,
      icon: Icon(
        Icons.error,
        color: AppColors.white,
        size: 24.sp,
      ),
      duration: duration,
      type: ToastificationType.error,
    );
  }

  static void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    // Swapped colors: white background with primary color text
    _showToast(
      context,
      message,
      bgColor: AppColors.primaryColor,
      textColor: AppColors.white,
      icon: Image.asset(
        'assets/images/logo.png',
        width: 30.w,
        height: 30.h,
      ),
      duration: duration,
      type: ToastificationType.success,
    );
  }

  static void showWarning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    _showToast(
      context,
      message,
      bgColor: Colors.orange,
      textColor: AppColors.white,
      icon: Icon(
        Icons.warning_amber_rounded,
        color: AppColors.white,
        size: 24.sp,
      ),
      duration: duration,
      type: ToastificationType.warning,
    );
  }
}
