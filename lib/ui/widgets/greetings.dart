import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/ui/view_models/task_view_model.dart';

class Greetings extends StatelessWidget {
  final String greetings;
  final double topDistance;
  final double distance;

  const Greetings({
    Key key,
    this.greetings,
    this.topDistance = 0.0,
    this.distance = 32.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: topDistance),
        CircleAvatar(
          backgroundColor: Colors.grey,
        ),
        SizedBox(height: distance),
        Text(
          greetings,
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        SizedBox(height: 8.0),
        Consumer<TaskViewModel>(
          builder: (_, model, __) => Text(
            'You have ${model.numberOfAllPlannedTasks()} task to do',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
