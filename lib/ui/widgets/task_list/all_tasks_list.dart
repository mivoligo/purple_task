import 'package:flutter/material.dart';
import '../../../db_models/db_models.dart';
import '../../ui.dart';

class AllTasksList extends StatelessWidget {
  final List<Task> list;
  final ScrollController controller;
  final bool shrinkWrap;

  const AllTasksList({
    Key key,
    @required this.list,
    @required this.controller,
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.separated(
        key: PageStorageKey('all_tasks'),
        shrinkWrap: shrinkWrap,
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
