import 'package:flutter/material.dart';
import '../../../db_models/db_models.dart';
import '../../ui.dart';

class SliverTasksList extends StatelessWidget {
  final List<Task> list;

  const SliverTasksList({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          Task task = list[index];
          return TaskItem(
            task: task,
          );
        },
        childCount: list.length,
      ),
    );
  }
}
