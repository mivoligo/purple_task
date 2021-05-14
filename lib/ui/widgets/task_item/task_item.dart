import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/controllers.dart';
import '../../../globals/globals.dart';
import '../../../globals/strings/strings.dart' as s;
import '../../../helpers.dart';
import '../../../models/models.dart';
import '../widgets.dart';
import 'due_date_selector.dart';
import 'task_options.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({required this.task});

  final Task task;

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  final _textController = TextEditingController();
  bool _hasText = false;

  void _updateTextField() {
    setState(() {
      _hasText = _textController.text.trim().isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _textController.addListener(_updateTextField);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        final taskTileState = watch(taskTileProvider(widget.task));
        final tileStatus = taskTileState.status;
        final tileController = watch(taskTileProvider(widget.task).notifier);
        final tasksController = watch(tasksProvider.notifier);
        final settings = watch(settingsControllerProvider);
        return Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Checkbox(
                    value: widget.task.isDone,
                    onChanged: (value) {
                      final updatedTask = widget.task.copyWith(
                        isDone: value,
                        dueDate: widget.task.dueDate,
                        doneTime: DateTime.now().millisecondsSinceEpoch,
                      );
                      tasksController.update(task: updatedTask);
                    },
                  ),
                ),
                Expanded(
                  child: tileStatus == TaskTileStateStatus.editName
                      ? CupertinoTextField(
                          controller: _textController,
                          autofocus: true,
                          // style: Theme.of(context).textTheme.subtitle1,
                          onSubmitted: _hasText
                              ? (value) {
                                  final updatedTask = widget.task.copyWith(
                                    name: value.trim(),
                                    dueDate: widget.task.dueDate,
                                  );
                                  tasksController.update(task: updatedTask);
                                  tileController.collapseTile();
                                }
                              : null,
                        )
                      : InkWell(
                          onTap: () {
                            _textController.text = widget.task.name;
                            tileController.showNameEditing();
                          },
                          child: Text(
                            widget.task.name,
                            style: CustomStyle.textStyleTaskName,
                          ),
                        ),
                ),
                DueDateSelector(task: widget.task),
                TaskOptions(task: widget.task),
              ],
            ),
            if (settings.showDoneTime &&
                widget.task.isDone &&
                widget.task.doneTime != null)
              Row(
                children: [
                  const SizedBox(width: 10.0),
                  Text('${s.completed}: ${TimeConversion.millisToDateAndTime(
                    widget.task.doneTime!,
                    dateFormat: settings.dateFormat,
                    timeFormat: settings.timeFormat,
                  )}'),
                ],
              ),
            AnimatedContainer(
              height: tileStatus == TaskTileStateStatus.editName ? 56 : 0,
              duration: const Duration(milliseconds: 90),
              child: (tileStatus == TaskTileStateStatus.editName)
                  ? Row(
                      children: [
                        const SizedBox(width: 10),
                        SimpleButton(
                          onPressed: tileController.collapseTile,
                          text: s.cancel,
                        ),
                        const Spacer(),
                        SimpleButton(
                          text: s.save,
                          color: Colors.green,
                          onPressed: _hasText
                              ? () {
                                  final updatedTask = widget.task.copyWith(
                                    name: _textController.text.trim(),
                                    dueDate: widget.task.dueDate,
                                  );
                                  tasksController.update(task: updatedTask);
                                  tileController.collapseTile();
                                }
                              : null,
                        ),
                        const SizedBox(width: 10),
                      ],
                    )
                  : null,
            ),
            Container(
              height: 1,
              color: const Color(0xFFE0E0E0),
            ),
          ],
        );
      },
    );
  }
}
