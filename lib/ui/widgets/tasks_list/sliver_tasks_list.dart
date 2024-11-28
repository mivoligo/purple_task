import 'dart:ui';

import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import '../../../models/task.dart';
import '../task_item/task_item.dart';
import '../task_item/task_menu.dart';

class SliverTasksList extends StatelessWidget {
  const SliverTasksList({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<Task> list;

  @override
  Widget build(BuildContext context) {
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

    return SliverReorderableList(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final task = list[index];
        return Container(
          key: Key(index.toString()),
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
        print(newIndex);
      },
    );
  }
}
