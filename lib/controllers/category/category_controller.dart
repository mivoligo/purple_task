import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../models/models.dart';
import '../categories/categories_controller.dart';

part 'category_controller.g.dart';

@riverpod
class CategoryNotifier extends _$CategoryNotifier {
  @override
  Category? build() => null;

  void setCurrentCategory(Category? category) {
    state = category;
  }

  void changeColor({required Color color}) {
    state = state?.copyWith(color: color);
  }

  void changeIcon({required int icon}) {
    state = state?.copyWith(icon: icon);
  }

  void changeName({required String name}) {
    state = state?.copyWith(name: name);
  }

  void update() {
    if (state != null) {
      ref.read(categoriesNotifierProvider.notifier).update(category: state!);
    }
  }
}
