import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Core app providers
class AppProvider {
  /// Private constructor to prevent direct instantiation
  AppProvider._();

  /// Provider for managing app theme mode
  static final themeModeProvider = StateProvider<ThemeMode>((ref) {
    return ThemeMode.system;
  });

  /// Provider for managing app locale
  static final localeProvider = StateProvider<Locale?>((ref) {
    return null;
  });

  /// Provider for managing app loading state
  static final loadingProvider = StateProvider<bool>((ref) {
    return false;
  });

  /// Provider for managing app error state
  static final errorProvider = StateProvider<String?>((ref) {
    return null;
  });
} 