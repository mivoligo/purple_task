import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/constants/custom_styles.dart';
import 'package:purple_task/core/constants/strings/strings.dart' as s;
import 'package:purple_task/core/helpers.dart';
import 'package:purple_task/core/ui/widgets/text_change_confirmation_dialog.dart';
import 'package:purple_task/features/settings/controllers/settings_controller.dart';
import 'package:purple_task/features/todos/controllers/tasks_controller.dart';
import 'package:purple_task/features/todos/models/task.dart';
import 'package:purple_task/features/todos/views/due_date_indicator.dart';

class TaskItem extends ConsumerWidget {
  const TaskItem({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final tasksController = ref.watch(tasksNotifierProvider.notifier);
    final settings = ref.watch(settingsNotifierProvider);
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(4),
          child: Checkbox(
            value: task.isDone,
            activeColor: colorScheme.onSurface.withAlpha(180),
            onChanged: (value) {
              final updatedTask = task.copyWith(
                isDone: value,
                doneTime: value ?? false
                    ? () => DateTime.now().millisecondsSinceEpoch
                    : () => null,
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
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        hoverColor: colorScheme.surface,
                        onTap: () => _onChangeName(
                          context: context,
                          tasksController: tasksController,
                        ),
                        child: Padding(
                          padding: EdgeInsets.zero,
                          child: Text(
                            task.name,
                            style: task.isDone
                                ? CustomStyle.textStyleTaskName.copyWith(
                                    color: colorScheme.onSurface.withAlpha(180),
                                  )
                                : CustomStyle.textStyleTaskName.copyWith(
                                    color: colorScheme.onSurface,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
              ),
              if (task.dueDate != null)
                Row(children: [DueDateIndicator(task: task)]),
              if (settings.value != null &&
                  settings.value!.showDoneTime &&
                  task.isDone &&
                  task.doneTime != null)
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        '${s.completed}: ${TimeConverter.millisToDateAndTime(
                          task.doneTime!,
                          dateFormat: settings.value?.dateFormat ?? 'd MMM y',
                          timeFormat: settings.value?.timeFormat ?? 'Hm',
                        )}',
                        style: CustomStyle.textStyleLabelSmall.copyWith(
                          color: colorScheme.onSurface.withAlpha(180),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _onChangeName({
    required BuildContext context,
    required TasksNotifier tasksController,
  }) {
    showDialog<void>(
      context: context,
      builder: (_) {
        return TextChangeConfirmationDialog(
          initialText: task.name,
          title: s.changeTaskName,
          confirmationButtonText: s.save,
          onConfirm: (newTaskName) {
            final updatedTask = task.copyWith(
              name: newTaskName,
            );
            tasksController.updateTask(task: updatedTask);
          },
        );
      },
    );
  }
}
