import 'package:bundlegram/data/models/wallet/service_model.dart';

class RecentTransactionsState {
  final List<ServiceModel> services; // All services/transactions
  final List<ServiceModel> filteredServices; // Filtered subset
  final String? filterType; // Current filter type
  final bool isLoading; // Loading state

  RecentTransactionsState({
    required this.services,
    required this.filteredServices,
    this.filterType,
    this.isLoading = false,
  });

  factory RecentTransactionsState.initial() {
    return RecentTransactionsState(
      services: [],
      filteredServices: [],
      filterType: null,
      isLoading: false,
    );
  }

  RecentTransactionsState copyWith({
    List<ServiceModel>? services,
    List<ServiceModel>? filteredServices,
    String? filterType,
    bool? isLoading,
  }) {
    return RecentTransactionsState(
      services: services ?? this.services,
      filteredServices: filteredServices ?? this.filteredServices,
      filterType: filterType ?? this.filterType,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
