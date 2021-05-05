import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../controllers/controllers.dart';
import '../../../../globals/strings/strings.dart' as s;

import '../../../../models/models.dart';
import '../../../ui.dart';

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
      child: Column(
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
            child: Consumer(
              builder: (context, watch, child) {
                final state = watch(categoryCardProvider(category.id));
                var description = '';
                final activeTasksNumber = state.activeTasksNumber;
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
                return CategoryHeader(
                  title: category.name,
                  description: description,
                  progress: state.progress,
                  color: category.color,
                );
              },
            ),
          ),
          AddTaskField(addTask: (_) {}),
          Expanded(child: Consumer(
            builder: (context, watch, child) {
              final taskProvider = watch(filteredTasksProvider(category.id));
              return ListView.builder(
                itemCount: taskProvider.length,
                itemBuilder: (context, index) {
                  final task = taskProvider[index];
                  return Text('${task.name}');
                },
              );
            },
          ))
        ],
      ),
    );
  }
}
