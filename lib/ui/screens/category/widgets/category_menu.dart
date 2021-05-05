import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../controllers/controllers.dart';
import '../../../../globals/strings/strings.dart' as s;
import '../../../../models/models.dart';
import '../../../widgets/category/confirmation_dialog.dart';
import '../../../widgets/color_selector.dart';
import '../../../widgets/icon_selector.dart';

class CategoryMenu extends StatefulWidget {
  const CategoryMenu({required this.category});

  final Category category;

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
        tooltip: s.showOptions,
        icon: Icon(
          AntIcons.menu,
          color: Colors.grey[700],
        ),
        offset: const Offset(0, 48),
        elevation: 4.0,
        onSelected: (dynamic item) => onItemSelected(context, item),
        itemBuilder: (context) {
          var menuList = <PopupMenuEntry<Object>>[];
          menuList.add(const PopupMenuItem(
            child: Text(s.deleteCompleted),
            value: 1,
          ));
          menuList.add(const PopupMenuItem(
            child: Text(s.deleteAllTasks),
            value: 2,
          ));
          menuList.add(const PopupMenuDivider());
          menuList.add(const PopupMenuItem(
            child: Text(s.deleteCategory),
            value: 3,
          ));
          menuList.add(const PopupMenuDivider());
          menuList.add(const PopupMenuItem(
            child: Text(s.changeName),
            value: 4,
          ));
          menuList.add(const PopupMenuItem(
            child: Text(s.changeColor),
            value: 5,
          ));
          menuList.add(const PopupMenuItem(
            child: Text(s.changeIcon),
            value: 6,
          ));

          return menuList;
        },
      ),
    );
  }

  void onItemSelected(BuildContext context, int item) {
    // final categoryCubit = context.read<CategoryCubit>();
    // final taskListCubit = context.read<TaskListCubit>();
    // final oldName = categoryCubit.state.category!.name;
    // final oldColor = categoryCubit.state.category!.color;
    // final oldIcon = categoryCubit.state.category!.icon;

    switch (item) {
      // delete completed tasks from category
      case 1:
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ConfirmationDialog(
            title: s.questionDeleteCompleted,
            content: const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(s.infoDeleteCompleted),
            ),
            confirmationText: s.delete,
            confirmationColor: Colors.red,
            onConfirm: () {
              context
                  .read(tasksProvider.notifier)
                  .removeCompletedTasksForCategory(
                      categoryId: widget.category.id);
              Navigator.of(context).pop();
            },
            onCancel: () => Navigator.of(context).pop(),
          ),
        );
        break;
      // delete all tasks from category
      case 2:
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ConfirmationDialog(
            title: s.questionDeleteAll,
            content: const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(s.infoDeleteAll),
            ),
            confirmationText: s.delete,
            confirmationColor: Colors.red,
            onConfirm: () {
              context
                  .read(tasksProvider.notifier)
                  .removeAllTasksForCategory(categoryId: widget.category.id);
              Navigator.of(context).pop();
            },
            onCancel: () => Navigator.of(context).pop(),
          ),
        );
        break;
      // delete category
      case 3:
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ConfirmationDialog(
            title: s.questionDeleteCategory,
            content: const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(s.infoDeleteCategory),
            ),
            confirmationText: s.delete,
            confirmationColor: Colors.red,
            onConfirm: () {
              // delete tasks with category id
              context
                  .read(tasksProvider.notifier)
                  .removeAllTasksForCategory(categoryId: widget.category.id);
              context
                  .read(categoriesProvider.notifier)
                  .remove(category: widget.category);
              // pop category screen
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            onCancel: () => Navigator.of(context).pop(),
          ),
        );
        break;
      // change name of category
      case 4:
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            textController.text = widget.category.name;
            return ConfirmationDialog(
              title: s.questionChangeName,
              content: Padding(
                padding: const EdgeInsets.all(24.0),
                child: CupertinoTextField(
                  controller: textController,
                  autofocus: true,
                  style: Theme.of(context).textTheme.subtitle1,
                  onChanged: (value) {
                    // return categoryCubit.nameChanged(name: value);
                  },
                  onSubmitted: (v) {
                    // _updateCategory(context,
                    //     categoryCubit.state.status == CategoryStatus.editing);
                    // Navigator.of(context).pop();
                  },
                ),
              ),
              confirmationText: s.save,
              onConfirm: () {
                // _updateCategory(context,
                //     categoryCubit.state.status == CategoryStatus.editing);
                // Navigator.of(context).pop();
              },
              onCancel: () {
                // categoryCubit.nameChanged(name: oldName);
                // Navigator.of(context).pop();
              },
            );
          },
        );
        break;
      // change color of category
      case 5:
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return ConfirmationDialog(
                title: s.questionChangeColor,
                content: SizedBox(
                  width: 500,
                  height: 200,
                  child: Column(
                    children: [
                      Container(
                        height: 20,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16.0),
                      Expanded(
                        child: ColorSelector(
                          selectedColor: Colors.grey,
                          isInCreator: false,
                        ),
                      ),
                    ],
                  ),
                ),
                confirmationText: s.save,
                onConfirm: () {
                  // return _updateCategory(context,
                  //   categoryCubit.state.status == CategoryStatus.editing);
                },
                onCancel: () {
                  // categoryCubit.colorChanged(color: oldColor);
                  // Navigator.of(context).pop();
                });
          },
        );
        break;
      // change icon of category
      case 6:
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return ConfirmationDialog(
              title: s.questionChangeIcon,
              content: SizedBox(
                width: 500,
                height: 200,
                child: Column(
                  children: [
                    Icon(
                      IconData(
                        3,
                        fontFamily: 'AntIcons',
                        fontPackage: 'ant_icons',
                      ),
                      color: Colors.blueGrey,
                      size: 28,
                    ),
                    const SizedBox(height: 16.0),
                    Expanded(
                      child: Container(
                        child: IconSelector(
                          selectedIcon: 3,
                          isInCreator: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              confirmationText: s.save,
              onConfirm: () {
                // return _updateCategory(context,
                //   categoryCubit.state.status == CategoryStatus.editing);
              },
              onCancel: () {
                // categoryCubit.iconChanged(icon: oldIcon);
                // Navigator.of(context).pop();
              },
            );
          },
        );
        break;
    }
  }

// void _updateCategory(BuildContext context, bool isSubmitting) {
//   if (!isSubmitting) {
//     context.read<CategoryCubit>().updateCategory();
//   }
// }
}
