import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// final connectivityProvider = StateNotifierProvider<ConnectivityNotifier, bool>(
//   (ref) => ConnectivityNotifier(),
// );

// class ConnectivityNotifier extends StateNotifier<bool> {
//   late final StreamSubscription _subscription;

//   ConnectivityNotifier() : super(true) {
//     _subscription = Connectivity().onConnectivityChanged.listen((result) {
//       state = result != ConnectivityResult.none;
//     });

//     _init(); // Check initial state
//   }

//   Future<void> _init() async {
//     final result = await Connectivity().checkConnectivity();
//     state = result != ConnectivityResult.none;
//   }

//   @override
//   void dispose() {
//     _subscription.cancel();
//     super.dispose();
//   }
// }

final connectivityStatusProvider = StreamProvider<ConnectivityResult>((ref) {
  final connectivity = Connectivity();
  return connectivity.onConnectivityChanged.map((results) {
    // Pick the first result, or default to none
    return results.isNotEmpty ? results.first : ConnectivityResult.none;
  });
});

