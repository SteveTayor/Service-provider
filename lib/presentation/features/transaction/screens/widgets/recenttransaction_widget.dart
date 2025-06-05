import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/service_provider.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/models/wallet/service_model.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/emptytransaction_widget.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/filter_sheet.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:bundlegram/presentation/general_widget/custom_listview.dart';
import 'package:bundlegram/presentation/general_widget/service_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          Text(
            'Recent transaction',
            style: context.textTheme.displayLarge!.copyWith(
              fontSize: 20.sp,
            ),
          ),
          40.verticalSpace,
          const Center(child: EmptytransactionWidget()),
        ],
      ),
    );
  }
}
// change the service icon to a widget to return since i have the icon as an svg image and i already have the component implemented in this form: AppSvgIcon(path: Assets.svgs.close)), so i already have the respective svg image for betting, cabletv, e-pin, electricity, education, ......

class RecentTransactionsScreen extends ConsumerWidget {
  const RecentTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentState = ref.watch(recentTransactionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // _showFilterDialog(context, ref);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: EdgeInsets.all(16.w),
            child: AppTextField(
              decoration: const InputDecoration().search().copyWith(
                    hintText: 'Search...',
                  ),
              onChange: (value) {
                ref.read(recentTransactionsProvider.notifier).search(value);
              },
            ),
          ),
          Text(
            'Recent transactions',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ).withContainer(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.all(12.w),
            border: Border.all(color: AppColors.primaryColor, width: 2),
            borderRadius: BorderRadius.circular(8.r),
          ),

          SizedBox(height: 16.h),

          // List
          Expanded(
            child: CustomListView<ServiceModel>(
              items: recentState.filteredServices,
              isLoading: recentState.isLoading,
              onRefresh: () async {
                ref.read(recentTransactionsProvider.notifier).refresh();
              },
              itemBuilder: (service, index) =>
                  ServiceListItem(service: service),
              onItemTap: (service, index) {
                _navigateToServiceDetails(context, service);
              },
              separatorBuilder: (context, index) => Container(
                height: 1,
                color: AppColors.greyD0.withOpacity(0.3),
                margin: context.symmetricPadding(
                  8.w,
                  0,
                ),
              ),
              emptyWidget: EmptytransactionWidget(),
            ),
          ),
        ],
      ),
    );
  }

  // void _showFilterDialog(BuildContext context, WidgetRef ref) {
  //   context.showBottomSheet(
  //     child: FilterBottomSheet(
  //       onFilterApplied: (filterType) {
  //         ref
  //             .read(recentTransactionsProvider.notifier)
  //             .filterByType(filterType);
  //       },
  //     ),
  //   );
  // }

  void _navigateToServiceDetails(BuildContext context, ServiceModel service) {
    // Navigate to specific service details based on type
    switch (service.type.toLowerCase()) {
      case 'betting':
        // Navigate to betting details
        break;
      case 'mobile data':
        // Navigate to data details
        break;
      case 'education':
        // Navigate to education details
        break;
      // Add other cases...
    }
  }
}
