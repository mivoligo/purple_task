import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/features/todos/providers/providers.dart';
import 'package:purple_task/features/todos/views/sliver_task_list_header.dart';
import 'package:purple_task/features/todos/views/sliver_tasks_list.dart';

class PlannedTasks extends StatefulWidget {
  const PlannedTasks({
    required this.categoryId,
    super.key,
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
    final tr = AppLocalizations.of(context);
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
              SliverTaskListHeader(title: tr.overdueTasksHeader),
            SliverTasksList(list: overdueTasks, isOrderFixed: true),
            if (todayTasks.isNotEmpty) SliverTaskListHeader(title: tr.today),
            SliverTasksList(list: todayTasks),
            if (tomorrowTasks.isNotEmpty)
              SliverTaskListHeader(title: tr.tomorrow),
            SliverTasksList(list: tomorrowTasks),
            if (futureTasks.isNotEmpty) SliverTaskListHeader(title: tr.later),
            SliverTasksList(list: futureTasks, isOrderFixed: true),
          ],
        );
      },
    );
  }
}
