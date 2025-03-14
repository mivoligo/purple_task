import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/constants/custom_styles.dart';
import 'package:purple_task/features/todos/controllers/tasks_controller.dart';
import 'package:purple_task/features/todos/models/task.dart';
import 'package:purple_task/features/todos/providers/providers.dart';
import 'package:purple_task/features/todos/views/add_task_field.dart';
import 'package:purple_task/features/todos/views/all_tasks.dart';
import 'package:purple_task/features/todos/views/completed_tasks.dart';
import 'package:purple_task/features/todos/views/planned_tasks.dart';

class UncategorizedTasks extends ConsumerStatefulWidget {
  const UncategorizedTasks({super.key});

  @override
  ConsumerState<UncategorizedTasks> createState() => _UncategorizedTasksState();
}

class _UncategorizedTasksState extends ConsumerState<UncategorizedTasks> {
  int navigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final uncategorizedTasks = ref.watch(uncategorizedTasksProvider);

    return Column(
      children: [
        if (uncategorizedTasks.isNotEmpty)
          NavigationBar(
            height: 64,
            backgroundColor: Colors.transparent,
            selectedIndex: navigationIndex,
            onDestinationSelected: (index) {
              setState(() {
                navigationIndex = index;
              });
            },
            destinations: [
              NavigationDestination(
                label: tr.toDoTasksHeader,
                icon: const Icon(AntIcons.edit),
              ),
              NavigationDestination(
                label: tr.allTasksHeader,
                icon: const Icon(AntIcons.profile),
              ),
              NavigationDestination(
                label: tr.completedTasksHeader,
                icon: const Icon(AntIcons.checkCircle),
              ),
            ],
          ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Text(
            tr.noCategoryHeader,
            style: CustomStyle.textStyleTaskFilter,
          ),
        ),
        Expanded(child: _buildTasksList()),
        Padding(
          padding: const EdgeInsets.all(8),
          child: AddTaskField(
            onAddTask: (value) {
              final task = Task(
                name: value,
                categoryId: -1,
                createTime: DateTime.now().millisecondsSinceEpoch,
              );
              ref.read(tasksNotifierProvider.notifier).add(task: task);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTasksList() {
    return switch (navigationIndex) {
      0 => const PlannedTasks(categoryId: -1),
      1 => const AllTasks(categoryId: -1),
      2 => const CompletedTasks(categoryId: -1),
      _ => const PlannedTasks(categoryId: -1),
    };
  }
}
