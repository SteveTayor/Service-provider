import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_service_state.dart';

class AllServiceHistoryNotifier extends StateNotifier<ServiceHistoryState> {
  AllServiceHistoryNotifier(this.ref, this.serviceType)
      : super(ServiceHistoryState());

  final Ref ref;
  final String serviceType;

  Future<void> loadServices() async {
    state = state.copyWith(isLoading: true);

    try {
      final all = ref.read(globalProvider).usersTransactions.value?.data ?? [];

      final filtered = all.where((txn) {
        final type =
            txn.subProduct?.product?.productName?.toLowerCase().trim() ?? '';
        return type == serviceType.toLowerCase();
      }).toList();

      state = state.copyWith(
        allTransactions: filtered,
        filteredTransactions: filtered,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
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
      final status = txn.status?.toLowerCase() ?? '';
      final product = txn.subProduct?.product?.productName?.toLowerCase() ?? '';
      return product.contains(q) || status.contains(q);
    }).toList();

    state = state.copyWith(
      filteredTransactions: filtered,
      searchQuery: query,
    );
  }

  Future<void> refresh() async {
    await loadServices();
  }

  void applyFilters({
    required Set<String> typeSet,
    required Set<String> statusSet,
    required String sortBy,
    required String amountBy,
  }) {
    var temp = List<UserTransactions>.from(state.allTransactions);

    if (typeSet.isNotEmpty) {
      temp = temp.where((txn) {
        final type = txn.subProduct?.product?.productName?.toLowerCase() ?? '';
        return typeSet.contains(type);
      }).toList();
    }

    if (statusSet.isNotEmpty) {
      temp = temp
          .where((txn) =>
              statusSet.contains(txn.status?.toLowerCase() ?? 'unknown'))
          .toList();
    }

    temp
      ..sort((a, b) {
        final da = a.createdAt ?? DateTime.now();
        final db = b.createdAt ?? DateTime.now();
        return sortBy == 'newest' ? db.compareTo(da) : da.compareTo(db);
      })
      ..sort((a, b) {
        final aa = a.amount?.toNumericValue();
        final bb = b.amount?.toNumericValue();
        return amountBy == 'largest' ? bb!.compareTo(aa!) : aa!.compareTo(bb!);
      });

    state = state.copyWith(filteredTransactions: temp);
  }
}
