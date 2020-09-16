import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../globals/globals.dart';
import '../../../db_models/db_models.dart';
import '../../ui.dart';

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
                  final taskViewModel =
                      Provider.of<TaskViewModel>(context, listen: false);
                  widget.task.isDone = value;
                  if (widget.task.isDone) {
                    widget.task.doneTime = taskViewModel.setTaskDoneTime();
                  }
                  taskViewModel.updateTask(widget.task.key, widget.task);
                },
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: _taskState == TaskState.EditName
                    ? CupertinoTextField(
                        controller: _textController,
                        autofocus: true,
                        style: Theme.of(context).textTheme.subtitle1,
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
                          style: widget.task.isDone
                              ? Theme.of(context).textTheme.subtitle2
                              : Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
              ),
              if (_taskState == TaskState.Normal)
                IconButton(
                  icon: const Icon(
                    AntIcons.delete,
                    color: Colors.grey,
                  ),
                  onPressed: setTaskDelete,
                  tooltip: DELETE,
                ),
              if (_taskState == TaskState.EditName) const SizedBox(width: 10.0),
            ],
          ),
          if (widget.task.isDone && widget.task.doneTime != null)
            Row(
              children: [
                SizedBox(width: 8.0),
                Text('Completed ${widget.task.doneTime}'),
              ],
            ),
          AnimatedContainer(
            height: _taskState == TaskState.Normal ? 0 : 56,
            duration: Duration(milliseconds: 90),
            child: Row(
              children: [
                const SizedBox(width: 10),
                SimpleButton(
                  onPressed: setTaskNormal,
                  text: CANCEL,
                ),
                Spacer(),
                if (_taskState == TaskState.ConfirmDelete)
                  SimpleButton(
                    text: DELETE,
                    color: Colors.red,
                    onPressed: () {
                      Provider.of<TaskViewModel>(context, listen: false)
                          .deleteTask(widget.task.key);
                      setTaskNormal();
                    },
                  ),
                if (_taskState == TaskState.EditName)
                  SimpleButton(
                    text: SAVE,
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
                  ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
