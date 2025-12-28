import 'dart:developer';

import 'package:bundlegram/core/error/error_sanitixed_users.dart';
import 'package:bundlegram/core/error/errors.dart';
import 'package:bundlegram/data/models/dashboard/dashboard_data_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bundlegram/core/error/failures.dart';
import 'package:bundlegram/data/models/dashboard/dashboard_request.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';

// Extended state to include empty state information
class StatisticsState {
  final AsyncValue<DashboardDataResponse> data;
  final bool isEmpty;
  final String? emptyReason;
  final DashboardDataRequest? currentRequest;

  const StatisticsState({
    required this.data,
    this.isEmpty = false,
    this.emptyReason,
    this.currentRequest,
  });

  StatisticsState copyWith({
    AsyncValue<DashboardDataResponse>? data,
    bool? isEmpty,
    String? emptyReason,
    DashboardDataRequest? currentRequest,
  }) {
    return StatisticsState(
      data: data ?? this.data,
      isEmpty: isEmpty ?? this.isEmpty,
      emptyReason: emptyReason ?? this.emptyReason,
      currentRequest: currentRequest ?? this.currentRequest,
    );
  }
}

final statisticsDashboardProvider =
    StateNotifierProvider<StatisticsDashboardNotifier, StatisticsState>(
  (ref) => StatisticsDashboardNotifier(ref),
);

class StatisticsDashboardNotifier extends StateNotifier<StatisticsState> {
  final Ref ref;

  StatisticsDashboardNotifier(this.ref)
      : super(const StatisticsState(data: AsyncLoading()));

  DashboardDataRequest? _lastRequest;

  /// Check if the requested month is in the future
  bool _isFutureMonth(DashboardDataRequest request) {
    final now = DateTime.now();
    final year = request.year is int
        ? request.year as int
        : int.parse(request.year.toString());
    final month = request.month is int
        ? request.month as int
        : int.parse(request.month.toString());
    final requestDate = DateTime(year, month);
    final currentDate = DateTime(now.year, now.month);
    return requestDate.isAfter(currentDate);
  }

  /// Get empty dashboard data for future months
  DashboardDataResponse _getEmptyDashboardData() {
    return DashboardDataResponse(
      status: '',
      message: 'No data available',
      data: DashboardData(
        barData: [],
        doughnutData: [],
      ),
    );
  }

  Future<void> fetch(DashboardDataRequest request) async {
    // Prevent same re-fetch
    if (_lastRequest == request && state.data is AsyncData && !state.isEmpty) {
      return;
    }

    _lastRequest = request;

    // Check if it's a future month
    if (_isFutureMonth(request)) {
      log('[STATISTICS] Future month detected: ${request.month}/${request.year}');

      state = StatisticsState(
        data: AsyncData(_getEmptyDashboardData()),
        isEmpty: true,
        emptyReason: 'No data available for future months',
        currentRequest: request,
      );
      return;
    }

    // Set loading state
    state = StatisticsState(
      data: const AsyncLoading(),
      isEmpty: false,
      currentRequest: request,
    );

    try {
      final token = await ref.read(secureStorageHelperProvider).getAuthToken();
      if (token == null) {
        final msg = 'Missing auth token';
        log('[STATISTICS ERROR] $msg');
        state = StatisticsState(
          data: AsyncError(msg, StackTrace.current),
          isEmpty: false,
          currentRequest: request,
        );
        return;
      }

      final result =
          await ref.read(apiServiceProvider).fetchDashboardData(token, request);

      result.fold(
        (fail) {
          log('[STATISTICS FAILURE] ${fail.runtimeType} => ${fail.properties}');
          final userMsg = userFacingMessageFromFailure(fail);
          final displayMsg = sanitizeErrorMessage(userMsg);

          state = StatisticsState(
            data: AsyncError(displayMsg, StackTrace.current),
            isEmpty: false,
            currentRequest: request,
          );
        },
        (data) {
          log('[STATISTICS SUCCESS]');

          // Check if the returned data is empty
          final hasBarData = data.data?.barData?.isNotEmpty ?? false;
          final hasDoughnutData = data.data?.doughnutData?.isNotEmpty ?? false;
          final isEmpty = !hasBarData && !hasDoughnutData;

          state = StatisticsState(
            data: AsyncData(data),
            isEmpty: isEmpty,
            emptyReason:
                isEmpty ? 'No transactions found for this period' : null,
            currentRequest: request,
          );
        },
      );
    } catch (e, st) {
      log('[STATISTICS EXCEPTION] ${e.runtimeType}: $e', stackTrace: st);
      final displayMsg = sanitizeErrorMessage(e);
      // context.showErrorSnackBar(displayMsg);
      state = StatisticsState(
        data: AsyncError(displayMsg, st),
        isEmpty: false,
        currentRequest: request,
      );
    }
  }

  void reset() {
    state = const StatisticsState(data: AsyncLoading());
  }

  /// Get the current month's data if available
  DashboardDataResponse? get currentData {
    return state.data.when(
      data: (data) => data,
      loading: () => null,
      error: (_, __) => null,
    );
  }

  /// Check if current state represents empty data
  bool get isEmpty => state.isEmpty;

  /// Get the reason why data is empty
  String? get emptyReason => state.emptyReason;

  /// Get bar chart data or empty list
  List<BarDatum> get barData {
    if (isEmpty) return [];
    return currentData?.data?.barData ?? [];
  }

  /// Get doughnut chart data or empty list
  List<DoughnutDatum> get doughnutData {
    if (isEmpty) return [];
    return currentData?.data?.doughnutData ?? [];
  }

  /// Check if the current request is for a future month
  bool get isFutureMonth {
    if (state.currentRequest == null) return false;
    return _isFutureMonth(state.currentRequest!);
  }
}
