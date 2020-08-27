import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/globals/strings/strings.dart';
import 'package:to_do/models/category.dart';
import 'package:to_do/ui/view_models/category_view_model.dart';
import 'package:to_do/ui/view_models/task_view_model.dart';
import 'package:to_do/ui/widgets/confirmation_dialog.dart';

class CategoryMenuWidget extends StatefulWidget {
  final VoidCallback onChangeColor;
  final VoidCallback onChangeIcon;
  final int categoryIndex;

  const CategoryMenuWidget({
    Key key,
    this.onChangeColor,
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
      case 1:
        showDialog(
          context: context,
          builder: (context) => ConfirmationDialog(
            title: Q_DELETE_COMPLETED,
            content: Text(D_DELETE_COMPLETED),
            confirmationText: DELETE,
            confirmationColor: Colors.red,
            onConfirm: () => taskModel.deleteCompletedTasksForCategory(
                categoryModel.currentCategory.id),
          ),
        );
        break;
      case 2:
        showDialog(
          context: context,
          builder: (context) => ConfirmationDialog(
            title: Q_DELETE_ALL,
            content: Text(D_DELETE_ALL),
            confirmationText: DELETE,
            confirmationColor: Colors.red,
            onConfirm: () => taskModel
                .deleteAllTasksForCategory(categoryModel.currentCategory.id),
          ),
        );
        break;
      case 3:
        showDialog(
          context: context,
          builder: (context) => ConfirmationDialog(
            title: Q_DELETE_CATEGORY,
            content: Text(D_DELETE_CATEGORY),
            confirmationText: DELETE,
            confirmationColor: Colors.red,
            onConfirm: () {
              taskModel
                  .deleteAllTasksForCategory(categoryModel.currentCategory.id);
              categoryModel.deleteCategory(widget.categoryIndex);
              Navigator.of(context).pop();
            },
          ),
        );
        break;
      case 4:
        showDialog(
          context: context,
          builder: (context) {
            textController.text = categoryModel.currentCategory.name;
            return ConfirmationDialog(
              title: Q_CHANGE_NAME,
              content: CupertinoTextField(
                controller: textController,
                autofocus: true,
                style: Theme.of(context).textTheme.subtitle1,
                onSubmitted: (v) {
                  updateCategoryName();
                  Navigator.of(context).pop();
                },
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
      case 5:
        return widget.onChangeColor();
        break;
      case 6:
        return widget.onChangeIcon();
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
}
