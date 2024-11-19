import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../constants/strings/strings.dart' as s;
import '../../../controllers/controllers.dart';
import '../../../helpers.dart';
import '../../../models/models.dart';

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
        return Card(
          elevation: 0,
          child: PopupMenuButton<int>(
            tooltip: s.setDueDate,
            onSelected: (item) => onItemSelected(context, ref, item),
            itemBuilder: (context) {
              var menuList = <PopupMenuEntry<int>>[];
              menuList.add(
                const PopupMenuItem(
                  child: Text(s.today),
                  value: 0,
                ),
              );
              menuList.add(
                const PopupMenuItem(
                  child: Text(s.tomorrow),
                  value: 1,
                ),
              );
              menuList.add(
                const PopupMenuItem(
                  child: Text(s.customDate),
                  value: 2,
                ),
              );
              menuList.add(
                const PopupMenuItem(
                  child: Text(s.noDate),
                  value: 3,
                ),
              );
              return menuList;
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: task.dueDate != null
                  ? Text(
                      TimeConversion.formatDueDate(
                        task.dueDate,
                        dateFormatSetting,
                      ),
                      style: CustomStyle.textStyleTaskFilter,
                    )
                  : const Icon(
                      AntIcons.calendarOutline,
                      size: 10,
                    ),
            ),
          ),
        );
      },
    );
  }

  void onItemSelected(BuildContext context, WidgetRef ref, int item) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    int? dueDate;
    switch (item) {
      case 0:
        dueDate = today.millisecondsSinceEpoch;
      case 1:
        dueDate = tomorrow.millisecondsSinceEpoch;
      case 2:
        useSelectedDate(context, ref);
        return;
      case 3:
        dueDate = null;
    }
    final updatedTask = task.copyWith(dueDate: dueDate);
    ref.read(tasksNotifierProvider.notifier).update(task: updatedTask);
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
