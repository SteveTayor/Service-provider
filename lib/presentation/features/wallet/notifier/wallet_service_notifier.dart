import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/data/models/wallet/service_model.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_service_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceHistoryNotifier extends StateNotifier<ServiceHistoryState> {
  ServiceHistoryNotifier(this.serviceType) : super(ServiceHistoryState());

  final String serviceType; // e.g. 'betting', 'mobile_data', ...

  Future<void> loadServices() async {
    state = state.copyWith(isLoading: true);

    try {
      final services = await _fetchServices();
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

  // Future<void> refresh() async {
  //   await loadServices();
  // }

  /// Applies multi‐criteria filters:
  ///  - [typeSet]: any of service.type.toLowerCase()
  ///  - [statusSet]: any of service.status.toLowerCase()
  ///  - [sortBy]: 'newest' or 'oldest' (date)
  ///  - [amountBy]: 'largest' or 'smallest'
  void applyFilters({
    required Set<String> typeSet,
    required Set<String> statusSet,
    required String sortBy,
    required String amountBy,
  }) {
    var temp = List<ServiceModel>.from(state.services);

    // 1) Filter by type
    if (typeSet.isNotEmpty) {
      temp = temp.where((s) {
        return typeSet.contains(s.type.toLowerCase());
      }).toList();
    }

    // 2) Filter by status
    if (statusSet.isNotEmpty) {
      temp = temp.where((s) {
        return statusSet.contains(s.status.toLowerCase());
      }).toList();
    }

    // 3) Sort by date
    temp
      ..sort((a, b) {
        final da = a.date.toDateTime() ?? DateTime(1970);
        final db = b.date.toDateTime() ?? DateTime(1970);
        if (sortBy == 'newest') {
          return db.compareTo(da);
        } else {
          return da.compareTo(db);
        }
      })

      // 4) Sort by amount (stable relative to date sort above)
      ..sort((a, b) {
        final aa = a.amount.toNumericValue();
        final bb = b.amount.toNumericValue();
        if (amountBy == 'largest') {
          return bb.compareTo(aa);
        } else {
          return aa.compareTo(bb);
        }
      });

    state = state.copyWith(filteredServices: temp);
  }

  Future<List<ServiceModel>> _fetchServices() async {
    switch (serviceType) {
      case 'betting':
        return await _fetchBettingHistory();
      case 'mobile_data':
        return await _fetchMobileDataHistory();
      case 'education':
        return await _fetchEducationHistory();
      case 'cable_tv':
        return await _fetchCableTvHistory();
      case 'electricity':
        return await _fetchElectricityHistory();
      case 'airtime':
        return await _fetchAirtimeHistory();
      case 'e_pin':
        return await _fetchEPinHistory();
      case 'wallet':
        return await _fetchWalletHistory();
      default:
        throw UnimplementedError('Service type $serviceType not implemented');
    }
  }

  Future<List<ServiceModel>> _fetchBettingHistory() async {
    throw UnimplementedError();
  }

  Future<List<ServiceModel>> _fetchMobileDataHistory() async {
    throw UnimplementedError();
  }

  Future<List<ServiceModel>> _fetchEducationHistory() async {
    throw UnimplementedError();
  }

  Future<List<ServiceModel>> _fetchCableTvHistory() async {
    throw UnimplementedError();
  }

  Future<List<ServiceModel>> _fetchElectricityHistory() async {
    throw UnimplementedError();
  }

  Future<List<ServiceModel>> _fetchAirtimeHistory() async {
    throw UnimplementedError();
  }

  Future<List<ServiceModel>> _fetchEPinHistory() async {
    throw UnimplementedError();
  }

  Future<List<ServiceModel>> _fetchWalletHistory() async {
    // TODO:  API calls for wallet top‐ups & withdrawals
    // final topUps = await fetchTopUpHistory();
    // final withdrawals = await fetchWithdrawalHistory();
    // return [...topUps, ...withdrawals];
    return []; // stub
  }
}
