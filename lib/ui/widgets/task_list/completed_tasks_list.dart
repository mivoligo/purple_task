import 'package:flutter/material.dart';
import '../../../db_models/db_models.dart';
import '../../ui.dart';

class CompletedTasksList extends StatelessWidget {
  final List<Task> list;
  final ScrollController controller;

  const CompletedTasksList({
    Key key,
    @required this.list,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.separated(
        key: PageStorageKey('completed_tasks'),
        controller: controller,
        itemBuilder: (context, index) {
          Task task = list[index];
          return TaskItem(
            task: task,
          );
        },
        separatorBuilder: (context, index) => const Divider(height: 8.0),
        itemCount: list.length,
      ),
    );
  }
}
