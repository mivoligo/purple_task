import 'package:flutter/material.dart';
import 'package:purple_task/features/settings/controllers/settings/settings_controller.dart';
import 'package:purple_task/features/todos/controllers/categories_controller.dart';
import 'package:purple_task/features/todos/models/category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_controller.g.dart';

@riverpod
class CategoryNotifier extends _$CategoryNotifier {
  @override
  Category? build() => null;

  void setCurrentCategory(Category? category) {
    state = category;
    ref
        .read(settingsNotifierProvider.notifier)
        .setUncategorizedViewPreference(value: category == null);
  }

  void changeColor(Color color) {
    state = state?.copyWith(color: color);
  }

  void changeIcon(int icon) {
    state = state?.copyWith(icon: icon);
  }

  void changeName({required String name}) {
    state = state?.copyWith(name: name);
  }

  void update() {
    if (state != null) {
      ref
          .read(categoriesNotifierProvider.notifier)
          .updateCategory(category: state!);
    }
  }
}
