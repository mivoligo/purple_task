import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../constants/strings/strings.dart' as s;
import '../../../controllers/controllers.dart';
import '../../../helpers.dart';
import '../../../models/models.dart';
import '../../../providers/providers.dart';
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
      builder: (context, ref, _) {
        final taskTileState = ref.watch(taskTileProvider(widget.task));
        final tileStatus = taskTileState.status;
        final tileController =
            ref.watch(taskTileProvider(widget.task).notifier);
        final tasksController = ref.watch(tasksProvider.notifier);
        final settings = ref.watch(settingsControllerProvider);
        return Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Checkbox(
                    value: widget.task.isDone,
                    activeColor: Colors.grey,
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
                      : Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            hoverColor: Colors.grey[300],
                            onTap: () {
                              _textController.text = widget.task.name;
                              tileController.showNameEditing();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                widget.task.name,
                                style: widget.task.isDone
                                    ? CustomStyle.textStyleTaskName.copyWith(
                                        color: Colors.grey,
                                      )
                                    : CustomStyle.textStyleTaskName,
                              ),
                            ),
                          ),
                        ),
                ),
                const SizedBox(width: 8),
                DueDateSelector(task: widget.task),
                TaskOptions(task: widget.task),
              ],
            ),
            if (settings.showDoneTime &&
                widget.task.isDone &&
                widget.task.doneTime != null)
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 4.0),
                    child: Text(
                      '${s.completed}: ${TimeConversion.millisToDateAndTime(
                        widget.task.doneTime!,
                        dateFormat: settings.dateFormat,
                        timeFormat: settings.timeFormat,
                      )}',
                      style: CustomStyle.textStyleLabelSmall,
                    ),
                  ),
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
            const Divider(height: 1),
          ],
        );
      },
    );
  }
}
