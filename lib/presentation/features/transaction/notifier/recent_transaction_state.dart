import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';

class RecentTransactionsState {
  RecentTransactionsState({
    required this.services,
    required this.filteredServices,
    this.filterType,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.error,
  });
  factory RecentTransactionsState.initial() {
    return RecentTransactionsState(
      services: [],
      filteredServices: [],
      filterType: null,
      isLoading: false,
      isLoadingMore: false,
      hasMore: true,
      error: null,
    );
  }
  final List<UserTransactions> services; // All fetched transactions
  final List<UserTransactions> filteredServices; // After search/filters
  final String? filterType; // (unused right now)
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final Object? error;

  RecentTransactionsState copyWith({
    List<UserTransactions>? services,
    List<UserTransactions>? filteredServices,
    String? filterType,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    Object? error,
  }) {
    return RecentTransactionsState(
      services: services ?? this.services,
      filteredServices: filteredServices ?? this.filteredServices,
      filterType: filterType ?? this.filterType,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      error: error,
    );
  }
}
