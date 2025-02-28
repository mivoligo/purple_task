import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/constants/strings/strings.dart' as s;
import 'package:purple_task/core/styles/providers/providers.dart';
import 'package:purple_task/core/styles/themes.dart';
import 'package:purple_task/features/settings/controllers/settings_controller.dart';

class ThemeSelector extends ConsumerWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsNotifierProvider);
    final themeController = ref.watch(appThemeProvider.notifier);

    String themeName(AppThemeMode? themeMode) {
      return switch (themeMode) {
        AppThemeMode.system => s.themeModeSystem,
        AppThemeMode.light => s.themeModeLight,
        AppThemeMode.dark => s.themeModeDark,
        _ => s.themeModeSystem,
      };
    }

    return MenuAnchor(
      menuChildren: [
        ...AppThemeMode.values.map(
          (themeMode) {
            final theme = themeName(themeMode);
            return MenuItemButton(
              onPressed: () {
                themeController.update(themeMode);
              },
              child: Text(
                theme,
                style: settingsState.value?.theme == themeMode
                    ? const TextStyle(fontWeight: FontWeight.bold)
                    : null,
              ),
            );
          },
        ),
      ],
      builder: (context, controller, child) {
        return OutlinedButton(
          onPressed: () {
            controller.isOpen ? controller.close() : controller.open();
          },
          child: Text(themeName(settingsState.value?.theme)),
        );
      },
    );
  }
}
