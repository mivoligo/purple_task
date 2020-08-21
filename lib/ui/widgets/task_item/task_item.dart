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
  bool _hasText = false;

  setTaskNormal() {
    setState(() {
      _taskState = TaskState.Normal;
      print('setting normal');
    });
  }

  setTaskDelete() {
    setState(() {
      _taskState = TaskState.ConfirmDelete;
    });
  }

  setTaskEdit() {
    setState(() {
      _textController.text = widget.task.name;
      _taskState = TaskState.EditName;
    });
  }

  _updateField() {
    setState(() {
      _hasText = _textController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    _textController.addListener(_updateField);
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
                        onSubmitted: _hasText
                            ? (v) {
                                Task _task = Task(
                                  name: _textController.text,
                                  isDone: widget.task.isDone,
                                  categoryId: widget.task.categoryId,
                                );
                                Provider.of<TaskViewModel>(context,
                                        listen: false)
                                    .updateTask(widget.task.key, _task);
                                setTaskNormal();
                              }
                            : null,
                      )
                    : InkWell(
                        onTap:
                            _taskState == TaskState.Normal ? setTaskEdit : null,
                        child: Text(
                          widget.task.name,
                          style: TextStyle(
                            color:
                                widget.task.isDone ? Colors.grey : Colors.black,
                            decoration: widget.task.isDone
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      ),
              ),
              if (_taskState == TaskState.Normal)
                IconButton(
                  icon: Icon(
                    AntIcons.delete,
                    color: Colors.grey,
                  ),
                  onPressed: setTaskDelete,
                  tooltip: DELETE,
                ),
              if (_taskState == TaskState.EditName) SizedBox(width: 10.0),
            ],
          ),
          AnimatedContainer(
            height: _taskState == TaskState.Normal ? 0 : 56,
            duration: Duration(milliseconds: 90),
            child: Row(
              children: [
                SizedBox(width: 10),
                FlatButton(
                  onPressed: setTaskNormal,
                  child: Text(
                    CANCEL,
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.grey,
                ),
                Spacer(),
                if (_taskState == TaskState.ConfirmDelete)
                  FlatButton(
                    color: Colors.red,
                    onPressed: () {
                      Provider.of<TaskViewModel>(context, listen: false)
                          .deleteTask(widget.task.key);
                      setTaskNormal();
                    },
                    child: Text(
                      DELETE,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                if (_taskState == TaskState.EditName)
                  FlatButton(
                    color: Colors.green,
                    onPressed: _hasText
                        ? () {
                            Task _task = Task(
                              name: _textController.text,
                              isDone: widget.task.isDone,
                              categoryId: widget.task.categoryId,
                            );
                            Provider.of<TaskViewModel>(context, listen: false)
                                .updateTask(widget.task.key, _task);
                            setTaskNormal();
                          }
                        : null,
                    child: Text(
                      SAVE,
                      style: TextStyle(color: Colors.white),
                    ),
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
