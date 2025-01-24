import 'dart:ui';

import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/features/todos/controllers/tasks_controller.dart';
import 'package:purple_task/features/todos/models/task.dart';
import 'package:purple_task/features/todos/views/task_item.dart';
import 'package:purple_task/features/todos/views/task_menu.dart';

class SliverTasksList extends ConsumerWidget {
  const SliverTasksList({
    required this.list,
    super.key,
    this.isOrderFixed = false,
  });

  final List<Task> list;
  final bool isOrderFixed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget proxyDecorator(
      Widget child,
      int index,
      Animation<double> animation,
    ) {
      return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          final animValue = Curves.easeInOut.transform(animation.value);
          final elevation = lerpDouble(1, 6, animValue);
          final scale = lerpDouble(1, 1.02, animValue);
          return Transform.scale(
            scale: scale,
            child: Card(
              elevation: elevation,
              shape: const RoundedRectangleBorder(),
              child: Row(
                children: [
                  Expanded(child: TaskItem(task: list[index])),
                  const Icon(AntIcons.menu, size: 16),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          );
        },
      );
    }

    if (isOrderFixed) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final task = list[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Expanded(child: TaskItem(task: task)),
                  TaskMenu(task: task),
                ],
              ),
            );
          },
          childCount: list.length,
        ),
      );
    }

    return SliverReorderableList(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final task = list[index];
        return Container(
          key: Key(index.toString()),
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Expanded(child: TaskItem(task: task)),
              ReorderableDragStartListener(
                index: index,
                child: TaskMenu(task: task),
              ),
            ],
          ),
        );
      },
      proxyDecorator: proxyDecorator,
      onReorder: (oldIndex, newIndex) {
        final currentItem = list[oldIndex];
        final affectedTasksList = <Task>[];

        if (oldIndex < newIndex) {
          newIndex -= 1;
          if (oldIndex == newIndex) {
            // TODOdo sprawdzenia
            return;
          }
          affectedTasksList.addAll(
            list.sublist(oldIndex, newIndex + 1).where(
                  (element) => element != currentItem,
                ),
          );
        } else {
          affectedTasksList.addAll(
            list.sublist(newIndex, oldIndex + 1).where(
                  (element) => element != currentItem,
                ),
          );
        }

        ref.read(tasksNotifierProvider.notifier).reorder(
          affectedTasksList: [
            currentItem,
            ...affectedTasksList,
          ],
          indexIncrease: oldIndex < newIndex,
        );
      },
    );
  }
}
