import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../globals/globals.dart';
import '../../../view_models/view_models.dart';
import '../../ui.dart';

class PlannedTasksList extends StatelessWidget {
  const PlannedTasksList({
    Key? key,
    required this.categoryId,
    required this.controller,
  }) : super(key: key);

  final int? categoryId;
  final ScrollController? controller;

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
        ],
      ),
    );
  }
}
