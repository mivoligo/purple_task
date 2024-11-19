import 'dart:math';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../constants/category_colors.dart';
import '../../models/models.dart';
import '../controllers.dart';

part 'new_category_controller.g.dart';

@riverpod
class NewCategoryNotifier extends _$NewCategoryNotifier {
  @override
  NewCategoryState build() {
    return NewCategoryState.initial();
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

  void changeTasks(String taskName) {
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
    _addTasksForCategory();
    ref.read(categoriesNotifierProvider.notifier).add(category: category);
  }

  void _addTasksForCategory() {
    final taskNotifier = ref.read(tasksNotifierProvider.notifier);
    if (state.tasks.isNotEmpty) {
      for (final task in state.tasks) {
        taskNotifier.add(task: task);
      }
    }
  }
}

Color _setRandomColor() {
  return Color(categoryColors[Random().nextInt(categoryColors.length)]);
}
// class NewCategoryController extends StateNotifier<NewCategoryState> {
//   NewCategoryController({
//     required CategoriesController categoriesController,
//     required TasksController tasksController,
//   })  : _categoriesController = categoriesController,
//         _tasksController = tasksController,
//         super(NewCategoryState.initial()) {
//     _startNewCategoryCreator();
//   }
//
//   final CategoriesController _categoriesController;
//   final TasksController _tasksController;
//
//   final _random = Random();
//
//   Color _setRandomColor() {
//     return Color(categoryColors[_random.nextInt(categoryColors.length)]);
//   }
//
//   Future<void> _startNewCategoryCreator() async {
//     state = state.copyWith(color: _setRandomColor());
//     await Future.delayed(const Duration(milliseconds: 200));
//     state = state.copyWith(status: NewCategoryStatus.name);
//   }
//
//   void changeName(String name) {
//     state = state.copyWith(name: name);
//   }
//
//   void progressToColor() {
//     if (state.name.trim().isNotEmpty) {
//       state = state.copyWith(status: NewCategoryStatus.color);
//     }
//   }
//
//   void changeColor(Color color) {
//     state = state.copyWith(color: color);
//   }
//
//   void progressToIcon() {
//     state = state.copyWith(status: NewCategoryStatus.icon);
//   }
//
//   void changeIcon(int icon) {
//     state = state.copyWith(icon: icon);
//   }
//
//   void progressToTasks() {
//     state = state.copyWith(status: NewCategoryStatus.tasks);
//   }
//
//   void changeTasks(String taskName) {
//     final task = Task(name: taskName, categoryId: state.id);
//     final taskList = state.tasks;
//     taskList.add(task);
//     state = state.copyWith(tasks: state.tasks);
//   }
//
//   void addNewCategory() {
//     final category = Category(
//       id: state.id,
//       name: state.name,
//       color: state.color,
//       icon: state.icon,
//     );
//     _addTasksForCategory();
//     _categoriesController.add(category: category);
//   }
//
//   void _addTasksForCategory() {
//     if (state.tasks.isNotEmpty) {
//       for (final task in state.tasks) {
//         _tasksController.add(task: task);
//       }
//     }
//   }
// }
