import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ui.dart';
import '../../../db_models/db_models.dart';
import '../../../globals/globals.dart';

class CategorySelector extends StatelessWidget {
  final Task task;

  const CategorySelector({
    Key key,
    @required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: PopupMenuButton(
        tooltip: CHANGE_CATEGORY,
        onSelected: (item) => onItemSelected(context, item),
        itemBuilder: (context) {
          var list = List<PopupMenuEntry<Object>>();
          final categoryList =
              Provider.of<CategoryViewModel>(context, listen: false)
                  .getListOfCategories();
          for (var category in categoryList) {
            list.add(PopupMenuItem(
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
          return list;
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<CategoryViewModel>(
            builder: (context, value, child) {
              return Text(
                value.currentCategory.name,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: Theme.of(context).primaryColor),
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
  }
}
