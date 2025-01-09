import 'dart:math';

import 'package:flutter/material.dart';
import 'package:purple_task/core/constants/category_colors.dart';
import 'package:purple_task/features/todos/controllers/categories_controller.dart';
import 'package:purple_task/features/todos/controllers/new_category_state.dart';
import 'package:purple_task/features/todos/controllers/tasks_controller.dart';
import 'package:purple_task/features/todos/models/new_category.dart';
import 'package:purple_task/features/todos/models/task.dart';
import 'package:purple_task/features/todos/repositories/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'new_category_controller.g.dart';

@riverpod
class NewCategoryNotifier extends _$NewCategoryNotifier {
  @override
  NewCategoryState build() {
    return NewCategoryState.initial().copyWith(
      color: _setRandomColor(),
      status: NewCategoryStatus.name,
    );
  }

  void changeName(String name) {
    state = state.copyWith(name: name);
  }

  void progressToColor() {
    if (state.name.trim().isNotEmpty) {
      state = state.copyWith(status: NewCategoryStatus.color);
    }
  }

  void changeColor(Color color) {
    state = state.copyWith(color: color);
  }

  void progressToIcon() {
    state = state.copyWith(status: NewCategoryStatus.icon);
  }

  void changeIcon(int icon) {
    state = state.copyWith(icon: icon);
  }

  void progressToTasks() {
    state = state.copyWith(status: NewCategoryStatus.tasks);
  }

  void updateNewTasksList(String taskName) {
    state = state.copyWith(tasksNamesList: [...state.tasksNamesList, taskName]);
  }

  Future<void> addNewCategoryAndTasks() async {
    final newCategory = NewCategory(
      name: state.name,
      color: state.color,
      icon: state.icon,
    );
    final newCategoryId = await ref
        .read(categoryRepositoryProvider)
        .add(newCategory: newCategory);

    await _addTasksForCategory(newCategoryId);
    await ref.read(categoriesNotifierProvider.notifier).refreshCategories();
  }

  Future<void> _addTasksForCategory(int categoryId) async {
    if (state.tasksNamesList.isNotEmpty) {
      await ref.read(tasksNotifierProvider.notifier).addTasksList(
            tasksList: state.tasksNamesList
                .map(
                  (taskName) => Task(name: taskName, categoryId: categoryId),
                )
                .toList(growable: false),
          );
    }
  }
}

Color _setRandomColor() {
  return Color(categoryColors[Random().nextInt(categoryColors.length)]);
}
