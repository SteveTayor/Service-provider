import 'package:bundlegram/data/models/wallet/service_model.dart';

class ServiceHistoryState {
  final List<ServiceModel> services;
  final List<ServiceModel> filteredServices;
  final bool isLoading;
  final String? error;
  final String searchQuery;

  ServiceHistoryState({
    this.services = const [],
    List<ServiceModel>? filteredServices,
    this.isLoading = false,
    this.error,
    this.searchQuery = '',
  }) : filteredServices = filteredServices ?? services;

  ServiceHistoryState copyWith({
    List<ServiceModel>? services,
    List<ServiceModel>? filteredServices,
    bool? isLoading,
    String? error,
    String? searchQuery,
  }) {
    return ServiceHistoryState(
      services: services ?? this.services,
      filteredServices: filteredServices ?? this.filteredServices,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
