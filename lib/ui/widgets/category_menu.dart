import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/strings/strings.dart' as s;
import '../../models/models.dart';
import '../../providers/providers.dart';
import 'widgets.dart';

class CategoryMenu extends StatefulWidget {
  const CategoryMenu({
    required this.onRemoveCategory,
    required this.onRemoveAllTasks,
    required this.onRemoveCompletedTasks,
  });

  final VoidCallback onRemoveCategory;
  final VoidCallback onRemoveAllTasks;
  final VoidCallback onRemoveCompletedTasks;

  @override
  _CategoryMenuState createState() => _CategoryMenuState();
}

class _CategoryMenuState extends State<CategoryMenu> {
  late final textController = TextEditingController();

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
        icon: const Icon(
          AntIcons.menu,
          color: Color(0xFF616161),
        ),
        offset: const Offset(0, 48),
        elevation: 4.0,
        onSelected: (dynamic item) => onItemSelected(context, item),
        itemBuilder: (context) {
          final menuList = <PopupMenuEntry<Object>>[];
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
            onConfirm: widget.onRemoveCompletedTasks,
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
            onConfirm: widget.onRemoveAllTasks,
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
            onConfirm: widget.onRemoveCategory,
          ),
        );
        break;
      // change name of category
      case 4:
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            final category = context.read(currentCategoryProvider).state!;
            textController.text = category.name;
            return ConfirmationDialog(
              title: s.questionChangeName,
              content: Padding(
                padding: const EdgeInsets.all(24.0),
                child: CupertinoTextField(
                  controller: textController,
                  autofocus: true,
                  onSubmitted: (value) {
                    final updatedCategory =
                        category.copyWith(name: textController.text);
                    _updateCategory(context, updatedCategory);
                    context.read(currentCategoryProvider).state =
                        updatedCategory;
                    Navigator.of(context).pop();
                  },
                ),
              ),
              confirmationText: s.save,
              onConfirm: textController.text.isNotEmpty
                  ? () {
                      final updatedCategory =
                          category.copyWith(name: textController.text);
                      _updateCategory(context, updatedCategory);
                      context.read(currentCategoryProvider).state =
                          updatedCategory;
                    }
                  : () => null,
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
            return Consumer(
              builder: (context, watch, _) {
                final category = watch(currentCategoryProvider).state!;
                final color = watch(categoryProvider(category)).category.color;
                return ConfirmationDialog(
                  title: s.questionChangeColor,
                  content: SizedBox(
                    width: 500,
                    height: 200,
                    child: Column(
                      children: [
                        Container(
                          height: 20,
                          color: color,
                        ),
                        const SizedBox(height: 16.0),
                        Expanded(
                          child: ColorSelector(
                            selectedColor: color,
                            isInCreator: false,
                            category: category,
                          ),
                        ),
                      ],
                    ),
                  ),
                  confirmationText: s.save,
                  onConfirm: () {
                    final updatedCategory = category.copyWith(color: color);
                    _updateCategory(context, updatedCategory);
                    context.read(currentCategoryProvider).state =
                        updatedCategory;
                  },
                );
              },
            );
          },
        );
        break;
      // change icon of category
      case 6:
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Consumer(
              builder: (context, watch, _) {
                final category = watch(currentCategoryProvider).state!;
                final icon = watch(categoryProvider(category)).category.icon;
                return ConfirmationDialog(
                  title: s.questionChangeIcon,
                  content: SizedBox(
                    width: 500,
                    height: 200,
                    child: Column(
                      children: [
                        Icon(
                          IconData(
                            icon,
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
                              selectedIcon: icon,
                              isInCreator: false,
                              category: category,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  confirmationText: s.save,
                  onConfirm: () {
                    final updatedCategory = category.copyWith(icon: icon);
                    _updateCategory(context, updatedCategory);
                    context.read(currentCategoryProvider).state =
                        updatedCategory;
                  },
                );
              },
            );
          },
        );
        break;
    }
  }

  void _updateCategory(BuildContext context, Category category) {
    context.read(categoriesProvider.notifier).update(category: category);
  }
}
