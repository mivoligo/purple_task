import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';

part 'category_controller.g.dart';

@riverpod
class CategoryNotifier extends _$CategoryNotifier {
  @override
  Category build() {
    final currentCategory = ref.watch(currentCategoryProvider);
    return currentCategory ?? Category.empty();
  }

  void changeColor({required Color color}) {
    state = state.copyWith(color: color);
  }

  void changeIcon({required int icon}) {
    state = state.copyWith(icon: icon);
  }
}
