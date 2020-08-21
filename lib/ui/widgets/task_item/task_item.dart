import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/globals/strings/strings.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/ui/view_models/task_view_model.dart';

enum TaskState {
  Normal,
  EditName,
  ConfirmDelete,
}

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
  TaskState _taskState = TaskState.Normal;
  final _textController = TextEditingController();

  setTaskNormal() {
    setState(() {
      _taskState = TaskState.Normal;
    });
  }

  setTaskDelete() {
    setState(() {
      _taskState = TaskState.ConfirmDelete;
    });
  }

  setTaskEdit() {
    setState(() {
      _taskState = TaskState.EditName;
    });
  }

  @override
  void initState() {
    _textController.text = widget.task.name;
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                activeColor: Colors.grey,
                value: widget.task.isDone,
                onChanged: (value) {
                  widget.task.isDone = value;
                  Provider.of<TaskViewModel>(context, listen: false)
                      .updateTask(widget.task.key, widget.task);
                },
              ),
              SizedBox(width: 8.0),
              Expanded(
                  child: _taskState == TaskState.EditName
                      ? CupertinoTextField(
                          controller: _textController,
                          autofocus: true,
                        )
                      : InkWell(
                          onTap: _taskState == TaskState.Normal
                              ? () {
                                  setTaskEdit();
                                }
                              : null,
                          child: Text(
                            widget.task.name,
                            style: TextStyle(
                              color: widget.task.isDone
                                  ? Colors.grey
                                  : Colors.black,
                              decoration: widget.task.isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                        )),
              if (_taskState == TaskState.Normal)
                IconButton(
                  icon: Icon(
                    AntIcons.delete,
                    color: Colors.grey,
                  ),
                  onPressed:
                      _taskState == TaskState.Normal ? setTaskDelete : null,
                  tooltip: DELETE,
                ),
            ],
          ),
          AnimatedContainer(
            height: _taskState == TaskState.Normal ? 0 : 56,
            duration: Duration(milliseconds: 90),
            child: Row(
              children: [
                SizedBox(width: 10),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      _taskState = TaskState.Normal;
                    });
                  },
                  child: Text(CANCEL),
                  color: Colors.grey,
                ),
                Spacer(),
                if (_taskState != TaskState.Normal)
                  FlatButton(
                    onPressed: _taskState == TaskState.ConfirmDelete
                        ? () {
                            Provider.of<TaskViewModel>(context, listen: false)
                                .deleteTask(widget.task.key);
                            setTaskNormal();
                          }
                        : () {
                            Task _task = Task(
                              name: _textController.text,
                              isDone: widget.task.isDone,
                              categoryId: widget.task.categoryId,
                            );
                            Provider.of<TaskViewModel>(context, listen: false)
                                .updateTask(widget.task.key, _task);
                            setTaskNormal();
                          },
                    child: _taskState == TaskState.ConfirmDelete
                        ? Text(DELETE)
                        : Text(SAVE),
                    color: _taskState == TaskState.ConfirmDelete
                        ? Colors.red
                        : Colors.green,
                  ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
