import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../controllers/controllers.dart';
import '../models/category.dart';

part 'category_controller.g.dart';

@riverpod
class CategoryNotifier extends _$CategoryNotifier {
  @override
  Category? build() => null;

  void setCurrentCategory(Category? category) {
    state = category;
    ref
        .read(settingsNotifierProvider.notifier)
        .setUncategorizedViewPreference(value: category == null ? true : false);
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
      // ref.read(categoriesNotifierProvider.notifier).update(category: state!);
    }
  }
}
