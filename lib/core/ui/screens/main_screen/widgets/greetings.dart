import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/constants/custom_styles.dart';
import 'package:purple_task/core/constants/strings/strings.dart' as s;
import 'package:purple_task/features/todos/providers/providers.dart';

class Greetings extends StatelessWidget {
  const Greetings({super.key});

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
        const SizedBox(height: 8),
        Consumer(
          builder: (context, ref, child) {
            final tasksNumber = ref.watch(numberOfAllActiveTasksProvider);
            final text = switch (tasksNumber) {
              0 => s.noTasksGreetings,
              1 => '${s.greetingsStart}$tasksNumber${s.greetingsEndSingular}',
              _ => '${s.greetingsStart}$tasksNumber${s.greetingsEndPlural}',
            };
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
