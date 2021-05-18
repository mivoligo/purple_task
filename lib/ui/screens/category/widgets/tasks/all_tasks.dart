import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../constants/strings/strings.dart' as s;
import '../../../../../controllers/controllers.dart';
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
    return Scrollbar(
      child: Consumer(
        builder: (context, watch, _) {
          final todayCompletedTasks =
              watch(todayCompletedTasksProvider(widget.categoryId));
          final yesterdayCompletedTasks =
              watch(yesterdayCompletedTasksProvider(widget.categoryId));
          final pastCompletedTasks =
              watch(pastCompletedTasksProvider(widget.categoryId));
          final noDueDateTasks =
              watch(noDueDateTasksProvider(widget.categoryId));
          final overdueTasks = watch(overdueTasksProvider(widget.categoryId));
          final todayTasks = watch(todayTasksProvider(widget.categoryId));
          final tomorrowTasks = watch(tomorrowTasksProvider(widget.categoryId));
          final futureTasks = watch(futureTasksProvider(widget.categoryId));
          return CustomScrollView(
            key: const PageStorageKey('all tasks'),
            controller: _scrollController,
            shrinkWrap: widget.shrinkWrap,
            slivers: [
              SliverTasksList(list: noDueDateTasks),
              if (overdueTasks.isNotEmpty)
                const SliverTaskListHeader(title: s.overdue),
              SliverTasksList(list: overdueTasks),
              if (todayTasks.isNotEmpty)
                const SliverTaskListHeader(title: s.today),
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
          );
        },
      ),
    );
  }
}
