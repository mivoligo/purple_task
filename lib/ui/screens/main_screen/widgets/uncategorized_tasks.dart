import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../controllers/controllers.dart';
import '../../../../globals/globals.dart';
import '../../../../globals/strings/strings.dart' as s;
import '../../../widgets/widgets.dart';

class UncategorizedTasks extends ConsumerWidget {
  const UncategorizedTasks({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final appHeight = MediaQuery.of(context).size.height;
    final listHeight = appHeight - 540;
    final uncategorizedTasks = watch(uncategorizedTasksProvider);
    return uncategorizedTasks.isNotEmpty
        ? Container(
            width: 400,
            decoration: CustomStyle.uncategorizedTasksDecoration,
            child: Row(
              children: [
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    children: [
                      const Text(s.noCategory),
                      LimitedBox(
                        maxHeight: listHeight,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: uncategorizedTasks.length,
                          itemBuilder: (context, index) {
                            final task = uncategorizedTasks[index];
                            return TaskItem(task: task);
                          },
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
                const SizedBox(width: 10.0),
              ],
            ),
          )
        : const SizedBox();
  }
}
