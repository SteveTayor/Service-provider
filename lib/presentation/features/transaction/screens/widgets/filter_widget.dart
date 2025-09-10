// lib/presentation/features/transaction/screens/widgets/transaction_filter_widget.dart

import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/styles.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TransactionFilterWidget extends StatefulWidget {
  final void Function({
    required String sortBy,
    required String amountBy,
    required Set<String> statusSet,
    required Set<String> typeSet,
  }) onApply;

  const TransactionFilterWidget({
    Key? key,
    required this.onApply,
  }) : super(key: key);

  @override
  State<TransactionFilterWidget> createState() =>
      _TransactionFilterWidgetState();
}

class _TransactionFilterWidgetState extends State<TransactionFilterWidget> {
  String _sortBy = 'newest';
  String _amountBy = 'largest';
  final Set<String> _statusSet = {};
  final Set<String> _typeSet = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Filters',
                      style: context.textTheme.titleSmall,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => context.pop(),
                  child: AppSvgIcon(path: Assets.svgs.close),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // ─── Sort by ───────────────────────────────────────────────────────────
            Text(
              'Sort by',
              style: context.textTheme.bodySmall!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Transform.scale(
                  scale: 1.2,
                  child: Radio<String>(
                    activeColor: AppColors.primaryColor,
                    value: 'newest',
                    groupValue: _sortBy,
                    onChanged: (v) => setState(() => _sortBy = v!),
                  ),
                ),
                Text(
                  'Newest first',
                  style: context.textTheme.bodySmall!
                      .copyWith(color: AppColors.black),
                ),
              ],
            ),
            Row(
              children: [
                Transform.scale(
                  scale: 1.2,
                  child: Radio<String>(
                    activeColor: AppColors.primaryColor,
                    value: 'oldest',
                    groupValue: _sortBy,
                    onChanged: (v) => setState(() => _sortBy = v!),
                  ),
                ),
                Text(
                  'Oldest first',
                  style: context.textTheme.bodySmall!
                      .copyWith(color: AppColors.black),
                ),
              ],
            ),

            SizedBox(height: 16.h),
            const Divider(
              color: AppColors.divider,
            ),

            // ─── Amount ─────────────────────────────────────────────────────────────
            SizedBox(height: 8.h),
            Text(
              'Amount',
              style: context.textTheme.bodySmall!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Transform.scale(
                  scale: 1.2,
                  child: Radio<String>(
                    activeColor: AppColors.primaryColor,
                    value: 'largest',
                    groupValue: _amountBy,
                    onChanged: (v) => setState(() => _amountBy = v!),
                  ),
                ),
                Text(
                  'Largest first',
                  style: context.textTheme.bodySmall!
                      .copyWith(color: AppColors.black),
                ),
              ],
            ),
            Row(
              children: [
                Transform.scale(
                  scale: 1.2,
                  child: Radio<String>(
                    activeColor: AppColors.primaryColor,
                    value: 'smallest',
                    groupValue: _amountBy,
                    onChanged: (v) => setState(() => _amountBy = v!),
                  ),
                ),
                Text(
                  'Smallest first',
                  style: context.textTheme.bodySmall!
                      .copyWith(color: AppColors.black),
                ),
              ],
            ),

            SizedBox(height: 16.h),
            const Divider(
              color: AppColors.divider,
            ),

            // ─── Status ─────────────────────────────────────────────────────────────
            SizedBox(height: 8.h),
            Text(
              'Status',
              style: context.textTheme.bodySmall!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: AppColors.primaryColor,
              checkColor: Colors.white,
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Pending',
                style: context.textTheme.bodySmall!
                    .copyWith(color: AppColors.black),
              ),
              value: _statusSet.contains('pending'),
              onChanged: (val) {
                setState(() {
                  if (val == true)
                    _statusSet.add('pending');
                  else
                    _statusSet.remove('pending');
                });
              },
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: AppColors.primaryColor,
              checkColor: Colors.white,
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Failed',
                style: context.textTheme.bodySmall!
                    .copyWith(color: AppColors.black),
              ),
              value: _statusSet.contains('failed'),
              onChanged: (val) {
                setState(() {
                  if (val == true)
                    _statusSet.add('failed');
                  else
                    _statusSet.remove('failed');
                });
              },
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: AppColors.primaryColor,
              checkColor: Colors.white,
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Successful',
                style: context.textTheme.bodySmall!
                    .copyWith(color: AppColors.black),
              ),
              value: _statusSet.contains('successful'),
              onChanged: (val) {
                setState(() {
                  if (val == true)
                    _statusSet.add('successful');
                  else
                    _statusSet.remove('successful');
                });
              },
            ),

            SizedBox(height: 16.h),
            const Divider(
              color: AppColors.divider,
            ),

            // ─── Type ─────────────────────────────────────────────────────────────────
            SizedBox(height: 8.h),
            Text(
              'Type',
              style: context.textTheme.bodySmall!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            // List all service types, with checkboxes on the left
            ...[
              'top-up',
              'withdrawal',
              'betting',
              'mobile data',
              'education',
              'cable tv',
              'electricity',
              'airtime',
              'e-pin voucher'
            ]
                .map((typeKey) => CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: AppColors.primaryColor,
                      checkColor: Colors.white,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        typeKey[0].toUpperCase() + typeKey.substring(1),
                        style: context.textTheme.bodySmall!
                            .copyWith(color: AppColors.black),
                      ),
                      value: _typeSet.contains(typeKey),
                      onChanged: (val) {
                        setState(() {
                          if (val == true)
                            _typeSet.add(typeKey);
                          else
                            _typeSet.remove(typeKey);
                        });
                      },
                    ))
                .toList(),

            SizedBox(height: 24.h),

            // ─── Apply Button ─────────────────────────────────────────────────────────
            BundlegramButton(
              text: 'Apply',
              onPressed: () {
                widget.onApply(
                  sortBy: _sortBy,
                  amountBy: _amountBy,
                  statusSet: _statusSet,
                  typeSet: _typeSet,
                );
              },
              width: double.infinity,
              height: 48.h,
              buttonStyle: BundlegramButtonStyle.primary(),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
