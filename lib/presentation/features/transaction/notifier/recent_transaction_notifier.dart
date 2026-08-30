import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/providers/service_provider.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
import 'package:bundlegram/presentation/features/transaction/notifier/recent_transaction_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:collection/collection.dart';

List<UserTransactions> takeTopKByDate(
  Map<String, dynamic> args,
) {
  final all = args['all'] as List<UserTransactions>;
  final k = args['k'] as int;

  final pq = PriorityQueue<UserTransactions>(
    (a, b) => a.createdAt!.compareTo(b.createdAt!),
  );

  for (final txn in all) {
    if (txn.createdAt == null) continue;
    pq.add(txn);
    if (pq.length > k) pq.removeFirst();
  }

  final top = pq.toList()..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

  return top;
}

class RecentTransactionsNotifier
    extends StateNotifier<RecentTransactionsState> {
  final Ref ref;

  RecentTransactionsNotifier(this.ref)
      : super(RecentTransactionsState.initial().copyWith(isLoading: true)) {
    // Listen for the global fetch completingâ€¦
//     ref.listen<AsyncValue<GetAllUserTransactionResponse?>>(
//       globalProvider.select((s) => s.usersTransactions),
//       (prev, next) {
//         next.when(
//           data: (wrapper)async {
//             try {
//               // final limited = _takeTopKByDate(wrapper?.data ?? [], k: 10);
//               final limited = await compute(
//   takeTopKByDate,
//   {'all': wrapper?.data ?? [], 'k': 10},
// );

//               state = state.copyWith(
//                 services: limited,
//                 filteredServices: limited,
//                 isLoading: false,
//                 error: null,
//               );
//             } catch (e) {
//               state = state.copyWith(isLoading: false, error: e);
//             }
//           },
//           error: (err, _) =>
//               state = state.copyWith(isLoading: false, error: err),
//           loading: () => state = state.copyWith(isLoading: true, error: null),
//         );
//       },
//     );
    int _lastCount = 0;

    ref.listen<AsyncValue<GetAllUserTransactionResponse?>>(
      globalProvider.select((s) => s.usersTransactions),
      (prev, next) {
        next.whenData((wrapper) async {
          final list = wrapper?.data ?? [];
          if (list.length == _lastCount) return;

          _lastCount = list.length;
          final limited = await compute(
            takeTopKByDate,
            {'all': list, 'k': 10},
          );

          state = state.copyWith(
            services: limited,
            filteredServices: limited,
            isLoading: false,
            error: null,
          );
        });
      },
    );
  }

  Future<void> refresh() async {
    ref.read(globalProvider).usersTransactions.whenData((data) async {
      try {
        // final limited = _takeTopKByDate(data?.data ?? [], k: 10);
        final limited = await compute(
          takeTopKByDate,
          {'all': data?.data ?? [], 'k': 10},
        );

        state = state.copyWith(
          services: limited,
          filteredServices: limited,
          isLoading: false,
        );
      } catch (e) {
        state = state.copyWith(isLoading: false, error: e);
      }
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

  /// Min-heap to keep top K recent transactions efficiently
  List<UserTransactions> _takeTopKByDate(
    List<UserTransactions> all, {
    required int k,
  }) {
    final pq = PriorityQueue<UserTransactions>(
      (a, b) => a.createdAt!.compareTo(b.createdAt!),
    );

    for (final txn in all) {
      if (txn.createdAt == null) continue;
      pq.add(txn);
      if (pq.length > k) pq.removeFirst();
    }

    final top = pq.toList()
      ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    return top;
  }
}

