import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:purple_task/features/todos/controllers/new_category_controller.dart';
import 'package:purple_task/features/todos/controllers/new_category_state.dart';
import 'package:purple_task/features/todos/views/new_category_color.dart';
import 'package:purple_task/features/todos/views/new_category_icon.dart';
import 'package:purple_task/features/todos/views/new_category_initial.dart';
import 'package:purple_task/features/todos/views/new_category_name.dart';
import 'package:purple_task/features/todos/views/new_category_tasks.dart';

class NewCategoryScreen extends ConsumerWidget {
  NewCategoryScreen({super.key});

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
          onNext: newCategoryController.progressToIcon,
        ),
      NewCategoryStatus.icon => CategoryIcon(
          focusNode: _focusNode,
          name: newCategoryState.name,
          color: newCategoryState.color,
          onNext: newCategoryController.progressToTasks,
          selectedIcon: newCategoryState.icon,
        ),
      NewCategoryStatus.tasks => NewCategoryTasks(
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
