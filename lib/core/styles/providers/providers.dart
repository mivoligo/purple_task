import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/styles/themes.dart';
import 'package:purple_task/features/settings/controllers/settings_controller.dart';
import 'package:purple_task/features/settings/settings_repository/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
Future<AppThemeMode> savedTheme(Ref ref) async {
  return ref.read(settingsRepositoryProvider).getTheme();
}

@riverpod
class AppTheme extends _$AppTheme {
  @override
  ThemeMode build() {
    final savedTheme = ref.watch(savedThemeProvider).valueOrNull;

    return switch (savedTheme) {
      AppThemeMode.dark => ThemeMode.dark,
      AppThemeMode.light => ThemeMode.light,
      _ => ThemeMode.system,
    };
  }

  Future<void> update(AppThemeMode theme) async {
    await ref
        .read(settingsNotifierProvider.notifier)
        .setTheme(value: theme.name);

    final savedTheme = ref.read(settingsNotifierProvider).valueOrNull?.theme;

    final updatedTheme = switch (savedTheme) {
      AppThemeMode.dark => ThemeMode.dark,
      AppThemeMode.light => ThemeMode.light,
      _ => ThemeMode.system,
    };

    state = updatedTheme;
  }
}
