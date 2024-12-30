import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/settings/controllers/settings/settings_controller.dart';
import '../../../constants/strings/strings.dart' as s;
import '../../widgets/dialog_base.dart';
import 'widgets/widgets.dart';

class Settings extends StatelessWidget {
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
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              children: [
                ListTile(
                  title: const Text(s.timeFormat),
                  trailing: TimeFormatSelector(),
                ),
                const Divider(indent: 8, endIndent: 8),
                ListTile(
                  title: const Text(s.dateFormat),
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
