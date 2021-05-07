import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/models.dart';
import 'category_state.dart';

final categoryProvider =
    StateNotifierProvider.family<CategoryController, CategoryState, Category>(
        (ref, category) {
  return CategoryController(category: category);
});

class CategoryController extends StateNotifier<CategoryState> {
  CategoryController({required this.category})
      : super(CategoryState.initial()) {
    _load(category: category);
  }

  final Category category;

  _load({required Category category}) {
    state = state.copyWith(
      category: category,
      status: CategoryStatus.data,
    );
  }

  void colorChanged({required Color color}) {
    state = state.copyWith(category: category.copyWith(color: color));
  }

  void iconChanged({required int icon}) {
    state = state.copyWith(category: category.copyWith(icon: icon));
  }
}
