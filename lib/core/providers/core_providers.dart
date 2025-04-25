import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Core storage provider for Hive boxes
final storageProvider = Provider<HiveInterface>((ref) {
  return Hive;
});

/// Environment configuration provider
final environmentProvider = Provider<String>((ref) {
  // This will be set during app initialization
  throw UnimplementedError();
});

/// Global loading state provider
final loadingProvider = StateProvider<bool>((ref) => false);

/// Global error state provider
final errorProvider = StateProvider<String?>((ref) => null);

/// App initialization state provider
final appInitializedProvider = StateProvider<bool>((ref) => false); 