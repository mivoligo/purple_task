import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../globals/globals.dart';
import '../../ui.dart';

class PlannedTasksList extends StatelessWidget {
  final int categoryId;
  final ScrollController controller;

  const PlannedTasksList({
    Key key,
    @required this.categoryId,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    return Scrollbar(
      child: CustomScrollView(
        key: PageStorageKey('planned tasks'),
        controller: controller,
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
        ],
      ),
    );
  }
}
