import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../tasks/bloc/task_list_cubit.dart';
import '../../tasks/ui/add_task_input.dart';
import '../../tasks/ui/task_tile.dart';
import '../../ui/ui.dart';
import '../data/models/category.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 32.0,
      ),
      child: BlocBuilder<TaskListCubit, TaskListState>(
        builder: (context, state) {
          final tasks = state is TaskListLoaded ? state.tasks : [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(
                    IconData(
                      category.icon,
                      fontFamily: 'AntIcons',
                      fontPackage: 'ant_icons',
                    ),
                    size: 42.0,
                    color: category.color,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 4.0,
                ),
                child: CategoryHeader(
                  title: category.name,
                  description: '${tasks.length}',
                  progress: 0.3,
                  color: category.color,
                ),
              ),
              AddTaskInput(categoryId: category.id),
              if (state is TaskListLoaded)
                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return TaskTile(task: task);
                    },
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
