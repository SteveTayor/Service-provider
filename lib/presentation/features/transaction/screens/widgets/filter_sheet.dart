import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({
    super.key,
    required this.onFilterApplied,
  });

  final Function(String?) onFilterApplied;

  @override
  Widget build(BuildContext context) {
    final filterOptions = [
      {'title': 'All', 'value': null},
      {'title': 'Top-up', 'value': 'top-up'},
      {'title': 'Betting', 'value': 'betting'},
      {'title': 'Cable TV', 'value': 'cable tv'},
      {'title': 'Education', 'value': 'education'},
      {'title': 'Mobile Data', 'value': 'mobile data'},
      {'title': 'Electricity', 'value': 'electricity'},
      {'title': 'Airtime', 'value': 'airtime'},
      {'title': 'E-pin Voucher', 'value': 'e-pin voucher'},
    ];

    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filter by Service Type',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.h),
          ...filterOptions.map((option) => ListTile(
                title: Text(option['title'] as String),
                onTap: () {
                  onFilterApplied(option['value'] as String?);
                  Navigator.pop(context);
                },
              )),
        ],
      ),
    );
  }
}
