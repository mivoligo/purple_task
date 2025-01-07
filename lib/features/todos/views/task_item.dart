import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/constants/custom_styles.dart';
import 'package:purple_task/core/constants/strings/strings.dart' as s;
import 'package:purple_task/core/helpers.dart';
import 'package:purple_task/core/ui/widgets/simple_button.dart';
import 'package:purple_task/features/settings/controllers/settings/settings_controller.dart';
import 'package:purple_task/features/todos/controllers/task_tile_controller.dart';
import 'package:purple_task/features/todos/controllers/task_tile_state.dart';
import 'package:purple_task/features/todos/controllers/tasks_controller.dart';
import 'package:purple_task/features/todos/models/task.dart';
import 'package:purple_task/features/todos/views/due_date_indicator.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({required this.task, super.key});

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
        final taskTileState = ref.watch(taskTileNotifierProvider(widget.task));
        final tileStatus = taskTileState.status;
        final tileController =
            ref.watch(taskTileNotifierProvider(widget.task).notifier);
        final tasksController = ref.watch(tasksNotifierProvider.notifier);
        final settings = ref.watch(settingsNotifierProvider);
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Checkbox(
                value: widget.task.isDone,
                activeColor: Colors.grey,
                onChanged: (value) {
                  final updatedTask = widget.task.copyWith(
                    isDone: value,
                    dueDate: () => widget.task.dueDate,
                    doneTime: DateTime.now().millisecondsSinceEpoch,
                  );
                  tasksController.updateTask(task: updatedTask);
                },
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: tileStatus == TaskTileStateStatus.editName
                            ? CupertinoTextField(
                                controller: _textController,
                                autofocus: true,
                                onSubmitted: _hasText
                                    ? (value) {
                                        final updatedTask =
                                            widget.task.copyWith(
                                          name: value.trim(),
                                          dueDate: () => widget.task.dueDate,
                                        );
                                        tasksController.updateTask(
                                          task: updatedTask,
                                        );
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
                                    padding: EdgeInsets.zero,
                                    child: Text(
                                      widget.task.name,
                                      style: widget.task.isDone
                                          ? CustomStyle.textStyleTaskName
                                              .copyWith(
                                              color: Colors.grey,
                                            )
                                          : CustomStyle.textStyleTaskName,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(width: 4),
                      // DueDateSelector(task: widget.task),
                    ],
                  ),
                  if (widget.task.dueDate != null)
                    Row(
                      children: [DueDateIndicator(task: widget.task)],
                    ),
                  if (settings.value != null &&
                      settings.value!.showDoneTime &&
                      widget.task.isDone &&
                      widget.task.doneTime != null)
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            '${s.completed}: ${TimeConverter.millisToDateAndTime(
                              widget.task.doneTime!,
                              dateFormat:
                                  settings.value?.dateFormat ?? 'd MMM y',
                              timeFormat: settings.value?.timeFormat ?? 'Hm',
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
                                backgroundColor: Colors.green,
                                onPressed: _hasText
                                    ? () {
                                        final updatedTask =
                                            widget.task.copyWith(
                                          name: _textController.text.trim(),
                                          dueDate: () => widget.task.dueDate,
                                        );
                                        tasksController.updateTask(
                                          task: updatedTask,
                                        );
                                        tileController.collapseTile();
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
          ],
        );
      },
    );
  }
}
