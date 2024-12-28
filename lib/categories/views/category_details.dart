import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/strings/strings.dart' as s;
import '../../tasks/controllers/tasks_controller.dart';
import '../../tasks/models/task.dart';
import '../../tasks/views/all_tasks.dart';
import '../../tasks/views/completed_tasks.dart';
import '../../tasks/views/planned_tasks.dart';
import '../../ui/widgets/widgets.dart';
import '../controllers/categories_controller.dart';
import '../models/category.dart';

class CategoryDetails extends ConsumerStatefulWidget {
  const CategoryDetails({required this.category, super.key});

  final Category category;

  @override
  ConsumerState<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends ConsumerState<CategoryDetails> {
  late int _navigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    final currentCategory = ref
        .watch(categoriesNotifierProvider)
        .valueOrNull
        ?.firstWhere((element) => element.id == widget.category.id);

    if (currentCategory == null) {
      return const CircularProgressIndicator();
    }

    return Column(
      children: [
        NavigationBar(
          backgroundColor: Colors.transparent,
          selectedIndex: _navigationIndex,
          height: 64,
          onDestinationSelected: (index) {
            setState(() {
              _navigationIndex = index;
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
        Expanded(
          child: _buildTasksList(currentCategory),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: AddTaskField(
            onAddTask: (value) {
              final task = Task(
                name: value,
                categoryId: currentCategory.id,
              );
              ref.read(tasksNotifierProvider.notifier).add(task: task);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTasksList(Category category) {
    return switch (_navigationIndex) {
      0 => PlannedTasks(categoryId: category.id),
      1 => AllTasks(categoryId: category.id),
      2 => CompletedTasks(categoryId: category.id),
      _ => PlannedTasks(categoryId: category.id),
    };
  }
}
