import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';

class ServiceHistoryState {
  final List<UserTransactions> allTransactions;
  final List<UserTransactions> filteredTransactions;
  final bool isLoading;
  final String? error;
  final String searchQuery;

  ServiceHistoryState({
    this.allTransactions = const [],
    List<UserTransactions>? filteredTransactions,
    this.isLoading = false,
    this.error,
    this.searchQuery = '',
  }) : filteredTransactions = filteredTransactions ?? allTransactions;

  ServiceHistoryState copyWith({
    List<UserTransactions>? allTransactions,
    List<UserTransactions>? filteredTransactions,
    bool? isLoading,
    String? error,
    String? searchQuery,
  }) {
    return ServiceHistoryState(
      allTransactions: allTransactions ?? this.allTransactions,
      filteredTransactions: filteredTransactions ?? this.filteredTransactions,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
