import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../globals/globals.dart';
import '../ui.dart';

class Greetings extends StatelessWidget {
  final String greetings;

  const Greetings({
    Key? key,
    required this.greetings,
  }) : super(key: key);

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
            int numberOfTasks = model.numberOfAllPlannedTasks();
            String text;
            switch (numberOfTasks) {
              case 0:
                text = NO_TASKS_GREETINGS;
                break;
              case 1:
                text =
                    '$GREETINGS_START $numberOfTasks $GREETINGS_END_SINGULAR';
                break;
              default:
                text = '$GREETINGS_START $numberOfTasks $GREETINGS_END_PLURAL';
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
