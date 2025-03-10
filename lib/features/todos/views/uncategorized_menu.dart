import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/ui/widgets/confirmation_dialog.dart';
import 'package:purple_task/features/todos/controllers/category_controller.dart';
import 'package:purple_task/features/todos/controllers/tasks_controller.dart';

class UncategorizedMenu extends ConsumerWidget {
  const UncategorizedMenu({
    super.key,
    this.iconSize,
  });

  final double? iconSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = AppLocalizations.of(context);
    return MenuAnchor(
      consumeOutsideTap: true,
      menuChildren: [
        MenuItemButton(
          child: Text(tr.categoryOptionDeleteCompleted),
          onPressed: () => _onDeleteCompletedTasks(context, ref),
        ),
        MenuItemButton(
          child: Text(tr.categoryOptionDeleteAllTasks),
          onPressed: () => _onDeleteAllTasks(context, ref),
        ),
      ],
      builder: (context, controller, child) {
        return IconButton(
          tooltip: tr.showOptions,
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
    final tr = AppLocalizations.of(context);
    showDialog<void>(
      context: context,
      builder: (_) => ConfirmationDialog(
        title: tr.deleteCompletedTasksDialogTitle,
        content: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(tr.deleteCompletedTasksDialogContent),
        ),
        confirmationText: tr.delete,
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
    final tr = AppLocalizations.of(context);
    showDialog<void>(
      context: context,
      builder: (_) => ConfirmationDialog(
        title: tr.deleteAllTasksDialogTitle,
        content: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(tr.deleteAllTasksDialogContent),
        ),
        confirmationText: tr.delete,
        confirmationColor: Colors.red,
        onConfirm: () => ref
            .read(tasksNotifierProvider.notifier)
            .removeAllTasksForCategory(categoryId: -1),
      ),
    );
  }
}
