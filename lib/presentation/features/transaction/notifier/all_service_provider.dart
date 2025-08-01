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
        next.whenData((wrapper) {
          _allTransactions = wrapper?.data ?? [];
          _loadServices();
        });
      },
    );
    // Initial load
    _loadServices();
  }

  final Ref ref;
  final String serviceType;
  static const int _batchSize = 20; // Same batch size as TransactionHistory
  List<UserTransactions> _allTransactions = [];

  void _loadServices() {
    final all = ref.read(globalProvider).usersTransactions.value?.data ?? [];
    final filtered = all.where((txn) {
      final type = txn.transType?.toLowerCase().trim();
      // txn.subProduct?.product?.productName?.toLowerCase().trim() ?? '';
      return type == serviceType.toLowerCase();
    }).toList();

    _allTransactions = filtered;
    final initialBatch = _allTransactions.take(_batchSize).toList();
    state = state.copyWith(
      allTransactions: _allTransactions,
      filteredTransactions: initialBatch,
      isLoading: false,
      error: null,
    );
  }

  void loadMoreTransactions() {
    final current = state.filteredTransactions.length;
    if (current >= _allTransactions.length) return; // All loaded

    final nextBatch = _allTransactions.skip(current).take(_batchSize).toList();
    final updated = [...state.filteredTransactions, ...nextBatch];

    state = state.copyWith(filteredTransactions: updated);
  }

  void search(String query) {
    if (query.isEmpty) {
      final initialBatch = _allTransactions.take(_batchSize).toList();
      state = state.copyWith(
        filteredTransactions: initialBatch,
        searchQuery: '',
      );
      return;
    }

    final q = query.toLowerCase();
    final filtered = _allTransactions.where((txn) {
      final status = txn.status?.toLowerCase() ?? '';
      final product = txn.subProduct?.product?.productName?.toLowerCase() ?? '';
      final description = txn.subProduct?.subName?.toLowerCase() ?? '';
      return product.contains(q) ||
          status.contains(q) ||
          description.contains(q);
    }).toList();

    state = state.copyWith(
      filteredTransactions: filtered,
      searchQuery: query,
    );
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    _loadServices();
  }

  void applyFilters({
    required Set<String> typeSet,
    required Set<String> statusSet,
    required String sortBy,
    required String amountBy,
  }) {
    var temp = List<UserTransactions>.from(_allTransactions);

    // Filter by status if provided
    if (statusSet.isNotEmpty) {
      temp = temp
          .where((txn) =>
              statusSet.contains(txn.status?.toLowerCase() ?? 'unknown'))
          .toList();
    }

    // Filter by type (optional, as serviceType already filters by productName)
    if (typeSet.isNotEmpty) {
      temp = temp.where((txn) {
        final type = txn.subProduct?.product?.productName?.toLowerCase() ?? '';
        return typeSet.contains(type);
      }).toList();
    }

    // Sort by date
    if (sortBy.isNotEmpty) {
      temp.sort((a, b) {
        final aDate = a.createdAt ?? DateTime(1970);
        final bDate = b.createdAt ?? DateTime(1970);
        return sortBy == 'newest'
            ? bDate.compareTo(aDate)
            : aDate.compareTo(bDate);
      });
    }

    // Sort by amount
    if (amountBy.isNotEmpty) {
      temp.sort((a, b) {
        final aAmt = double.tryParse(a.amount ?? '0') ?? 0;
        final bAmt = double.tryParse(b.amount ?? '0') ?? 0;
        return amountBy == 'largest'
            ? bAmt.compareTo(aAmt)
            : aAmt.compareTo(bAmt);
      });
    }

    _allTransactions = temp;
    final initialBatch = _allTransactions.take(_batchSize).toList();
    state = state.copyWith(filteredTransactions: initialBatch);
  }
}
