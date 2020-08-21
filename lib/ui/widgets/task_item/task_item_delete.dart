import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/globals/strings/strings.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/ui/view_models/task_view_model.dart';

class TaskItemDelete extends StatelessWidget {
  final Task task;
  final Function onCancel;
  final Function onDelete;

  const TaskItemDelete({
    Key key,
    this.task,
    this.onCancel,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 40),
            Expanded(child: Text(task.name)),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 10),
            FlatButton(
              onPressed: onCancel,
              child: Text(CANCEL),
              color: Colors.grey,
            ),
            Spacer(),
            FlatButton(
              onPressed: () {
                Provider.of<TaskViewModel>(context, listen: false)
                    .deleteTask(task.key);
                onDelete();
              },
              child: Text(DELETE),
              color: Colors.red,
            ),
            SizedBox(width: 10),
          ],
        )
      ],
    );
  }
}
