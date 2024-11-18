import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/strings/strings.dart' as s;
import '../../../providers/providers.dart';
import '../../widgets/widgets.dart';
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
            final state = ref.watch(settingsControllerProvider);
            final controller = ref.watch(settingsControllerProvider.notifier);
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
                    value: state.showDoneTime,
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
