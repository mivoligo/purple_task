import 'package:flutter/material.dart';
import '../../../models/task.dart';
import '../../../ui/widgets/task_item/task_item.dart';

class AllTasksList extends StatelessWidget {
  final List<Task> list;
  final ScrollController controller;

  const AllTasksList({
    Key key,
    @required this.list,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.separated(
        controller: controller,
        itemBuilder: (context, index) {
          Task task = list[index];
          return TaskItem(
            task: task,
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: list.length,
      ),
    );
  }
}
