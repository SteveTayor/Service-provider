import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/service_provider.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/models/wallet/service_model.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/emptytransaction_widget.dart';
import 'package:bundlegram/presentation/general_widget/custom_listview.dart';
import 'package:bundlegram/presentation/general_widget/service_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MobileDataHistoryScreen extends ConsumerWidget {
  const MobileDataHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataState = ref.watch(mobileDataHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Data History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterOptions(context, ref),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              decoration: const InputDecoration().search().copyWith(
                    hintText: 'Search transactions...',
                  ),
              onChanged: (value) {
                ref.read(mobileDataHistoryProvider.notifier).search(value);
              },
            ),
          ),

          // List
          Expanded(
            child: CustomListView<ServiceModel>(
              items: dataState.filteredServices,
              isLoading: dataState.isLoading,
              onRefresh: () =>
                  ref.read(mobileDataHistoryProvider.notifier).refresh(),
              itemBuilder: (service, index) =>
                  ServiceListItem(service: service),
              onItemTap: (service, index) {
                _showDataDetails(context, service);
              },
              emptyWidget: Builder(
                builder: (context) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EmptytransactionWidget(),
                      SizedBox(height: 16.h),
                      Text(
                        'No Data bundle history found',
                        style: context.textTheme.bodyMedium
                            ?.copyWith(color: AppColors.grey8E),
                      ),
                    ],
                  ),
                ),
              ),
              // _buildEmptyState('No data purchases found', Icons.wifi),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterOptions(BuildContext context, WidgetRef ref) {
    // Show filter bottom sheet
  }

  void _showDataDetails(BuildContext context, ServiceModel service) {
    // Show data purchase details
  }

  Widget _buildEmptyState(String message, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64.w, color: AppColors.grey8E),
          SizedBox(height: 16.h),
          Text(message,
              style: TextStyle(fontSize: 16.sp, color: AppColors.grey8E)),
        ],
      ),
    );
  }
}
