import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../db_models/db_models.dart';
import '../../../globals/globals.dart';
import '../../ui.dart';

class DueDateSelector extends StatelessWidget {
  const DueDateSelector({
    Key? key,
    required this.task,
    required this.onDateSelected,
  }) : super(key: key);

  final Task task;
  final VoidCallback onDateSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: PopupMenuButton(
        tooltip: setDueDate,
        onSelected: (dynamic item) => onItemSelected(context, item),
        itemBuilder: (context) {
          var menuList = <PopupMenuEntry<Object>>[];
          menuList.add(
            PopupMenuItem(
              child: Text(today),
              value: 0,
            ),
          );
          menuList.add(
            PopupMenuItem(
              child: Text(tomorrow),
              value: 1,
            ),
          );
          menuList.add(
            PopupMenuItem(
              child: Text(customDate),
              value: 2,
            ),
          );
          menuList.add(
            PopupMenuItem(
              child: Text(noDate),
              value: 3,
            ),
          );
          return menuList;
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<TaskViewModel>(
            builder: (context, value, child) {
              final dateFormat =
                  Provider.of<SettingsViewModel>(context, listen: false)
                      .getDateFormat();
              return Text(
                value.displayDueDate(task.dueDate, dateFormat),
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Theme.of(context).primaryColor),
              );
            },
          ),
        ),
      ),
    );
  }

  void onItemSelected(BuildContext context, int item) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    switch (item) {
      case 0:
        // set due date to today
        task.dueDate = today.millisecondsSinceEpoch;
        break;
      case 1:
        // set due date to tomorrow
        task.dueDate = tomorrow.millisecondsSinceEpoch;
        break;
      case 2:
        // set custom date
        useSelectedDate(context);
        return;
      case 3:
        // set date to null
        task.dueDate = null;
        break;
    }
    Provider.of<TaskViewModel>(context, listen: false)
        .updateTask(task.key, task);
    onDateSelected();
  }

  void useSelectedDate(BuildContext context) async {
    final dueDateDate = task.dueDate != null
        ? DateTime.fromMillisecondsSinceEpoch(task.dueDate!)
        : DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: dueDateDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      helpText: dueDate,
      cancelText: cancel,
      confirmText: save,
    );
    if (selectedDate != null) {
      task.dueDate = selectedDate.millisecondsSinceEpoch;
      Provider.of<TaskViewModel>(context, listen: false)
          .updateTask(task.key, task);
    }
    onDateSelected();
  }
}
