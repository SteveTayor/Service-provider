import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// FIX: the previous version only listened to `onConnectivityChanged`,
/// This checks connectivity explicitly first, yields that,
/// then continues with live updates.
final connectivityStatusProvider = StreamProvider<ConnectivityResult>((
  ref,
) async* {
  final connectivity = Connectivity();

  final initial = await connectivity.checkConnectivity();
  yield initial.isNotEmpty ? initial.first : ConnectivityResult.none;

  yield* connectivity.onConnectivityChanged.map((results) {
    return results.isNotEmpty ? results.first : ConnectivityResult.none;
  });
});
