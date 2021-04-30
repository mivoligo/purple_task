import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple_task/globals/strings/strings.dart';

import '../../../view_models/view_models.dart';
import '../../ui.dart';

class CompletedTasksList extends StatelessWidget {
  const CompletedTasksList({
    Key? key,
    required this.categoryId,
    required this.controller,
    this.shrinkWrap = false,
  }) : super(key: key);

  final int? categoryId;
  final ScrollController? controller;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    return Scrollbar(
      child: CustomScrollView(
        key: PageStorageKey('completed tasks'),
        controller: controller,
        shrinkWrap: shrinkWrap,
        slivers: [
          if (taskViewModel
              .getTodayCompletedTasksForCategory(categoryId)
              .isNotEmpty)
            SliverTaskListHeader(title: completedToday),
          SliverTasksList(
              list:
                  taskViewModel.getTodayCompletedTasksForCategory(categoryId)),
          if (taskViewModel
              .getYesterdayCompletedTasksForCategory(categoryId)
              .isNotEmpty)
            SliverTaskListHeader(title: completedYesterday),
          SliverTasksList(
              list: taskViewModel
                  .getYesterdayCompletedTasksForCategory(categoryId)),
          if (taskViewModel
              .getEarlierCompletedTasksForCategory(categoryId)
              .isNotEmpty)
            SliverTaskListHeader(title: completedEarlier),
          SliverTasksList(
              list: taskViewModel
                  .getEarlierCompletedTasksForCategory(categoryId)),
        ],
      ),
    );
  }
}
