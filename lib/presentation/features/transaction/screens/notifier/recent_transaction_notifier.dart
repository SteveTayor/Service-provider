// lib/presentation/features/transaction/screens/notifier/recent_transaction_notifier.dart

import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/providers/service_provider.dart';
import 'package:bundlegram/data/dummy_datda.dart';
import 'package:bundlegram/data/models/wallet/service_model.dart';
import 'package:bundlegram/presentation/features/transaction/screens/notifier/recent_transaction_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentTransactionsNotifier
    extends StateNotifier<RecentTransactionsState> {
  RecentTransactionsNotifier(this.ref)
      : super(RecentTransactionsState(
          services: const [],
          filteredServices: const [],
          filterType: null,
          isLoading: false,
        )) {
    _initializeWithDummy();
    _setupListeners();
    _updateServices();
  }

  final Ref ref;

  /// Initially populate with dummy data so the UI can show something.
  void _initializeWithDummy() {
    state = state.copyWith(
      services: dummyTransactions,
      filteredServices: dummyTransactions,
    );
  }

  void _setupListeners() {
    ref.listen(bettingHistoryProvider, (prev, next) => _updateServices());
    ref.listen(mobileDataHistoryProvider, (prev, next) => _updateServices());
    ref.listen(educationHistoryProvider, (prev, next) => _updateServices());
    ref.listen(cableTvHistoryProvider, (prev, next) => _updateServices());
    ref.listen(electricityHistoryProvider, (prev, next) => _updateServices());
    ref.listen(airtimeHistoryProvider, (prev, next) => _updateServices());
    ref.listen(ePinHistoryProvider, (prev, next) => _updateServices());
  }

  void _updateServices() {
    // Combine “real” providers only if they’ve loaded something;
    // otherwise keep dummy.
    final realList = [
      ...ref.read(bettingHistoryProvider).services,
      ...ref.read(mobileDataHistoryProvider).services,
      ...ref.read(educationHistoryProvider).services,
      ...ref.read(cableTvHistoryProvider).services,
      ...ref.read(electricityHistoryProvider).services,
      ...ref.read(airtimeHistoryProvider).services,
      ...ref.read(ePinHistoryProvider).services,
    ];

    if (realList.isNotEmpty) {
      state = state.copyWith(
        services: realList,
        filteredServices: realList,
      );
    }
  }
  // final Ref ref;

  // void _setupListeners() {
  //   ref.listen(bettingHistoryProvider, (prev, next) => _updateServices());
  //   ref.listen(mobileDataHistoryProvider, (prev, next) => _updateServices());
  //   ref.listen(educationHistoryProvider, (prev, next) => _updateServices());
  //   ref.listen(cableTvHistoryProvider, (prev, next) => _updateServices());
  //   ref.listen(electricityHistoryProvider, (prev, next) => _updateServices());
  //   ref.listen(airtimeHistoryProvider, (prev, next) => _updateServices());
  //   ref.listen(ePinHistoryProvider, (prev, next) => _updateServices());
  // }

  // void _updateServices() {
  //   final allServices = [
  //     ...ref.read(bettingHistoryProvider).services,
  //     ...ref.read(mobileDataHistoryProvider).services,
  //     ...ref.read(educationHistoryProvider).services,
  //     ...ref.read(cableTvHistoryProvider).services,
  //     ...ref.read(electricityHistoryProvider).services,
  //     ...ref.read(airtimeHistoryProvider).services,
  //     ...ref.read(ePinHistoryProvider).services,
  //   ];
  //   state = state.copyWith(
  //     services: allServices,
  //     filteredServices: allServices,
  //   );
  // }

  /// Applies multi‐criteria filtering across all service types:
  ///  - typeSet: any of service.type.toLowerCase()
  ///  - statusSet: any of service.status.toLowerCase()
  ///  - sortBy: 'newest' or 'oldest' (by date)
  ///  - amountBy: 'largest' or 'smallest'
  void applyFilters({
    required Set<String> typeSet,
    required Set<String> statusSet,
    required String sortBy,
    required String amountBy,
  }) {
    var temp = List<ServiceModel>.from(state.services);

    // 1) Filter by type if non-empty
    if (typeSet.isNotEmpty) {
      temp = temp.where((s) => typeSet.contains(s.type.toLowerCase())).toList();
    }

    // 2) Filter by status if non-empty
    if (statusSet.isNotEmpty) {
      temp = temp
          .where((s) => statusSet.contains(s.status.toLowerCase()))
          .toList();
    }

    // 3) Sort by date
    temp
      ..sort((a, b) {
        final da = a.date.toDateTime() ?? DateTime(1970);
        final db = b.date.toDateTime() ?? DateTime(1970);
        return (sortBy == 'newest') ? db.compareTo(da) : da.compareTo(db);
      })

      // 4) Sort by amount
      ..sort((a, b) {
        final aa = a.amount.toNumericValue();
        final bb = b.amount.toNumericValue();
        return (amountBy == 'largest') ? bb.compareTo(aa) : aa.compareTo(bb);
      });

    state = state.copyWith(filteredServices: temp);
  }

  void search(String query) {
    if (query.isEmpty) {
      state = state.copyWith(filteredServices: state.services);
      return;
    }
    final q = query.toLowerCase();
    final filtered = state.services.where((service) {
      final titleLower = service.title.toLowerCase();
      final statusLower = service.status.toLowerCase();
      return titleLower.contains(q) || statusLower.contains(q);
    }).toList();
    state = state.copyWith(filteredServices: filtered);
  }

  void refresh() {
    ref.read(bettingHistoryProvider.notifier).refresh();
    ref.read(mobileDataHistoryProvider.notifier).refresh();
    ref.read(educationHistoryProvider.notifier).refresh();
    ref.read(cableTvHistoryProvider.notifier).refresh();
    ref.read(electricityHistoryProvider.notifier).refresh();
    ref.read(airtimeHistoryProvider.notifier).refresh();
    ref.read(ePinHistoryProvider.notifier).refresh();
  }
}
