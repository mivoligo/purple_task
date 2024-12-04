import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../constants/strings/strings.dart' as s;
import '../../../../../providers/providers.dart';
import '../../../../widgets/widgets.dart';

class AllTasks extends StatefulWidget {
  const AllTasks({
    required this.categoryId,
    this.shrinkWrap = false,
  });

  final int categoryId;
  final bool shrinkWrap;

  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
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
        final todayCompletedTasks =
            ref.watch(todayCompletedTasksInCategoryProvider(widget.categoryId));
        final yesterdayCompletedTasks = ref.watch(
          yesterdayCompletedTasksInCategoryProvider(widget.categoryId),
        );
        final pastCompletedTasks =
            ref.watch(pastCompletedTasksInCategoryProvider(widget.categoryId));
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
          key: const PageStorageKey('all tasks'),
          controller: _scrollController,
          shrinkWrap: widget.shrinkWrap,
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
            if (todayCompletedTasks.isNotEmpty)
              const SliverTaskListHeader(title: s.completedToday),
            SliverTasksList(list: todayCompletedTasks, isOrderFixed: true),
            if (yesterdayCompletedTasks.isNotEmpty)
              const SliverTaskListHeader(title: s.completedYesterday),
            SliverTasksList(list: yesterdayCompletedTasks, isOrderFixed: true),
            if (pastCompletedTasks.isNotEmpty)
              const SliverTaskListHeader(title: s.completedEarlier),
            SliverTasksList(list: pastCompletedTasks, isOrderFixed: true),
          ],
        );
      },
    );
  }
}
