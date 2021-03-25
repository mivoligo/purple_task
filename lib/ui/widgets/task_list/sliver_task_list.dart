import 'package:flutter/material.dart';
import '../../../db_models/db_models.dart';
import '../../ui.dart';

class SliverTasksList extends StatelessWidget {
  const SliverTasksList({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<Task> list;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final task = list[index];
          return TaskItem(
            task: task,
          );
        },
        childCount: list.length,
      ),
    );
  }
}
