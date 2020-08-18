import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/ui/view_models/task_view_model.dart';
import 'package:to_do/ui/widgets/task_item.dart';

class AllTasks extends StatelessWidget {
  final int categoryId;

  const AllTasks({
    Key key,
    @required this.categoryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskViewModel taskModel =
        Provider.of<TaskViewModel>(context, listen: false);
    return ListView.separated(
      itemBuilder: (context, index) {
        Task task = taskModel.getAllTasksForCategory(categoryId)[index];
        return TaskItem(
          task: task,
        );
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: taskModel.getAllTasksForCategory(categoryId).length,
    );
  }
}
