import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../entities/entities.dart';
import '../../../globals/globals.dart';
import '../../../view_models/view_models.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    Key? key,
    required this.task,
    required this.onCategorySelected,
  }) : super(key: key);

  final TaskEntity task;
  final VoidCallback onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: PopupMenuButton(
        tooltip: changeCategory,
        onSelected: (dynamic item) => onItemSelected(context, item),
        itemBuilder: (context) {
          var menuList = <PopupMenuEntry<Object>>[];
          final categoryList =
              Provider.of<CategoryViewModel>(context, listen: false)
                  .getListOfCategories();
          for (var category in categoryList) {
            menuList.add(PopupMenuItem(
              child: Row(
                children: [
                  Icon(
                    IconData(
                      category.icon,
                      fontFamily: 'AntIcons',
                      fontPackage: 'ant_icons',
                    ),
                    color: Color(category.color),
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
          child: Consumer<CategoryViewModel>(
            builder: (context, value, child) {
              if (task.categoryId == -1) {
                return Text(
                  noCategory,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Theme.of(context).primaryColor),
                );
              }
              return Row(
                children: [
                  Icon(
                    IconData(
                      value.currentCategory!.icon,
                      fontFamily: 'AntIcons',
                      fontPackage: 'ant_icons',
                    ),
                    color: Color(value.currentCategory!.color),
                    size: 18,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    value.currentCategory!.name,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void onItemSelected(BuildContext context, int item) {
    task.categoryId = item;
    Provider.of<TaskViewModel>(context, listen: false)
        .updateTask(task.key, task);
    onCategorySelected();
  }
}
