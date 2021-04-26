import 'package:flutter/material.dart';
import '../../globals/globals.dart';
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
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Checkbox(
                value: task.isDone,
                onChanged: (_) {},
              ),
            ),
            Expanded(
              child: Text(
                task.name,
                style: CustomStyles.textStyleTaskName,
              ),
            ),
            CustomIconButton(
              icon: Icon(Icons.arrow_drop_down),
              color: Colors.transparent,
            )
          ],
        ),
        Container(
          height: 1,
          color: Colors.grey.shade300,
        ),
      ],
    );
  }
}
