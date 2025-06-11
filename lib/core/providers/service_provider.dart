import 'package:bundlegram/presentation/features/transaction/notifier/all_service_provider.dart';
import 'package:bundlegram/presentation/features/transaction/notifier/recent_transaction_notifier.dart';
import 'package:bundlegram/presentation/features/transaction/notifier/recent_transaction_state.dart';
import 'package:bundlegram/presentation/features/transaction/notifier/transaction_history_notifier.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_service_notifier.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_service_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bettingHistoryProvider =
    StateNotifierProvider<AllServiceHistoryNotifier, ServiceHistoryState>(
  (ref) => AllServiceHistoryNotifier('betting'),
);

final mobileDataHistoryProvider =
    StateNotifierProvider<AllServiceHistoryNotifier, ServiceHistoryState>(
  (ref) => AllServiceHistoryNotifier('mobile_data'),
);

final educationHistoryProvider =
    StateNotifierProvider<AllServiceHistoryNotifier, ServiceHistoryState>(
  (ref) => AllServiceHistoryNotifier('education'),
);

final cableTvHistoryProvider =
    StateNotifierProvider<AllServiceHistoryNotifier, ServiceHistoryState>(
  (ref) => AllServiceHistoryNotifier('cable_tv'),
);

final internetServiceHistoryProvider =
    StateNotifierProvider<AllServiceHistoryNotifier, ServiceHistoryState>(
  (ref) => AllServiceHistoryNotifier('internet_service'),
);

final electricityHistoryProvider =
    StateNotifierProvider<AllServiceHistoryNotifier, ServiceHistoryState>(
  (ref) => AllServiceHistoryNotifier('electricity'),
);

final airtimeHistoryProvider =
    StateNotifierProvider<AllServiceHistoryNotifier, ServiceHistoryState>(
  (ref) => AllServiceHistoryNotifier('airtime'),
);

final ePinHistoryProvider =
    StateNotifierProvider<AllServiceHistoryNotifier, ServiceHistoryState>(
  (ref) => AllServiceHistoryNotifier('e-pin'),
);

final walletHistoryProvider =
    StateNotifierProvider<WalletServiceHistoryNotifier, ServiceHistoryState>(
  (ref) => WalletServiceHistoryNotifier('wallet'),
);

final recentTransactionsProvider =
    StateNotifierProvider<RecentTransactionsNotifier, RecentTransactionsState>(
  (ref) => RecentTransactionsNotifier(),
);

final transactionHistoryProvider =
    StateNotifierProvider<TransactionHistoryNotifier, ServiceHistoryState>(
  (ref) => TransactionHistoryNotifier(),
);
