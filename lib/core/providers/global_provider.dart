import 'dart:async';
import 'dart:developer';
import 'package:bundlegram/core/error/failures.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/providers/state/global_state.dart';
import 'package:bundlegram/core/router/route_constants.dart';
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
      fetchProfile(context),
      fetchUsersTransactions(context),
    ]);
  }

  Future<void> initializeData(BuildContext context) async {
    state = state.copyWith(
      profile: const AsyncLoading(),
      walletBalance: const AsyncLoading(),
      dashboardData: const AsyncLoading(),
      banks: const AsyncLoading(),
    );
    await fetchBanks(context);
    await fetchUsersTransactions(context);
  }

  void _handleError(String message, BuildContext context) {
    context.showErrorSnackBar(message);
    log('GlobalProvider Error: $message');
  }

  void _handleFailure(Failure failure, BuildContext context) async {
    final message = failure.properties.isNotEmpty
        ? failure.properties.join('\n')
        : 'Something went wrong';

    if (failure is AuthenticationFailure &&
        failure.properties.contains(
            'Your session has expired or you are already logged in on another device.')) {
      await _storage.clearAll();
      if (context.mounted) context.go(RouteConstants.login);
    } else {
      context.showErrorSnackBar(message);
    }
  }

  Future<void> fetchProfile(BuildContext context) async {
    final token = await _storage.getAuthToken();
    if (token == null)
      return _handleError('Authentication token missing', context);

    final result = await _api.getProfile(token);
    result.fold(
      (fail) {
        _handleFailure(fail, context);
        state = state.copyWith(profile: AsyncError(fail, StackTrace.current));
      },
      (data) {
        state = state.copyWith(profile: AsyncData(data));
        if (data.data?.pin == null && context.mounted) {
          context.go(RouteConstants.pinScreen);
        }
      },
    );
  }

  Future<void> fetchWalletBalance(BuildContext context) async {
    final token = await _storage.getAuthToken();
    if (token == null)
      return _handleError('Authentication token missing', context);

    final result = await _api.getWallet(token);
    result.fold(
      (fail) {
        _handleFailure(fail, context);
        state =
            state.copyWith(walletBalance: AsyncError(fail, StackTrace.current));
      },
      (data) => state = state.copyWith(walletBalance: AsyncData(data)),
    );
  }

  Future<void> fetchDashboardData(
      BuildContext context, int month, int year) async {
    final token = await _storage.getAuthToken();
    if (token == null) {
      _handleError('Authentication token missing', context);
      state = state.copyWith(
          dashboardData: const AsyncError('No token', StackTrace.empty));
      return;
    }

    state = state.copyWith(dashboardData: const AsyncLoading());

    final result = await AsyncValue.guard(() async {
      final response = await _api.fetchDashboardData(
        token,
        DashboardDataRequest(month: month, year: year),
      );

      return response.fold(
        (fail) {
          _handleFailure(fail, context);
          throw fail; // Automatically puts into AsyncError
        },
        (data) => data,
      );
    });

    state = state.copyWith(dashboardData: result);
  }

  Future<void> fetchBanks(BuildContext context) async {
    final token = await _storage.getAuthToken();
    if (token == null)
      return _handleError('Authentication token missing', context);

    final result = await _api.getAllBanks(token);
    result.fold(
      (fail) {
        _handleFailure(fail, context);
        state = state.copyWith(banks: AsyncError(fail, StackTrace.current));
      },
      (data) => state = state.copyWith(banks: AsyncData(data)),
    );
  }

  Future<void> fetchUserBanks(BuildContext context) async {
    final token = await _storage.getAuthToken();
    if (token == null)
      return _handleError('Authentication token missing', context);

    final result = await _api.getUserBanks(token);
    result.fold(
      (fail) => _handleFailure(fail, context),
      (data) => log('Fetched user banks: ${data.data?.length}'),
    );
  }

  Future<void> fetchVirtualAccount(BuildContext context) async {
    final token = await _storage.getAuthToken();
    if (token == null)
      return _handleError('Authentication token missing', context);

    state = state.copyWith(virtualAccounts: const AsyncLoading());
    final result = await _api.getVirtualAccount(token);
    result.fold(
      (fail) {
        _handleFailure(fail, context);
        state = state.copyWith(
            virtualAccounts: AsyncError(fail, StackTrace.current));
      },
      (data) => state = state.copyWith(virtualAccounts: AsyncData(data)),
    );
  }

  Future<void> fetchUsersTransactions(BuildContext context) async {
    final token = await _storage.getAuthToken();
    if (token == null)
      return _handleError('Authentication token missing', context);

    state = state.copyWith(usersTransactions: const AsyncLoading());
    final result = await _api.getAllTransactions(token);
    result.fold(
      (fail) {
        _handleFailure(fail, context);
        state = state.copyWith(
            usersTransactions: AsyncError(fail, StackTrace.current));
      },
      (data) => state = state.copyWith(usersTransactions: AsyncData(data)),
    );
  }
}
