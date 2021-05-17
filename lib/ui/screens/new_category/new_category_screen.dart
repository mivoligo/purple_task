import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/controllers.dart';
import 'widgets/widgets.dart';

enum CategoryCreatorStatus { normal, success }

final categoryCreatorStatusProvider =
    StateProvider((_) => CategoryCreatorStatus.normal);

class NewCategoryScreen extends ConsumerWidget {
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final newCategoryState = watch(newCategoryControllerProvider);
    final newCategoryController = watch(newCategoryControllerProvider.notifier);
    switch (newCategoryState.status) {
      case NewCategoryStatus.initial:
        return CategoryInitial(color: newCategoryState.color);

      case NewCategoryStatus.name:
        return CategoryName(
          onNameChanged: newCategoryController.nameChanged,
          color: newCategoryState.color,
          focusNode: _focusNode,
          onSubmitted: () {
            _focusNode.unfocus();
            FocusScope.of(context).requestFocus(_focusNode);
            newCategoryController.progressToColor();
          },
          onNext: newCategoryController.progressToColor,
          onCancel: () {
            Navigator.of(context).pop();
          },
        );

      case NewCategoryStatus.color:
        return CategoryColor(
          focusNode: _focusNode,
          name: newCategoryState.name,
          color: newCategoryState.color,
          selectedColor: newCategoryState.color,
          onNext: newCategoryController.progressToIcon,
          onCancel: () {
            Navigator.of(context).pop();
          },
        );

      case NewCategoryStatus.icon:
        return CategoryIcon(
          focusNode: _focusNode,
          name: newCategoryState.name,
          color: newCategoryState.color,
          onNext: newCategoryController.progressToTasks,
          onCancel: () {
            Navigator.of(context).pop();
          },
          selectedIcon: newCategoryState.icon,
        );

      case NewCategoryStatus.tasks:
        return CategoryTasks(
          tasks: newCategoryState.tasks,
          onAddTask: newCategoryController.tasksChanged,
          focusNode: _focusNode,
          name: newCategoryState.name,
          color: newCategoryState.color,
          onNext: () {
            newCategoryController.addNewCategory();
            Navigator.of(context).pop();
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
          selectedIcon: newCategoryState.icon,
        );
    }
  }
}
