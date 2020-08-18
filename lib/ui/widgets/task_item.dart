import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:to_do/models/task.dart';

class TaskItem extends StatefulWidget {
  final Task task;

  const TaskItem({
    Key key,
    this.task,
  }) : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0.0),
      title: Text(
        widget.task.name,
        style: TextStyle(
          color: widget.task.isDone ? Colors.grey : Colors.black,
          decoration: widget.task.isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      leading: Checkbox(
        activeColor: Colors.grey,
        value: widget.task.isDone,
        onChanged: (value) {
          setState(() {
            widget.task.isDone = value;
            widget.task.save(); // save changes to hive
          });
        },
      ),
      trailing: IconButton(
        icon: Icon(AntIcons.menu),
        onPressed: widget.task.delete,
      ),
    );
  }
}
