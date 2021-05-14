import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../controllers/controllers.dart';
import '../../../../globals/strings/strings.dart' as s;
import '../../../widgets/task_list/sliver_tasks_list.dart';
import '../../../widgets/task_list/task_list.dart';

class CompletedTasks extends ConsumerWidget {
  const CompletedTasks({
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

    return Scrollbar(
      child: CustomScrollView(
        key: const PageStorageKey('planned tasks'),
        controller: controller,
        slivers: [
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
