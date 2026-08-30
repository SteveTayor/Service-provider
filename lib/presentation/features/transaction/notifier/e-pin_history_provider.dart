import 'package:bundlegram/data/models/products/epin/epin_trannsactions.dart';
import 'package:bundlegram/presentation/features/transaction/screens/bulk%20e-pin/model/epin_mapper.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_service_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
import 'package:bundlegram/core/providers/global_provider.dart';

class EpinHistoryNotifier extends StateNotifier<ServiceHistoryState> {
  EpinHistoryNotifier(this.ref) : super(ServiceHistoryState()) {
    // Listen to changes in globalProvider.epinTransactions and update local lists
    ref.listen<AsyncValue<EpinTransactionRequestsResponse?>>(
      globalProvider.select((s) => s.epinTransactions),
      (prev, next) {
        next.when(
          data: (wrapper) {
            // wrapper is EpinTransactionRequestsResponse?
            final datumList = (wrapper?.data?.data) ?? <Datum>[];
            final items = datumList.map((d) => d.toUserTransactions()).toList();
            _originalTransactions = items;
            _applyFiltersAndReset();
          },
          loading: () {
            // keep UI informed
            state = state.copyWith(isLoading: true, error: null);
          },
          error: (err, _) {
            state = state.copyWith(isLoading: false, error: err.toString());
          },
        );
      },
    );

    // Load initial data from global provider if already present
    _loadInitialFromProvider();
  }

  final Ref ref;
  static const int _batchSize = 20;

  // Master list (converted EPIN -> UserTransactions)
  List<UserTransactions> _originalTransactions = [];

  // Current filtered full list (used for pagination)
  List<UserTransactions> _currentFilteredFull = [];

  // Populate _originalTransactions from globalProvider if available
  void _loadInitialFromProvider() {
    final wrapper = ref.read(globalProvider).epinTransactions.value;
    final datumList = (wrapper?.data?.data) ?? <Datum>[];
    final items = datumList.map((d) => d.toUserTransactions()).toList();
    _originalTransactions = items;
    _applyFiltersAndReset();
  }

  /// Public API: refresh will re-read what's in global provider.
  /// It does not call the API (GlobalProvider is responsible for fetching).
  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, error: null);
    _loadInitialFromProvider();
  }

  void loadMoreTransactions() {
    final current = state.filteredTransactions.length;
    if (current >= _currentFilteredFull.length) return; // all loaded

    final nextBatch =
        _currentFilteredFull.skip(current).take(_batchSize).toList();
    state = state.copyWith(
        filteredTransactions: [...state.filteredTransactions, ...nextBatch]);
  }

  void search(String query) {
    if (query.trim().isEmpty) {
      _applyFiltersAndReset();
      return;
    }
    _applyFiltersAndReset(searchQuery: query);
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

  // ----- Internal filtering / paging logic (same behavior as AllServiceHistoryNotifier) -----
  void _applyFiltersAndReset({
    Set<String>? typeSet,
    Set<String>? statusSet,
    String? sortBy,
    String? amountBy,
    String? searchQuery,
  }) {
    var temp = [..._originalTransactions];

    // Search
    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      final q = searchQuery.toLowerCase();
      temp = temp.where((txn) {
        final status = txn.status?.toLowerCase() ?? '';
        final product =
            txn.subProduct?.product?.productName?.toLowerCase() ?? '';
        final description = txn.subProduct?.subName?.toLowerCase() ?? '';
        final transRef = txn.transRef?.toLowerCase() ?? '';
        return product.contains(q) ||
            status.contains(q) ||
            description.contains(q) ||
            transRef.contains(q);
      }).toList();
    }

    // Status filter
    if (statusSet != null && statusSet.isNotEmpty) {
      final normalized = statusSet.map((s) => s.toLowerCase()).toSet();
      temp = temp.where((txn) {
        final s = txn.status?.toLowerCase() ?? 'unknown';
        return normalized.contains(s);
      }).toList();
    }

    // Type filter (by product name)
    if (typeSet != null && typeSet.isNotEmpty) {
      final normalized = typeSet.map((s) => s.toLowerCase()).toSet();
      temp = temp.where((txn) {
        final type = txn.subProduct?.product?.productName?.toLowerCase() ?? '';
        return normalized.contains(type);
      }).toList();
    }

    // Sort by date (default newest first)
    if (sortBy != null && sortBy.isNotEmpty) {
      temp.sort((a, b) {
        final aDate = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bDate = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return sortBy == 'newest'
            ? bDate.compareTo(aDate)
            : aDate.compareTo(bDate);
      });
    } else {
      temp.sort((a, b) {
        final aDate = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bDate = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bDate.compareTo(aDate);
      });
    }

    // Sort by amount (secondary)
    if (amountBy != null && amountBy.isNotEmpty) {
      temp.sort((a, b) {
        final aAmt = _amountValue(a);
        final bAmt = _amountValue(b);
        return amountBy == 'largest'
            ? bAmt.compareTo(aAmt)
            : aAmt.compareTo(bAmt);
      });
    }

    // Set current filtered full list and reset visible page
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

  double _amountValue(UserTransactions txn) {
    if (txn.deductAmount != null) return txn.deductAmount!;
    final raw = txn.amount ?? '0';
    return double.tryParse(raw.replaceAll(',', '')) ?? 0.0;
  }
}

