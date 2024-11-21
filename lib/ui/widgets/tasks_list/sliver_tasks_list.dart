import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../models/task.dart';
import '../task_item/task_item.dart';

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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  list[index].name,
                ),
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
          child: ReorderableDragStartListener(
            index: index,
            child: TaskItem(
              task: task,
            ),
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
