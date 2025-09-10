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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';

class CustomSnackBar {
  static void _showToast(
    String message, {
    required Color bgColor,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: bgColor,
      textColor: AppColors.white,
      fontSize: 14.sp,
    );
  }

  static void show(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    _showToast(message, bgColor: AppColors.primaryColor, duration: duration);
  }

  static void showError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    _showToast(message, bgColor: AppColors.errorText, duration: duration);
  }

  static void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    _showToast(message, bgColor: AppColors.primaryColor, duration: duration);
  }

  static void showWarning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    _showToast(message, bgColor: Colors.orange, duration: duration);
  }
}
