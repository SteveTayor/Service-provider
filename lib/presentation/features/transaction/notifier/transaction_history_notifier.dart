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
  List<UserTransactions> _allTransactions = [];

  TransactionHistoryNotifier(this.ref)
      : super(RecentTransactionsState.initial()) {
    ref.listen<AsyncValue<GetAllUserTransactionResponse?>>(
      globalProvider.select((s) => s.usersTransactions),
      (prev, next) {
        next.whenData((wrapper) {
          _allTransactions = wrapper?.data ?? [];
          _resetVisibleTransactions();
        });
      },
    );
  }

  void _resetVisibleTransactions() {
    final initialBatch = _allTransactions.take(_batchSize).toList();
    state = state.copyWith(
      services: _allTransactions,
      filteredServices: initialBatch,
      isLoading: false,
    );
  }

  void loadMoreTransactions() {
    final current = state.filteredServices.length;
    if (current >= _allTransactions.length) return; // all loaded

    final nextBatch = _allTransactions.skip(current).take(_batchSize).toList();

    final updated = [...state.filteredServices, ...nextBatch];
    state = state.copyWith(filteredServices: updated);
  }

  void loadServices() {
    ref.read(globalProvider).usersTransactions.whenData((data) {
      _allTransactions = data?.data ?? [];
      _resetVisibleTransactions();
    });
  }

  void refresh() {
    loadServices();
  }

  void search(String query) {
    if (query.isEmpty) {
      _resetVisibleTransactions();
      return;
    }

    final q = query.toLowerCase();
    final filtered = _allTransactions.where((txn) {
      final name = txn.subProduct?.subName?.toLowerCase() ?? '';
      final status = txn.status?.toLowerCase() ?? '';
      final type = txn.transType?.toLowerCase() ?? '';
      return name.contains(q) || status.contains(q) || type.contains(q);
    }).toList();

    state = state.copyWith(filteredServices: filtered);
  }

  void applyFilters({
    required Set<String> typeSet,
    required Set<String> statusSet,
    required String sortBy,
    required String amountBy,
  }) {
    var temp = [..._allTransactions];

    if (typeSet.isNotEmpty) {
      temp = temp
          .where((txn) => typeSet.contains(
              txn.subProduct?.product?.type?.toLowerCase() ?? 'unknown'))
          .toList();
    }

    if (statusSet.isNotEmpty) {
      temp = temp
          .where((txn) =>
              statusSet.contains(txn.status?.toLowerCase() ?? 'unknown'))
          .toList();
    }

    if (sortBy.isNotEmpty) {
      temp.sort((a, b) {
        final aDate = a.createdAt ?? DateTime(1970);
        final bDate = b.createdAt ?? DateTime(1970);
        return sortBy == 'newest'
            ? bDate.compareTo(aDate)
            : aDate.compareTo(bDate);
      });
    }

    if (amountBy.isNotEmpty) {
      temp.sort((a, b) {
        final aAmt = double.tryParse(a.amount ?? '') ?? 0;
        final bAmt = double.tryParse(b.amount ?? '') ?? 0;
        return amountBy == 'largest'
            ? bAmt.compareTo(aAmt)
            : aAmt.compareTo(bAmt);
      });
    }

    _allTransactions = temp;
    _resetVisibleTransactions();
  }
}
