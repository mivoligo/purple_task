import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ui.dart';
import '../../../db_models/db_models.dart';
import '../../../globals/globals.dart';

class CategorySelector extends StatelessWidget {
  final Task task;
  final VoidCallback onCategorySelected;

  const CategorySelector({
    Key key,
    @required this.task,
    @required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: PopupMenuButton(
        tooltip: CHANGE_CATEGORY,
        onSelected: (item) => onItemSelected(context, item),
        itemBuilder: (context) {
          var menuList = List<PopupMenuEntry<Object>>();
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
                  NO_CATEGORY,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: Theme.of(context).primaryColor),
                );
              }
              return Row(
                children: [
                  Icon(
                    IconData(
                      value.currentCategory.icon,
                      fontFamily: 'AntIcons',
                      fontPackage: 'ant_icons',
                    ),
                    color: Color(value.currentCategory.color),
                    size: 18,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    value.currentCategory.name,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
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

  onItemSelected(context, item) {
    task.categoryId = item;
    Provider.of<TaskViewModel>(context, listen: false)
        .updateTask(task.key, task);
    onCategorySelected();
  }
}
