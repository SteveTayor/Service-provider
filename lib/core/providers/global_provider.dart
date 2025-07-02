import 'dart:async';
import 'dart:developer';
import 'package:bundlegram/core/error/failures.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/providers/state/global_state.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/models/dashboard/dashboard_request.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:bundlegram/presentation/features/setting/screens/pin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final globalProvider = StateNotifierProvider<GlobalProvider, GlobalState>(
  (ref) => GlobalProvider(
    GlobalState(),
    ref.read(apiServiceProvider),
    ref.read(secureStorageHelperProvider),
    ref,
  ),
);

class GlobalProvider extends StateNotifier<GlobalState> {
  final ApiService _api;
  final SecureStorageHelper _storage;
  final Ref _ref;

  GlobalProvider(super.state, this._api, this._storage, this._ref);

  Future<void> initializeWalletandAccounts(BuildContext context) async {
    await Future.wait([
      fetchUserBanks(context),
      fetchVirtualAccount(context),
      fetchWalletBalance(context),
      fetchDashboardData(context),
      fetchUsersTransactions(context),
      fetchProfile(context),
    ]);
  }

  Future<void> initializeData(BuildContext context) async {
    // final token = await _storage.getAuthToken();
    // if (token == null) {
    //   _handleError('Authentication token missing', context);
    //   return;
    // }

    state = state.copyWith(
      profile: const AsyncLoading(),
      walletBalance: const AsyncLoading(),
      dashboardData: const AsyncLoading(),
      banks: const AsyncLoading(),
    );

    await Future.wait([
      fetchBanks(context),
    ]);
  }

  Future<void> fetchProfile(BuildContext context) async {
    final token = await _storage.getAuthToken();
    if (token == null) {
      _handleError('Authentication token missing', context);
      return;
    }
    final result = await _api.getProfile(token);
    result.fold(
      (fail) {
        final message = fail.properties.isNotEmpty
            ? fail.properties.join('\n')
            : 'Failed to fetch profile';
        context.showErrorSnackBar(message);
        state = state.copyWith(profile: AsyncError(fail, StackTrace.current));
      },
      (data) {
        state = state.copyWith(profile: AsyncData(data));
        final profile = data;
        if (profile.data?.pin == null) {
          context
              .go('/create-pin'); // Or pushReplacement with PinScreen if needed
        }
      },
    );
  }

  Future<void> fetchWalletBalance(BuildContext context) async {
    final token = await _storage.getAuthToken();
    if (token == null) {
      _handleError('Authentication token missing', context);
      return;
    }
    final result = await _api.getWallet(token);
    result.fold(
      (fail) {
        final message = fail.properties.isNotEmpty
            ? fail.properties.join('\n')
            : 'Failed to fetch wallet balance';
        context.showErrorSnackBar(message);
        state =
            state.copyWith(walletBalance: AsyncError(fail, StackTrace.current));
      },
      (data) {
        state = state.copyWith(walletBalance: AsyncData(data));
      },
    );
  }

  Future<void> fetchDashboardData(BuildContext context) async {
    final token = await _storage.getAuthToken();
    if (token == null) {
      _handleError('Authentication token missing', context);
      return;
    }
    final now = DateTime.now();
    final result = await _api.fetchDashboardData(
      token,
      DashboardDataRequest(month: now.month, year: now.year),
    );
    result.fold(
      (fail) {
        final message = fail.properties.isNotEmpty
            ? fail.properties.join('\n')
            : 'Failed to fetch dashboard data';
        context.showErrorSnackBar(message);
        state =
            state.copyWith(dashboardData: AsyncError(fail, StackTrace.current));
      },
      (data) {
        state = state.copyWith(dashboardData: AsyncData(data));
      },
    );
  }

  Future<void> fetchBanks(BuildContext context) async {
    final token = await _storage.getAuthToken();
    if (token == null) {
      _handleError('Authentication token missing', context);
      return;
    }
    final result = await _api.getAllBanks(token);
    result.fold(
      (fail) {
        final message = fail.properties.isNotEmpty
            ? fail.properties.join('\n')
            : 'Failed to fetch banks';
        context.showErrorSnackBar(message);
        state = state.copyWith(banks: AsyncError(fail, StackTrace.current));
      },
      (data) {
        state = state.copyWith(banks: AsyncData(data));
      },
    );
  }

  Future<void> fetchUserBanks(BuildContext context) async {
    final token = await _storage.getAuthToken();
    if (token == null) {
      _handleError('Authentication token missing', context);
      return;
    }
    final result = await _api.getUserBanks(token);
    result.fold(
      (fail) {
        final message = fail.properties.isNotEmpty
            ? fail.properties.join('\n')
            : 'Failed to fetch user banks';
        context.showErrorSnackBar(message);
      },
      (data) {
        log('Fetched user banks: ${data.data?.length}');
      },
    );
  }

  Future<void> fetchVirtualAccount(BuildContext context) async {
    final token = await _storage.getAuthToken();
    if (token == null) {
      _handleError('Authentication token missing', context);
      return;
    }
    state = state.copyWith(virtualAccounts: const AsyncLoading());
    final result = await _api.getVirtualAccount(token);
    result.fold(
      (fail) {
        final message = fail.properties.isNotEmpty
            ? fail.properties.join('\n')
            : 'Failed to fetch virtual account';
        context.showErrorSnackBar(message);
        state = state.copyWith(
            virtualAccounts: AsyncError(fail, StackTrace.current));
      },
      (data) {
        state = state.copyWith(virtualAccounts: AsyncData(data));
      },
    );
  }

  void _handleError(String message, BuildContext context) {
    context.showErrorSnackBar(message);
    log('GlobalProvider Error: $message');
  }

  Future<void> fetchUsersTransactions(BuildContext context) async {
    final token = await _storage.getAuthToken();
    if (token == null) {
      _handleError('Authentication token missing', context);
      return;
    }
    state = state.copyWith(usersTransactions: const AsyncLoading());
    final result = await _api.getAllTransactions(token);
    result.fold(
      (fail) {
        final message = fail.properties.isNotEmpty
            ? fail.properties.join('\n')
            : 'Failed to fetch transactions';
        context.showErrorSnackBar(message);
        state = state.copyWith(
            usersTransactions: AsyncError(fail, StackTrace.current));
      },
      (data) {
        state = state.copyWith(usersTransactions: AsyncData(data));
      },
    );
  }
}
