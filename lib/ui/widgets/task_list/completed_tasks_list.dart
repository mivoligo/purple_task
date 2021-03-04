import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../globals/globals.dart';
import '../../ui.dart';

class CompletedTasksList extends StatelessWidget {
  final int categoryId;
  final ScrollController controller;
  final bool shrinkWrap;

  const CompletedTasksList({
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
        key: PageStorageKey('completed tasks'),
        controller: controller,
        shrinkWrap: shrinkWrap,
        slivers: [
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
