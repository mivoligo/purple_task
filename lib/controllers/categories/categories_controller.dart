import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/models.dart';

import '../../repositories/repositories.dart';
import '../controllers.dart';

final categoriesProvider =
    StateNotifierProvider<CategoriesController, CategoriesState>((ref) {
  return CategoriesController(
    baseCategoryRepository: ref.watch(categoryRepositoryProvider),
  );
});

final categoryNameProvider = Provider.family<String, int>((ref, categoryId) {
  final categories = ref.watch(categoriesProvider).categories;
  return categories.firstWhere((element) => element.id == categoryId).name;
});

final categoryColorProvider = Provider.family<Color, int>((ref, categoryId) {
  final categories = ref.watch(categoriesProvider).categories;
  return categories.firstWhere((element) => element.id == categoryId).color;
});

final categoryIconProvider = Provider.family<int, int>((ref, categoryId) {
  final categories = ref.watch(categoriesProvider).categories;
  return categories.firstWhere((element) => element.id == categoryId).icon;
});

class CategoriesController extends StateNotifier<CategoriesState> {
  CategoriesController({
    required BaseCategoryRepository baseCategoryRepository,
  })  : _categoryRepository = baseCategoryRepository,
        super(CategoriesState.initial()) {
    _fetchCategories();
  }

  final BaseCategoryRepository _categoryRepository;

  void _fetchCategories() {
    state = state.copyWith(status: CategoriesStateStatus.loading);
    final categories = _categoryRepository.getCategories();
    state = state.copyWith(
        categories: categories, status: CategoriesStateStatus.data);
  }

  Future<void> add({required Category category}) async {
    await _categoryRepository.add(category: category);
    state = state.copyWith(
      categories: [...state.categories, category],
      status: CategoriesStateStatus.data,
    );
  }

  Future<void> remove({required Category category}) async {
    await _categoryRepository.remove(category: category);
    state = state.copyWith(
      categories: state.categories
          .where((element) => element.id != category.id)
          .toList(),
      status: CategoriesStateStatus.data,
    );
  }

  Future<void> update({required Category category}) async {
    await _categoryRepository.update(category: category);
    state = state.copyWith(
      categories: [
        for (final element in state.categories)
          if (element.id == category.id) category else element
      ],
      status: CategoriesStateStatus.data,
    );
  }
}
