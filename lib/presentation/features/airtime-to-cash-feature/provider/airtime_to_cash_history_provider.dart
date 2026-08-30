import 'dart:async';

import 'package:bundlegram/core/error/error_sanitixed_users.dart';
import 'package:bundlegram/core/error/errors.dart';
import 'package:bundlegram/data/airtime_to_cash_repository.dart';
import 'package:bundlegram/data/mock_airtime_to_cash_repository.dart';
import 'package:bundlegram/data/models/airtime_2_cash/airtime_to_cash_transaction.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class AirtimeToCashHistoryState {
  const AirtimeToCashHistoryState({
    this.isLoading = false,
    this.transactions = const [],
    this.error,
    this.query = '',
  });

  final bool isLoading;
  final List<AirtimeToCashTransaction> transactions;
  final String? error;
  final String query;

  AirtimeToCashHistoryState copyWith({
    bool? isLoading,
    List<AirtimeToCashTransaction>? transactions,
    String? error,
    bool clearError = false,
    String? query,
  }) {
    return AirtimeToCashHistoryState(
      isLoading: isLoading ?? this.isLoading,
      transactions: transactions ?? this.transactions,
      error: clearError ? null : (error ?? this.error),
      query: query ?? this.query,
    );
  }
}

final airtimeToCashHistoryProvider =
    StateNotifierProvider.autoDispose<
      AirtimeToCashHistoryNotifier,
      AirtimeToCashHistoryState
    >(
      (ref) => AirtimeToCashHistoryNotifier(
        ref.read(airtimeToCashRepositoryProvider),
      )..refresh(),
    );

class AirtimeToCashHistoryNotifier
    extends StateNotifier<AirtimeToCashHistoryState> {
  AirtimeToCashHistoryNotifier(this._repository)
    : super(const AirtimeToCashHistoryState());

  final IAirtimeToCashRepository _repository;
  Timer? _searchDebounce;

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, clearError: true);
    final result = await _repository.getTransactions(query: state.query);
    result.fold(
      (fail) => state = state.copyWith(
        isLoading: false,
        error: sanitizeErrorMessage(userFacingMessageFromFailure(fail)),
      ),
      (txns) => state = state.copyWith(isLoading: false, transactions: txns),
    );
  }

  void onSearchChanged(String value) {
    state = state.copyWith(query: value);
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 400), refresh);
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }
}
