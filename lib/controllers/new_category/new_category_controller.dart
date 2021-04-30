import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/category.dart';
import '../../repositories/repositories.dart';
import 'new_category_state.dart';

final newCategoryControllerProvider =
    StateNotifierProvider<NewCategoryController, NewCategoryState>(
  (ref) {
    return NewCategoryController(ref.watch(categoryRepositoryProvider));
  },
);

class NewCategoryController extends StateNotifier<NewCategoryState> {
  NewCategoryController(this._categoryRepository)
      : super(NewCategoryState.initial());

  final CategoryRepository _categoryRepository;

  void nameChanged(String name) {
    state = state.copyWith(name: name);
  }

  void progressToColor() {
    state = state.copyWith(status: NewCategoryStatus.color);
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

  void addNewCategory() {
    final category = Category(
      id: DateTime.now().millisecondsSinceEpoch,
      name: state.name,
      color: state.color,
      icon: state.icon,
    );
    _categoryRepository.addCategory(category: category);
  }

  void resetCategory() {
    state = NewCategoryState.initial();
  }
}
