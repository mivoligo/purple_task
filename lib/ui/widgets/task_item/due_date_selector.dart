import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/strings/strings.dart' as s;
import '../../../controllers/controllers.dart';
import '../../../helpers.dart';
import '../../../models/models.dart';
import '../widgets.dart';

class DueDateSelector extends StatelessWidget {
  const DueDateSelector({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final dateFormatSetting =
            ref.watch(settingsNotifierProvider).dateFormat;

        return MenuAnchor(
          consumeOutsideTap: true,
          menuChildren: [
            MenuItemButton(
              onPressed: () {
                final now = DateTime.now();
                final today = DateTime(now.year, now.month, now.day);
                ref.read(tasksNotifierProvider.notifier).update(
                      task:
                          task.copyWith(dueDate: today.millisecondsSinceEpoch),
                    );
              },
              child: const Text(s.today),
            ),
            MenuItemButton(
              onPressed: () {
                final now = DateTime.now();
                final tomorrow = DateTime(now.year, now.month, now.day + 1);
                ref.read(tasksNotifierProvider.notifier).update(
                      task: task.copyWith(
                        dueDate: tomorrow.millisecondsSinceEpoch,
                      ),
                    );
              },
              child: const Text(s.tomorrow),
            ),
            MenuItemButton(
              onPressed: () {
                useSelectedDate(context, ref);
              },
              child: const Text(s.customDate),
            ),
            MenuItemButton(
              onPressed: () {
                ref
                    .read(tasksNotifierProvider.notifier)
                    .update(task: task.copyWith(dueDate: null));
              },
              child: const Text(s.noDate),
            ),
          ],
          builder: (context, controller, child) {
            return SimpleButton(
              foregroundColor: Colors.black87,
              backgroundColor: Colors.white,
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              text: task.dueDate != null
                  ? TimeConverter.formatDueDate(
                      task.dueDate,
                      dateFormatSetting,
                    )
                  : null,
              icon: task.dueDate == null
                  ? const Icon(
                      AntIcons.calendarOutline,
                      size: 16,
                    )
                  : null,
            );
          },
        );
      },
    );
  }

  void useSelectedDate(BuildContext context, WidgetRef ref) async {
    final dueDateDate = task.dueDate != null
        ? DateTime.fromMillisecondsSinceEpoch(task.dueDate!)
        : DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: dueDateDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      helpText: s.dueDate,
      cancelText: s.cancel,
      confirmText: s.save,
    );
    if (selectedDate != null) {
      final updatedTask =
          task.copyWith(dueDate: selectedDate.millisecondsSinceEpoch);
      ref.read(tasksNotifierProvider.notifier).update(task: updatedTask);
    }
  }
}
