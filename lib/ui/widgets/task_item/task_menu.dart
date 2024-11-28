import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../constants/strings/strings.dart' as s;
import '../../../controllers/controllers.dart';
import '../../../models/models.dart';

class TaskMenu extends StatelessWidget {
  const TaskMenu({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final categories = ref.watch(categoriesNotifierProvider);
        final otherCategories =
            categories.where((element) => element.id != task.categoryId);

        return MenuAnchor(
          consumeOutsideTap: true,
          menuChildren: [
            MenuItemButton(
              child: const Text(
                s.delete,
                style: CustomStyle.textStyleWarning, // todo style font size
              ),
              onPressed: () =>
                  ref.read(tasksNotifierProvider.notifier).remove(task: task),
            ),
            SubmenuButton(
              menuChildren: [
                MenuItemButton(
                  onPressed: () {
                    final now = DateTime.now();
                    final today = DateTime(now.year, now.month, now.day);
                    ref.read(tasksNotifierProvider.notifier).update(
                          task: task.copyWith(
                            dueDate: today.millisecondsSinceEpoch,
                          ),
                        );
                  },
                  child: const Text(s.today),
                ),
                MenuItemButton(
                  onPressed: () {
                    final now = DateTime.now();
                    final tomorrow = DateTime(now.year, now.month, now.day + 1);
                    ref.read(tasksNotifierProvider.notifier).update(
                          task: task.copyWith(
                            dueDate: tomorrow.millisecondsSinceEpoch,
                          ),
                        );
                  },
                  child: const Text(s.tomorrow),
                ),
                MenuItemButton(
                  onPressed: () {
                    useSelectedDate(context, ref);
                  },
                  child: const Text(s.customDate),
                ),
                MenuItemButton(
                  onPressed: () {
                    ref
                        .read(tasksNotifierProvider.notifier)
                        .update(task: task.copyWith(dueDate: null));
                  },
                  child: const Text(s.noDate),
                ),
              ],
              child: const Text('Set due date'),
            ),
            if (otherCategories.isNotEmpty)
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
                            .update(task: task.copyWith(categoryId: e.id));
                      },
                    ),
                  ),
                  if (task.categoryId != -1)
                    MenuItemButton(
                      leadingIcon: const SizedBox(width: 24),
                      child: const Text(s.noCategory),
                      onPressed: () {
                        ref
                            .read(tasksNotifierProvider.notifier)
                            .update(task: task.copyWith(categoryId: -1));
                      },
                    ),
                ],
                child: const Text(s.changeCategory),
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

  void useSelectedDate(BuildContext context, WidgetRef ref) async {
    final dueDateDate = task.dueDate != null
        ? DateTime.fromMillisecondsSinceEpoch(task.dueDate!)
        : DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: dueDateDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      helpText: s.dueDate,
      cancelText: s.cancel,
      confirmText: s.save,
    );
    if (selectedDate != null) {
      final updatedTask =
          task.copyWith(dueDate: selectedDate.millisecondsSinceEpoch);
      ref.read(tasksNotifierProvider.notifier).update(task: updatedTask);
    }
  }
}
