import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
import 'package:bundlegram/presentation/features/transaction/notifier/recent_transaction_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

final walletTransactionsProvider =
    StateNotifierProvider<WalletTransactionsNotifier, RecentTransactionsState>(
        (ref) {
  return WalletTransactionsNotifier(ref);
});

class WalletTransactionsNotifier
    extends StateNotifier<RecentTransactionsState> {
  final Ref ref;

  WalletTransactionsNotifier(this.ref)
      : super(RecentTransactionsState.initial().copyWith(isLoading: true)) {
    ref.listen<AsyncValue<GetAllUserTransactionResponse?>>(
      globalProvider.select((s) => s.usersTransactions),
      (prev, next) {
        next.whenData((wrapper) {
          final filtered = (wrapper?.data ?? []).where((txn) {
            final type = txn.transType?.toLowerCase() ?? '';
            return type == 'fund_wallet' || type == 'withdrawal';
          }).toList();

          final limited = _takeTopKByDate(filtered, k: 10);

          state = state.copyWith(
            services: limited,
            filteredServices: limited,
            isLoading: false,
          );
        });
      },
    );
  }

  void refresh() {
    ref.read(globalProvider).usersTransactions.whenData((data) {
      final filtered = (data?.data ?? []).where((txn) {
        final type = txn.transType?.toLowerCase() ?? '';
        return type == 'fund_wallet' || type == 'withdrawal';
      }).toList();

      final limited = _takeTopKByDate(filtered, k: 10);

      state = state.copyWith(
        services: limited,
        filteredServices: limited,
        isLoading: false,
      );
    });
  }

  List<UserTransactions> _takeTopKByDate(List<UserTransactions> all,
      {required int k}) {
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
