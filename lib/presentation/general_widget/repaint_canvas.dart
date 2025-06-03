import 'package:bundlegram/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceiptCutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.fill;

    final path = Path();

    // Start from top-left
    path.moveTo(0, 0);

    // Create zigzag pattern across the top
    double zigzagWidth = 8.w;
    double zigzagHeight = 6.h;

    for (double x = 0; x < size.width; x += zigzagWidth) {
      bool isEven = ((x / zigzagWidth) % 2) == 0;
      if (isEven) {
        path.lineTo(x + zigzagWidth / 2, zigzagHeight);
        path.lineTo(x + zigzagWidth, 0);
      } else {
        path.lineTo(x + zigzagWidth / 2, -zigzagHeight);
        path.lineTo(x + zigzagWidth, 0);
      }
    }

    // Complete the rectangle
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
