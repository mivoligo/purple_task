import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../constants/strings/strings.dart' as s;
import '../../../controllers/controllers.dart';
import '../../../models/models.dart';

class TaskMenu extends StatelessWidget {
  const TaskMenu({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final categories = ref.watch(categoriesNotifierProvider);

        return MenuAnchor(
          consumeOutsideTap: true,
          menuChildren: [
            MenuItemButton(
              child: const Text(
                s.delete,
                style: CustomStyle.textStyleWarning, // todo style font size
              ),
              onPressed: () =>
                  ref.read(tasksNotifierProvider.notifier).remove(task: task),
            ),
            SubmenuButton(
              menuChildren: [
                ...categories
                    .where((element) => element.id != task.categoryId)
                    .map(
                      (e) => MenuItemButton(
                        leadingIcon: Icon(
                          IconData(
                            e.icon,
                            fontFamily: 'AntIcons',
                            fontPackage: 'ant_icons',
                          ),
                          // size: iconSize,
                          color: e.color,
                        ),
                        child: SizedBox(
                          width: 200,
                          child: Text(
                            e.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        onPressed: () {
                          ref
                              .read(tasksNotifierProvider.notifier)
                              .update(task: task.copyWith(categoryId: e.id));
                        },
                      ),
                    ),
                if (task.categoryId != -1)
                  MenuItemButton(
                    leadingIcon: const SizedBox(width: 24),
                    child: const Text(s.noCategory),
                    onPressed: () {
                      ref
                          .read(tasksNotifierProvider.notifier)
                          .update(task: task.copyWith(categoryId: -1));
                    },
                  ),
              ],
              child: const Text(s.changeCategory),
            ),
          ],
          builder: (context, controller, child) {
            return IconButton(
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              icon: const Icon(Icons.arrow_drop_down),
            );
          },
        );
      },
    );
  }
}
