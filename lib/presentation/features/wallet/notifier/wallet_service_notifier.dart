import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/data/dummy_datda.dart';
import 'package:bundlegram/data/models/wallet/service_model.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_service_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WalletServiceHistoryNotifier extends StateNotifier<ServiceHistoryState> {
  WalletServiceHistoryNotifier(this.serviceType) : super(ServiceHistoryState());

  final String serviceType;

  Future<void> loadServices() async {
    state = state.copyWith(isLoading: true);
    try {
      final services = await _fetchServices();
      print('Fetched $serviceType Services: ${services.length}'); // Debug
      state = state.copyWith(
        services: services,
        filteredServices: services,
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
        filteredServices: state.services,
        searchQuery: '',
      );
      return;
    }
    final filtered = state.services.where((service) {
      final titleLower = service.title.toLowerCase();
      final statusLower = service.status.toLowerCase();
      final q = query.toLowerCase();
      return titleLower.contains(q) || statusLower.contains(q);
    }).toList();
    state = state.copyWith(
      filteredServices: filtered,
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
        final da = a.date.toDateTime() ?? DateTime(1970);
        final db = b.date.toDateTime() ?? DateTime(1970);
        return sortBy == 'newest' ? db.compareTo(da) : da.compareTo(db);
      })
      ..sort((a, b) {
        final aa = a.amount.toNumericValue();
        final bb = b.amount.toNumericValue();
        return amountBy == 'largest' ? bb.compareTo(aa) : aa.compareTo(bb);
      });
    print('Filtered $serviceType Services: ${temp.length}'); // Debug
    state = state.copyWith(filteredServices: temp);
  }

  Future<List<ServiceModel>> _fetchServices() async {
    switch (serviceType) {
      case 'wallet':
        return await _fetchWalletHistory();
      default:
        throw UnimplementedError('Service type $serviceType not implemented');
    }
  }

  Future<List<ServiceModel>> _fetchWalletHistory() async {
    return dummyTransactions.where((transaction) {
      final type = transaction.type.toLowerCase();
      return type.contains('top-up') || type.contains('withdrawal');
    }).toList();
  }
}
