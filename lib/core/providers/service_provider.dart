import 'package:bundlegram/presentation/features/transaction/screens/notifier/recent_transaction_notifier.dart';
import 'package:bundlegram/presentation/features/transaction/screens/notifier/recent_transaction_state.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_service_notifier.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_service_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Providers for different service types

final bettingHistoryProvider =
    StateNotifierProvider<ServiceHistoryNotifier, ServiceHistoryState>(
  (ref) => ServiceHistoryNotifier('betting'),
);

final mobileDataHistoryProvider =
    StateNotifierProvider<ServiceHistoryNotifier, ServiceHistoryState>(
  (ref) => ServiceHistoryNotifier('mobile_data'),
);

final educationHistoryProvider =
    StateNotifierProvider<ServiceHistoryNotifier, ServiceHistoryState>(
  (ref) => ServiceHistoryNotifier('education'),
);

final cableTvHistoryProvider =
    StateNotifierProvider<ServiceHistoryNotifier, ServiceHistoryState>(
  (ref) => ServiceHistoryNotifier('cable_tv'),
);

final electricityHistoryProvider =
    StateNotifierProvider<ServiceHistoryNotifier, ServiceHistoryState>(
  (ref) => ServiceHistoryNotifier('electricity'),
);

final airtimeHistoryProvider =
    StateNotifierProvider<ServiceHistoryNotifier, ServiceHistoryState>(
  (ref) => ServiceHistoryNotifier('airtime'),
);

final ePinHistoryProvider =
    StateNotifierProvider<ServiceHistoryNotifier, ServiceHistoryState>(
  (ref) => ServiceHistoryNotifier('e_pin'),
);

final recentTransactionsProvider =
    StateNotifierProvider<RecentTransactionsNotifier, RecentTransactionsState>(
  RecentTransactionsNotifier.new,
);

final walletHistoryProvider =
    StateNotifierProvider<ServiceHistoryNotifier, ServiceHistoryState>(
  (ref) => ServiceHistoryNotifier('wallet'),
);
