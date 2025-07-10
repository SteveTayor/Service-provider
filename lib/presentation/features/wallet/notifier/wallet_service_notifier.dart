import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/data/dummy_datda.dart';
import 'package:bundlegram/data/models/wallet/service_model.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_service_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bundlegram/core/providers/global_provider.dart';

final walletServiceHistoryProvider = StateNotifierProvider.family<
    WalletServiceHistoryNotifier,
    ServiceHistoryState,
    String>((ref, serviceType) {
  return WalletServiceHistoryNotifier(ref, serviceType);
});

class WalletServiceHistoryNotifier extends StateNotifier<ServiceHistoryState> {
  final Ref ref;
  final String serviceType;

  WalletServiceHistoryNotifier(this.ref, this.serviceType)
      : super(ServiceHistoryState()) {
    _loadFromGlobal();
  }

  void _loadFromGlobal() {
    final data = ref.read(globalProvider).usersTransactions
      ..whenData((txns) {
        final filtered = txns?.data?.where((txn) {
          final type = txn.transType?.toLowerCase() ?? '';
          return type.contains('fund_wallet') || type.contains('withdrawal');
        }).toList();

        state = state.copyWith(
          allTransactions: filtered,
          filteredTransactions: filtered,
        );
      });
  }

  void refresh() {
    _loadFromGlobal();
  }

  void search(String query) {
    if (query.isEmpty) {
      state = state.copyWith(
        filteredTransactions: state.allTransactions,
        searchQuery: '',
      );
      return;
    }

    final q = query.toLowerCase();
    final filtered = state.allTransactions.where((txn) {
      final type = txn.transType?.toLowerCase() ?? '';
      final status = txn.status?.toLowerCase() ?? '';
      final name = txn.subProduct?.subName?.toLowerCase() ?? '';
      return type.contains(q) || status.contains(q) || name.contains(q);
    }).toList();

    state = state.copyWith(
      filteredTransactions: filtered,
      searchQuery: query,
    );
  }

  void applyFilters({
    required Set<String> typeSet,
    required Set<String> statusSet,
    required String sortBy,
    required String amountBy,
  }) {
    var temp = [...state.allTransactions];

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

    state = state.copyWith(filteredTransactions: temp);
  }
}
