import 'package:flutter/material.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/ui/widgets/task_item.dart';

class TasksList extends StatelessWidget {
  final List<Task> list;

  const TasksList({
    Key key,
    @required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        Task task = list[index];
        return TaskItem(
          task: task,
        );
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: list.length,
    );
  }
}
