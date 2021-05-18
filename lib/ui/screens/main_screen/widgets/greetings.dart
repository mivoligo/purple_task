import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/strings/strings.dart' as s;
import '../../../../controllers/controllers.dart';

class Greetings extends StatelessWidget {
  const Greetings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.greetings,
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(height: 8.0),
        Consumer(
          builder: (context, watch, child) {
            final tasksNumber = watch(allActiveTasksProvider);
            String text;
            switch (tasksNumber) {
              case 0:
                text = s.noTasksGreetings;
                break;
              case 1:
                text =
                    '${s.greetingsStart}$tasksNumber${s.greetingsEndSingular}';
                break;
              default:
                text = '${s.greetingsStart}$tasksNumber${s.greetingsEndPlural}';
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
