import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/providers/service_provider.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
import 'package:bundlegram/presentation/features/transaction/notifier/recent_transaction_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
import 'package:bundlegram/presentation/features/transaction/notifier/recent_transaction_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentTransactionsNotifier
    extends StateNotifier<RecentTransactionsState> {
  final Ref ref;

  RecentTransactionsNotifier(this.ref)
      // ← Start with isLoading=true so first-load skeleton shows exactly once
      : super(RecentTransactionsState.initial().copyWith(isLoading: true)) {
    // Listen for the global fetch completing…
    ref.listen<AsyncValue<GetAllUserTransactionResponse?>>(
      globalProvider.select((s) => s.usersTransactions),
      (prev, next) {
        next.whenData((wrapper) {
          final recent = (wrapper?.data ?? [])
              .where((txn) => txn.createdAt != null)
              .toList()
            ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

          final limited = recent.take(10).toList();

          // When data arrives, publish it and turn off loading once and for all
          state = state.copyWith(
            services: limited,
            filteredServices: limited,
            isLoading: false,
          );
        });
      },
    );
  }

  /// Calling refresh() will re-filter or re-publish the existing
  /// data if you need to retrigger the listener logic; it won't
  /// turn isLoading back on.
  void refresh() {
    ref.read(globalProvider).usersTransactions.whenData((data) {
      final recent = (data?.data ?? [])
          .where((txn) => txn.createdAt != null)
          .toList()
        ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

      final limited = recent.take(10).toList();

      state = state.copyWith(
        services: limited,
        filteredServices: limited,
        isLoading: false, // stays false
      );
    });
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
        final aDate = a.createdAt!;
        final bDate = b.createdAt!;
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

    state = state.copyWith(filteredServices: temp);
  }
}
