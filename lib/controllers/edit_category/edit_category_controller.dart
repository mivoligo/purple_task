import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/models.dart';
import 'edit_category_state.dart';

final editCategoryProvider = StateNotifierProvider.family
    .autoDispose<EditCategoryController, EditCategoryState, Category>(
        (ref, category) {
  return EditCategoryController(category: category);
});

class EditCategoryController extends StateNotifier<EditCategoryState> {
  EditCategoryController({required this.category})
      : super(EditCategoryState.initial()) {
    _load(category: category);
  }

  final Category category;

  _load({required Category category}) {
    state = state.copyWith(
      color: category.color,
      icon: category.icon,
      status: EditCategoryStatus.data,
    );
  }

  void colorChanged({required Color color}) {
    state = state.copyWith(color: color);
  }

  void iconChanged({required int icon}) {
    state = state.copyWith(icon: icon);
  }
}
