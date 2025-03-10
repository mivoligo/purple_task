import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/constants/custom_styles.dart';
import 'package:purple_task/features/todos/providers/providers.dart';

class Greetings extends StatelessWidget {
  const Greetings({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr.greetings,
          style: CustomStyle.textStyle24.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 8),
        Consumer(
          builder: (context, ref, child) {
            final tasksNumber = ref.watch(numberOfAllActiveTasksProvider);

            return Text(
              tr.totalTasksInfo(tasksNumber),
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
