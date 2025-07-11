import 'package:bundlegram/data/models/banks/get_all_users_banks_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bundlegram/data/models/auth/wallet/get_wallet_response.dart';
import 'package:bundlegram/data/models/dashboard/dashboard_data_response.dart';
import 'package:bundlegram/data/models/profile/profile_response.dart';
import 'package:bundlegram/data/models/banks/get_all_banks_response.dart';
import 'package:bundlegram/data/models/banks/get_virtual_account_response.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';

class GlobalState {
  final AsyncValue<ProfileResponse?> profile;
  final AsyncValue<GetWalletResponse?> walletBalance;
  final AsyncValue<DashboardDataResponse?> dashboardData;
  final AsyncValue<GetAllBanksResponse?> banks;
  final AsyncValue<GetVirtualAccountsResponse?> virtualAccounts;
  final AsyncValue<GetAllUserTransactionResponse?> usersTransactions;
  final AsyncValue<GetAllUserBanksResponse?> userBanks;
  final DateTime? lastTransactionFetch;

  GlobalState({
    this.profile = const AsyncData(null),
    this.walletBalance = const AsyncData(null),
    this.dashboardData = const AsyncData(null),
    this.banks = const AsyncData(null),
    this.virtualAccounts = const AsyncData(null),
    this.usersTransactions = const AsyncData(null),
    this.userBanks = const AsyncData(null),
    this.lastTransactionFetch,
  });

  GlobalState copyWith({
    AsyncValue<ProfileResponse?>? profile,
    AsyncValue<GetWalletResponse?>? walletBalance,
    AsyncValue<DashboardDataResponse?>? dashboardData,
    AsyncValue<GetAllBanksResponse?>? banks,
    AsyncValue<GetVirtualAccountsResponse?>? virtualAccounts,
    AsyncValue<GetAllUserTransactionResponse?>? usersTransactions,
    AsyncValue<GetAllUserBanksResponse?>? userBanks,
    DateTime? lastTransactionFetch,
  }) {
    return GlobalState(
      profile: profile ?? this.profile,
      walletBalance: walletBalance ?? this.walletBalance,
      dashboardData: dashboardData ?? this.dashboardData,
      banks: banks ?? this.banks,
      virtualAccounts: virtualAccounts ?? this.virtualAccounts,
      usersTransactions: usersTransactions ?? this.usersTransactions,
      userBanks: userBanks ?? this.userBanks,
      lastTransactionFetch: lastTransactionFetch ?? this.lastTransactionFetch,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GlobalState &&
          runtimeType == other.runtimeType &&
          profile == other.profile &&
          walletBalance == other.walletBalance &&
          dashboardData == other.dashboardData &&
          banks == other.banks &&
          virtualAccounts == other.virtualAccounts &&
          usersTransactions == other.usersTransactions &&
          userBanks == other.userBanks &&
          lastTransactionFetch == other.lastTransactionFetch;

  @override
  int get hashCode =>
      profile.hashCode ^
      walletBalance.hashCode ^
      dashboardData.hashCode ^
      banks.hashCode ^
      virtualAccounts.hashCode ^
      usersTransactions.hashCode ^
      userBanks.hashCode ^
      lastTransactionFetch.hashCode;
}
