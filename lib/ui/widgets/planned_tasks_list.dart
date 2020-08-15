import 'package:flutter/material.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/ui/view_models/task_view_model.dart';
import 'package:to_do/ui/widgets/task_item.dart';

class PlannedTasks extends StatelessWidget {
  const PlannedTasks({
    Key key,
    @required this.taskModel,
  }) : super(key: key);

  final TaskViewModel taskModel;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        Task task = taskModel.tasksListPlanned[index];
        return TaskItem(
          name: task.name,
          isDone: task.isDone,
        );
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: taskModel.tasksListPlanned.length,
    );
  }
}
