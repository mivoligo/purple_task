import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/features/todos/providers/providers.dart';
import 'package:purple_task/features/todos/views/sliver_task_list_header.dart';
import 'package:purple_task/features/todos/views/sliver_tasks_list.dart';

class CompletedTasks extends StatefulWidget {
  const CompletedTasks({
    required this.categoryId,
    super.key,
  });

  final int categoryId;

  @override
  _CompletedTasksState createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
  late final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    return Scrollbar(
      controller: _scrollController,
      child: Consumer(
        builder: (context, ref, _) {
          final todayCompletedTasks = ref
              .watch(todayCompletedTasksInCategoryProvider(widget.categoryId));
          final yesterdayCompletedTasks = ref.watch(
            yesterdayCompletedTasksInCategoryProvider(widget.categoryId),
          );
          final pastCompletedTasks = ref
              .watch(pastCompletedTasksInCategoryProvider(widget.categoryId));
          return CustomScrollView(
            key: const PageStorageKey('completed tasks'),
            controller: _scrollController,
            slivers: [
              if (todayCompletedTasks.isNotEmpty)
                SliverTaskListHeader(title: tr.completedTodayTasksHeader),
              SliverTasksList(list: todayCompletedTasks, isOrderFixed: true),
              if (yesterdayCompletedTasks.isNotEmpty)
                SliverTaskListHeader(title: tr.completedYesterdayTasksHeader),
              SliverTasksList(
                list: yesterdayCompletedTasks,
                isOrderFixed: true,
              ),
              if (pastCompletedTasks.isNotEmpty)
                SliverTaskListHeader(title: tr.completedEarlierTasksHeader),
              SliverTasksList(list: pastCompletedTasks, isOrderFixed: true),
            ],
          );
        },
      ),
    );
  }
}
