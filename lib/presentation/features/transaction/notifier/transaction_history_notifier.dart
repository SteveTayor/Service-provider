import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
import 'package:bundlegram/presentation/app.dart';
import 'package:bundlegram/presentation/features/transaction/notifier/recent_transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionHistoryNotifier
    extends StateNotifier<RecentTransactionsState> {
  final Ref ref;
  static const int _batchSize = 20;
// full list from global provider
  List<UserTransactions> _originalTransactions = [];
  // When filters/search are active we keep the full filtered set here,
  List<UserTransactions> _currentFilteredFull = [];

  TransactionHistoryNotifier(this.ref)
      : super(RecentTransactionsState.initial()) {
    ref.listen<AsyncValue<GetAllUserTransactionResponse?>>(
      globalProvider.select((s) => s.usersTransactions),
      (prev, next) {
        next.whenData((wrapper) {
          _originalTransactions = wrapper?.data ?? [];
          _applyFiltersAndReset();
        });
      },
    );
  }

  void _applyFiltersAndReset({
    Set<String>? typeSet,
    Set<String>? statusSet,
    String? sortBy,
    String? amountBy,
    String? searchQuery,
  }) {
    // Start from the original master list
    var temp = _originalTransactions;

    // Apply search first (if provided)
    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      final q = searchQuery.toLowerCase();
      temp = temp.where((txn) {
        final name = txn.subProduct?.subName?.toLowerCase() ?? '';
        final status = txn.status?.toLowerCase() ?? '';
        final type = txn.transType?.toLowerCase() ?? '';
        return name.contains(q) || status.contains(q) || type.contains(q);
      }).toList();
    }

    // Apply type filter
    if (typeSet != null && typeSet.isNotEmpty) {
      temp = temp
          .where((txn) => typeSet.contains(
              txn.subProduct?.product?.type?.toLowerCase() ?? 'unknown'))
          .toList();
    }

    // Apply status filter
    if (statusSet != null && statusSet.isNotEmpty) {
      temp = temp
          .where((txn) =>
              statusSet.contains(txn.status?.toLowerCase() ?? 'unknown'))
          .toList();
    }

    // Sorting by date
    if (sortBy != null && sortBy.isNotEmpty) {
      temp.sort((a, b) {
        final aDate = a.createdAt ?? DateTime(1970);
        final bDate = b.createdAt ?? DateTime(1970);
        return sortBy == 'newest'
            ? bDate.compareTo(aDate)
            : aDate.compareTo(bDate);
      });
    }

    // Sort by amount
    if (amountBy != null && amountBy.isNotEmpty) {
      temp.sort((a, b) {
        final aAmt = double.tryParse(a.amount ?? '') ?? 0;
        final bAmt = double.tryParse(b.amount ?? '') ?? 0;
        return amountBy == 'largest'
            ? bAmt.compareTo(aAmt)
            : aAmt.compareTo(bAmt);
      });
    }

    // Set the filtered full list and reset pagination slice
    _currentFilteredFull = temp;
    _resetVisibleTransactionsFromCurrentFiltered();
  }

  void _resetVisibleTransactionsFromCurrentFiltered() {
    final initialBatch = _currentFilteredFull.take(_batchSize).toList();
    final hasMore = _currentFilteredFull.length > initialBatch.length;

    state = state.copyWith(
      services: _originalTransactions,
      filteredServices: initialBatch,
      isLoading: false,
      isLoadingMore: false,
      hasMore: hasMore,
    );
  }

  void loadMoreTransactions() {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    final current = state.filteredServices.length;
    final nextBatch =
        _currentFilteredFull.skip(current).take(_batchSize).toList();

    final updated = [...state.filteredServices, ...nextBatch];
    final hasMore = updated.length < _currentFilteredFull.length;

    state = state.copyWith(
      filteredServices: updated,
      isLoadingMore: false,
      hasMore: hasMore,
    );
  }

  void loadServices() {
    ref.read(globalProvider).usersTransactions.whenData((data) {
      _originalTransactions = data?.data ?? [];
      _applyFiltersAndReset();
    });
  }

  void refresh() {
    loadServices();
  }

  void search(String query) {
    if (query.isEmpty) {
      _applyFiltersAndReset();
      return;
    }

    _applyFiltersAndReset();
  }

  void applyFilters({
    required Set<String> typeSet,
    required Set<String> statusSet,
    required String sortBy,
    required String amountBy,
  }) {
    // NOTE: we pass sets and names to the internal apply function; it will derive results
    _applyFiltersAndReset(
      typeSet: typeSet,
      statusSet: statusSet,
      sortBy: sortBy,
      amountBy: amountBy,
    );
  }
}
