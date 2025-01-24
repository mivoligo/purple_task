import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:purple_task/core/helpers.dart';
import 'package:purple_task/features/settings/controllers/settings_controller.dart';
import 'package:purple_task/features/todos/models/task.dart';

class DueDateIndicator extends StatelessWidget {
  const DueDateIndicator({
    required this.task,
    super.key,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final dateFormatSetting =
            ref.watch(settingsNotifierProvider).value?.dateFormat;

        return Row(
          children: [
            const Icon(
              AntIcons.calendarOutline,
              size: 14,
            ),
            const SizedBox(width: 2),
            Text(
              TimeConverter.formatDueDate(
                task.dueDate,
                dateFormatSetting,
              ),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        );
      },
    );
  }
}
