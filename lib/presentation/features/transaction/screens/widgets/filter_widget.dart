// lib/presentation/features/transaction/screens/widgets/transaction_filter_widget.dart

import 'package:bundlegram/core/extensions/responsive_extensions.dart';
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
  final bool useResponsive;

  const TransactionFilterWidget({
    Key? key,
    required this.onApply,
    this.useResponsive = true,
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
    final r = context.responsive;
    return Container(
      padding: EdgeInsets.all(
        widget.useResponsive ? r.spacing(16) : 16.w, // CHANGED
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            widget.useResponsive ? r.radiusSize(16) : 16.r, // CHANGED
          ),
        ),
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
            SizedBox(
              height: widget.useResponsive ? r.spacing(20) : 20.h, // CHANGED
            ),

            // ─── Sort by ───────────────────────────────────────────────────────────
            Text(
              'Sort by',
              style: context.textTheme.bodySmall!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: widget.useResponsive ? r.spacing(8) : 8.h, // CHANGED
            ),
            // Row(
            //   children: [
            //     Transform.scale(
            //       scale: 1.2,
            //       child: Radio<String>(
            //         activeColor: AppColors.primaryColor,
            //         value: 'newest',
            //         groupValue: _sortBy,
            //         onChanged: (v) => setState(() => _sortBy = v!),
            //       ),
            //     ),
            //     Text(
            //       'Newest first',
            //       style: context.textTheme.bodySmall!
            //           .copyWith(color: AppColors.black),
            //     ),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Transform.scale(
            //       scale: 1.2,
            //       child: Radio<String>(
            //         activeColor: AppColors.primaryColor,
            //         value: 'oldest',
            //         groupValue: _sortBy,
            //         onChanged: (v) => setState(() => _sortBy = v!),
            //       ),
            //     ),
            //     Text(
            //       'Oldest first',
            //       style: context.textTheme.bodySmall!
            //           .copyWith(color: AppColors.black),
            //     ),
            //   ],
            // ),
            _buildRadioOption('newest', 'Newest first'),
            _buildRadioOption('oldest', 'Oldest first'),

            SizedBox(
              height: widget.useResponsive ? r.spacing(16) : 16.h, // CHANGED
            ),
            const Divider(
              color: AppColors.divider,
            ),

            // ─── Amount ─────────────────────────────────────────────────────────────
            SizedBox(
              height: widget.useResponsive ? r.spacing(8) : 8.h, // CHANGED
            ),
            Text(
              'Amount',
              style: context.textTheme.bodySmall!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: widget.useResponsive ? r.spacing(8) : 8.h, // CHANGED
            ),
            // Row(
            //   children: [
            //     Transform.scale(
            //       scale: 1.2,
            //       child: Radio<String>(
            //         activeColor: AppColors.primaryColor,
            //         value: 'largest',
            //         groupValue: _amountBy,
            //         onChanged: (v) => setState(() => _amountBy = v!),
            //       ),
            //     ),
            //     Text(
            //       'Largest first',
            //       style: context.textTheme.bodySmall!
            //           .copyWith(color: AppColors.black),
            //     ),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Transform.scale(
            //       scale: 1.2,
            //       child: Radio<String>(
            //         activeColor: AppColors.primaryColor,
            //         value: 'smallest',
            //         groupValue: _amountBy,
            //         onChanged: (v) => setState(() => _amountBy = v!),
            //       ),
            //     ),
            //     Text(
            //       'Smallest first',
            //       style: context.textTheme.bodySmall!
            //           .copyWith(color: AppColors.black),
            //     ),
            //   ],
            // ),
            _buildRadioOption('largest', 'Largest first', isAmount: true),
            _buildRadioOption('smallest', 'Smallest first', isAmount: true),

            SizedBox(
              height: widget.useResponsive ? r.spacing(16) : 16.h, // CHANGED
            ),

            const Divider(
              color: AppColors.divider,
            ),

            // ─── Status ─────────────────────────────────────────────────────────────
            SizedBox(
              height: widget.useResponsive ? r.spacing(8) : 8.h, // CHANGED
            ),
            Text(
              'Status',
              style: context.textTheme.bodySmall!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: widget.useResponsive ? r.spacing(8) : 8.h, // CHANGED
            ),
            // CheckboxListTile(
            //   controlAffinity: ListTileControlAffinity.leading,
            //   activeColor: AppColors.primaryColor,
            //   checkColor: Colors.white,
            //   contentPadding: EdgeInsets.zero,
            //   title: Text(
            //     'Pending',
            //     style: context.textTheme.bodySmall!
            //         .copyWith(color: AppColors.black),
            //   ),
            //   value: _statusSet.contains('pending'),
            //   onChanged: (val) {
            //     setState(() {
            //       if (val == true)
            //         _statusSet.add('pending');
            //       else
            //         _statusSet.remove('pending');
            //     });
            //   },
            // ),
            // CheckboxListTile(
            //   controlAffinity: ListTileControlAffinity.leading,
            //   activeColor: AppColors.primaryColor,
            //   checkColor: Colors.white,
            //   contentPadding: EdgeInsets.zero,
            //   title: Text(
            //     'Failed',
            //     style: context.textTheme.bodySmall!
            //         .copyWith(color: AppColors.black),
            //   ),
            //   value: _statusSet.contains('failed'),
            //   onChanged: (val) {
            //     setState(() {
            //       if (val == true)
            //         _statusSet.add('failed');
            //       else
            //         _statusSet.remove('failed');
            //     });
            //   },
            // ),
            // CheckboxListTile(
            //   controlAffinity: ListTileControlAffinity.leading,
            //   activeColor: AppColors.primaryColor,
            //   checkColor: Colors.white,
            //   contentPadding: EdgeInsets.zero,
            //   title: Text(
            //     'Successful',
            //     style: context.textTheme.bodySmall!
            //         .copyWith(color: AppColors.black),
            //   ),
            //   value: _statusSet.contains('successful'),
            //   onChanged: (val) {
            //     setState(() {
            //       if (val == true)
            //         _statusSet.add('successful');
            //       else
            //         _statusSet.remove('successful');
            //     });
            //   },
            // ),
            _buildCheckbox('pending', 'Pending'),
            _buildCheckbox('failed', 'Failed'),
            _buildCheckbox('successful', 'Successful'),

            SizedBox(
              height: widget.useResponsive ? r.spacing(16) : 16.h, // CHANGED
            ),
            const Divider(
              color: AppColors.divider,
            ),

            // ─── Type ─────────────────────────────────────────────────────────────────
            SizedBox(
              height: widget.useResponsive ? r.spacing(8) : 8.h, // CHANGED
            ),
            Text(
              'Type',
              style: context.textTheme.bodySmall!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: widget.useResponsive ? r.spacing(8) : 8.h, // CHANGED
            ),
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
            ].map((typeKey) => _buildTypeCheckbox(typeKey)).toList(),
            // .map((typeKey) => CheckboxListTile(
            //       controlAffinity: ListTileControlAffinity.leading,
            //       activeColor: AppColors.primaryColor,
            //       checkColor: Colors.white,
            //       contentPadding: EdgeInsets.zero,
            //       title: Text(
            //         typeKey[0].toUpperCase() + typeKey.substring(1),
            //         style: context.textTheme.bodySmall!
            //             .copyWith(color: AppColors.black),
            //       ),
            //       value: _typeSet.contains(typeKey),
            //       onChanged: (val) {
            //         setState(() {
            //           if (val == true)
            //             _typeSet.add(typeKey);
            //           else
            //             _typeSet.remove(typeKey);
            //         });
            //       },
            //     ))
            // .toList(),

            SizedBox(height: 24.h),

            // ─── Apply Button ─────────────────────────────────────────────────────────
            BundlegramButton(
              useResponsive: widget.useResponsive,
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
              height: widget.useResponsive ? r.spacing(48) : 48.h,
              buttonStyle: BundlegramButtonStyle.primary(),
            ),
            SizedBox(
              height: widget.useResponsive ? r.spacing(16) : 16.h, // CHANGED
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(String value, String label,
      {bool isAmount = false}) {
    final r = context.responsive;
    return Row(
      children: [
        Transform.scale(
          scale: 1.2,
          child: Radio<String>(
            activeColor: AppColors.primaryColor,
            value: value,
            groupValue: isAmount ? _amountBy : _sortBy,
            onChanged: (v) => setState(() {
              if (isAmount) {
                _amountBy = v!;
              } else {
                _sortBy = v!;
              }
            }),
          ),
        ),
        Text(
          label,
          style: context.textTheme.bodySmall!.copyWith(color: AppColors.black),
        ),
      ],
    );
  }

  Widget _buildCheckbox(String value, String label) {
    final r = context.responsive;
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: AppColors.primaryColor,
      checkColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      title: Text(
        label,
        style: context.textTheme.bodySmall!.copyWith(color: AppColors.black),
      ),
      value: _statusSet.contains(value),
      onChanged: (val) {
        setState(() {
          if (val == true) {
            _statusSet.add(value);
          } else {
            _statusSet.remove(value);
          }
        });
      },
    );
  }

  Widget _buildTypeCheckbox(String typeKey) {
    final r = context.responsive;
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: AppColors.primaryColor,
      checkColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      title: Text(
        typeKey[0].toUpperCase() + typeKey.substring(1),
        style: context.textTheme.bodySmall!.copyWith(color: AppColors.black),
      ),
      value: _typeSet.contains(typeKey),
      onChanged: (val) {
        setState(() {
          if (val == true) {
            _typeSet.add(typeKey);
          } else {
            _typeSet.remove(typeKey);
          }
        });
      },
    );
  }
}
