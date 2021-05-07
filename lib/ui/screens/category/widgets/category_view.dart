import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../controllers/controllers.dart';
import '../../../../globals/strings/strings.dart' as s;

import '../../../../models/models.dart';
import '../../../ui.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({required this.categoryId});

  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 32.0,
      ),
      child: Consumer(
        builder: (context, watch, _) {
          final categoryName = watch(categoryNameProvider(categoryId));
          final categoryColor = watch(categoryColorProvider(categoryId));
          final categoryIcon = watch(categoryIconProvider(categoryId));
          final tasksController = watch(tasksProvider.notifier);
          final filteredTasks = watch(filteredTasksProvider(categoryId));
          var description = '';
          final activeTasksNumber =
              watch(activeTasksNumberProvider(categoryId));
          final progress = watch(progressProvider(categoryId));
          switch (activeTasksNumber) {
            case 0:
              description = '$activeTasksNumber ${s.taskPlural}';
              break;
            case 1:
              description = '$activeTasksNumber ${s.taskSingular}';
              break;
            default:
              description = '$activeTasksNumber ${s.taskPlural}';
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(
                    IconData(
                      categoryIcon,
                      fontFamily: 'AntIcons',
                      fontPackage: 'ant_icons',
                    ),
                    size: 42.0,
                    color: categoryColor,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 4.0,
                  top: 20.0,
                  right: 4.0,
                  bottom: 12.0,
                ),
                child: CategoryHeader(
                  title: categoryName,
                  description: description,
                  progress: progress,
                  color: categoryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: AddTaskField(
                  addTask: (value) {
                    final task = Task(name: value, categoryId: categoryId);
                    tasksController.add(task: task);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = filteredTasks[index];
                    return TaskItem(task: task);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
