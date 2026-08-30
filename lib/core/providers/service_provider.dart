import 'package:bundlegram/presentation/features/transaction/notifier/e-pin_history_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:bundlegram/presentation/features/transaction/notifier/all_service_provider.dart';
import 'package:bundlegram/presentation/features/transaction/notifier/recent_transaction_notifier.dart';
import 'package:bundlegram/presentation/features/transaction/notifier/recent_transaction_state.dart';
import 'package:bundlegram/presentation/features/transaction/notifier/transaction_history_notifier.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_service_notifier.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_service_state.dart';

// Aliases for AllServiceHistoryNotifier
final bettingHistoryProvider =
    StateNotifierProvider<AllServiceHistoryNotifier, ServiceHistoryState>(
  (ref) => AllServiceHistoryNotifier(ref, 'betting'),
);

final mobileDataHistoryProvider =
    StateNotifierProvider<AllServiceHistoryNotifier, ServiceHistoryState>(
  (ref) => AllServiceHistoryNotifier(ref, 'mobile_data'),
);

final educationHistoryProvider =
    StateNotifierProvider<AllServiceHistoryNotifier, ServiceHistoryState>(
  (ref) => AllServiceHistoryNotifier(ref, 'education'),
);

final cableTvHistoryProvider =
    StateNotifierProvider<AllServiceHistoryNotifier, ServiceHistoryState>(
  (ref) => AllServiceHistoryNotifier(ref, 'cable_tv'),
);

final internetServiceHistoryProvider =
    StateNotifierProvider<AllServiceHistoryNotifier, ServiceHistoryState>(
  (ref) => AllServiceHistoryNotifier(ref, 'internet_service'),
);

final electricityHistoryProvider =
    StateNotifierProvider<AllServiceHistoryNotifier, ServiceHistoryState>(
  (ref) => AllServiceHistoryNotifier(ref, 'electricity'),
);

final airtimeHistoryProvider =
    StateNotifierProvider<AllServiceHistoryNotifier, ServiceHistoryState>(
  (ref) => AllServiceHistoryNotifier(ref, 'airtime'),
);

// final ePinHistoryProvider =
//     StateNotifierProvider<AllServiceHistoryNotifier, ServiceHistoryState>(
//   (ref) => AllServiceHistoryNotifier(ref, 'epin'),
// );
final ePinHistoryProvider =
    StateNotifierProvider<EpinHistoryNotifier, ServiceHistoryState>(
  (ref) => EpinHistoryNotifier(ref),
);

// âœ… Wallet history now using the .family provider properly
final walletServiceHistoryProvider = StateNotifierProvider.family<
    WalletServiceHistoryNotifier,
    ServiceHistoryState,
    String>((ref, serviceType) {
  return WalletServiceHistoryNotifier(ref, serviceType);
});

// Recent and all transactions
final recentTransactionsProvider =
    StateNotifierProvider<RecentTransactionsNotifier, RecentTransactionsState>(
  (ref) => RecentTransactionsNotifier(ref),
);

final transactionHistoryProvider =
    StateNotifierProvider<TransactionHistoryNotifier, RecentTransactionsState>(
  (ref) => TransactionHistoryNotifier(ref),
);

