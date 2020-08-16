import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:to_do/models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({
    Key key,
    this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0.0),
      title: Text(task.name),
      leading: Checkbox(
        value: task.isDone,
        onChanged: (value) {
          task.isDone = value;
        },
      ),
      trailing: IconButton(
        icon: Icon(AntIcons.menu),
        onPressed: task.delete,
      ),
    );
  }
}
