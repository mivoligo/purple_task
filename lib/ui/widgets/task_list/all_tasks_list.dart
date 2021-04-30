import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple_task/globals/strings/strings.dart';

import '../../../view_models/view_models.dart';
import '../../ui.dart';

class AllTasksList extends StatelessWidget {
  const AllTasksList({
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
        key: PageStorageKey('all tasks'),
        controller: controller,
        shrinkWrap: shrinkWrap,
        slivers: [
          SliverTasksList(
              list: taskViewModel.getNoDueDateTasksForCategory(categoryId)),
          if (taskViewModel.getOverdueTasksForCategory(categoryId).isNotEmpty)
            SliverTaskListHeader(title: overdue),
          SliverTasksList(
              list: taskViewModel.getOverdueTasksForCategory(categoryId)),
          if (taskViewModel.getTodaysTasksForCategory(categoryId).isNotEmpty)
            SliverTaskListHeader(title: today),
          SliverTasksList(
              list: taskViewModel.getTodaysTasksForCategory(categoryId)),
          if (taskViewModel.getTomorrowsTasksForCategory(categoryId).isNotEmpty)
            SliverTaskListHeader(title: tomorrow),
          SliverTasksList(
              list: taskViewModel.getTomorrowsTasksForCategory(categoryId)),
          if (taskViewModel.getFutureTasksForCategory(categoryId).isNotEmpty)
            SliverTaskListHeader(title: later),
          SliverTasksList(
              list: taskViewModel.getFutureTasksForCategory(categoryId)),
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
