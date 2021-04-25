import 'package:flutter/material.dart';
import '../../ui/ui.dart';
import '../data/models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: task.isDone,
              onChanged: (_) {},
            ),
            Expanded(child: Text(task.name)),
            CustomIconButton(icon: Icon(Icons.arrow_drop_down))
          ],
        ),
        Container(
          height: 1,
          color: Colors.grey,
        )
      ],
    );
  }
}
