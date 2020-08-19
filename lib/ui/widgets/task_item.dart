import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/ui/view_models/task_view_model.dart';

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
          print("task key: ${widget.task.key} ");
          setState(() {
            widget.task.isDone = value;

            Provider.of<TaskViewModel>(context, listen: false)
                .updateTask(widget.task.key, widget.task);
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
