import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TransactionFilterWidget extends StatefulWidget {
  const TransactionFilterWidget({super.key});

  @override
  State<TransactionFilterWidget> createState() =>
      _TransactionFilterWidgetState();
}

class _TransactionFilterWidgetState extends State<TransactionFilterWidget> {
  String sortBy = 'newest';
  String amount = 'largest';
  List<String> status = [];
  List<String> type = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Center(
                      child: Text(
                'Filters',
                style: context.textTheme.bodyMedium,
              ))),
              InkWell(
                onTap: () {
                  context.pop();
                },
                child: AppSvgIcon(path: Assets.svgs.close),
              ),
            ],
          ),
          const SizedBox(height: 20),

          /// Sort By
          const Text('Sort by'),
          Row(
            children: [
              Transform.scale(
                scale: 1.5,
                child: Radio(
                  activeColor: Colors.black,
                  value: 'new',
                  groupValue: sortBy,
                  onChanged: (value) => setState(() => sortBy = value!),
                ),
              ),
              Text(
                'Newest first (default)',
                style: context.textTheme.bodySmall!.copyWith(
                  color: AppColors.black,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Transform.scale(
                scale: 1.5,
                child: Radio(
                  activeColor: Colors.black,
                  value: 'new',
                  groupValue: sortBy,
                  onChanged: (value) => setState(() => sortBy = value!),
                ),
              ),
              Text(
                'Newest first (default)',
                style: context.textTheme.bodySmall!.copyWith(
                  color: AppColors.black,
                ),
              ),
            ],
          ),

          /// Amount
          const Divider(),
          const Text('Amount'),
          Row(
            children: [
              Transform.scale(
                scale: 1.5,
                child: Radio(
                  activeColor: Colors.black,
                  value: '',
                  groupValue: sortBy,
                  onChanged: (value) => setState(() => sortBy = value!),
                ),
              ),
              Text(
                'Largest first',
                style: context.textTheme.bodySmall!.copyWith(
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Transform.scale(
                scale: 1.5,
                child: Radio(
                  activeColor: Colors.black,
                  value: '',
                  groupValue: sortBy,
                  onChanged: (value) => setState(() => sortBy = value!),
                ),
              ),
              Text(
                'Smallest first',
                style: context.textTheme.bodySmall!.copyWith(
                  color: AppColors.black,
                ),
              ),
            ],
          ),

          /// Status
          const Divider(),
          const Text('Status'),
          CheckboxListTile(
            title: Text(
              'Pending',
              style: context.textTheme.bodySmall!.copyWith(
                color: AppColors.black,
              ),
            ),
            value: status.contains('pending'),
            onChanged: (val) {
              setState(() {
                val! ? status.add('pending') : status.remove('pending');
              });
            },
          ),
          CheckboxListTile(
            title: Text(
              'Failed',
              style: context.textTheme.bodySmall!.copyWith(
                color: AppColors.black,
              ),
            ),
            value: status.contains('failed'),
            onChanged: (val) {
              setState(() {
                val! ? status.add('failed') : status.remove('failed');
              });
            },
          ),
          CheckboxListTile(
            title: Text(
              'Successfull',
              style: context.textTheme.bodySmall!.copyWith(
                color: AppColors.black,
              ),
            ),
            value: status.contains('successful'),
            onChanged: (val) {
              setState(() {
                val! ? status.add('successful') : status.remove('successful');
              });
            },
          ),

          /// Type
          const Divider(),
          const Text('Type'),
          CheckboxListTile(
            title: Text(
              'Top-up',
              style: context.textTheme.bodySmall!.copyWith(
                color: AppColors.black,
              ),
            ),
            value: type.contains('topup'),
            onChanged: (val) {
              setState(() {
                val! ? type.add('topup') : type.remove('topup');
              });
            },
          ),

          /// Apply Button
          40.verticalSpace,
          BundlegramButton(
            text: 'Apply',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
