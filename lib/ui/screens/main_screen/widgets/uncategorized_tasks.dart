import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/strings/strings.dart' as s;
import '../../../../providers/providers.dart';
import '../../category/widgets/widgets.dart';

class UncategorizedTasks extends ConsumerWidget {
  UncategorizedTasks({
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uncategorizedTasks = ref.watch(uncategorizedTasksProvider);
    return uncategorizedTasks.isNotEmpty
        ? Container(
            width: width,
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
                        maxHeight: height,
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
