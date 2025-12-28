import 'package:bundlegram/core/error/failures.dart';
import 'package:bundlegram/core/extensions/responsive_extensions.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/data/models/dashboard/dashboard_data_response.dart';
import 'package:bundlegram/data/models/dashboard/dashboard_request.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/transaction/notifier/statistic_visual_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class StatisticsDashboard extends ConsumerStatefulWidget {
  const StatisticsDashboard({
    Key? key,
    this.useResponsive = true,
  }) : super(key: key);

  final bool useResponsive;

  @override
  ConsumerState<StatisticsDashboard> createState() =>
      _StatisticsDashboardState();
}

class _StatisticsDashboardState extends ConsumerState<StatisticsDashboard>
    with TickerProviderStateMixin {
  late final List<String> monthYearList;
  String selectedTransMonth = '';
  String selectedBillsMonth = '';

  // NEW: Track touched pie chart section
  int touchedIndex = -1;

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
    setState(() => touchedIndex = -1); // Reset touched state
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
    final r = context.responsive;
    final statisticsState = ref.watch(statisticsDashboardProvider);

    return SingleChildScrollView(
      padding:
          EdgeInsets.all(widget.useResponsive ? r.spacing(16) : 16), // CHANGED
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'Statistics',
                    style: widget.useResponsive
                        ? TextStyle(
                            fontSize: r.textSize(15),
                            fontWeight: FontWeight.w500,
                          )
                        : context.textTheme.bodyMedium,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  HapticFeedback.lightImpact();
                  context.pop();
                },
                child: AppSvgIcon(path: Assets.svgs.close),
              ),
            ],
          ),
          SizedBox(
              height: widget.useResponsive ? r.spacing(24) : 24.h), // CHANGED

          // Daily transactions section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Daily transactions',
                style: widget.useResponsive
                    ? TextStyle(
                        fontSize: r.textSize(14),
                        fontWeight: FontWeight.w500,
                      )
                    : Theme.of(context).textTheme.bodyMedium,
              ),
              _buildDropdown(selectedTransMonth, (v) {
                if (v == null) return;
                setState(() => selectedTransMonth = v);
                final req = _toRequest(v);
                ref.read(statisticsDashboardProvider.notifier).fetch(req);
                _resetAndStartAnimations();
              }),
            ],
          ),
          SizedBox(
              height: widget.useResponsive ? r.spacing(16) : 16), // CHANGED
          _buildBarChartSection(statisticsState),

          SizedBox(
              height: widget.useResponsive ? r.spacing(32) : 32), // CHANGED

          // Bill distributed section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bill distributed',
                style: widget.useResponsive
                    ? TextStyle(
                        fontSize: r.textSize(14),
                        fontWeight: FontWeight.w500,
                      )
                    : Theme.of(context).textTheme.bodyMedium,
              ),
              _buildDropdown(selectedBillsMonth, (v) {
                if (v == null) return;
                setState(() => selectedBillsMonth = v);
                final req = _toRequest(v);
                ref.read(statisticsDashboardProvider.notifier).fetch(req);
                _resetAndStartAnimations();
              }),
            ],
          ),
          SizedBox(
              height: widget.useResponsive ? r.spacing(16) : 16), // CHANGED
          _buildPieChartSection(statisticsState),
        ],
      ),
    );
  }

  Widget _buildBarChartSection(StatisticsState statisticsState) {
    final r = context.responsive;

    return AnimatedBuilder(
      animation: _barChartAnimation,
      builder: (context, child) {
        return statisticsState.data.when(
          data: (resp) {
            final barData = resp.data?.barData ?? [];
            if (barData.isEmpty) {
              return _buildEmptyBarChart('No transaction data available');
            }

            final hasNonZeroData =
                barData.any((bar) => _toDouble(bar.amount) > 0);
            if (!hasNonZeroData) {
              return _buildEmptyBarChart(
                  'No transactions recorded for this period');
            }

            final barWidth = widget.useResponsive ? r.spacing(16) : 16.0;
            final spacing = widget.useResponsive ? r.spacing(8) : 8.0;
            final totalWidth = (barWidth + spacing) * barData.length + 40;

            // CHANGED: Responsive height
            final chartHeight = widget.useResponsive ? r.spacing(260) : 260.0;

            return SizedBox(
              height: chartHeight,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: totalWidth,
                  child: _buildBarChartNew(barData, spacing, barWidth),
                ),
              ),
            );
          },
          loading: () => SizedBox(
            height: widget.useResponsive ? r.spacing(224) : 224, // CHANGED
            child: const Center(child: CircularProgressIndicator()),
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
    final r = context.responsive;

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.start,
        maxY: (barData
                .map((e) => _toDouble(e.amount))
                .fold<double>(0, (a, b) => a > b ? a : b) +
            2000),
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: widget.useResponsive ? r.spacing(40) : 40,
              interval: 10000,
              getTitlesWidget: (value, meta) {
                return Text(
                  NumberFormat.compact().format(value),
                  style: TextStyle(
                    fontSize: widget.useResponsive ? r.textSize(10) : 10,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: widget.useResponsive ? r.spacing(28) : 28,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= barData.length)
                  return const SizedBox();
                if (index % 2 != 0) return const SizedBox();
                return SideTitleWidget(
                  meta: meta,
                  child: Text(
                    barData[index].day,
                    style: TextStyle(
                      fontSize: widget.useResponsive ? r.textSize(10) : 10,
                    ),
                  ),
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
    final r = context.responsive;

    return AnimatedBuilder(
      animation: _pieChartAnimation,
      builder: (context, child) {
        return statisticsState.data.when(
          data: (resp) {
            if (statisticsState.isEmpty) {
              return _buildEmptyPieChart(statisticsState.emptyReason);
            }

            final doughnut = resp.data?.doughnutData ?? [];
            if (doughnut.isEmpty) {
              return _buildEmptyPieChart('No bill distribution data available');
            }

            final hasNonZeroData =
                doughnut.any((item) => _toDouble(item.value) > 0);
            if (!hasNonZeroData) {
              return _buildEmptyPieChartState(
                  'No bill payments recorded for this period');
            }

            // CHANGED: Responsive height
            final chartHeight = widget.useResponsive ? r.spacing(350) : 350.0;

            return SizedBox(
              height: chartHeight,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: _buildInteractivePieChart(
                      doughnut,
                      _pieChartAnimation.value,
                    ),
                  ),
                  Expanded(child: _buildLegend(doughnut)),
                ],
              ),
            );
          },
          loading: () => SizedBox(
            height: widget.useResponsive ? r.spacing(350) : 350, // CHANGED
            child: const Center(child: CircularProgressIndicator()),
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

  // NEW: Interactive pie chart that responds to touch/hover
  Widget _buildInteractivePieChart(
    List<DoughnutDatum> data,
    double animationValue,
  ) {
    final r = context.responsive;
    final total = data.fold<double>(
      0,
      (sum, d) => sum + _toDouble(d.value),
    );

    // Get the item to display (touched item or first by default)
    final displayIndex =
        touchedIndex >= 0 && touchedIndex < data.length ? touchedIndex : 0;
    final displayItem = data[displayIndex];
    final displayValue = _toDouble(displayItem.value);
    final displayPct =
        total > 0 ? ((displayValue / total * 100)).toStringAsFixed(0) : '0';

    return Stack(
      children: [
        Transform.rotate(
          angle: -1.5708 + (1.5708 * (1 - animationValue)),
          child: PieChart(
            PieChartData(
              // NEW: Enable touch interaction
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              sections: List.generate(data.length, (i) {
                final d = data[i];
                final isTouched = i == touchedIndex;

                return PieChartSectionData(
                  value: _toDouble(d.value) * animationValue,
                  radius: isTouched ? 90 : 80, // CHANGED: Grow when touched
                  color: pieColors[i % pieColors.length],
                  showTitle: false,
                );
              }),
              centerSpaceRadius: widget.useResponsive ? r.spacing(50) : 50,
              startDegreeOffset: 0,
            ),
          ),
        ),
        // Info box that updates based on touched section
        Positioned(
          right: 0,
          child: AnimatedOpacity(
            opacity: animationValue,
            duration: const Duration(milliseconds: 300),
            child: Container(
              padding: EdgeInsets.all(
                widget.useResponsive ? r.spacing(12) : 12,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(
                  widget.useResponsive ? r.radiusSize(8) : 8,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayItem.label.replaceAll("_", " ").capiTalizeFirstLast,
                    style: TextStyle(
                      fontSize: widget.useResponsive ? r.textSize(12) : 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    '₦${displayValue.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: widget.useResponsive ? r.textSize(16) : 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '($displayPct%)',
                    style: TextStyle(
                      fontSize: widget.useResponsive ? r.textSize(12) : 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorWidget(Object err, VoidCallback onRetry) {
    final r = context.responsive;
    final msg = err is Failure
        ? (err.properties.isNotEmpty
            ? err.properties.join(', ')
            : err.runtimeType.toString())
        : err.toString();

    return Column(
      children: [
        Text(
          msg,
          style: TextStyle(
            color: Colors.red,
            fontSize: widget.useResponsive ? r.textSize(14) : 14,
          ),
        ),
        TextButton(
          onPressed: onRetry,
          child: Text(
            'Retry',
            style: TextStyle(
              fontSize: widget.useResponsive ? r.textSize(14) : 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(String value, void Function(String?) onChanged) {
    final r = context.responsive;

    return Container(
      height: widget.useResponsive ? r.spacing(36) : 36,
      padding: EdgeInsets.symmetric(
        horizontal: widget.useResponsive ? r.spacing(8) : 8,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffDBDEE2)),
        borderRadius: BorderRadius.circular(
          widget.useResponsive ? r.radiusSize(8) : 8,
        ),
      ),
      child: DropdownButton<String>(
        value: value,
        underline: const SizedBox(),
        dropdownColor: Colors.white,
        iconEnabledColor: Colors.black,
        style: TextStyle(
          color: Colors.black,
          fontSize: widget.useResponsive ? r.textSize(12) : 12,
        ),
        items: monthYearList
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: TextStyle(
                      fontSize: widget.useResponsive ? r.textSize(12) : 12,
                    ),
                  ),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildEmptyBarChart(String? reason) {
    final r = context.responsive;

    return Container(
      height: widget.useResponsive ? r.spacing(224) : 224,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(
          widget.useResponsive ? r.radiusSize(8) : 8,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bar_chart,
              size: widget.useResponsive ? r.iconSize(base: 48) : 48,
              color: Colors.grey.shade400,
            ),
            SizedBox(height: widget.useResponsive ? r.spacing(8) : 8),
            Text(
              reason ?? 'No data available',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: widget.useResponsive ? r.textSize(14) : 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyPieChartState(String? reason) {
    final r = context.responsive;

    return Container(
      height: widget.useResponsive ? r.spacing(350) : 350,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(
          widget.useResponsive ? r.radiusSize(8) : 8,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.pie_chart_outline,
              size: widget.useResponsive ? r.iconSize(base: 32) : 32,
              color: Colors.grey.shade400,
            ),
            SizedBox(height: widget.useResponsive ? r.spacing(24) : 24),
            Text(
              'No Bill Distribution Data',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: widget.useResponsive ? r.textSize(16) : 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: widget.useResponsive ? r.spacing(8) : 8),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widget.useResponsive ? r.spacing(40) : 40,
              ),
              child: Text(
                reason ?? 'No bill payments found for this period',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: widget.useResponsive ? r.textSize(14) : 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyPieChart(String? reason) {
    final r = context.responsive;

    return Container(
      height: widget.useResponsive ? r.spacing(350) : 350,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(
          widget.useResponsive ? r.radiusSize(8) : 8,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.pie_chart,
              size: widget.useResponsive ? r.iconSize(base: 48) : 48,
              color: Colors.grey.shade400,
            ),
            SizedBox(height: widget.useResponsive ? r.spacing(8) : 8),
            Text(
              reason ?? 'No data available',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: widget.useResponsive ? r.textSize(14) : 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(List<DoughnutDatum> data) {
    final r = context.responsive;

    return Wrap(
      spacing: widget.useResponsive ? r.spacing(16) : 16,
      runSpacing: widget.useResponsive ? r.spacing(8) : 8,
      children: List.generate(data.length, (i) {
        final d = data[i];
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: widget.useResponsive ? r.spacing(12) : 12,
              height: widget.useResponsive ? r.spacing(12) : 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: pieColors[i % pieColors.length],
              ),
            ),
            SizedBox(width: widget.useResponsive ? r.spacing(8) : 8),
            Text(
              d.label.replaceAll("_", " ").capiTalizeFirstLast,
              style: TextStyle(
                fontSize: widget.useResponsive ? r.textSize(12) : 12,
              ),
            ),
          ],
        );
      }),
    );
  }
}

// import 'package:bundlegram/core/error/failures.dart';
// import 'package:bundlegram/core/extensions/string_extensions.dart';
// import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
// import 'package:bundlegram/data/models/dashboard/dashboard_data_response.dart';
// import 'package:bundlegram/data/models/dashboard/dashboard_request.dart';
// import 'package:bundlegram/gen/assets.gen.dart';
// import 'package:bundlegram/presentation/features/transaction/notifier/statistic_visual_provider.dart';
// import 'package:bundlegram/presentation/general_widget/app_svg.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:intl/intl.dart';

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class StatisticsDashboard extends ConsumerStatefulWidget {
//   const StatisticsDashboard({Key? key}) : super(key: key);

//   @override
//   ConsumerState<StatisticsDashboard> createState() =>
//       _StatisticsDashboardState();
// }

// class _StatisticsDashboardState extends ConsumerState<StatisticsDashboard>
//     with TickerProviderStateMixin {
//   late final List<String> monthYearList;
//   String selectedTransMonth = '';
//   String selectedBillsMonth = '';

//   // Animation controllers
//   late AnimationController _barChartAnimationController;
//   late AnimationController _pieChartAnimationController;
//   late Animation<double> _barChartAnimation;
//   late Animation<double> _pieChartAnimation;

//   final List<Color> pieColors = [
//     Colors.red,
//     Colors.orange,
//     Colors.pink.shade100,
//     Colors.blue,
//     Colors.green,
//     Colors.purple,
//     Colors.teal,
//   ];

//   double _toDouble(dynamic val) {
//     if (val is num) return val.toDouble();
//     if (val is String) return double.tryParse(val) ?? 0;
//     return 0;
//   }

//   @override
//   void initState() {
//     super.initState();

//     // Initialize animation controllers
//     _barChartAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );

//     _pieChartAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 1200),
//       vsync: this,
//     );

//     _barChartAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _barChartAnimationController,
//       curve: Curves.easeInOut,
//     ));

//     _pieChartAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _pieChartAnimationController,
//       curve: Curves.easeInOut,
//     ));

//     final now = DateTime.now();
//     monthYearList = List.generate(12, (i) {
//       final dt = DateTime(now.year, now.month - i);
//       return DateFormat('MMMM yyyy').format(dt);
//     }).reversed.toList();

//     selectedTransMonth = monthYearList.last;
//     selectedBillsMonth = monthYearList.last;

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final transReq = _toRequest(selectedTransMonth);
//       ref.read(statisticsDashboardProvider.notifier).fetch(transReq);
//       _startAnimations();
//     });
//   }

//   @override
//   void dispose() {
//     _barChartAnimationController.dispose();
//     _pieChartAnimationController.dispose();
//     super.dispose();
//   }

//   void _startAnimations() {
//     _barChartAnimationController.forward();
//     _pieChartAnimationController.forward();
//   }

//   void _resetAndStartAnimations() {
//     _barChartAnimationController.reset();
//     _pieChartAnimationController.reset();
//     _startAnimations();
//   }

//   DashboardDataRequest _toRequest(String monthYear) {
//     final parts = monthYear.split(' ');
//     final m = DateFormat.MMMM().parse(parts[0]).month;
//     final y = int.parse(parts[1]);
//     return DashboardDataRequest(month: m, year: y);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final statisticsState = ref.watch(statisticsDashboardProvider);

//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Center(
//                   child: Text(
//                     'Statistics',
//                     style: context.textTheme.bodyMedium,
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   HapticFeedback.lightImpact();
//                   context.pop();
//                 },
//                 child: AppSvgIcon(path: Assets.svgs.close),
//               ),
//             ],
//           ),
//           24.verticalSpace,
//           // Daily transactions section
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('Daily transactions',
//                   style: Theme.of(context).textTheme.bodyMedium),
//               _buildDropdown(selectedTransMonth, (v) {
//                 if (v == null) return;
//                 setState(() => selectedTransMonth = v);
//                 final req = _toRequest(v);
//                 ref.read(statisticsDashboardProvider.notifier).fetch(req);
//                 _resetAndStartAnimations();
//               }),
//             ],
//           ),
//           const SizedBox(height: 16),
//           _buildBarChartSection(statisticsState),

//           const SizedBox(height: 32),

//           // Bill distributed section
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('Bill distributed',
//                   style: Theme.of(context).textTheme.bodyMedium),
//               _buildDropdown(selectedBillsMonth, (v) {
//                 if (v == null) return;
//                 setState(() => selectedBillsMonth = v);
//                 final req = _toRequest(v);
//                 ref.read(statisticsDashboardProvider.notifier).fetch(req);
//                 _resetAndStartAnimations();
//               }),
//             ],
//           ),
//           const SizedBox(height: 16),
//           _buildPieChartSection(statisticsState),
//         ],
//       ),
//     );
//   }

//   Widget _buildBarChartSection(StatisticsState statisticsState) {
//     return AnimatedBuilder(
//       animation: _barChartAnimation,
//       builder: (context, child) {
//         return statisticsState.data.when(
//           data: (resp) {
//             final barData = resp.data?.barData ?? [];
//             if (barData.isEmpty) {
//               return _buildEmptyBarChart('No transaction data available');
//             }
//             // / Additional check: if all amounts are zero, also show empty state
//             final hasNonZeroData =
//                 barData.any((bar) => _toDouble(bar.amount) > 0);
//             if (!hasNonZeroData) {
//               return _buildEmptyBarChart(
//                   'No transactions recorded for this period');
//             }

//             // Calculate a reasonable width per bar:
//             final barWidth = 16.0;
//             final spacing = 8.0;
//             // Total chart width = (barWidth + spacing) * number of bars + some padding
//             final totalWidth = (barWidth + spacing) * barData.length + 40;

//             return SizedBox(
//               height: 260,
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: SizedBox(
//                   width: totalWidth,
//                   child: _buildBarChartNew(barData, spacing, barWidth),
//                 ),
//               ),
//             );
//           },
//           loading: () => const SizedBox(
//             height: 224,
//             child: Center(child: CircularProgressIndicator()),
//           ),
//           error: (err, _) => _buildErrorWidget(err, () {
//             final req = _toRequest(selectedTransMonth);
//             ref.read(statisticsDashboardProvider.notifier).fetch(req);
//             _resetAndStartAnimations();
//           }),
//         );
//       },
//     );
//   }

//   BarChart _buildBarChartNew(
//       List<BarDatum> barData, double spacing, double barWidth) {
//     return BarChart(
//       BarChartData(
//         alignment: BarChartAlignment.start,
//         maxY: (barData
//                 .map((e) => _toDouble(e.amount))
//                 .fold<double>(0, (a, b) => a > b ? a : b) +
//             2000),
//         barTouchData: BarTouchData(enabled: false),
//         titlesData: FlTitlesData(
//           // Show left (Y) axis titles:
//           leftTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               reservedSize: 40,
//               interval: 10000, // adjust to suit your scale
//               getTitlesWidget: (value, meta) {
//                 return Text(
//                   NumberFormat.compact().format(value),
//                   style: const TextStyle(fontSize: 10, color: Colors.grey),
//                 );
//               },
//             ),
//           ),
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               reservedSize: 28,
//               getTitlesWidget: (value, meta) {
//                 final index = value.toInt();
//                 if (index < 0 || index >= barData.length)
//                   return const SizedBox();
//                 // Only show every 2nd or 3rd label to avoid crowding:
//                 if (index % 2 != 0) return const SizedBox();
//                 return SideTitleWidget(
//                   // axisSide: meta.axisSide,
//                   meta: meta,
//                   child: Text(barData[index].day,
//                       style: const TextStyle(fontSize: 10)),
//                 );
//               },
//             ),
//           ),
//           topTitles: const AxisTitles(),
//           rightTitles: const AxisTitles(),
//         ),
//         gridData: const FlGridData(show: false),
//         borderData: FlBorderData(show: false),
//         barGroups: List.generate(barData.length, (i) {
//           final y = _toDouble(barData[i].amount) * _barChartAnimation.value;
//           return BarChartGroupData(
//             x: i,
//             barsSpace: spacing,
//             barRods: [
//               BarChartRodData(
//                 toY: y,
//                 width: barWidth,
//                 borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(4)),
//                 color: Colors.red.withOpacity(_barChartAnimation.value),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }

//   Widget _buildPieChartSection(StatisticsState statisticsState) {
//     return AnimatedBuilder(
//       animation: _pieChartAnimation,
//       builder: (context, child) {
//         return statisticsState.data.when(
//           data: (resp) {
//             // Check if provider indicates empty state
//             if (statisticsState.isEmpty) {
//               return _buildEmptyPieChart(statisticsState.emptyReason);
//             }

//             final doughnut = resp.data?.doughnutData ?? [];
//             if (doughnut.isEmpty) {
//               return _buildEmptyPieChart('No bill distribution data available');
//             }
//             // Additional checks for meaningful data
//             final hasNonZeroData =
//                 doughnut.any((item) => _toDouble(item.value) > 0);
//             if (!hasNonZeroData) {
//               return _buildEmptyPieChartState(
//                   'No bill payments recorded for this period');
//             }

//             return SizedBox(
//               height: 350,
//               child: Column(
//                 children: [
//                   Expanded(
//                       flex: 3,
//                       child:
//                           _buildPieChart(doughnut, _pieChartAnimation.value)),
//                   Expanded(child: _buildLegend(doughnut)),
//                 ],
//               ),
//             );
//           },
//           loading: () => const SizedBox(
//             height: 350,
//             child: Center(child: CircularProgressIndicator()),
//           ),
//           error: (err, _) => _buildErrorWidget(err, () {
//             final req = _toRequest(selectedBillsMonth);
//             ref.read(statisticsDashboardProvider.notifier).fetch(req);
//             _resetAndStartAnimations();
//           }),
//         );
//       },
//     );
//   }

//   Widget _buildErrorWidget(Object err, VoidCallback onRetry) {
//     final msg = err is Failure
//         ? (err.properties.isNotEmpty
//             ? err.properties.join(', ')
//             : err.runtimeType.toString())
//         : err.toString();

//     return Column(
//       children: [
//         Text(msg, style: const TextStyle(color: Colors.red)),
//         TextButton(
//           onPressed: onRetry,
//           child: const Text('Retry'),
//         ),
//       ],
//     );
//   }

//   Widget _buildDropdown(String value, void Function(String?) onChanged) {
//     return Container(
//       height: 36,
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       decoration: BoxDecoration(
//         border: Border.all(color: const Color(0xffDBDEE2)),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: DropdownButton<String>(
//         value: value,
//         underline: const SizedBox(),
//         dropdownColor: Colors.white, // background of dropdown menu
//         iconEnabledColor: Colors.black,
//         style: context.textTheme.bodySmall?.copyWith(color: Colors.black),
//         items: monthYearList
//             .map((e) => DropdownMenuItem(
//                 value: e, child: Text(e, style: context.textTheme.bodySmall)))
//             .toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }

//   Widget _buildBarChart(List<BarDatum> data, double animationValue) {
//     final amounts = data.map((e) => _toDouble(e.amount)).toList();
//     final maxY =
//         (amounts.isNotEmpty ? amounts.reduce((a, b) => a > b ? a : b) : 0) +
//             2000;

//     return BarChart(BarChartData(
//       alignment: BarChartAlignment.spaceAround,
//       maxY: maxY.toDouble(),
//       barTouchData: BarTouchData(enabled: false),
//       titlesData: FlTitlesData(
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             getTitlesWidget: (v, meta) {
//               final day = data.length > v.toInt() ? data[v.toInt()].day : '';
//               return SideTitleWidget(
//                 meta: meta,
//                 child: Text(
//                   day,
//                   style: TextStyle(
//                     color: Colors.grey.withOpacity(animationValue),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         leftTitles: const AxisTitles(),
//         topTitles: const AxisTitles(),
//         rightTitles: const AxisTitles(),
//       ),
//       gridData: const FlGridData(show: false),
//       borderData: FlBorderData(show: false),
//       barGroups: List.generate(data.length, (i) {
//         return BarChartGroupData(
//           x: i,
//           barRods: [
//             BarChartRodData(
//               toY: amounts[i] * animationValue,
//               width: 20,
//               color: Colors.red,
//               borderRadius:
//                   const BorderRadius.vertical(top: Radius.circular(4)),
//             ),
//           ],
//         );
//       }),
//     ));
//   }

//   Widget _buildEmptyBarChart(String? reason) {
//     return Container(
//       height: 224,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.bar_chart,
//               size: 48,
//               color: Colors.grey.shade400,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               reason ?? 'No data available',
//               style: TextStyle(
//                 color: Colors.grey.shade600,
//                 fontSize: 14,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPieChart(List<DoughnutDatum> data, double animationValue) {
//     final bills = data.firstWhere(
//       (d) => d.label.toLowerCase().contains('bill'),
//       orElse: () => DoughnutDatum(label: 'Bills payment', value: 0),
//     );
//     final total = data.fold<double>(
//       0,
//       (sum, d) => sum + _toDouble(d.value),
//     );
//     final pct = total > 0
//         ? ((_toDouble(bills.value) / total * 100)).toStringAsFixed(0)
//         : '0';

//     return Stack(
//       children: [
//         Transform.rotate(
//           angle: -1.5708 +
//               (1.5708 * (1 - animationValue)), // Anti-clockwise from top
//           child: PieChart(
//             PieChartData(
//               sections: List.generate(data.length, (i) {
//                 final d = data[i];
//                 return PieChartSectionData(
//                   value: _toDouble(d.value) * animationValue,
//                   radius: 80,
//                   color: pieColors[i % pieColors.length],
//                   showTitle: false,
//                 );
//               }),
//               centerSpaceRadius: 50,
//               startDegreeOffset: 0,
//             ),
//           ),
//         ),
//         Positioned(
//           right: 0,
//           child: AnimatedOpacity(
//             opacity: animationValue,
//             duration: const Duration(milliseconds: 300),
//             child: Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade100,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Bills payment',
//                       style:
//                           TextStyle(fontSize: 12, color: Colors.grey.shade600)),
//                   Text('₦${bills.value}',
//                       style: const TextStyle(
//                           fontSize: 16, fontWeight: FontWeight.bold)),
//                   Text('($pct%)',
//                       style:
//                           TextStyle(fontSize: 12, color: Colors.grey.shade600)),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

// //empty state with illustration
//   Widget _buildEmptyBarChartWithIllustration(String? reason) {
//     return Container(
//       height: 260,
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Create a simple bar chart illustration using containers
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: List.generate(5, (index) {
//                 return Container(
//                   width: 12,
//                   height: 20.0 + (index * 8), // Varying heights
//                   margin: const EdgeInsets.symmetric(horizontal: 2),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade300,
//                     borderRadius: const BorderRadius.vertical(
//                       top: Radius.circular(2),
//                     ),
//                   ),
//                 );
//               }),
//             ),
//             const SizedBox(height: 24),
//             Text(
//               'No Transaction Data',
//               style: TextStyle(
//                 color: Colors.grey.shade700,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               reason ?? 'Transactions will appear here once available',
//               style: TextStyle(
//                 color: Colors.grey.shade600,
//                 fontSize: 14,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyPieChartState(String? reason) {
//     return Container(
//       height: 350,
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50, // Subtle background
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Animated empty pie chart illustration
//             TweenAnimationBuilder(
//               duration: const Duration(milliseconds: 1200),
//               tween: Tween<double>(begin: 0.0, end: 1.0),
//               builder: (context, double progress, child) {
//                 return Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     // Background circle
//                     Container(
//                       width: 100,
//                       height: 100,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: Colors.grey.shade300,
//                           width: 2,
//                         ),
//                       ),
//                     ),
//                     // Animated arc
//                     SizedBox(
//                       width: 100,
//                       height: 100,
//                       child: CircularProgressIndicator(
//                         value: progress * 0.3, // Partial fill for visual appeal
//                         strokeWidth: 2,
//                         valueColor: AlwaysStoppedAnimation<Color>(
//                           Colors.grey.shade400,
//                         ),
//                         backgroundColor: Colors.transparent,
//                       ),
//                     ),
//                     // Center icon
//                     Icon(
//                       Icons.pie_chart_outline,
//                       size: 32,
//                       color: Colors.grey.shade400,
//                     ),
//                   ],
//                 );
//               },
//             ),
//             const SizedBox(height: 24),
//             Text(
//               'No Bill Distribution Data',
//               style: TextStyle(
//                 color: Colors.grey.shade700,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 40),
//               child: Text(
//                 reason ?? 'No bill payments found for this period',
//                 style: TextStyle(
//                   color: Colors.grey.shade600,
//                   fontSize: 14,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Action button
//             // TextButton.icon(
//             //   onPressed: () {
//             //     final req = _toRequest(selectedBillsMonth);
//             //     ref.read(statisticsDashboardProvider.notifier).fetch(req);
//             //     _resetAndStartAnimations();
//             //   },
//             //   icon: const Icon(Icons.refresh, size: 16),
//             //   label: const Text('Refresh Data'),
//             //   style: TextButton.styleFrom(
//             //     foregroundColor: Colors.blue,
//             //     textStyle: const TextStyle(fontSize: 12),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyPieChart(String? reason) {
//     return Container(
//       height: 350,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.pie_chart,
//               size: 48,
//               color: Colors.grey.shade400,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               reason ?? 'No data available',
//               style: TextStyle(
//                 color: Colors.grey.shade600,
//                 fontSize: 14,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLegend(List<DoughnutDatum> data) {
//     return Wrap(
//       spacing: 16,
//       runSpacing: 8,
//       children: List.generate(data.length, (i) {
//         final d = data[i];
//         return Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 12,
//               height: 12,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: pieColors[i % pieColors.length],
//               ),
//             ),
//             const SizedBox(width: 8),
//             Text(
//               d.label.replaceAll("_", " ").capiTalizeFirstLast,
//               style: const TextStyle(fontSize: 12),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }

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
// HapticFeedback.lightImpact() ;
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
