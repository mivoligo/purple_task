import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/strings/strings.dart' as s;
import '../../controllers/controllers.dart';
import '../../models/models.dart';
import 'widgets.dart';

class CategoryMenu extends ConsumerStatefulWidget {
  const CategoryMenu({
    required this.category,
    required this.canDeleteCategory,
    this.iconSize,
  });

  final Category category;
  final bool canDeleteCategory;
  final double? iconSize;

  @override
  _CategoryMenuState createState() => _CategoryMenuState();
}

class _CategoryMenuState extends ConsumerState<CategoryMenu> {
  late final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      consumeOutsideTap: true,
      menuChildren: [
        MenuItemButton(
          child: const Text(s.deleteCompleted),
          onPressed: onDeleteCompletedTasks,
        ),
        MenuItemButton(
          child: const Text(s.deleteAllTasks),
          onPressed: onDeleteAllTasks,
        ),
        const PopupMenuDivider(),
        if (widget.canDeleteCategory) ...[
          MenuItemButton(
            child: const Text(s.deleteCategory),
            onPressed: onDeleteCategory,
          ),
          const PopupMenuDivider(),
        ],
        MenuItemButton(
          child: const Text(s.changeName),
          onPressed: onChangeName,
        ),
        MenuItemButton(
          child: const Text(s.changeColor),
          onPressed: onChangeColor,
        ),
        MenuItemButton(
          child: const Text(s.changeIcon),
          onPressed: onChangeIcon,
        ),
      ],
      builder: (context, controller, child) {
        return IconButton(
          tooltip: s.showOptions,
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              ref
                  .read(categoryNotifierProvider.notifier)
                  .setCurrentCategory(widget.category);
              controller.open();
            }
          },
          icon: Icon(
            AntIcons.menu,
            size: widget.iconSize,
          ),
        );
      },
    );
  }

  void onDeleteCompletedTasks() {
    final category = ref.watch(categoryNotifierProvider)!;
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
          ref
              .read(tasksNotifierProvider.notifier)
              .removeCompletedTasksForCategory(categoryId: category.id);
        },
      ),
    );
  }

  void onDeleteAllTasks() {
    final category = ref.watch(categoryNotifierProvider)!;
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
        onConfirm: () => ref
            .read(tasksNotifierProvider.notifier)
            .removeAllTasksForCategory(categoryId: category.id),
      ),
    );
  }

  void onDeleteCategory() {
    final category = ref.watch(categoryNotifierProvider)!;
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
          ref
              .read(tasksNotifierProvider.notifier)
              .removeAllTasksForCategory(categoryId: category.id);
          ref
              .read(categoriesNotifierProvider.notifier)
              .remove(categoryId: category.id);
          // remove category from current category state
          ref.read(categoryNotifierProvider.notifier).setCurrentCategory(null);
        },
      ),
    );
  }

  void onChangeName() {
    final category = ref.watch(categoryNotifierProvider)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        textController.text = category.name;
        return ConfirmationDialog(
          title: s.questionChangeName,
          content: Padding(
            padding: const EdgeInsets.all(24.0),
            child: CupertinoTextField(
              controller: textController,
              autofocus: true,
              onSubmitted: (_) {
                updateName();
                Navigator.of(context).pop();
              },
            ),
          ),
          confirmationText: s.save,
          onConfirm: textController.text.isNotEmpty ? updateName : () => null,
        );
      },
    );
  }

  void onChangeColor() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Consumer(
          builder: (context, ref, _) {
            final color = ref.watch(categoryNotifierProvider)!.color;
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
                        onSelect: ref
                            .read(categoryNotifierProvider.notifier)
                            .changeColor,
                      ),
                    ),
                  ],
                ),
              ),
              confirmationText: s.save,
              onConfirm: ref.read(categoryNotifierProvider.notifier).update,
            );
          },
        );
      },
    );
  }

  void onChangeIcon() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Consumer(
          builder: (context, ref, _) {
            final category = ref.watch(categoryNotifierProvider)!;
            final icon = category.icon;
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
                      color: category.color,
                      size: 28,
                    ),
                    const SizedBox(height: 16.0),
                    Expanded(
                      child: Container(
                        child: IconSelector(
                          selectedIcon: icon,
                          onSelect: ref
                              .read(categoryNotifierProvider.notifier)
                              .changeIcon,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              confirmationText: s.save,
              onConfirm: ref.read(categoryNotifierProvider.notifier).update,
            );
          },
        );
      },
    );
  }

  void updateName() {
    ref.read(categoryNotifierProvider.notifier)
      ..changeName(name: textController.text)
      ..update();
  }
}
