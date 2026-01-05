import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class BankAccountsShimmer extends StatelessWidget {
  const BankAccountsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Show 2-3 shimmer placeholders
          ...List.generate(3, (index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: const BankDetailShimmerItem(),
            );
          }),
          20.verticalSpace,
          // Shimmer for "Add another account" button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 20.h,
                width: 180.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================
// Single Bank Detail Shimmer Item
// ============================================
class BankDetailShimmerItem extends StatelessWidget {
  const BankDetailShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        color: const Color(0xffF1F5FF),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row (Account # and delete icon)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 14.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                Container(
                  height: 20.h,
                  width: 20.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
            12.verticalSpace,
            // Account number (large text)
            Container(
              height: 36.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            8.verticalSpace,
            // Bank name
            Container(
              height: 16.h,
              width: 150.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
