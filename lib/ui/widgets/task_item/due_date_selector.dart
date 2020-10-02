import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ui.dart';
import '../../../db_models/db_models.dart';
import '../../../globals/globals.dart';

class DueDateSelector extends StatelessWidget {
  final Task task;

  const DueDateSelector({
    Key key,
    @required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: PopupMenuButton(
        tooltip: SET_DUE_DATE,
        onSelected: (item) => onItemSelected(context, item),
        itemBuilder: (context) {
          var menuList = List<PopupMenuEntry<Object>>();
          menuList.add(
            PopupMenuItem(
              child: Text(TODAY),
              value: 0,
            ),
          );
          menuList.add(
            PopupMenuItem(
              child: Text(TOMORROW),
              value: 1,
            ),
          );
          menuList.add(
            PopupMenuItem(
              child: Text(CUSTOM_DATE),
              value: 2,
            ),
          );
          menuList.add(
            PopupMenuItem(
              child: Text(NO_DATE),
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
                    .subtitle1
                    .copyWith(color: Theme.of(context).primaryColor),
              );
            },
          ),
        ),
      ),
    );
  }

  onItemSelected(context, item) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    switch (item) {
      case 0:
        // set due date to today
        task.dueDate = today.millisecondsSinceEpoch;
        Provider.of<TaskViewModel>(context, listen: false)
            .updateTask(task.key, task);
        break;
      case 1:
        // set due date to tomorrow
        task.dueDate = tomorrow.millisecondsSinceEpoch;
        Provider.of<TaskViewModel>(context, listen: false)
            .updateTask(task.key, task);
        break;
      case 2:
        // set custom date
        useSelectedDate(context);
        break;
      case 3:
        // set date to null
        task.dueDate = null;
        Provider.of<TaskViewModel>(context, listen: false)
            .updateTask(task.key, task);
        break;
    }
  }

  void useSelectedDate(context) async {
    final dueDate = task.dueDate != null
        ? DateTime.fromMillisecondsSinceEpoch(task.dueDate)
        : DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: dueDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      helpText: DUE_DATE,
      cancelText: CANCEL,
      confirmText: SAVE,
    );
    if (selectedDate != null) {
      task.dueDate = selectedDate.millisecondsSinceEpoch;
      Provider.of<TaskViewModel>(context, listen: false)
          .updateTask(task.key, task);
    }
  }
}
