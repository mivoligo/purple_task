import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/constants/strings/strings.dart' as s;
import 'package:purple_task/core/ui/widgets/dialog_base.dart';
import 'package:purple_task/features/settings/controllers/settings_controller.dart';
import 'package:purple_task/features/settings/views/widgets/date_format_selector.dart';
import 'package:purple_task/features/settings/views/widgets/time_format_selector.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DialogBase(
      title: s.settings,
      heroTag: 'settings',
      content: Expanded(
        child: Consumer(
          builder: (context, ref, _) {
            final state = ref.watch(settingsNotifierProvider);
            final controller = ref.watch(settingsNotifierProvider.notifier);
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              children: [
                const ListTile(
                  title: Text(s.timeFormat),
                  trailing: TimeFormatSelector(),
                ),
                const Divider(indent: 8, endIndent: 8),
                const ListTile(
                  title: Text(s.dateFormat),
                  trailing: DateFormatSelector(),
                ),
                const Divider(indent: 8, endIndent: 8),
                CheckboxListTile(
                  title: const Text(s.displayTimeCompleted),
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
