import 'package:flutter/material.dart';
import '../../../entities/entities.dart';
import '../../ui.dart';

class SliverTasksList extends StatelessWidget {
  const SliverTasksList({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<TaskEntity> list;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final task = list[index];
          return TaskItemOld(
            task: task,
          );
        },
        childCount: list.length,
      ),
    );
  }
}
