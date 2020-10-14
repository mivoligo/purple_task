import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../globals/globals.dart';
import '../../ui.dart';

class AllTasksList extends StatelessWidget {
  final int categoryId;
  final ScrollController controller;
  final bool shrinkWrap;

  const AllTasksList({
    Key key,
    @required this.categoryId,
    @required this.controller,
    this.shrinkWrap = false,
  }) : super(key: key);

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
            SliverTaskListHeader(title: OVERDUE),
          SliverTasksList(
              list: taskViewModel.getOverdueTasksForCategory(categoryId)),
          if (taskViewModel.getTodaysTasksForCategory(categoryId).isNotEmpty)
            SliverTaskListHeader(title: TODAY),
          SliverTasksList(
              list: taskViewModel.getTodaysTasksForCategory(categoryId)),
          if (taskViewModel.getTomorrowsTasksForCategory(categoryId).isNotEmpty)
            SliverTaskListHeader(title: TOMORROW),
          SliverTasksList(
              list: taskViewModel.getTomorrowsTasksForCategory(categoryId)),
          if (taskViewModel.getFutureTasksForCategory(categoryId).isNotEmpty)
            SliverTaskListHeader(title: LATER),
          SliverTasksList(
              list: taskViewModel.getFutureTasksForCategory(categoryId)),
          if (taskViewModel
              .getTodayCompletedTasksForCategory(categoryId)
              .isNotEmpty)
            SliverTaskListHeader(title: COMPLETED_TODAY),
          SliverTasksList(
              list:
                  taskViewModel.getTodayCompletedTasksForCategory(categoryId)),
          if (taskViewModel
              .getYesterdayCompletedTasksForCategory(categoryId)
              .isNotEmpty)
            SliverTaskListHeader(title: COMPLETED_YESTERDAY),
          SliverTasksList(
              list: taskViewModel
                  .getYesterdayCompletedTasksForCategory(categoryId)),
          if (taskViewModel
              .getEarlierCompletedTasksForCategory(categoryId)
              .isNotEmpty)
            SliverTaskListHeader(title: COMPLETED_EARLIER),
          SliverTasksList(
              list: taskViewModel
                  .getEarlierCompletedTasksForCategory(categoryId)),
        ],
      ),
    );
  }
}
