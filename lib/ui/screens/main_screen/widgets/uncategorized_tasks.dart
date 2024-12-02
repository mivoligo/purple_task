import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../constants/strings/strings.dart' as s;

import '../../../../constants/constants.dart';
import '../../../../controllers/controllers.dart';
import '../../../../models/models.dart';
import '../../../../providers/providers.dart';
import '../../../widgets/widgets.dart';
import '../../category/widgets/widgets.dart';

class UncategorizedTasks extends ConsumerStatefulWidget {
  const UncategorizedTasks();

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
            destinations: [
              const NavigationDestination(
                label: s.toDo,
                icon: Icon(AntIcons.edit),
              ),
              const NavigationDestination(
                label: s.all,
                icon: Icon(AntIcons.profile),
              ),
              const NavigationDestination(
                label: s.completed,
                icon: Icon(AntIcons.checkCircle),
              ),
            ],
          ),
        const Padding(
          padding: EdgeInsets.all(4.0),
          child: Text(
            s.noCategory,
            style: CustomStyle.textStyleTaskFilter,
          ),
        ),
        Expanded(child: _buildTasksList()),
        Padding(
          padding: const EdgeInsets.all(8.0),
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
