import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/models/dashboard/dashboard_data_response.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/platform_screen_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/core/providers/state/global_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class StatisticsDashboard extends ConsumerWidget {
  const StatisticsDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardDataAsync = ref.watch(globalProvider).dashboardData;

    return dashboardDataAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Failed to load statistics')),
      data: (data) {
        final barData = data?.data?.barData;
        final doughnutData = data?.data?.doughnutData;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Spacer(),
                    Center(
                      child: Text(
                        'Statistics',
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () => context.pop(),
                      child: AppSvgIcon(path: Assets.svgs.close),
                    ),
                  ],
                ),
                24.verticalSpace,

                /// Daily Transactions
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Daily transactions',
                            style: context.textTheme.bodySmall),
                        const SizedBox(), // No dropdown now; data is for current month
                      ],
                    ),
                    24.verticalSpace,
                    SizedBox(height: 224.h, child: _buildBarChart(barData!)),
                  ],
                ).withContainer(
                  border:
                      Border.all(width: 1.w, color: const Color(0xffE8EBEF)),
                  padding: context.symmetricPadding(10, 16),
                ),
                36.verticalSpace,

                /// Bill Distribution
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Bill distributed',
                        style: context.textTheme.bodySmall),
                    const SizedBox(),
                  ],
                ),
                24.verticalSpace,
                SizedBox(
                  height: 350.h,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 3,
                        child: _buildPieChart(doughnutData!),
                      ),
                      Flexible(
                        child: _buildLegend(doughnutData),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBarChart(List<BarDatum> data) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: _getMaxY(data),
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  // axisSide: meta.axisSide,
                  space: 4,
                  meta: meta,
                  child: Text('${value.toInt()}',
                      style: const TextStyle(fontSize: 12)),
                );
              },
              reservedSize: 30,
            ),
          ),
          leftTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          topTitles: const AxisTitles(),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: data.map((item) {
          final x = int.tryParse(item.day) ?? 0;
          return BarChartGroupData(
            x: x,
            barRods: [
              BarChartRodData(
                toY: item.amount.toDouble(),
                color: AppColors.primaryColor,
                width: 20,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  double _getMaxY(List<BarDatum> data) {
    final maxAmount = data.map((e) => e.amount).fold<double>(
        0, (prev, amount) => amount > prev ? amount.toDouble() : prev);
    return (maxAmount * 1.2).clamp(10000, 100000);
  }

  Widget _buildPieChart(List<DoughnutDatum> data) {
    final total = data.fold<int>(0, (sum, item) => sum + item.value);
    return Stack(
      children: [
        PieChart(
          PieChartData(
            sections: data.map((item) {
              final value = item.value.toDouble();
              return PieChartSectionData(
                color: _categoryColor(item.label),
                value: value,
                title: '',
                radius: 80,
              );
            }).toList(),
            centerSpaceRadius: 50,
            sectionsSpace: 0,
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Total: ₦${_formatCurrency(total)}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegend(List<DoughnutDatum> data) {
    return Wrap(
      spacing: 20,
      children: data.map((item) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: _categoryColor(item.label),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(item.label),
          ],
        );
      }).toList(),
    );
  }

  String _formatCurrency(int amount) {
    return amount
        .toString()
        .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',');
  }

  Color _categoryColor(String label) {
    switch (label) {
      case 'mobile_data':
        return Colors.blue;
      case 'airtime':
        return Colors.orange;
      case 'bill_payment':
        return Colors.red;
      case 'fund_wallet':
        return Colors.green;
      case 'merchant':
        return Colors.purple;
      case 'withdrawal':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }
}

// class StatisticsDashboard extends StatefulWidget {
//   const StatisticsDashboard({super.key});

//   @override
//   State<StatisticsDashboard> createState() => _StatisticsDashboardState();
// }

// class _StatisticsDashboardState extends State<StatisticsDashboard> {
//   String selectedTransactionMonth = 'January 2024';
//   String selectedBillsMonth = 'January 2024';

//   // Sample data for daily transactions
//   final List<TransactionData> dailyTransactions = [
//     TransactionData(18, 7000),
//     TransactionData(19, 4000),
//     TransactionData(20, 8500),
//     TransactionData(21, 1500),
//     TransactionData(22, 6000),
//     TransactionData(23, 3000),
//     TransactionData(24, 5000),
//   ];

//   // Sample data for bill distribution
//   final List<BillDistributionData> billDistribution = [
//     BillDistributionData('Data', 35, Colors.red),
//     BillDistributionData('Bills payment', 43, Colors.pink.shade100),
//     BillDistributionData('Airtime', 22, Colors.orange),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Center(
//                     child: Text(
//                       'Statistics',
//                       style: context.textTheme.bodyMedium,
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     context.pop();
//                   },
//                   child: AppSvgIcon(path: Assets.svgs.close),
//                 ),
//               ],
//             ),
//             24.verticalSpace,

//             // Daily transactions section
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         'Daily transactions',
//                         style: context.textTheme.bodySmall,
//                       ),
//                     ),
//                     _buildDropdown(
//                       selectedTransactionMonth,
//                       (String? newValue) {
//                         setState(() {
//                           selectedTransactionMonth = newValue!;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//                 24.verticalSpace,
//                 SizedBox(
//                   height: 224.h, // Already adaptive
//                   child: _buildBarChart(),
//                 ),
//               ],
//             ).withContainer(
//               border: Border.all(width: 1.w, color: const Color(0xffE8EBEF)),
//               padding: context.symmetricPadding(10, 16),
//             ),
//             const SizedBox(height: 36),

//             // Bill distributed section
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Bill distributed',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 _buildDropdown(
//                   selectedBillsMonth,
//                   (String? newValue) {
//                     setState(() {
//                       selectedBillsMonth = newValue!;
//                     });
//                   },
//                 ),
//               ],
//             ),
//             24.verticalSpace,
//             SizedBox(
//               height: 350.h, // Changed to adaptive height
//               child: Column(
//                 children: [
//                   Flexible(
//                     flex: 3,
//                     child: _buildPieChart(),
//                   ),
//                   Flexible(child: _buildLegend()),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdown(String value, Function(String?) onChanged) {
//     return Container(
//       height: 36.h,
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//       decoration: BoxDecoration(
//         border: Border.all(color: const Color(0xffDBDEE2)),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: DropdownButton<String>(
//         style: context.textTheme.labelMedium,
//         value: value,
//         dropdownColor: AppColors.white,
//         icon: AppSvgIcon(path: Assets.svgs.chevronDown),
//         underline: const Material(),
//         items: <String>[
//           'January 2024',
//           'February 2024',
//           'March 2024',
//         ].map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(value),
//           );
//         }).toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }

//   Widget _buildBarChart() {
//     return BarChart(
//       BarChartData(
//         alignment: BarChartAlignment.spaceAround,
//         maxY: 10000,
//         barTouchData: BarTouchData(
//           enabled: false,
//         ),
//         titlesData: FlTitlesData(
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: (value, meta) {
//                 return SideTitleWidget(
//                   meta: meta,
//                   child: Text(
//                     value.toInt().toString(),
//                     style: const TextStyle(
//                       color: Colors.grey,
//                       fontSize: 12,
//                     ),
//                   ),
//                 );
//               },
//               reservedSize: 30,
//             ),
//           ),
//           leftTitles: const AxisTitles(),
//           topTitles: const AxisTitles(),
//           rightTitles: const AxisTitles(),
//         ),
//         gridData: const FlGridData(
//           show: false,
//         ),
//         borderData: FlBorderData(
//           show: false,
//         ),
//         barGroups: dailyTransactions.map((data) {
//           return BarChartGroupData(
//             x: data.day,
//             barRods: [
//               BarChartRodData(
//                 toY: data.amount,
//                 color: Colors.red,
//                 width: 20,
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(4),
//                   topRight: Radius.circular(4),
//                 ),
//               ),
//             ],
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _buildPieChart() {
//     return Stack(
//       children: [
//         PieChart(
//           PieChartData(
//             sections: billDistribution.map((data) {
//               return PieChartSectionData(
//                 color: data.color,
//                 value: data.percentage,
//                 title: '',
//                 radius: 80,
//               );
//             }).toList(),
//             centerSpaceRadius: 50,
//             sectionsSpace: 0,
//           ),
//         ),
//         Positioned(
//           right: 0,
//           child: Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade100,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   'Bills payment',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   '₦6,450,000',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey.shade800,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   '(43%)',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildLegend() {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 16),
//         Expanded(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: billDistribution.map((data) {
//               return Row(
//                 children: [
//                   Container(
//                     width: 12,
//                     height: 12,
//                     decoration: BoxDecoration(
//                       color: data.color,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     data.category,
//                     style: const TextStyle(
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               );
//             }).toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class TransactionData {
//   TransactionData(this.day, this.amount);
//   final int day;
//   final double amount;
// }

// class BillDistributionData {
//   BillDistributionData(this.category, this.percentage, this.color);
//   final String category;
//   final double percentage;
//   final Color color;
// }
