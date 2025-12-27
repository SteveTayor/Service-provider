import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_service_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllServiceHistoryNotifier extends StateNotifier<ServiceHistoryState> {
  AllServiceHistoryNotifier(this.ref, this.serviceType)
      : super(ServiceHistoryState()) {
    // Listen to global provider changes
    ref.listen<AsyncValue<GetAllUserTransactionResponse?>>(
      globalProvider.select((s) => s.usersTransactions),
      (prev, next) {
        next.when(
          data: (wrapper) {
            _originalTransactions = (wrapper?.data ?? [])
                .where((txn) =>
                    (txn.transType ?? '').toLowerCase().trim() ==
                    serviceType.toLowerCase())
                .toList();
            _applyFiltersAndReset();
          },
          loading: () {
            state = state.copyWith(isLoading: true, error: null);
          },
          error: (err, stack) {
            state = state.copyWith(
              isLoading: false,
              error: err.toString(), // or sanitize
            );
          },
        );
      },
    );
    // Initial load
    _loadInitialFromProvider();
  }

  final Ref ref;
  final String serviceType;
  static const int _batchSize = 20; // Same batch size as TransactionHistory
// list from global provider filtered by serviceType need not overwritten
  List<UserTransactions> _originalTransactions = [];

  // Full filtered list derived from master (used for pagination)
  List<UserTransactions> _currentFilteredFull = [];

  void _loadInitialFromProvider() {
    final all = ref.read(globalProvider).usersTransactions.value?.data ?? [];
    _originalTransactions = all
        .where((txn) =>
            (txn.transType ?? '').toLowerCase().trim() ==
            serviceType.toLowerCase())
        .toList();
    _applyFiltersAndReset();
  }

  void _applyFiltersAndReset({
    Set<String>? typeSet,
    Set<String>? statusSet,
    String? sortBy,
    String? amountBy,
    String? searchQuery,
  }) {
    // Start from the immutable master list
    var temp = [..._originalTransactions];

    // Search
    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      final q = searchQuery.toLowerCase();
      temp = temp.where((txn) {
        final status = txn.status?.toLowerCase() ?? '';
        final product =
            txn.subProduct?.product?.productName?.toLowerCase() ?? '';
        final description = txn.subProduct?.subName?.toLowerCase() ?? '';
        return product.contains(q) ||
            status.contains(q) ||
            description.contains(q);
      }).toList();
    }

    // Status filter
    if (statusSet != null && statusSet.isNotEmpty) {
      temp = temp
          .where((txn) =>
              statusSet.contains(txn.status?.toLowerCase() ?? 'unknown'))
          .toList();
    }

    // Type filter (optional; master already filtered by serviceType)
    if (typeSet != null && typeSet.isNotEmpty) {
      temp = temp.where((txn) {
        final type = txn.subProduct?.product?.productName?.toLowerCase() ?? '';
        return typeSet.contains(type);
      }).toList();
    }

    // Sort by date
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
        final aAmt = double.tryParse(a.amount ?? '0') ?? 0;
        final bAmt = double.tryParse(b.amount ?? '0') ?? 0;
        return amountBy == 'largest'
            ? bAmt.compareTo(aAmt)
            : aAmt.compareTo(bAmt);
      });
    }

    // Set the filtered full list and reset visible page
    _currentFilteredFull = temp;
    _resetVisibleTransactionsFromCurrentFiltered();
  }

  void _resetVisibleTransactionsFromCurrentFiltered() {
    final initialBatch = _currentFilteredFull.take(_batchSize).toList();
    state = state.copyWith(
      allTransactions: _originalTransactions,
      filteredTransactions: initialBatch,
      isLoading: false,
      error: null,
    );
  }

  void _loadServices() {
    // keep backwards compatibility: load initial view from provider
    _loadInitialFromProvider();
  }

  void loadMoreTransactions() {
    final current = state.filteredTransactions.length;
    if (current >= _currentFilteredFull.length) return; // All loaded

    final nextBatch =
        _currentFilteredFull.skip(current).take(_batchSize).toList();
    final updated = [...state.filteredTransactions, ...nextBatch];

    state = state.copyWith(filteredTransactions: updated);
  }

  void search(String query) {
    if (query.isEmpty) {
      // reset to master for this service type
      _applyFiltersAndReset();
      return;
    }
    _applyFiltersAndReset(searchQuery: query);
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    _loadInitialFromProvider();
  }

  void applyFilters({
    required Set<String> typeSet,
    required Set<String> statusSet,
    required String sortBy,
    required String amountBy,
  }) {
    _applyFiltersAndReset(
      typeSet: typeSet,
      statusSet: statusSet,
      sortBy: sortBy,
      amountBy: amountBy,
    );
  }
}
