import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/globals/strings/strings.dart';
import 'package:to_do/models/category.dart';
import 'package:to_do/ui/view_models/category_view_model.dart';
import 'package:to_do/ui/view_models/task_view_model.dart';
import 'package:to_do/ui/widgets/color_selector.dart';
import 'package:to_do/ui/widgets/confirmation_dialog.dart';

class CategoryMenuWidget extends StatefulWidget {
  final VoidCallback onChangeIcon;
  final int categoryIndex;

  const CategoryMenuWidget({
    Key key,
    this.onChangeIcon,
//    @required this.categoryId,
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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    taskModel = Provider.of<TaskViewModel>(context, listen: false);
    categoryModel = Provider.of<CategoryViewModel>(context, listen: false);

    return PopupMenuButton(
      icon: Icon(AntIcons.menu),
      offset: Offset(0, 48),
      elevation: 4.0,
      onSelected: (item) => onItemSelected(context, item),
      itemBuilder: (context) {
        var list = List<PopupMenuEntry<Object>>();
        list.add(PopupMenuItem(
          child: Text(DELETE_COMPLETED),
          value: 1,
        ));
        list.add(PopupMenuItem(
          child: Text(DELETE_ALL_TASKS),
          value: 2,
        ));
        list.add(PopupMenuDivider());
        list.add(PopupMenuItem(
          child: Text(DELETE_CATEGORY),
          value: 3,
        ));
        list.add(PopupMenuDivider());
        list.add(PopupMenuItem(
          child: Text(CHANGE_NAME),
          value: 4,
        ));
        list.add(PopupMenuItem(
          child: Text(CHANGE_COLOR),
          value: 5,
        ));
        list.add(PopupMenuItem(
          child: Text(CHANGE_ICON),
          value: 6,
        ));

        return list;
      },
    );
  }

  void onItemSelected(context, item) {
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
              onConfirm: () {
                updateCategoryName();
              },
            );
          },
        );
        break;
      // change color of category
      case 5:
        showDialog(
          context: context,
          builder: (context) {
            categoryModel.color = categoryModel.currentCategory.color;

            return ConfirmationDialog(
              title: Q_CHANGE_COLOR,
              content: StatefulBuilder(
                builder: (context, setState) {
                  print('reb');
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
                        SizedBox(height: 16.0),
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
              onConfirm: () {
                updateCategoryColor();
              },
            );
          },
        );
        break;
      case 6:
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('title'),
          ),
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
}
