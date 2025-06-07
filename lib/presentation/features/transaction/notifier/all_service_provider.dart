import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/data/dummy_datda.dart';
import 'package:bundlegram/data/models/wallet/service_model.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_service_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllServiceHistoryNotifier extends StateNotifier<ServiceHistoryState> {
  AllServiceHistoryNotifier(this.serviceType) : super(ServiceHistoryState());

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
      print('Error loading $serviceType services: $e'); // Debug
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
      print(
          'Search cleared for $serviceType, showing all: ${state.services.length}'); // Debug
      return;
    }
    final filtered = state.services.where((service) {
      final titleLower = service.title.toLowerCase();
      final statusLower = service.status.toLowerCase();
      final q = query.toLowerCase();
      return titleLower.contains(q) || statusLower.contains(q);
    }).toList();
    print('Searched $serviceType Services: ${filtered.length}'); // Debug
    state = state.copyWith(
      filteredServices: filtered,
      searchQuery: query,
    );
  }

  Future<void> refresh() async {
    await loadServices();
    print('Refreshed $serviceType Services'); // Debug
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
    print('Filtered $serviceType Services: ${temp.length}'); // Debug
    state = state.copyWith(filteredServices: temp);
  }

  Future<List<ServiceModel>> _fetchServices() async {
    switch (serviceType) {
      case 'betting':
        return await _fetchBettingHistory();
      case 'mobile data':
        return await _fetchMobileDataHistory();
      case 'education':
        return await _fetchEducationHistory();
      case 'cable tv':
        return await _fetchCableTvHistory();
      case 'electricity':
        return await _fetchElectricityHistory();
      case 'airtime':
        return await _fetchAirtimeHistory();
      case 'e-pin':
        return await _fetchEPinHistory();
      case 'internet service':
        return await _fetchInternetServiceHistory();
      default:
        throw UnimplementedError('Service type $serviceType not implemented');
    }
  }

  Future<List<ServiceModel>> _fetchBettingHistory() async {
    final bettingTransactions = dummyTransactions
        .where((transaction) => transaction.type == 'betting')
        .toList();
    return Future.value(bettingTransactions);
  }

  Future<List<ServiceModel>> _fetchMobileDataHistory() async {
    final mobileDataTransactions = dummyTransactions
        .where((transaction) => transaction.type == 'mobile data')
        .toList();
    return Future.value(mobileDataTransactions);
  }

  Future<List<ServiceModel>> _fetchEducationHistory() async {
    final educationTransactions = dummyTransactions
        .where((transaction) => transaction.type == 'education')
        .toList();
    return Future.value(educationTransactions);
  }

  Future<List<ServiceModel>> _fetchInternetServiceHistory() async {
    final internetServiceTransactions = dummyTransactions
        .where((transaction) => transaction.type == 'internet service')
        .toList();
    return Future.value(internetServiceTransactions);
  }

  Future<List<ServiceModel>> _fetchCableTvHistory() async {
    final cableTvTransactions = dummyTransactions
        .where((transaction) => transaction.type == 'cable tv')
        .toList();
    return Future.value(cableTvTransactions);
  }

  Future<List<ServiceModel>> _fetchElectricityHistory() async {
    final electricityTransactions = dummyTransactions
        .where((transaction) => transaction.type == 'electricity')
        .toList();
    return Future.value(electricityTransactions);
  }

  Future<List<ServiceModel>> _fetchAirtimeHistory() async {
    final airtimeTransactions = dummyTransactions
        .where((transaction) => transaction.type == 'airtime')
        .toList();
    return Future.value(airtimeTransactions);
  }

  Future<List<ServiceModel>> _fetchEPinHistory() async {
    final ePinTransactions = dummyTransactions
        .where((transaction) => transaction.type == 'e-pin voucher')
        .toList();
    return Future.value(ePinTransactions);
  }
}
