import 'package:bundlegram/core/utils/theme/theme_mode_enum.dart';
import 'package:bundlegram/core/utils/theme/theme_notifier.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeSettingsScreen extends ConsumerWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final notifier = ref.read(themeProvider.notifier);

    return BundlegramScaffold(
      appBar: const BundlegramAppbar(titleText: 'Theme Settings'),
      body: Column(
        spacing: 8.h,
        children: [
          RadioListTile<AppThemeMode>(
            title: const Text("System default"),
            value: AppThemeMode.system,
            groupValue: themeState.mode,
            onChanged: (v) => notifier.setTheme(v!),
          ),
          RadioListTile<AppThemeMode>(
            title: const Text("Light mode"),
            value: AppThemeMode.light,
            groupValue: themeState.mode,
            onChanged: (v) => notifier.setTheme(v!),
          ),
          RadioListTile<AppThemeMode>(
            title: const Text("Dark mode"),
            value: AppThemeMode.dark,
            groupValue: themeState.mode,
            onChanged: (v) => notifier.setTheme(v!),
          ),
        ],
      ),
    );
  }
}
