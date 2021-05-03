import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../globals/globals.dart';
import '../../models/category.dart';
import '../../models/models.dart';
import '../../repositories/repositories.dart';
import '../controllers.dart';
import 'new_category_state.dart';

final newCategoryControllerProvider =
    StateNotifierProvider.autoDispose<NewCategoryController, NewCategoryState>(
  (ref) {
    return NewCategoryController(
      categoryRepository: ref.watch(categoryRepositoryProvider),
      taskRepository: ref.watch(taskRepositoryProvider),
      categoriesController: ref.watch(categoriesControllerProvider.notifier),
    );
  },
);

class NewCategoryController extends StateNotifier<NewCategoryState> {
  NewCategoryController({
    required BaseCategoryRepository categoryRepository,
    required BaseTaskRepository taskRepository,
    required CategoriesController categoriesController,
  })  : _categoryRepository = categoryRepository,
        _taskRepository = taskRepository,
        _categoriesController = categoriesController,
        super(NewCategoryState.initial()) {
    _startNewCategoryCreator();
  }

  final BaseCategoryRepository _categoryRepository;
  final BaseTaskRepository _taskRepository;
  final CategoriesController _categoriesController;

  final _random = Random();

  Color _setRandomColor() {
    return Color(categoryColors[_random.nextInt(categoryColors.length)]);
  }

  Future<void> _startNewCategoryCreator() async {
    state = state.copyWith(color: _setRandomColor());
    await Future.delayed(const Duration(milliseconds: 200));
    state = state.copyWith(status: NewCategoryStatus.name);
  }

  void nameChanged(String name) {
    state = state.copyWith(name: name);
  }

  void progressToColor() {
    if (state.name.trim().isNotEmpty) {
      state = state.copyWith(status: NewCategoryStatus.color);
    }
  }

  void colorChanged(Color color) {
    state = state.copyWith(color: color);
  }

  void progressToIcon() {
    state = state.copyWith(status: NewCategoryStatus.icon);
  }

  void iconChanged(int icon) {
    state = state.copyWith(icon: icon);
  }

  void progressToTasks() {
    state = state.copyWith(status: NewCategoryStatus.tasks);
  }

  void tasksChanged(String taskName) {
    final task = Task(name: taskName, categoryId: state.id);
    final taskList = state.tasks;
    taskList.add(task);
    state = state.copyWith(tasks: state.tasks);
  }

  void addNewCategory() {
    final category = Category(
      id: state.id,
      name: state.name,
      color: state.color,
      icon: state.icon,
    );
    _categoryRepository.addCategory(category: category);
    _addTasksForCategory();
    _categoriesController.state =
        _categoriesController.state.copyWith(categories: [
      ..._categoriesController.state.categories,
      category,
    ]);
  }

  void _addTasksForCategory() {
    if (state.tasks.isNotEmpty) {
      for (var task in state.tasks) {
        _taskRepository.addTask(task);
      }
    }
  }
}
