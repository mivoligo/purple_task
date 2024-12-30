import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/constants/strings/strings.dart' as s;
import 'package:purple_task/core/ui/screens/settings/widgets/widgets.dart';
import 'package:purple_task/core/ui/widgets/dialog_base.dart';
import 'package:purple_task/features/settings/controllers/settings/settings_controller.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

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
                ListTile(
                  title: const Text(s.displayTimeCompleted),
                  trailing: Switch(
                    activeColor: Theme.of(context).primaryColor,
                    value: state.value?.showDoneTime ?? false,
                    onChanged: (value) => controller.setDisplayTaskDoneTimePref(
                      showDoneTime: value,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
