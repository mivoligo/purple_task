import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../globals/globals.dart';
import '../../../db_models/db_models.dart';
import '../../ui.dart';

class CategoryMenuWidget extends StatefulWidget {
  final int categoryIndex;

  const CategoryMenuWidget({
    Key key,
    @required this.categoryIndex,
  }) : super(key: key);

  @override
  _CategoryMenuWidgetState createState() => _CategoryMenuWidgetState();
}

class _CategoryMenuWidgetState extends State<CategoryMenuWidget> {
  TaskViewModel taskModel;
  CategoryViewModel categoryModel;
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    taskModel = Provider.of<TaskViewModel>(context, listen: false);
    categoryModel = Provider.of<CategoryViewModel>(context, listen: false);

    return Material(
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: PopupMenuButton(
        tooltip: SHOW_OPTIONS,
        icon: Icon(
          AntIcons.menu,
          color: Colors.grey[700],
        ),
        offset: const Offset(0, 48),
        elevation: 4.0,
        onSelected: (item) => onItemSelected(context, item),
        itemBuilder: (context) {
          var menuList = List<PopupMenuEntry<Object>>();
          menuList.add(PopupMenuItem(
            child: Text(DELETE_COMPLETED),
            value: 1,
          ));
          menuList.add(PopupMenuItem(
            child: Text(DELETE_ALL_TASKS),
            value: 2,
          ));
          menuList.add(PopupMenuDivider());
          menuList.add(PopupMenuItem(
            child: Text(DELETE_CATEGORY),
            value: 3,
          ));
          menuList.add(PopupMenuDivider());
          menuList.add(PopupMenuItem(
            child: Text(CHANGE_NAME),
            value: 4,
          ));
          menuList.add(PopupMenuItem(
            child: Text(CHANGE_COLOR),
            value: 5,
          ));
          menuList.add(PopupMenuItem(
            child: Text(CHANGE_ICON),
            value: 6,
          ));

          return menuList;
        },
      ),
    );
  }

  void onItemSelected(context, item) {
    // get current color and icon here
    categoryModel.color = categoryModel.currentCategory.color;
    categoryModel.icon = categoryModel.currentCategory.icon;
    switch (item) {
      // delete completed tasks from category
      case 1:
        showDialog(
          context: context,
          builder: (context) => ConfirmationDialog(
            title: Q_DELETE_COMPLETED,
            content: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(D_DELETE_COMPLETED),
            ),
            confirmationText: DELETE,
            confirmationColor: Colors.red,
            onConfirm: () => taskModel.deleteCompletedTasksForCategory(
                categoryModel.currentCategory.id),
          ),
        );
        break;
      // delete all tasks from category
      case 2:
        showDialog(
          context: context,
          builder: (context) => ConfirmationDialog(
            title: Q_DELETE_ALL,
            content: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(D_DELETE_ALL),
            ),
            confirmationText: DELETE,
            confirmationColor: Colors.red,
            onConfirm: () => taskModel
                .deleteAllTasksForCategory(categoryModel.currentCategory.id),
          ),
        );
        break;
      // delete category
      case 3:
        showDialog(
          context: context,
          builder: (context) => ConfirmationDialog(
            title: Q_DELETE_CATEGORY,
            content: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(D_DELETE_CATEGORY),
            ),
            confirmationText: DELETE,
            confirmationColor: Colors.red,
            onConfirm: () {
              // delete tasks with category id
              taskModel
                  .deleteAllTasksForCategory(categoryModel.currentCategory.id);
              // delete category
              categoryModel.deleteCategory(widget.categoryIndex);
              // pop category screen
              Navigator.of(context).pop();
            },
          ),
        );
        break;
      // change name of category
      case 4:
        showDialog(
          context: context,
          builder: (context) {
            textController.text = categoryModel.currentCategory.name;
            return ConfirmationDialog(
              title: Q_CHANGE_NAME,
              content: Padding(
                padding: const EdgeInsets.all(24.0),
                child: CupertinoTextField(
                  controller: textController,
                  autofocus: true,
                  style: Theme.of(context).textTheme.subtitle1,
                  onSubmitted: (v) {
                    updateCategoryName();
                    Navigator.of(context).pop();
                  },
                ),
              ),
              confirmationText: SAVE,
              confirmationColor: Colors.green,
              onConfirm: updateCategoryName,
            );
          },
        );
        break;
      // change color of category
      case 5:
        showDialog(
          context: context,
          builder: (context) {
            return ConfirmationDialog(
              title: Q_CHANGE_COLOR,
              content: StatefulBuilder(
                builder: (context, setState) {
                  return Container(
                    width: 500,
                    height: 100,
                    child: Column(
                      children: [
                        Consumer<CategoryViewModel>(
                          builder: (_, categoryModel, __) => Container(
                            height: 20,
                            color: Color(categoryModel.color),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Expanded(
                          child: Container(child: ColorSelector()),
                        ),
                      ],
                    ),
                  );
                },
              ),
              confirmationText: SAVE,
              confirmationColor: Colors.green,
              onConfirm: updateCategoryColor,
            );
          },
        );
        break;
      // change icon of category
      case 6:
        showDialog(
          context: context,
          builder: (context) {
            return ConfirmationDialog(
              title: Q_CHANGE_ICON,
              content: StatefulBuilder(
                builder: (context, setState) {
                  return Container(
                    width: 500,
                    height: 100,
                    child: Column(
                      children: [
                        Consumer<CategoryViewModel>(
                          builder: (_, categoryModel, __) => Icon(
                            IconData(
                              categoryModel.icon,
                              fontFamily: 'AntIcons',
                              fontPackage: 'ant_icons',
                            ),
                            color: Color(categoryModel.currentCategory.color),
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Expanded(
                          child: Container(child: IconSelector()),
                        ),
                      ],
                    ),
                  );
                },
              ),
              confirmationText: SAVE,
              confirmationColor: Colors.green,
              onConfirm: updateCategoryIcon,
            );
          },
        );
        break;
    }
  }

  void updateCategoryName() {
    Category _category = Category(
      name: textController.text,
      color: categoryModel.currentCategory.color,
      icon: categoryModel.currentCategory.icon,
      id: categoryModel.currentCategory.id,
    );
    categoryModel.updateCategory(widget.categoryIndex, _category);
    categoryModel.currentCategory = _category;
  }

  void updateCategoryColor() {
    Category _category = Category(
      name: categoryModel.currentCategory.name,
      color: categoryModel.color,
      icon: categoryModel.currentCategory.icon,
      id: categoryModel.currentCategory.id,
    );
    categoryModel.updateCategory(widget.categoryIndex, _category);
    categoryModel.currentCategory = _category;
  }

  void updateCategoryIcon() {
    Category _category = Category(
      name: categoryModel.currentCategory.name,
      color: categoryModel.currentCategory.color,
      icon: categoryModel.icon,
      id: categoryModel.currentCategory.id,
    );
    categoryModel.updateCategory(widget.categoryIndex, _category);
    categoryModel.currentCategory = _category;
  }
}
