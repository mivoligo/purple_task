import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/controllers.dart';
import '../../../globals/globals.dart' as g;
import '../../../globals/strings/strings.dart' as s;
import '../../../models/models.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    Key? key,
    required this.task,
    required this.onCategorySelected,
  }) : super(key: key);

  final Task task;
  final VoidCallback onCategorySelected;

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
              final updatedTask = task.copyWith(categoryId: item as int);
              context.read(tasksProvider.notifier).update(task: updatedTask);
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
                      Text(category.name),
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
                      style: g.CustomStyle.textStyleTaskName
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
                        Text(
                          currentCategory.name,
                          style: g.CustomStyle.textStyleTaskName
                              .copyWith(color: Theme.of(context).primaryColor),
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
