import 'package:bundlegram/core/error/failures.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/data/models/dashboard/dashboard_data_response.dart';
import 'package:bundlegram/data/models/dashboard/dashboard_request.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/transaction/notifier/statistic_visual_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatisticsDashboard extends ConsumerStatefulWidget {
  const StatisticsDashboard({Key? key}) : super(key: key);

  @override
  ConsumerState<StatisticsDashboard> createState() =>
      _StatisticsDashboardState();
}

class _StatisticsDashboardState extends ConsumerState<StatisticsDashboard>
    with TickerProviderStateMixin {
  late final List<String> monthYearList;
  String selectedTransMonth = '';
  String selectedBillsMonth = '';

  // Animation controllers
  late AnimationController _barChartAnimationController;
  late AnimationController _pieChartAnimationController;
  late Animation<double> _barChartAnimation;
  late Animation<double> _pieChartAnimation;

  final List<Color> pieColors = [
    Colors.red,
    Colors.orange,
    Colors.pink.shade100,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.teal,
  ];

  double _toDouble(dynamic val) {
    if (val is num) return val.toDouble();
    if (val is String) return double.tryParse(val) ?? 0;
    return 0;
  }

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _barChartAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _pieChartAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _barChartAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _barChartAnimationController,
      curve: Curves.easeInOut,
    ));

    _pieChartAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pieChartAnimationController,
      curve: Curves.easeInOut,
    ));

    final now = DateTime.now();
    monthYearList = List.generate(12, (i) {
      final dt = DateTime(now.year, now.month - i);
      return DateFormat('MMMM yyyy').format(dt);
    }).reversed.toList();

    selectedTransMonth = monthYearList.last;
    selectedBillsMonth = monthYearList.last;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final transReq = _toRequest(selectedTransMonth);
      ref.read(statisticsDashboardProvider.notifier).fetch(transReq);
      _startAnimations();
    });
  }

  @override
  void dispose() {
    _barChartAnimationController.dispose();
    _pieChartAnimationController.dispose();
    super.dispose();
  }

  void _startAnimations() {
    _barChartAnimationController.forward();
    _pieChartAnimationController.forward();
  }

  void _resetAndStartAnimations() {
    _barChartAnimationController.reset();
    _pieChartAnimationController.reset();
    _startAnimations();
  }

  DashboardDataRequest _toRequest(String monthYear) {
    final parts = monthYear.split(' ');
    final m = DateFormat.MMMM().parse(parts[0]).month;
    final y = int.parse(parts[1]);
    return DashboardDataRequest(month: m, year: y);
  }

  @override
  Widget build(BuildContext context) {
    final statisticsState = ref.watch(statisticsDashboardProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'Statistics',
                    style: context.textTheme.bodyMedium,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  context.pop();
                },
                child: AppSvgIcon(path: Assets.svgs.close),
              ),
            ],
          ),
          24.verticalSpace,
          // Daily transactions section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Daily transactions',
                  style: Theme.of(context).textTheme.bodyMedium),
              _buildDropdown(selectedTransMonth, (v) {
                if (v == null) return;
                setState(() => selectedTransMonth = v);
                final req = _toRequest(v);
                ref.read(statisticsDashboardProvider.notifier).fetch(req);
                _resetAndStartAnimations();
              }),
            ],
          ),
          const SizedBox(height: 16),
          _buildBarChartSection(statisticsState),

          const SizedBox(height: 32),

          // Bill distributed section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Bill distributed',
                  style: Theme.of(context).textTheme.bodyMedium),
              _buildDropdown(selectedBillsMonth, (v) {
                if (v == null) return;
                setState(() => selectedBillsMonth = v);
                final req = _toRequest(v);
                ref.read(statisticsDashboardProvider.notifier).fetch(req);
                _resetAndStartAnimations();
              }),
            ],
          ),
          const SizedBox(height: 16),
          _buildPieChartSection(statisticsState),
        ],
      ),
    );
  }

  Widget _buildBarChartSection(StatisticsState statisticsState) {
    return AnimatedBuilder(
      animation: _barChartAnimation,
      builder: (context, child) {
        return statisticsState.data.when(
          data: (resp) {
            final barData = resp.data?.barData ?? [];
            if (barData.isEmpty) {
              return _buildEmptyBarChart('No transaction data available');
            }

            // Calculate a reasonable width per bar:
            final barWidth = 16.0;
            final spacing = 8.0;
            // Total chart width = (barWidth + spacing) * number of bars + some padding
            final totalWidth = (barWidth + spacing) * barData.length + 40;

            return SizedBox(
              height: 260,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: totalWidth,
                  child: _buildBarChartNew(barData, spacing, barWidth),
                ),
              ),
            );
          },
          loading: () => const SizedBox(
            height: 224,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (err, _) => _buildErrorWidget(err, () {
            final req = _toRequest(selectedTransMonth);
            ref.read(statisticsDashboardProvider.notifier).fetch(req);
            _resetAndStartAnimations();
          }),
        );
      },
    );
  }

  BarChart _buildBarChartNew(
      List<BarDatum> barData, double spacing, double barWidth) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.start,
        maxY: (barData
                .map((e) => _toDouble(e.amount))
                .fold<double>(0, (a, b) => a > b ? a : b) +
            2000),
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          // Show left (Y) axis titles:
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 10000, // adjust to suit your scale
              getTitlesWidget: (value, meta) {
                return Text(
                  NumberFormat.compact().format(value),
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= barData.length)
                  return const SizedBox();
                // Only show every 2nd or 3rd label to avoid crowding:
                if (index % 2 != 0) return const SizedBox();
                return SideTitleWidget(
                  // axisSide: meta.axisSide,
                  meta: meta,
                  child: Text(barData[index].day,
                      style: const TextStyle(fontSize: 10)),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(barData.length, (i) {
          final y = _toDouble(barData[i].amount) * _barChartAnimation.value;
          return BarChartGroupData(
            x: i,
            barsSpace: spacing,
            barRods: [
              BarChartRodData(
                toY: y,
                width: barWidth,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(4)),
                color: Colors.red.withOpacity(_barChartAnimation.value),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildPieChartSection(StatisticsState statisticsState) {
    return AnimatedBuilder(
      animation: _pieChartAnimation,
      builder: (context, child) {
        return statisticsState.data.when(
          data: (resp) {
            // Check if provider indicates empty state
            if (statisticsState.isEmpty) {
              return _buildEmptyPieChart(statisticsState.emptyReason);
            }

            final doughnut = resp.data?.doughnutData ?? [];
            if (doughnut.isEmpty) {
              return _buildEmptyPieChart('No bill distribution data available');
            }

            return SizedBox(
              height: 350,
              child: Column(
                children: [
                  Expanded(
                      flex: 3,
                      child:
                          _buildPieChart(doughnut, _pieChartAnimation.value)),
                  Expanded(child: _buildLegend(doughnut)),
                ],
              ),
            );
          },
          loading: () => const SizedBox(
            height: 350,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (err, _) => _buildErrorWidget(err, () {
            final req = _toRequest(selectedBillsMonth);
            ref.read(statisticsDashboardProvider.notifier).fetch(req);
            _resetAndStartAnimations();
          }),
        );
      },
    );
  }

  Widget _buildErrorWidget(Object err, VoidCallback onRetry) {
    final msg = err is Failure
        ? (err.properties.isNotEmpty
            ? err.properties.join(', ')
            : err.runtimeType.toString())
        : err.toString();

    return Column(
      children: [
        Text(msg, style: const TextStyle(color: Colors.red)),
        TextButton(
          onPressed: onRetry,
          child: const Text('Retry'),
        ),
      ],
    );
  }

  Widget _buildDropdown(String value, void Function(String?) onChanged) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffDBDEE2)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: value,
        underline: const SizedBox(),
        dropdownColor: Colors.white, // background of dropdown menu
        iconEnabledColor: Colors.black,
        style: context.textTheme.bodySmall?.copyWith(color: Colors.black),
        items: monthYearList
            .map((e) => DropdownMenuItem(
                value: e, child: Text(e, style: context.textTheme.bodySmall)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildBarChart(List<BarDatum> data, double animationValue) {
    final amounts = data.map((e) => _toDouble(e.amount)).toList();
    final maxY =
        (amounts.isNotEmpty ? amounts.reduce((a, b) => a > b ? a : b) : 0) +
            2000;

    return BarChart(BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: maxY.toDouble(),
      barTouchData: BarTouchData(enabled: false),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (v, meta) {
              final day = data.length > v.toInt() ? data[v.toInt()].day : '';
              return SideTitleWidget(
                meta: meta,
                child: Text(
                  day,
                  style: TextStyle(
                    color: Colors.grey.withOpacity(animationValue),
                  ),
                ),
              );
            },
          ),
        ),
        leftTitles: const AxisTitles(),
        topTitles: const AxisTitles(),
        rightTitles: const AxisTitles(),
      ),
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(show: false),
      barGroups: List.generate(data.length, (i) {
        return BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: amounts[i] * animationValue,
              width: 20,
              color: Colors.red,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(4)),
            ),
          ],
        );
      }),
    ));
  }

  Widget _buildEmptyBarChart(String? reason) {
    return Container(
      height: 224,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bar_chart,
              size: 48,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 8),
            Text(
              reason ?? 'No data available',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart(List<DoughnutDatum> data, double animationValue) {
    final bills = data.firstWhere(
      (d) => d.label.toLowerCase().contains('bill'),
      orElse: () => DoughnutDatum(label: 'Bills payment', value: 0),
    );
    final total = data.fold<double>(
      0,
      (sum, d) => sum + _toDouble(d.value),
    );
    final pct = total > 0
        ? ((_toDouble(bills.value) / total * 100)).toStringAsFixed(0)
        : '0';

    return Stack(
      children: [
        Transform.rotate(
          angle: -1.5708 +
              (1.5708 * (1 - animationValue)), // Anti-clockwise from top
          child: PieChart(
            PieChartData(
              sections: List.generate(data.length, (i) {
                final d = data[i];
                return PieChartSectionData(
                  value: _toDouble(d.value) * animationValue,
                  radius: 80,
                  color: pieColors[i % pieColors.length],
                  showTitle: false,
                );
              }),
              centerSpaceRadius: 50,
              startDegreeOffset: 0,
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: AnimatedOpacity(
            opacity: animationValue,
            duration: const Duration(milliseconds: 300),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bills payment',
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                  Text('₦${bills.value}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('($pct%)',
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyPieChart(String? reason) {
    return Container(
      height: 350,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.pie_chart,
              size: 48,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 8),
            Text(
              reason ?? 'No data available',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(List<DoughnutDatum> data) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: List.generate(data.length, (i) {
        final d = data[i];
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: pieColors[i % pieColors.length],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              d.label.replaceAll("_", " ").capiTalizeFirstLast,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
      }),
    );
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
