import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/globals/strings/strings.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/ui/view_models/task_view_model.dart';

class TaskItemEdit extends StatefulWidget {
  final Task task;
  final Function onCancel;
  final Function onSave;

  const TaskItemEdit({
    Key key,
    this.task,
    this.onCancel,
    this.onSave,
  }) : super(key: key);

  @override
  _TaskItemEditState createState() => _TaskItemEditState();
}

class _TaskItemEditState extends State<TaskItemEdit> {
  final _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.task.name;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoTextField(
          autofocus: true,
          controller: _controller,
        ),
        Row(
          children: [
            SizedBox(width: 10),
            FlatButton(
              onPressed: widget.onCancel,
              child: Text(CANCEL),
              color: Colors.grey,
            ),
            Spacer(),
            FlatButton(
              onPressed: () {
                Task _task = Task(
                  name: _controller.text,
                  isDone: widget.task.isDone,
                  categoryId: widget.task.categoryId,
                );
                Provider.of<TaskViewModel>(context, listen: false)
                    .updateTask(widget.task.key, _task);
                widget.onSave();
              },
              child: Text(SAVE),
              color: Colors.green,
            ),
            SizedBox(width: 10),
          ],
        )
      ],
    );
  }
}
