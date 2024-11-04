import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/strings/strings.dart' as s;
import '../../../../providers/providers.dart';

class Greetings extends StatelessWidget {
  const Greetings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.greetings,
          style: CustomStyle.textStyle24.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
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
              style: CustomStyle.textStyleTitle.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            );
          },
        ),
      ],
    );
  }
}
