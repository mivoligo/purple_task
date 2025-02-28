import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/styles/providers/providers.dart';
import 'package:purple_task/core/styles/themes.dart';
import 'package:purple_task/features/settings/controllers/settings_controller.dart';

class ThemeSelector extends ConsumerWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsNotifierProvider);
    final controller = ref.watch(appThemeProvider.notifier);
    return MenuAnchor(
      menuChildren: [
        ...AppThemeMode.values.map(
          (theme) => MenuItemButton(
            onPressed: () {
              controller.update(theme);
            },
            child: Text(
              theme.name,
              style: settingsState.value?.theme == theme
                  ? const TextStyle(fontWeight: FontWeight.bold)
                  : null,
            ),
          ),
        ),
      ],
      builder: (context, controller, child) {
        return OutlinedButton(
          onPressed: () {
            controller.isOpen ? controller.close() : controller.open();
          },
          child: Text(
            settingsState.value?.theme.name ?? AppThemeMode.system.name,
          ),
        );
      },
    );
  }
}
