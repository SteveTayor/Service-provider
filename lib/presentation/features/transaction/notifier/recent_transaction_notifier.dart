import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/data/dummy_datda.dart';
import 'package:bundlegram/data/models/wallet/service_model.dart';
import 'package:bundlegram/presentation/features/transaction/notifier/recent_transaction_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentTransactionsNotifier
    extends StateNotifier<RecentTransactionsState> {
  RecentTransactionsNotifier()
      : super(RecentTransactionsState(
          services: const [],
          filteredServices: const [],
          filterType: null,
          isLoading: false,
        )) {
    loadServices();
  }

  Future<void> loadServices() async {
    state = state.copyWith(isLoading: true);
    try {
      final services = await _fetchRecentTransactions();
      print('Fetched Recent Transactions: ${services.length}'); // Debug
      state = state.copyWith(
        services: services,
        filteredServices: services,
        isLoading: false,
      );
    } catch (e) {
      print('Error loading recent transactions: $e'); // Debug
      state = state.copyWith(
        isLoading: false,
      );
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      state = state.copyWith(filteredServices: state.services);
      print('Search cleared, showing all: ${state.services.length}'); // Debug
      return;
    }
    final q = query.toLowerCase();
    final filtered = state.services.where((service) {
      final titleLower = service.title.toLowerCase();
      final statusLower = service.status.toLowerCase();
      return titleLower.contains(q) || statusLower.contains(q);
    }).toList();
    print('Searched Recent Transactions: ${filtered.length}'); // Debug
    state = state.copyWith(filteredServices: filtered);
  }

  Future<void> refresh() async {
    await loadServices();
    print('Refreshed Recent Transactions'); // Debug
  }

  void applyFilters({
    required Set<String> typeSet,
    required Set<String> statusSet,
    required String sortBy,
    required String amountBy,
  }) {
    var temp = List<ServiceModel>.from(state.services);
    if (typeSet.isNotEmpty) {
      temp = temp.where((s) => typeSet.contains(s.type.toLowerCase())).toList();
    }
    if (statusSet.isNotEmpty) {
      temp = temp
          .where((s) => statusSet.contains(s.status.toLowerCase()))
          .toList();
    }
    temp
      ..sort((a, b) {
        final da = a.date.toDateTime() ?? DateTime.now();
        final db = b.date.toDateTime() ?? DateTime.now();
        return sortBy == 'newest' ? db.compareTo(da) : da.compareTo(db);
      })
      ..sort((a, b) {
        final aa = a.amount.toNumericValue();
        final bb = b.amount.toNumericValue();
        return amountBy == 'largest' ? bb.compareTo(aa) : aa.compareTo(bb);
      });
    print('Filtered Recent Transactions: ${temp.length}'); // Debug
    state = state.copyWith(filteredServices: temp);
  }

  Future<List<ServiceModel>> _fetchRecentTransactions() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final recent = dummyTransactions.where((txn) {
      try {
        final dt = txn.date.toDateTime() ?? DateTime(1970);
        final txnDate = DateTime(dt.year, dt.month, dt.day);
        return txnDate.isAtSameMomentAs(today) ||
            txnDate.isAtSameMomentAs(yesterday);
      } catch (e) {
        print('Error parsing date for ${txn.id}: $e');
        return false;
      }
    }).toList();
    return Future.value(recent);
  }
}
