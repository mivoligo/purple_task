import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/strings/strings.dart' as s;
import '../../providers/providers.dart';
import 'sliver_task_list_header.dart';
import 'sliver_tasks_list.dart';

class PlannedTasks extends StatefulWidget {
  const PlannedTasks({
    required this.categoryId,
  });

  final int categoryId;

  @override
  _PlannedTasksState createState() => _PlannedTasksState();
}

class _PlannedTasksState extends State<PlannedTasks> {
  late final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final noDueDateTasks =
            ref.watch(noDueDateTasksInCategoryProvider(widget.categoryId));
        final overdueTasks =
            ref.watch(overdueTasksInCategoryProvider(widget.categoryId));
        final todayTasks =
            ref.watch(todayTasksInCategoryProvider(widget.categoryId));
        final tomorrowTasks =
            ref.watch(tomorrowTasksInCategoryProvider(widget.categoryId));
        final futureTasks =
            ref.watch(futureTasksInCategoryProvider(widget.categoryId));
        return CustomScrollView(
          key: const PageStorageKey('planned tasks'),
          controller: _scrollController,
          slivers: [
            SliverTasksList(list: noDueDateTasks),
            if (overdueTasks.isNotEmpty)
              const SliverTaskListHeader(title: s.overdue),
            SliverTasksList(list: overdueTasks, isOrderFixed: true),
            if (todayTasks.isNotEmpty)
              const SliverTaskListHeader(title: s.today),
            SliverTasksList(list: todayTasks),
            if (tomorrowTasks.isNotEmpty)
              const SliverTaskListHeader(title: s.tomorrow),
            SliverTasksList(list: tomorrowTasks),
            if (futureTasks.isNotEmpty)
              const SliverTaskListHeader(title: s.later),
            SliverTasksList(list: futureTasks, isOrderFixed: true),
          ],
        );
      },
    );
  }
}
