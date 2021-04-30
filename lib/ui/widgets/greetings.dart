import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple_task/globals/strings/strings.dart';

import '../../view_models/view_models.dart';

class Greetings extends StatelessWidget {
  const Greetings({
    Key? key,
    required this.greetings,
  }) : super(key: key);

  final String greetings;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greetings,
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(height: 8.0),
        Consumer<TaskViewModel>(
          builder: (_, model, __) {
            final numberOfTasks = model.numberOfAllPlannedTasks();
            String text;
            switch (numberOfTasks) {
              case 0:
                text = noTasksGreetings;
                break;
              case 1:
                text = '$greetingsStart $numberOfTasks $greetingsEndSingular';
                break;
              default:
                text = '$greetingsStart $numberOfTasks $greetingsEndPlural';
            }
            return Text(
              text,
              style: Theme.of(context).textTheme.headline6,
            );
          },
        ),
      ],
    );
  }
}
