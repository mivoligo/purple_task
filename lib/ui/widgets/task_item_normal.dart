import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/globals/strings/strings.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/ui/view_models/task_view_model.dart';

class TaskItemNormal extends StatelessWidget {
  final Task task;
  final Function onNamePressed;
  final Function onDeletePressed;

  const TaskItemNormal({
    Key key,
    this.task,
    this.onNamePressed,
    this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          activeColor: Colors.grey,
          value: task.isDone,
          onChanged: (value) {
            task.isDone = value;
            Provider.of<TaskViewModel>(context, listen: false)
                .updateTask(task.key, task);
          },
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: InkWell(
            onTap: onNamePressed,
            child: Text(task.name),
          ),
        ),
        IconButton(
          icon: Icon(
            AntIcons.delete,
            color: Colors.grey,
          ),
          onPressed: onDeletePressed,
          tooltip: DELETE,
        ),
      ],
    );
  }
}
