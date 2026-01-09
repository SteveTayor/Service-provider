import 'dart:async';
import 'dart:developer';

import 'package:bundlegram/core/error/error_sanitixed_users.dart';
import 'package:bundlegram/core/error/failures.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/providers/state/global_helper.dart';
import 'package:bundlegram/core/providers/state/global_state.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/models/dashboard/dashboard_request.dart';
import 'package:bundlegram/data/models/products/epin/epin_trannsactions.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:bundlegram/presentation/app.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/provider/products_provider.dart';
import 'package:bundlegram/presentation/features/setting/screens/widget/pin_sheet.dart';
import 'package:bundlegram/presentation/features/transaction/screens/bulk%20e-pin/model/epin_mapper.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
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
  bool _isInitializing = false;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  GlobalProvider(super.state, this._api, this._storage, this._ref);
//  Restore session using existing token
  Future<void> initialize() async {
    //  never initialize twice
    if (_isInitialized || _isInitializing) return;

    _isInitializing = true;
    // state = state.copyWith(isLoading: true, error: null);
    final ctx = navigatorKey.currentContext!;

    try {
      final storage = _ref.read(secureStorageHelperProvider);
      final token = await storage.getAuthToken();

      if (token == null) {
        return;
        // throw Exception('No authentication token found');
      }

      // ALL CORE APIS – CALLED ONCE
      await Future.wait([
        initializeWalletandAccounts(ctx),
        initializePlatformDependencies(ctx),
      ]);

      _isInitialized = true;
    } catch (e) {
      _isInitialized = false;

      rethrow;
    } finally {
      _isInitializing = false;
    }
  }

  Future<void> initializePlatformDependencies(BuildContext context) async {
    try {
      // debug the fetched products
      debugPrint('Fetching products...');

      // Prefetch core products
      await Future.wait([
        _ref.read(productsProvider(PlatformProductType.airtime).future),
        _ref.read(productsProvider(PlatformProductType.mobileData).future),
        _ref.read(productsProvider(PlatformProductType.betting).future),
        _ref.read(productsProvider(PlatformProductType.cableTv).future),
        _ref.read(productsProvider(PlatformProductType.electricity).future),
      ]);

      // Prefetch minimal beneficiaries
      await _ref.read(minimalBeneficiariesProvider.future);
    } catch (e) {
      context.showErrorSnackBar(
        'Unable to fetch services. Please try again.',
      );
    }
  }

  // Future<bool> restoreSession(BuildContext context) async {
  //   final token = await _storage.getAuthToken();
  //   if (token == null) return false;
  //   //fetchProfile ONLY (sequential)
  //   final profileResult = await _api.getProfile(token);
  //   bool profileOk = true;
  //   profileResult.fold(
  //     (fail) {
  //       profileOk = false;
  //     },
  //     (data) {
  //       state = state.copyWith(profile: AsyncData(data));
  //     },
  //   );
  //   if (!profileOk) {
  //     debugPrint('[restoreSession] Token invalid → fallback to email/password');
  //     return false;
  //   }
  //   // Token confirmed valid → proceed to other calls
  //   unawaited(fetchWalletBalance(context));
  //   unawaited(fetchBanks(context));
  //   unawaited(fetchUserBanks(context));
  //   unawaited(fetchVirtualAccount(context));
  //   unawaited(fetchEpinTransactionRequests(context, force: true));
  //   unawaited(fetchUsersTransactions(context, force: true));
  //   return true;
  // }
  Future<bool> restoreSession(BuildContext context) async {
    final token = await _storage.getAuthToken();
    if (token == null) return false;

    final profileResult = await _api.getProfile(token);

    return profileResult.fold(
      (_) => false,
      (data) {
        state = state.copyWith(profile: AsyncData(data));
        return true;
      },
    );
  }

  Future<void> initializeWalletandAccounts(BuildContext context) async {
    await Future.wait([
      fetchWalletBalance(context),
      fetchProfile(context),
    ]);

    unawaited(fetchUserBanks(context));
    unawaited(fetchVirtualAccount(context));
    unawaited(fetchEpinTransactionRequests(context, force: true));

    // Defer transactions
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   fetchUsersTransactions(context);
    // });
  }

  // Future<void> initializeData(BuildContext context) async {
  //   state = state.copyWith(
  //     profile: const AsyncLoading(),
  //     walletBalance: const AsyncLoading(),
  //     dashboardData: const AsyncLoading(),
  //     banks: const AsyncLoading(),
  //   );
  //   await fetchBanks(context);
  //   unawaited(fetchEpinTransactionRequests(context, force: true));
  //   await fetchUsersTransactions(context);
  // }

  void _handleError(String message, BuildContext context) {
    context.showErrorSnackBar(message);
    debugPrint('GlobalProvider Error: $message');
  }

  void _handleFailure(Failure failure, BuildContext context) async {
    // final message = failure.properties.isNotEmpty
    //     ? failure.properties.join('\n')
    //     : 'Something went wrong';

    if (failure is ServerFailure ||
        (failure is AuthenticationFailure &&
            failure.properties.contains(
                'Your session has expired or you are already logged in on another device.'))) {
      // await _storage.deleteAuthToken();
      final ctx = navigatorKey.currentContext;
      if (ctx != null) {
        ctx.go(RouteConstants.lockScreen);
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
        // if (data.data?.pin == null && context.mounted) {
        //   context.go(RouteConstants.pinScreen);
        // }
        if (data.data?.pin == null && context.mounted) {
          context.showBottomSheet(
            child: const PinSheet(),
            isDismissible: false,
            showDragHandle: false,
          );
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
        debugPrint('Fetched user banks: ${data.data?.length}');
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

  // Future<void> fetchUsersTransactions(BuildContext context,
  //     {bool force = false}) async {
  //   final token = await _storage.getAuthToken();
  //   if (token == null) {
  //     return _handleError('Authentication token missing', context);
  //   }

  //   final now = DateTime.now();
  //   if (!force && state.lastTransactionFetch != null) {
  //     final diff = now.difference(state.lastTransactionFetch!);
  //     if (diff.inMinutes < 10) {
  //       // Cache still valid
  //       return;
  //     }
  //   }

  //   state = state.copyWith(usersTransactions: const AsyncLoading());

  //   final result = await _api.getAllTransactions(token);
  //   result.fold(
  //     (fail) {
  //       _handleFailure(fail, context);
  //       state = state.copyWith(
  //         usersTransactions: AsyncError(fail, StackTrace.current),
  //       );
  //     },
  //     (dataWrapper) {
  //       final allTx = dataWrapper.data ?? [];

  //       state = state.copyWith(
  //         usersTransactions: AsyncData(dataWrapper),
  //         lastTransactionFetch: now,
  //       );
  //     },
  //   );
  // }
  Future<void> fetchUsersTransactions(BuildContext context,
      {bool force = false}) async {
    final token = await _storage.getAuthToken();
    if (token == null) return;

    final now = DateTime.now();

    // --- caching: only short-circuit if last fetch is recent AND we already have epin cached
    // if (!force && state.lastTransactionFetch != null) {
    //   final diff = now.difference(state.lastTransactionFetch!);
    //   if (diff.inMinutes < 10) {
    //     // If we already have epinTransactions cached, it's safe to skip fetching again.
    //     // But if epinTransactions is missing, we must continue so EPIN history is available.
    //     if (state.epinTransactions is AsyncData) {
    //       // Debug log
    //       debugPrint(
    //           '[fetchUsersTransactions] Skipping fetch (cache recent, ${diff.inMinutes}m ago)');
    //       return;
    //     } else {
    //       debugPrint(
    //           '[fetchUsersTransactions] Cache recent (${diff.inMinutes}m) but epin not present -> proceeding to fetch.');
    //     }
    //   }
    // }
    if (!force &&
        state.lastTransactionFetch != null &&
        DateTime.now().difference(state.lastTransactionFetch!) <
            const Duration(minutes: 5)) {
      return;
    }

    state = state.copyWith(usersTransactions: const AsyncLoading());

    // --- 1) EPIN: use cached epinTransactions if available to avoid extra network calls
    EpinTransactionRequestsResponse? epinWrapper;
    if (!force && state.epinTransactions is AsyncData) {
      epinWrapper = (state.epinTransactions
              as AsyncData<EpinTransactionRequestsResponse?>)
          .value;
      debugPrint(
          '[fetchUsersTransactions] Using cached epinTransactions with ${epinWrapper?.data?.data?.length ?? 0} items');
    } else {
      final epinResult = await _api.getEpinTransactionRequests(token);
      epinResult.fold(
        (fail) {
          _handleFailure(fail, context);
          // keep going: we still want main transactions even if epin failed
          debugPrint(
              '[fetchUsersTransactions] epin fetch failed: ${fail.properties}');
        },
        (data) {
          epinWrapper = data;
          debugPrint(
              '[fetchUsersTransactions] Fetched epin pages -> items: ${data.data?.data?.length ?? 0}');
        },
      );
    }

    // --- 2) main transactions
    GetAllUserTransactionResponse? mainWrapper;
    Failure? mainFailure;
    final result = await _api.getAllTransactions(token);
    result.fold(
      (fail) => mainFailure = fail,
      (data) => mainWrapper = data,
    );

    if (mainWrapper == null && epinWrapper == null) {
      final fail = mainFailure!;
      _handleFailure(fail, context);
      state = state.copyWith(
        usersTransactions: AsyncError(fail, StackTrace.current),
      );
      return;
    }

    // --- 3) Merge & debug-print samples
    final mainList = mainWrapper?.data ?? [];
    final epinAsTx = (epinWrapper?.data?.data ?? [])
        .map((d) => d.toUserTransactions())
        .toList();
    debugPrint(
        'MERGE_DBG: epinWrapper?.data?.data length=${epinWrapper?.data?.data?.length ?? 0}');
    if (epinWrapper?.data?.data != null &&
        epinWrapper!.data!.data!.isNotEmpty) {
      for (var i = 0; i < epinWrapper!.data!.data!.length && i < 5; i++) {
        final d = epinWrapper!.data!.data![i];
        debugPrint(
            'MERGE_DBG datum[$i] -> id=${d.id}, ref=${d.reference}, createdAt=${d.createdAt}, agentPhone=${d.agentPhone}');
      }
    }

    debugPrint(
        '[fetchUsersTransactions] mainList: ${mainList.length}, epinAsTx: ${epinAsTx.length}');

    // Log sample entries and their createdAt to help debugging
    void _logSamples(List<UserTransactions> list, String tag,
        [int sample = 3]) {
      for (var i = 0; i < list.length && i < sample; i++) {
        final t = list[i];
        debugPrint(
            '[$tag sample $i] ref=${t.transRef}, status=${t.status}, createdAt=${t.createdAt}');
      }
    }

    _logSamples(mainList, 'MAIN');
    _logSamples(epinAsTx, 'EPIN');

    // final merged = [...mainList, ...epinAsTx];
    final merged = await compute(
      mergeAndSortTransactions,
      {
        'main': mainList,
        'epin': epinAsTx,
      },
    );

    merged.sort((a, b) {
      final aDate = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bDate = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      return bDate.compareTo(aDate);
    });

    // After mapping to UserTransactions, print sample createdAt/parsing
    if (epinAsTx.isNotEmpty) {
      for (var i = 0; i < epinAsTx.length && i < 5; i++) {
        final t = epinAsTx[i];
        debugPrint(
            'MERGE_DBG epinTx[$i] -> transRef=${t.transRef}, createdAt=${t.createdAt}, amount=${t.amount}');
      }
    }

    debugPrint('[fetchUsersTransactions] merged length: ${merged.length}');
    if (merged.isNotEmpty) {
      debugPrint(
          '[fetchUsersTransactions] newest merged createdAt: ${merged.first.createdAt}');
    }

    // --- 4) Update state (also persist epinWrapper into state.epinTransactions if we fetched it)
    state = state.copyWith(
      usersTransactions: AsyncData(
        GetAllUserTransactionResponse(
          status: 'success',
          data: merged,
          message: 'ok',
        ),
      ),
      epinTransactions:
          epinWrapper != null ? AsyncData(epinWrapper) : state.epinTransactions,
      lastTransactionFetch: now,
    );

    // If main failed but epin succeeded, still surface main error non-blocking
    if (mainFailure != null && epinWrapper != null) {
      _handleFailure(mainFailure!, context);
    }
  }

  /// Fetch EPIN transaction requests and store in state.epinTransactions
  Future<void> fetchEpinTransactionRequests(BuildContext context,
      {bool force = false}) async {
    final token = await _storage.getAuthToken();
    if (token == null) {
      return _handleError('Authentication token missing', context);
    }

    // Caching: if not forced and we already have data, skip
    if (!force && state.epinTransactions is AsyncData) {
      final existing = (state.epinTransactions as AsyncData).value;
      if (existing != null) {
        return;
      }
    }

    state = state.copyWith(epinTransactions: const AsyncLoading());

    final result = await _api.getEpinTransactionRequests(token);

    result.fold(
      (fail) {
        _handleFailure(fail, context);
        state = state.copyWith(
          epinTransactions: AsyncError(fail, StackTrace.current),
        );
      },
      (data) {
        state = state.copyWith(epinTransactions: AsyncData(data));
      },
    );
  }
}
