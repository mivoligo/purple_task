import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/strings/strings.dart' as s;
import '../../../../controllers/controllers.dart';
import '../../category/widgets/widgets.dart';

class UncategorizedTasks extends ConsumerWidget {
  const UncategorizedTasks({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final appHeight = MediaQuery.of(context).size.height;
    final listHeight = appHeight - 542;
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
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          s.noCategory,
                          style: CustomStyle.textStyleTaskFilter,
                        ),
                      ),
                      LimitedBox(
                        maxHeight: listHeight,
                        child: const AllTasks(
                          categoryId: -1,
                          shrinkWrap: true,
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
