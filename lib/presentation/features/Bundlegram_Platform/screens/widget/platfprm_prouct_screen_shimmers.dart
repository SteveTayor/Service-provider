import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class PlatformProductShimmer extends StatelessWidget {
  const PlatformProductShimmer({
    Key? key,
    this.showSecondaryInput = false,
    this.showTabs = false,
    this.showDropdown = false,
    this.showGrid = true,
    this.gridItemCount = 6,
    this.isAmountGrid = false,
  }) : super(key: key);

  final bool showSecondaryInput;
  final bool showTabs;
  final bool showDropdown;
  final bool showGrid;
  final int gridItemCount;
  final bool isAmountGrid;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main input field (phone/biller)
            _ShimmerBox(
              height: 56.h,
              borderRadius: 8.r,
            ),

            // Beneficiary dropdown (for airtime/data)
            16.verticalSpace,
            _ShimmerBox(
              height: 56.h,
              borderRadius: 8.r,
            ),

            // Secondary input (for betting/cable/electricity)
            if (showSecondaryInput) ...[
              24.verticalSpace,
              _ShimmerBox(
                height: 56.h,
                borderRadius: 8.r,
              ),
            ],

            // Tabs (for electricity)
            if (showTabs) ...[
              16.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: _ShimmerBox(
                      height: 48.h,
                      borderRadius: 4.r,
                    ),
                  ),
                  2.horizontalSpace,
                  Expanded(
                    child: _ShimmerBox(
                      height: 48.h,
                      borderRadius: 4.r,
                    ),
                  ),
                ],
              ),
            ],

            // Dropdown (for data type/package selection)
            if (showDropdown) ...[
              24.verticalSpace,
              _ShimmerBox(
                height: 56.h,
                borderRadius: 8.r,
              ),
            ],

            // Grid of products/amounts
            if (showGrid) ...[
              24.verticalSpace,
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20.h,
                  crossAxisSpacing: 10.w,
                  childAspectRatio: isAmountGrid ? 1.6 : 1.4,
                ),
                itemCount: gridItemCount,
                itemBuilder: (_, i) => _ShimmerBox(
                  borderRadius: 8.r,
                ),
              ),

              // Amount input field (below grid)
              if (isAmountGrid) ...[
                24.verticalSpace,
                _ShimmerBox(
                  height: 56.h,
                  borderRadius: 8.r,
                ),
              ],

              // Selected bundle amount display (for mobile data)
              if (!isAmountGrid) ...[
                24.verticalSpace,
                _ShimmerBox(
                  height: 80.h,
                  borderRadius: 8.r,
                ),
              ],
            ],

            // Balance display
            24.verticalSpace,
            _ShimmerBox(
              height: 56.h,
              borderRadius: 6.r,
            ),

            // Continue button
            40.verticalSpace,
            _ShimmerBox(
              height: 56.h,
              borderRadius: 8.r,
            ),
          ],
        ),
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({
    Key? key,
    this.width,
    this.height,
    this.borderRadius,
  }) : super(key: key);

  final double? width;
  final double? height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 4),
      ),
    );
  }
}

// Extension for vertical space
extension IntExtension on int {
  SizedBox get verticalSpace => SizedBox(height: toDouble());
  SizedBox get horizontalSpace => SizedBox(width: toDouble());
}
