import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
import 'package:bundlegram/presentation/features/transaction/notifier/recent_transaction_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentTransactionsNotifier
    extends StateNotifier<RecentTransactionsState> {
  final Ref ref;

  RecentTransactionsNotifier(this.ref)
      : super(RecentTransactionsState.initial()) {
    loadServices();
  }

  void loadServices() {
    ref.read(globalProvider).usersTransactions.whenData((data) {
      final now = DateTime.now();
      final last7Days = now.subtract(const Duration(days: 7));

      final recent = (data?.data ?? []).where((txn) {
        final txnDate = txn.createdAt;
        return txnDate != null && txnDate.isAfter(last7Days);
      }).toList();

      state = state.copyWith(
        services: recent,
        filteredServices: recent,
        isLoading: false,
      );
    });
  }

  void refresh() {
    loadServices();
  }

  void search(String query) {
    if (query.isEmpty) {
      state = state.copyWith(filteredServices: state.services);
      return;
    }

    final q = query.toLowerCase();
    final filtered = state.services.where((txn) {
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
    var temp = [...state.services];

    if (typeSet.isNotEmpty) {
      temp = temp
          .where((txn) =>
              typeSet.contains(txn.transType?.toLowerCase() ?? 'unknown'))
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
        final aDate = a.createdAt;
        final bDate = b.createdAt;
        return sortBy == 'newest'
            ? bDate!.compareTo(aDate!)
            : aDate!.compareTo(bDate!);
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

    state = state.copyWith(filteredServices: temp);
  }
}
