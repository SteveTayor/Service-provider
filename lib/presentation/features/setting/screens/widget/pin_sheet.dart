import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'pin_content.dart';

class PinSheet extends StatelessWidget {
  const PinSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // height: 55-70% of screen depending on keyboard; adjust if needed
    final height = MediaQuery.of(context).size.height * 0.62;
    return SizedBox(
      height: height,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PinContent(compact: true),
        ],
      ),
    );
  }
}
