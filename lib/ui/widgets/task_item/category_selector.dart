import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../constants/strings/strings.dart' as s;
import '../../../models/models.dart';
import '../../../providers/providers.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        final categories = watch(categoriesProvider).categories;

        return Card(
          elevation: 1,
          child: PopupMenuButton(
            tooltip: s.changeCategory,
            onSelected: (item) {
              final updatedTask = task.copyWith(
                dueDate: task.dueDate,
                categoryId: item as int,
              );
              context.read(tasksProvider.notifier).update(task: updatedTask);
              Navigator.of(context).pop();
            },
            itemBuilder: (context) {
              var menuList = <PopupMenuEntry<Object>>[];
              for (var category in categories) {
                menuList.add(PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(
                        IconData(
                          category.icon,
                          fontFamily: 'AntIcons',
                          fontPackage: 'ant_icons',
                        ),
                        color: category.color,
                      ),
                      const SizedBox(width: 8),
                      Flexible(child: Text(category.name)),
                    ],
                  ),
                  value: category.id,
                ));
              }
              return menuList;
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(
                builder: (context) {
                  if (task.categoryId == -1) {
                    return Text(
                      s.noCategory,
                      textAlign: TextAlign.center,
                      style: CustomStyle.textStyleTaskFilter
                          .copyWith(color: Theme.of(context).primaryColor),
                    );
                  } else {
                    final currentCategory = categories.firstWhere(
                        (category) => category.id == task.categoryId);
                    return Row(
                      children: [
                        Icon(
                          IconData(
                            currentCategory.icon,
                            fontFamily: 'AntIcons',
                            fontPackage: 'ant_icons',
                          ),
                          color: currentCategory.color,
                          size: 18,
                        ),
                        const SizedBox(width: 4.0),
                        Flexible(
                          child: Text(
                            currentCategory.name,
                            style: CustomStyle.textStyleTaskFilter.copyWith(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
