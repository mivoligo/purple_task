import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/ui/widgets/dialog_base.dart';
import 'package:purple_task/features/settings/controllers/settings_controller.dart';
import 'package:purple_task/features/settings/views/widgets/date_format_selector.dart';
import 'package:purple_task/features/settings/views/widgets/language_selector.dart';
import 'package:purple_task/features/settings/views/widgets/theme_selector.dart';
import 'package:purple_task/features/settings/views/widgets/time_format_selector.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    return DialogBase(
      title: tr.settings,
      heroTag: 'settings',
      content: Expanded(
        child: Consumer(
          builder: (context, ref, _) {
            final state = ref.watch(settingsNotifierProvider);
            final controller = ref.watch(settingsNotifierProvider.notifier);

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              children: [
                ListTile(
                  title: Text(tr.settingsOptionLanguage),
                  trailing: const LanguageSelector(),
                ),
                const Divider(indent: 8, endIndent: 8),
                ListTile(
                  title: Text(tr.settingsOptionThemeMode),
                  trailing: const ThemeSelector(),
                ),
                const Divider(indent: 8, endIndent: 8),
                ListTile(
                  title: Text(tr.settingsOptionTimeFormat),
                  trailing: const TimeFormatSelector(),
                ),
                const Divider(indent: 8, endIndent: 8),
                ListTile(
                  title: Text(tr.settingsOptionDateFormat),
                  trailing: const DateFormatSelector(),
                ),
                const Divider(indent: 8, endIndent: 8),
                CheckboxListTile(
                  title: Text(tr.settingsOptionDisplayTimeCompleted),
                  value: state.value?.showDoneTime,
                  onChanged: (value) => value != null
                      ? controller.setDisplayTaskDoneTimePref(
                          showDoneTime: value,
                        )
                      : null,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
