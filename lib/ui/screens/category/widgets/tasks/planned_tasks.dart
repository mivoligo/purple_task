import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../constants/strings/strings.dart' as s;
import '../../../../../controllers/controllers.dart';
import '../../../../widgets/widgets.dart';

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
    return Scrollbar(
      child: Consumer(
        builder: (context, watch, _) {
          final noDueDateTasks =
              watch(noDueDateTasksProvider(widget.categoryId));
          final overdueTasks = watch(overdueTasksProvider(widget.categoryId));
          final todayTasks = watch(todayTasksProvider(widget.categoryId));
          final tomorrowTasks = watch(tomorrowTasksProvider(widget.categoryId));
          final futureTasks = watch(futureTasksProvider(widget.categoryId));
          return CustomScrollView(
            key: const PageStorageKey('planned tasks'),
            controller: _scrollController,
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
            ],
          );
        },
      ),
    );
  }
}
