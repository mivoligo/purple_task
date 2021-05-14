import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../controllers/controllers.dart';
import '../../../../globals/strings/strings.dart' as s;
import '../../../widgets/task_list/sliver_tasks_list.dart';
import '../../../widgets/task_list/task_list.dart';

class AllTasks extends ConsumerWidget {
  const AllTasks({
    Key? key,
    required this.categoryId,
    required this.controller,
  }) : super(key: key);

  final int categoryId;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final todayCompletedTasks = watch(todayCompletedTasksProvider(categoryId));
    final yesterdayCompletedTasks =
        watch(yesterdayCompletedTasksProvider(categoryId));
    final pastCompletedTasks = watch(pastCompletedTasksProvider(categoryId));
    final noDueDateTasks = watch(noDueDateTasksProvider(categoryId));
    final overdueTasks = watch(overdueTasksProvider(categoryId));
    final todayTasks = watch(todayTasksProvider(categoryId));
    final tomorrowTasks = watch(tomorrowTasksProvider(categoryId));
    final futureTasks = watch(futureTasksProvider(categoryId));
    return Scrollbar(
      child: CustomScrollView(
        key: const PageStorageKey('all tasks'),
        controller: controller,
        slivers: [
          SliverTasksList(list: noDueDateTasks),
          if (overdueTasks.isNotEmpty)
            const SliverTaskListHeader(title: s.overdue),
          SliverTasksList(list: overdueTasks),
          if (todayTasks.isNotEmpty) const SliverTaskListHeader(title: s.today),
          SliverTasksList(list: todayTasks),
          if (tomorrowTasks.isNotEmpty)
            const SliverTaskListHeader(title: s.tomorrow),
          SliverTasksList(list: tomorrowTasks),
          if (futureTasks.isNotEmpty)
            const SliverTaskListHeader(title: s.later),
          SliverTasksList(list: futureTasks),
          if (todayCompletedTasks.isNotEmpty)
            const SliverTaskListHeader(title: s.completedToday),
          SliverTasksList(list: todayCompletedTasks),
          if (yesterdayCompletedTasks.isNotEmpty)
            const SliverTaskListHeader(title: s.completedYesterday),
          SliverTasksList(list: yesterdayCompletedTasks),
          if (pastCompletedTasks.isNotEmpty)
            const SliverTaskListHeader(title: s.completedEarlier),
          SliverTasksList(list: pastCompletedTasks),
        ],
      ),
    );
  }
}
