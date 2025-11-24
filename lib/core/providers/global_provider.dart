import 'dart:async';
import 'dart:developer';

import 'package:bundlegram/core/error/error_sanitixed_users.dart';
import 'package:bundlegram/core/error/failures.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/providers/state/global_state.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/models/dashboard/dashboard_request.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:bundlegram/presentation/app.dart';
import 'package:collection/collection.dart';
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

/// Returns the K transactions with the latest createdAt, sorted newest→oldest.
List<UserTransactions> _takeTopKByDate(
  List<UserTransactions> all, {
  required int k,
}) {
  // Min-heap ordered oldest→newest
  final pq = PriorityQueue<UserTransactions>(
    (a, b) => a.createdAt!.compareTo(b.createdAt!),
  );

  for (final txn in all) {
    if (txn.createdAt == null) continue;
    pq.add(txn);
    if (pq.length > k) pq.removeFirst();
  }

  // Now heap has at most K items — pull them out and sort descending
  final top = pq.toList()..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
  return top;
}

class GlobalProvider extends StateNotifier<GlobalState> {
  final ApiService _api;
  final SecureStorageHelper _storage;
  final Ref _ref;

  GlobalProvider(super.state, this._api, this._storage, this._ref);
//  Restore session using existing token
  Future<void> restoreSession(BuildContext context) async {
    final token = await _storage.getAuthToken();
    if (token == null) {
      _handleError('No saved session found', context);
      final ctx = navigatorKey.currentContext;

      if (ctx != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ctx.go(RouteConstants.login);
        });
      }
      //  ctx.go(RouteConstants.login);
      return;
    }

    // Re-fetch essential data
    await Future.wait([
      fetchProfile(context),
      fetchWalletBalance(context),
      fetchBanks(context),
    ]);

    // Fetch background data without blocking UI
    unawaited(fetchUserBanks(context));
    unawaited(fetchVirtualAccount(context));
    unawaited(fetchUsersTransactions(context, force: true));
  }

  Future<void> initializeWalletandAccounts(BuildContext context) async {
    await Future.wait([
      fetchWalletBalance(context),
      fetchProfile(context),
    ]);

    unawaited(fetchUserBanks(context));
    unawaited(fetchVirtualAccount(context));
    // Defer transactions
    Future.delayed(const Duration(milliseconds: 500), () {
      fetchUsersTransactions(context);
    });
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
      await _storage.deleteAuthToken();
      final ctx = navigatorKey.currentContext;
      if (ctx != null) {
        ctx.go(RouteConstants.login);
      }
    } else {
      final userMsg = userFacingMessageFromFailure(failure);
      context.showErrorSnackBar(userMsg);
      // context.showErrorSnackBar(message);
    }
  }

  Future<void> fetchProfile(BuildContext context) async {
    final token = await _storage.getAuthToken();
    if (token == null) {
      return _handleError('Authentication token missing', context);
    }

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
    if (token == null) {
      return _handleError('Authentication token missing', context);
    }

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
    if (token == null) {
      return _handleError('Authentication token missing', context);
    }

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
    if (token == null) {
      return _handleError('Authentication token missing', context);
    }

    final result = await _api.getUserBanks(token);
    result.fold(
      (fail) {
        state = state.copyWith(userBanks: AsyncError(fail, StackTrace.current));
        _handleFailure(fail, context);
      },
      (data) {
        state = state.copyWith(userBanks: AsyncData(data));
        log('Fetched user banks: ${data.data?.length}');
      },
    );
  }

  Future<void> fetchVirtualAccount(BuildContext context) async {
    final token = await _storage.getAuthToken();
    if (token == null) {
      return _handleError('Authentication token missing', context);
    }

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

  Future<void> fetchUsersTransactions(BuildContext context,
      {bool force = false}) async {
    final token = await _storage.getAuthToken();
    if (token == null) {
      return _handleError('Authentication token missing', context);
    }

    final now = DateTime.now();
    if (!force && state.lastTransactionFetch != null) {
      final diff = now.difference(state.lastTransactionFetch!);
      if (diff.inMinutes < 10) {
        // Cache still valid
        return;
      }
    }

    state = state.copyWith(usersTransactions: const AsyncLoading());

    final result = await _api.getAllTransactions(token);
    result.fold(
      (fail) {
        _handleFailure(fail, context);
        state = state.copyWith(
          usersTransactions: AsyncError(fail, StackTrace.current),
        );
      },
      (dataWrapper) {
        final allTx = dataWrapper.data ?? [];

        state = state.copyWith(
          usersTransactions: AsyncData(dataWrapper),
          lastTransactionFetch: now,
        );
      },
    );
  }
}
