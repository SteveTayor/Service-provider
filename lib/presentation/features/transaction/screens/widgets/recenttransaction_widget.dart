import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/emptytransaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecenttransactionWidget extends StatelessWidget {
  const RecenttransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          24.verticalSpace,
          Text('Recent transaction',style: context.textTheme.displayLarge!.copyWith(
            fontSize: 20.sp,
          ),),
          40.verticalSpace,
          const Center(child: EmptytransactionWidget()),
        ],
      ),
    );
  }
}