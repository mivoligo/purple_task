import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple_task/globals/strings/strings.dart';

import '../../../entities/entities.dart';
import '../../../helpers.dart';
import '../../../view_models/view_models.dart';
import '../../ui.dart';

enum TaskState {
  normalTaskState,
  editNameTaskState,
  expandedTaskState,
}

class TaskItemOld extends StatefulWidget {
  const TaskItemOld({
    Key? key,
    required this.task,
  }) : super(key: key);

  final TaskEntity task;

  @override
  _TaskItemOldState createState() => _TaskItemOldState();
}

class _TaskItemOldState extends State<TaskItemOld> {
  TaskState _taskState = TaskState.normalTaskState;
  final _textController = TextEditingController();
  bool _hasText = false;

  void setTaskNormal() {
    setState(() {
      _taskState = TaskState.normalTaskState;
    });
  }

  void setTaskExpanded() {
    setState(() {
      _taskState = TaskState.expandedTaskState;
    });
  }

  void setTaskEditName() {
    setState(() {
      _textController.text = widget.task.name;
      _taskState = TaskState.editNameTaskState;
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
    final _taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    final _displayDoneTaskTime = _settings.getDisplayTaskDOneTimePref();
    String? _timeFormat = _settings.getTimeFormat();
    String? _dateFormat = _settings.getDateFormat();
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: _taskState == TaskState.normalTaskState
                ? Colors.transparent
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 4.0),
                  Checkbox(
                    activeColor: Colors.grey,
                    value: widget.task.isDone,
                    onChanged: (value) {
                      if (value != null) {
                        widget.task.isDone = value;
                      }
                      if (widget.task.isDone) {
                        widget.task.doneTime = _taskViewModel.setTaskDoneTime();
                      }
                      _taskViewModel.updateTask(widget.task.key, widget.task);
                    },
                  ),
                  const SizedBox(width: 4.0),
                  Expanded(
                    child: _taskState == TaskState.editNameTaskState
                        ? CupertinoTextField(
                            controller: _textController,
                            autofocus: true,
                            style: Theme.of(context).textTheme.subtitle1,
                            onSubmitted: _hasText
                                ? (v) {
                                    widget.task.name = _textController.text;
                                    _taskViewModel.updateTask(
                                        widget.task.key, widget.task);
                                    setTaskNormal();
                                  }
                                : null,
                          )
                        : InkWell(
                            onTap: _taskState == TaskState.normalTaskState ||
                                    _taskState == TaskState.expandedTaskState
                                ? setTaskEditName
                                : null,
                            child: Text(
                              widget.task.name,
                              style: widget.task.isDone
                                  ? Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      )
                                  : Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                  ),
                  const SizedBox(width: 8.0),
                  if (widget.task.dueDate != null)
                    Text(_taskViewModel.displayDueDate(
                        widget.task.dueDate, _dateFormat)),
                  if (_taskState == TaskState.normalTaskState ||
                      _taskState == TaskState.editNameTaskState)
                    CustomIconButton(
                      icon: const Icon(
                        Icons.arrow_drop_down,
                      ),
                      color: Colors.transparent,
                      onPressed: setTaskExpanded,
                      tooltip: showOptions,
                    ),
                  if (_taskState == TaskState.expandedTaskState)
                    CustomIconButton(
                      icon: const Icon(
                        Icons.arrow_drop_up,
                      ),
                      color: Colors.transparent,
                      onPressed: setTaskNormal,
                      tooltip: hideOptions,
                    ),
                ],
              ),
              if (_displayDoneTaskTime &&
                  widget.task.isDone &&
                  widget.task.doneTime != null)
                Row(
                  children: [
                    SizedBox(width: 10.0),
                    Text(
                      '$completed: ${TimeConversion.millisToDateAndTime(
                        widget.task.doneTime!,
                        dateFormat: _dateFormat,
                        timeFormat: _timeFormat,
                      )}',
                    ),
                  ],
                ),
              AnimatedContainer(
                height: _taskState == TaskState.expandedTaskState ? 140 : 0,
                duration: Duration(milliseconds: 120),
                child: _taskState == TaskState.expandedTaskState
                    ? TaskOptionsOld(
                        task: widget.task,
                        onCategorySelected: setTaskNormal,
                        onDateSelected: setTaskNormal,
                        onDeletePressed: () {
                          _taskViewModel.deleteTask(widget.task.key);
                          setTaskNormal();
                        },
                      )
                    : null,
              ),
              AnimatedContainer(
                height: _taskState == TaskState.editNameTaskState ? 56 : 0,
                duration: Duration(milliseconds: 90),
                child: (_taskState == TaskState.editNameTaskState)
                    ? Row(
                        children: [
                          const SizedBox(width: 10),
                          SimpleButton(
                            onPressed: setTaskNormal,
                            text: cancel,
                          ),
                          Spacer(),
                          SimpleButton(
                            text: save,
                            color: Colors.green,
                            onPressed: _hasText
                                ? () {
                                    widget.task.name = _textController.text;
                                    _taskViewModel.updateTask(
                                        widget.task.key, widget.task);
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
        ),
        Divider(height: 6.0),
      ],
    );
  }
}

class TaskOptionsOld extends StatelessWidget {
  const TaskOptionsOld({
    Key? key,
    required this.task,
    required this.onDeletePressed,
    required this.onCategorySelected,
    required this.onDateSelected,
  }) : super(key: key);

  final TaskEntity task;
  final VoidCallback onDeletePressed;
  final VoidCallback onCategorySelected;
  final VoidCallback onDateSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(category),
                    ),
                    CategorySelectorOld(
                      task: task,
                      onCategorySelected: onCategorySelected,
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(dueDate),
                    ),
                    DueDateSelectorOld(
                      task: task,
                      onDateSelected: onDateSelected,
                    ),
                  ],
                ),
                const SizedBox(width: 6),
              ],
            ),
            const SizedBox(height: 16.0),
            SimpleButton(
              text: delete,
              color: Colors.red,
              onPressed: onDeletePressed,
            ),
          ],
        ),
      ),
    );
  }
}
