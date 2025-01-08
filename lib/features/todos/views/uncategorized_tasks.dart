import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:purple_task/core/constants/custom_styles.dart';
import 'package:purple_task/core/constants/strings/strings.dart' as s;
import 'package:purple_task/features/todos/controllers/providers/providers.dart';
import 'package:purple_task/features/todos/controllers/tasks_controller.dart';
import 'package:purple_task/features/todos/models/task.dart';
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
            destinations: const [
              NavigationDestination(
                label: s.toDo,
                icon: Icon(AntIcons.edit),
              ),
              NavigationDestination(
                label: s.all,
                icon: Icon(AntIcons.profile),
              ),
              NavigationDestination(
                label: s.completed,
                icon: Icon(AntIcons.checkCircle),
              ),
            ],
          ),
        const Padding(
          padding: EdgeInsets.all(4),
          child: Text(
            s.noCategory,
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
