import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';

class RecentTransactionsState {
  final List<UserTransactions> services; // All fetched transactions
  final List<UserTransactions> filteredServices; // After search/filters
  final String? filterType; // (unused right now)
  final bool isLoading; // true only on very first load

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
    List<UserTransactions>? services,
    List<UserTransactions>? filteredServices,
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
