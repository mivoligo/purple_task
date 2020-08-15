import 'package:flutter/material.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/ui/view_models/task_view_model.dart';
import 'package:to_do/ui/widgets/task_item.dart';

class CompletedTasks extends StatelessWidget {
  const CompletedTasks({
    Key key,
    @required this.taskModel,
    @required this.categoryId,
  }) : super(key: key);

  final TaskViewModel taskModel;
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        Task task = taskModel.completedTasksForCategory(categoryId)[index];
        return TaskItem(
          name: '${task.name}',
          isDone: task.isDone,
        );
      },
      separatorBuilder: (_, __) => Divider(),
      itemCount: taskModel.numberOfCompletedTasksForCategory(categoryId),
    );
  }
}
