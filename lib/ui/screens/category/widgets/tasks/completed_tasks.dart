import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../controllers/controllers.dart';
import '../../../../../globals/strings/strings.dart' as s;
import '../../../../widgets/widgets.dart';

class CompletedTasks extends StatefulWidget {
  const CompletedTasks({
    required this.categoryId,
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
    return Scrollbar(
      child: Consumer(
        builder: (context, watch, _) {
          final todayCompletedTasks =
              watch(todayCompletedTasksProvider(widget.categoryId));
          final yesterdayCompletedTasks =
              watch(yesterdayCompletedTasksProvider(widget.categoryId));
          final pastCompletedTasks =
              watch(pastCompletedTasksProvider(widget.categoryId));
          return CustomScrollView(
            key: const PageStorageKey('completed tasks'),
            controller: _scrollController,
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
          );
        },
      ),
    );
  }
}
