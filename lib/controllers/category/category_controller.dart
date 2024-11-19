import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../models/models.dart';

part 'category_controller.g.dart';

@riverpod
class CategoryNotifier extends _$CategoryNotifier {
  @override
  Category build() => Category.empty();

  void changeColor({required Color color}) {
    state = state.copyWith(color: color);
  }

  void changeIcon({required int icon}) {
    state = state.copyWith(icon: icon);
  }
}
