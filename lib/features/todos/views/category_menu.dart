import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/ui/widgets/confirmation_dialog.dart';
import 'package:purple_task/core/ui/widgets/text_change_confirmation_dialog.dart';
import 'package:purple_task/features/todos/controllers/categories_controller.dart';
import 'package:purple_task/features/todos/controllers/category_controller.dart';
import 'package:purple_task/features/todos/controllers/tasks_controller.dart';
import 'package:purple_task/features/todos/models/category.dart';
import 'package:purple_task/features/todos/views/color_selector.dart';
import 'package:purple_task/features/todos/views/icon_selector.dart';

class CategoryMenu extends ConsumerStatefulWidget {
  const CategoryMenu({
    required this.category,
    required this.canDeleteCategory,
    this.iconSize,
    super.key,
  });

  final Category category;
  final bool canDeleteCategory;
  final double? iconSize;

  @override
  _CategoryMenuState createState() => _CategoryMenuState();
}

class _CategoryMenuState extends ConsumerState<CategoryMenu> {
  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    return MenuAnchor(
      consumeOutsideTap: true,
      menuChildren: [
        MenuItemButton(
          onPressed: onDeleteCompletedTasks,
          child: Text(tr.categoryOptionDeleteCompleted),
        ),
        MenuItemButton(
          onPressed: onDeleteAllTasks,
          child: Text(tr.categoryOptionDeleteAllTasks),
        ),
        const PopupMenuDivider(),
        if (widget.canDeleteCategory) ...[
          MenuItemButton(
            onPressed: onDeleteCategory,
            child: Text(tr.categoryOptionDeleteCategory),
          ),
          const PopupMenuDivider(),
        ],
        MenuItemButton(
          onPressed: onChangeName,
          child: Text(tr.categoryOptionChangeName),
        ),
        MenuItemButton(
          onPressed: onChangeColor,
          child: Text(tr.categoryOptionChangeColor),
        ),
        MenuItemButton(
          onPressed: onChangeIcon,
          child: Text(tr.categoryOptionChangeIcon),
        ),
      ],
      builder: (context, controller, child) {
        return IconButton(
          tooltip: tr.showOptions,
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
    final tr = AppLocalizations.of(context);
    showDialog<void>(
      context: context,
      builder: (_) => ConfirmationDialog(
        title: tr.deleteCompletedTasksDialogTitle,
        content: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(tr.deleteCompletedTasksDialogContent),
        ),
        confirmationText: tr.delete,
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
    final tr = AppLocalizations.of(context);
    showDialog<void>(
      context: context,
      builder: (_) => ConfirmationDialog(
        title: tr.deleteAllTasksDialogTitle,
        content: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(tr.deleteAllTasksDialogContent),
        ),
        confirmationText: tr.delete,
        confirmationColor: Colors.red,
        onConfirm: () => ref
            .read(tasksNotifierProvider.notifier)
            .removeAllTasksForCategory(categoryId: category.id),
      ),
    );
  }

  void onDeleteCategory() {
    final category = ref.watch(categoryNotifierProvider)!;
    final tr = AppLocalizations.of(context);

    showDialog<void>(
      context: context,
      builder: (_) => ConfirmationDialog(
        title: tr.deleteCategoryDialogTitle,
        content: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(tr.deleteCategoryDialogContent(category.name)),
        ),
        confirmationText: tr.delete,
        confirmationColor: Colors.red,
        onConfirm: () {
          ref
              .read(tasksNotifierProvider.notifier)
              .removeAllTasksForCategory(categoryId: category.id);
          ref
              .read(categoriesNotifierProvider.notifier)
              .removeCategory(categoryId: category.id);
          // remove category from current category state
          ref.read(categoryNotifierProvider.notifier).setCurrentCategory(null);
        },
      ),
    );
  }

  void onChangeName() {
    final category = ref.watch(categoryNotifierProvider)!;
    final tr = AppLocalizations.of(context);

    showDialog<void>(
      context: context,
      builder: (_) {
        return TextChangeConfirmationDialog(
          title: tr.changeCategoryNameDialogTitle,
          initialText: category.name,
          confirmationButtonText: tr.saveButton,
          onConfirm: (text) {
            ref.read(categoryNotifierProvider.notifier)
              ..changeName(name: text)
              ..update();
          },
        );
      },
    );
  }

  void onChangeColor() {
    showDialog<void>(
      context: context,
      builder: (_) {
        return Consumer(
          builder: (context, ref, _) {
            final color = ref.watch(categoryNotifierProvider)!.color;
            final tr = AppLocalizations.of(context);

            return ConfirmationDialog(
              title: tr.changeCategoryColorDialogTitle,
              content: SizedBox(
                width: 500,
                height: 200,
                child: Column(
                  children: [
                    Container(
                      height: 20,
                      color: color,
                    ),
                    const SizedBox(height: 16),
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
              confirmationText: tr.saveButton,
              onConfirm: ref.read(categoryNotifierProvider.notifier).update,
            );
          },
        );
      },
    );
  }

  void onChangeIcon() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return Consumer(
          builder: (context, ref, _) {
            final category = ref.watch(categoryNotifierProvider)!;
            final tr = AppLocalizations.of(context);

            final icon = category.icon;
            return ConfirmationDialog(
              title: tr.changeCategoryIconDialogTitle,
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
                    const SizedBox(height: 16),
                    Expanded(
                      child: IconSelector(
                        selectedIcon: icon,
                        onSelect: ref
                            .read(categoryNotifierProvider.notifier)
                            .changeIcon,
                      ),
                    ),
                  ],
                ),
              ),
              confirmationText: tr.saveButton,
              onConfirm: ref.read(categoryNotifierProvider.notifier).update,
            );
          },
        );
      },
    );
  }
}
