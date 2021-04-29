import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../entities/entities.dart';
import '../../../globals/globals.dart';
import '../../../view_models/view_models.dart';
import '../../ui.dart';

class CategoryMenuWidget extends StatefulWidget {
  const CategoryMenuWidget({
    Key? key,
    required this.categoryIndex,
  }) : super(key: key);

  final int? categoryIndex;

  @override
  _CategoryMenuWidgetState createState() => _CategoryMenuWidgetState();
}

class _CategoryMenuWidgetState extends State<CategoryMenuWidget> {
  late TaskViewModel taskModel;
  late CategoryViewModel categoryModel;
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
        tooltip: showOptions,
        icon: Icon(
          AntIcons.menu,
          color: Colors.grey[700],
        ),
        offset: const Offset(0, 48),
        elevation: 4.0,
        onSelected: (dynamic item) => onItemSelected(context, item),
        itemBuilder: (context) {
          var menuList = <PopupMenuEntry<Object>>[];
          menuList.add(PopupMenuItem(
            child: Text(deleteCompleted),
            value: 1,
          ));
          menuList.add(PopupMenuItem(
            child: Text(deleteAllTasks),
            value: 2,
          ));
          menuList.add(PopupMenuDivider());
          menuList.add(PopupMenuItem(
            child: Text(deleteCategory),
            value: 3,
          ));
          menuList.add(PopupMenuDivider());
          menuList.add(PopupMenuItem(
            child: Text(changeName),
            value: 4,
          ));
          menuList.add(PopupMenuItem(
            child: Text(changeColor),
            value: 5,
          ));
          menuList.add(PopupMenuItem(
            child: Text(changeIcon),
            value: 6,
          ));

          return menuList;
        },
      ),
    );
  }

  void onItemSelected(BuildContext context, int item) {
    // get current color and icon here
    categoryModel.color = categoryModel.currentCategory!.color;
    categoryModel.icon = categoryModel.currentCategory!.icon;
    switch (item) {
      // delete completed tasks from category
      case 1:
        showDialog(
          context: context,
          builder: (context) => ConfirmationDialog(
            title: questionDeleteCompleted,
            content: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(infoDeleteCompleted),
            ),
            confirmationText: delete,
            confirmationColor: Colors.red,
            onConfirm: () => taskModel.deleteCompletedTasksForCategory(
                categoryModel.currentCategory!.id),
          ),
        );
        break;
      // delete all tasks from category
      case 2:
        showDialog(
          context: context,
          builder: (context) => ConfirmationDialog(
            title: questionDeleteAll,
            content: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(infoDeleteAll),
            ),
            confirmationText: delete,
            confirmationColor: Colors.red,
            onConfirm: () => taskModel
                .deleteAllTasksForCategory(categoryModel.currentCategory!.id),
          ),
        );
        break;
      // delete category
      case 3:
        showDialog(
          context: context,
          builder: (context) => ConfirmationDialog(
            title: questionDeleteCategory,
            content: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(infoDeleteCategory),
            ),
            confirmationText: delete,
            confirmationColor: Colors.red,
            onConfirm: () {
              // delete tasks with category id
              taskModel
                  .deleteAllTasksForCategory(categoryModel.currentCategory!.id);
              // delete category
              categoryModel.deleteCategory(widget.categoryIndex!);
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
            textController.text = categoryModel.currentCategory!.name;
            return ConfirmationDialog(
              title: questionChangeName,
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
              confirmationText: save,
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
              title: questionChangeColor,
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
              confirmationText: save,
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
              title: questionChangeIcon,
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
                            color: Color(categoryModel.currentCategory!.color),
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
              confirmationText: save,
              confirmationColor: Colors.green,
              onConfirm: updateCategoryIcon,
            );
          },
        );
        break;
    }
  }

  void updateCategoryName() {
    final _category = CategoryEntity(
      name: textController.text,
      color: categoryModel.currentCategory!.color,
      icon: categoryModel.currentCategory!.icon,
      id: categoryModel.currentCategory!.id,
    );
    categoryModel.updateCategory(widget.categoryIndex!, _category);
    categoryModel.currentCategory = _category;
  }

  void updateCategoryColor() {
    final _category = CategoryEntity(
      name: categoryModel.currentCategory!.name,
      color: categoryModel.color,
      icon: categoryModel.currentCategory!.icon,
      id: categoryModel.currentCategory!.id,
    );
    categoryModel.updateCategory(widget.categoryIndex!, _category);
    categoryModel.currentCategory = _category;
  }

  void updateCategoryIcon() {
    final _category = CategoryEntity(
      name: categoryModel.currentCategory!.name,
      color: categoryModel.currentCategory!.color,
      icon: categoryModel.icon,
      id: categoryModel.currentCategory!.id,
    );
    categoryModel.updateCategory(widget.categoryIndex!, _category);
    categoryModel.currentCategory = _category;
  }
}
