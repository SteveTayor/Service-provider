import 'package:bundlegram/core/utils/theme/theme_mode_enum.dart';
import 'package:bundlegram/core/utils/theme/theme_state.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  final storage = ref.read(secureStorageHelperProvider);
  return ThemeNotifier(storage);
});

class ThemeNotifier extends StateNotifier<ThemeState> {
  final SecureStorageHelper storage;

  ThemeNotifier(this.storage) : super(const ThemeState(AppThemeMode.system)) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final saved = await storage.getThemeMode();
    if (saved == null) return;

    state = ThemeState(AppThemeMode.values.firstWhere(
      (e) => e.name == saved,
      orElse: () => AppThemeMode.system,
    ));
  }

  Future<void> setTheme(AppThemeMode mode) async {
    state = ThemeState(mode);
    await storage.setThemeMode(mode.name);
  }

  ThemeMode get flutterThemeMode {
    switch (state.mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
