import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../globals/globals.dart';
import '../../ui/widgets/widgets.dart';
import '../bloc/category_cubit.dart';

class CategoryMenu extends StatefulWidget {
  const CategoryMenu();

  @override
  _CategoryMenuState createState() => _CategoryMenuState();
}

class _CategoryMenuState extends State<CategoryMenu> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
    // categoryModel.color = categoryModel.currentCategory!.color;
    // categoryModel.icon = categoryModel.currentCategory!.icon;
    final categoryCubit = context.read<CategoryCubit>();
    switch (item) {
      // delete completed tasks from category
      case 1:
        showDialog(
          context: context,
          builder: (_) => ConfirmationDialog(
            title: questionDeleteCompleted,
            content: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(infoDeleteCompleted),
            ),
            confirmationText: delete,
            confirmationColor: Colors.red,
            onConfirm: () {},
          ),
        );
        break;
      // delete all tasks from category
      case 2:
        showDialog(
          context: context,
          builder: (_) => ConfirmationDialog(
            title: questionDeleteAll,
            content: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(infoDeleteAll),
            ),
            confirmationText: delete,
            confirmationColor: Colors.red,
            onConfirm: () {},
          ),
        );
        break;
      // delete category
      case 3:
        showDialog(
          context: context,
          builder: (_) => ConfirmationDialog(
            title: questionDeleteCategory,
            content: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(infoDeleteCategory),
            ),
            confirmationText: delete,
            confirmationColor: Colors.red,
            onConfirm: () {
              // delete tasks with category id

              // delete category
              categoryCubit.removeCategory();

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
            textController.text = categoryCubit.state.category?.name ?? '';
            return ConfirmationDialog(
              title: questionChangeName,
              content: Padding(
                padding: const EdgeInsets.all(24.0),
                child: CupertinoTextField(
                  controller: textController,
                  autofocus: true,
                  style: Theme.of(context).textTheme.subtitle1,
                  onChanged: (value) => categoryCubit.updateName(name: value),
                  onSubmitted: (v) {
                    categoryCubit.updateCategory();
                    Navigator.of(context).pop();
                  },
                ),
              ),
              confirmationText: save,
              confirmationColor: Colors.green,
              onConfirm: () => _updateCategory(context,
                  categoryCubit.state.status == CategoryStatus.editing),
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
                        Container(
                          height: 20,
                          color: Colors.blueGrey,
                        ),
                        const SizedBox(height: 16.0),
                        Expanded(
                          child: Container(child: ColourSelector()),
                        ),
                      ],
                    ),
                  );
                },
              ),
              confirmationText: save,
              confirmationColor: Colors.green,
              onConfirm: () => _updateCategory(context,
                  categoryCubit.state.status == CategoryStatus.editing),
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
                        Icon(
                          // IconData(
                          //   categoryModel.icon,
                          //   fontFamily: 'AntIcons',
                          //   fontPackage: 'ant_icons',
                          // ),
                          Icons.animation,
                          color: Colors.blueGrey,
                          size: 28,
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
              onConfirm: () => _updateCategory(context,
                  categoryCubit.state.status == CategoryStatus.editing),
            );
          },
        );
        break;
    }
  }

  void _updateCategory(BuildContext context, bool isSubmitting) {
    if (!isSubmitting) {
      context.read<CategoryCubit>().updateCategory();
    }
  }

  void updateCategoryColor() {}

  void updateCategoryIcon() {}
}
