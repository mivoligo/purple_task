import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../helpers.dart';
import '../../../globals/globals.dart';
import '../../../db_models/db_models.dart';
import '../../ui.dart';

enum TaskState {
  Normal,
  EditName,
  Expanded,
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

  setTaskExpanded() {
    setState(() {
      _taskState = TaskState.Expanded;
    });
  }

  setTaskConfirmDelete() {
    setState(() {
      _taskState = TaskState.ConfirmDelete;
    });
  }

  setTaskEditName() {
    setState(() {
      _textController.text = widget.task.name;
      _taskState = TaskState.EditName;
    });
  }

  _updateTextField() {
    setState(() {
      _hasText = _textController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    _textController.addListener(_updateTextField);
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _settings = Provider.of<SettingsViewModel>(context, listen: false);
    bool _displayDoneTaskTime = _settings.getDisplayTaskDOneTimePref();
    String _timeFormat = _settings.getTimeFormat();
    String _dateFormat = _settings.getDateFormat();
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
                        onTap: _taskState == TaskState.Normal ||
                                _taskState == TaskState.Expanded
                            ? setTaskEditName
                            : null,
                        child: Text(
                          widget.task.name,
                          style: widget.task.isDone
                              ? Theme.of(context).textTheme.subtitle2
                              : Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
              ),
              if (_taskState == TaskState.Normal)
                CustomIconButton(
                  icon: const Icon(
                    Icons.arrow_drop_down,
                  ),
                  color: Colors.transparent,
                  onPressed: setTaskExpanded,
                  tooltip: OPTIONS,
                ),
              if (_taskState == TaskState.EditName) const SizedBox(width: 10.0),
              if (_taskState == TaskState.Expanded)
                CustomIconButton(
                  icon: const Icon(
                    Icons.arrow_drop_up,
                  ),
                  color: Colors.transparent,
                  onPressed: setTaskNormal,
                  tooltip: CLOSE,
                ),
            ],
          ),
          if (_displayDoneTaskTime &&
              widget.task.isDone &&
              widget.task.doneTime != null)
            Row(
              children: [
                SizedBox(width: 8.0),
                Text(
                  '$COMPLETED: ${TimeConversion().millisToDateAndTime(widget.task.doneTime, dateFormat: _dateFormat, timeFormat: _timeFormat)}',
                ),
              ],
            ),
          AnimatedContainer(
            height: _taskState == TaskState.Expanded ? 160 : 0,
            duration: Duration(milliseconds: 120),
            child: _taskState == TaskState.Expanded ? TaskOptions() : null,
          ),
          AnimatedContainer(
            height: _taskState == TaskState.EditName ? 56 : 0,
            duration: Duration(milliseconds: 90),
            child: (_taskState == TaskState.EditName)
                ? Row(
                    children: [
                      const SizedBox(width: 10),
                      SimpleButton(
                        onPressed: setTaskNormal,
                        text: CANCEL,
                      ),
                      Spacer(),
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
                                Provider.of<TaskViewModel>(context,
                                        listen: false)
                                    .updateTask(widget.task.key, _task);
                                setTaskNormal();
                              }
                            : null,
                      ),
                      const SizedBox(width: 10),
                    ],
                  )
                : null,
          ),
        ],
      ),
    );
  }
}

class TaskOptions extends StatelessWidget {
  const TaskOptions({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Expanded(
          child: Row(
            children: [
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(CATEGORY),
                  RaisedButton(onPressed: null),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(DUE_DATE),
                  RaisedButton(onPressed: null),
                ],
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
        SimpleButton(
          text: DELETE,
          color: Colors.red,
          onPressed: () {},
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
