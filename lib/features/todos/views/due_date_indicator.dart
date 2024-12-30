import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/helpers.dart';
import '../../settings/controllers/settings/settings_controller.dart';
import '../models/task.dart';

class DueDateIndicator extends StatelessWidget {
  const DueDateIndicator({
    Key? key,
    required this.task,
  }) : super(key: key);

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
