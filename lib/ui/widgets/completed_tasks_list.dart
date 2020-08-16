import 'package:flutter/material.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/ui/view_models/task_view_model.dart';
import 'package:to_do/ui/widgets/task_item.dart';

class CompletedTasks extends StatelessWidget {
  const CompletedTasks({
    Key key,
    @required this.taskModel,
  }) : super(key: key);

  final TaskViewModel taskModel;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        Task task = taskModel.tasksListCompleted[index];
        return TaskItem(
          task: task,
        );
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: taskModel.tasksListCompleted.length,
    );
  }
}