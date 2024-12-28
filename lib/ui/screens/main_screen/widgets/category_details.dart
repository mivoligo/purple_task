import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/strings/strings.dart' as s;
import '../../../../controllers/controllers.dart';
import '../../../../models/models.dart';
import '../../../widgets/widgets.dart';
import '../../category/widgets/widgets.dart';

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
