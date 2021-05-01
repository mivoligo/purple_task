import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../globals/globals.dart';
import '../../models/category.dart';
import '../../repositories/repositories.dart';
import 'new_category_state.dart';

final newCategoryControllerProvider =
    StateNotifierProvider.autoDispose<NewCategoryController, NewCategoryState>(
  (ref) {
    return NewCategoryController(ref.watch(categoryRepositoryProvider));
  },
);

class NewCategoryController extends StateNotifier<NewCategoryState> {
  NewCategoryController(this._categoryRepository)
      : super(NewCategoryState.initial()) {
    _startNewCategoryCreator();
  }

  final CategoryRepository _categoryRepository;
  final _random = Random();

  Color _setRandomColor() {
    return Color(categoryColors[_random.nextInt(categoryColors.length)]);
  }

  Future<void> _startNewCategoryCreator() async {
    state = state.copyWith(color: _setRandomColor());
    await Future.delayed(Duration(milliseconds: 200));
    state = state.copyWith(status: NewCategoryStatus.name);
  }

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
}
