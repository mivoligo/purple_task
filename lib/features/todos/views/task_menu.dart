import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/constants/custom_styles.dart';
import 'package:purple_task/features/todos/controllers/categories_controller.dart';
import 'package:purple_task/features/todos/controllers/tasks_controller.dart';
import 'package:purple_task/features/todos/models/task.dart';

class TaskMenu extends StatelessWidget {
  const TaskMenu({
    required this.task,
    super.key,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    return Consumer(
      builder: (context, ref, _) {
        final categories = ref.watch(categoriesNotifierProvider);
        final otherCategories = categories.valueOrNull
            ?.where((element) => element.id != task.categoryId);

        return MenuAnchor(
          consumeOutsideTap: true,
          menuChildren: [
            MenuItemButton(
              child: Text(
                tr.delete,
                style: CustomStyle.textStyleWarning, // TODO style font size
              ),
              onPressed: () => ref
                  .read(tasksNotifierProvider.notifier)
                  .remove(taskId: task.id!),
            ),
            SubmenuButton(
              menuChildren: [
                MenuItemButton(
                  onPressed: () {
                    final now = DateTime.now();
                    final today = DateTime(now.year, now.month, now.day);
                    ref.read(tasksNotifierProvider.notifier).updateTask(
                          task: task.copyWith(
                            dueDate: () => today.millisecondsSinceEpoch,
                          ),
                        );
                  },
                  child: Text(tr.today),
                ),
                MenuItemButton(
                  onPressed: () {
                    final now = DateTime.now();
                    final tomorrow = DateTime(now.year, now.month, now.day + 1);
                    ref.read(tasksNotifierProvider.notifier).updateTask(
                          task: task.copyWith(
                            dueDate: () => tomorrow.millisecondsSinceEpoch,
                          ),
                        );
                  },
                  child: Text(tr.tomorrow),
                ),
                MenuItemButton(
                  onPressed: () {
                    useSelectedDate(context, ref);
                  },
                  child: Text(tr.customDate),
                ),
                MenuItemButton(
                  onPressed: () {
                    ref
                        .read(tasksNotifierProvider.notifier)
                        .updateTask(task: task.copyWith(dueDate: () => null));
                  },
                  child: Text(tr.noDate),
                ),
              ],
              child: Text(tr.setDueDate),
            ),
            if (otherCategories != null && otherCategories.isNotEmpty)
              SubmenuButton(
                menuChildren: [
                  ...otherCategories.map(
                    (e) => MenuItemButton(
                      leadingIcon: Icon(
                        IconData(
                          e.icon,
                          fontFamily: 'AntIcons',
                          fontPackage: 'ant_icons',
                        ),
                        // size: iconSize,
                        color: e.color,
                      ),
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          e.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      onPressed: () {
                        ref
                            .read(tasksNotifierProvider.notifier)
                            .updateTask(task: task.copyWith(categoryId: e.id));
                      },
                    ),
                  ),
                  if (task.categoryId != -1)
                    MenuItemButton(
                      leadingIcon: const SizedBox(width: 24),
                      child: Text(tr.noCategoryHeader),
                      onPressed: () {
                        ref
                            .read(tasksNotifierProvider.notifier)
                            .updateTask(task: task.copyWith(categoryId: -1));
                      },
                    ),
                ],
                child: Text(tr.taskOptionMoveToCategory),
              ),
          ],
          builder: (context, controller, child) {
            return IconButton(
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              icon: const Icon(
                AntIcons.menu,
                size: 16,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> useSelectedDate(BuildContext context, WidgetRef ref) async {
    final tr = AppLocalizations.of(context);
    final dueDateDate = task.dueDate != null
        ? DateTime.fromMillisecondsSinceEpoch(task.dueDate!)
        : DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: dueDateDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      helpText: tr.dueDate,
      cancelText: tr.cancelButton,
      confirmText: tr.saveButton,
    );
    if (selectedDate != null) {
      final updatedTask =
          task.copyWith(dueDate: () => selectedDate.millisecondsSinceEpoch);
      await ref
          .read(tasksNotifierProvider.notifier)
          .updateTask(task: updatedTask);
    }
  }
}
