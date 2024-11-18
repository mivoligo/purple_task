import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/controllers.dart';
import '../../../providers/providers.dart';
import 'widgets/widgets.dart';

class NewCategoryScreen extends ConsumerWidget {
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newCategoryState = ref.watch(newCategoryControllerProvider);
    final newCategoryController =
        ref.watch(newCategoryControllerProvider.notifier);
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
        );

      case NewCategoryStatus.color:
        return CategoryColor(
          focusNode: _focusNode,
          name: newCategoryState.name,
          color: newCategoryState.color,
          selectedColor: newCategoryState.color,
          onNext: newCategoryController.progressToIcon,
        );

      case NewCategoryStatus.icon:
        return CategoryIcon(
          focusNode: _focusNode,
          name: newCategoryState.name,
          color: newCategoryState.color,
          onNext: newCategoryController.progressToTasks,
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
            // ref.watch(categoryCreatorStatusProvider) =
            //     CategoryCreatorStatus.success;
            Navigator.of(context).pop();
          },
          selectedIcon: newCategoryState.icon,
        );
    }
  }
}
