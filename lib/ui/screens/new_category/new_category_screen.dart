import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/controllers.dart';
import 'widgets/widgets.dart';

class NewCategoryScreen extends ConsumerWidget {
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newCategoryState = ref.watch(newCategoryNotifierProvider);
    final newCategoryController =
        ref.watch(newCategoryNotifierProvider.notifier);
    return switch (newCategoryState.status) {
      NewCategoryStatus.initial =>
        CategoryInitial(color: newCategoryState.color),
      NewCategoryStatus.name => CategoryName(
          onNameChanged: newCategoryController.changeName,
          color: newCategoryState.color,
          focusNode: _focusNode,
          onSubmitted: () {
            _focusNode.unfocus();
            FocusScope.of(context).requestFocus(_focusNode);
            newCategoryController.progressToColor();
          },
          onNext: newCategoryController.progressToColor,
        ),
      NewCategoryStatus.color => CategoryColor(
          focusNode: _focusNode,
          name: newCategoryState.name,
          color: newCategoryState.color,
          selectedColor: newCategoryState.color,
          onNext: newCategoryController.progressToIcon,
        ),
      NewCategoryStatus.icon => CategoryIcon(
          focusNode: _focusNode,
          name: newCategoryState.name,
          color: newCategoryState.color,
          onNext: newCategoryController.progressToTasks,
          selectedIcon: newCategoryState.icon,
        ),
      NewCategoryStatus.tasks => CategoryTasks(
          tasks: newCategoryState.tasks,
          onAddTask: newCategoryController.changeTasks,
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
        )
    };
  }
}
