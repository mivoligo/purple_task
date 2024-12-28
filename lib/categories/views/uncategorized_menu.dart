import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/strings/strings.dart' as s;
import '../../tasks/controllers/tasks_controller.dart';
import '../../ui/widgets/widgets.dart';
import '../controllers/category_controller.dart';

class UncategorizedMenu extends ConsumerWidget {
  const UncategorizedMenu({
    this.iconSize,
  });

  final double? iconSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MenuAnchor(
      consumeOutsideTap: true,
      menuChildren: [
        MenuItemButton(
          child: const Text(s.deleteCompleted),
          onPressed: () => _onDeleteCompletedTasks(context, ref),
        ),
        MenuItemButton(
          child: const Text(s.deleteAllTasks),
          onPressed: () => _onDeleteAllTasks(context, ref),
        ),
      ],
      builder: (context, controller, child) {
        return IconButton(
          tooltip: s.showOptions,
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              ref
                  .read(categoryNotifierProvider.notifier)
                  .setCurrentCategory(null);
              controller.open();
            }
          },
          icon: Icon(
            AntIcons.menu,
            size: iconSize,
          ),
        );
      },
    );
  }

  void _onDeleteCompletedTasks(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ConfirmationDialog(
        title: s.questionDeleteCompleted,
        content: const Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(s.infoDeleteCompleted),
        ),
        confirmationText: s.delete,
        confirmationColor: Colors.red,
        onConfirm: () {
          ref
              .read(tasksNotifierProvider.notifier)
              .removeCompletedTasksForCategory(categoryId: -1);
        },
      ),
    );
  }

  void _onDeleteAllTasks(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ConfirmationDialog(
        title: s.questionDeleteAll,
        content: const Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(s.infoDeleteAll),
        ),
        confirmationText: s.delete,
        confirmationColor: Colors.red,
        onConfirm: () => ref
            .read(tasksNotifierProvider.notifier)
            .removeAllTasksForCategory(categoryId: -1),
      ),
    );
  }
}
