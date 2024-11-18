import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../constants/strings/strings.dart' as s;
import '../../../models/models.dart';
import '../../../providers/providers.dart';
import 'category_selector.dart';

class TaskOptions extends StatelessWidget {
  const TaskOptions({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return PopupMenuButton(
          tooltip: s.showOptions,
          onSelected: (item) {
            // remove task when clicked on the first item
            if (item as int == 0) {
              ref.read(tasksProvider.notifier).remove(task: task);
            }
          },
          itemBuilder: (context) {
            var menuList = <PopupMenuEntry<Object>>[];
            menuList.add(
              const PopupMenuItem(
                child: Center(
                  child: Text(
                    s.delete,
                    style: CustomStyle.textStyleWarning,
                    // textAlign: TextAlign.center,
                  ),
                ),
                value: 0,
              ),
            );

            menuList.add(const PopupMenuDivider());

            menuList.add(
              PopupMenuItem(
                enabled: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      s.changeCategory,
                      textAlign: TextAlign.center,
                      style: CustomStyle.textStyleLabelSmall,
                    ),
                    CategorySelector(task: task),
                  ],
                ),
                value: 1,
              ),
            );

            return menuList;
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_drop_down,
              size: 18,
            ),
          ),
        );
      },
    );
  }
}
