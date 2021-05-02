import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repositories/repositories.dart';
import '../controllers.dart';

class CategoriesController extends StateNotifier<CategoriesState> {
  CategoriesController({
    required BaseCategoryRepository baseCategoryRepository,
  })  : _categoryRepository = baseCategoryRepository,
        super(CategoriesState.initial()) {
    _loadCategories();
  }

  final BaseCategoryRepository _categoryRepository;

  void _loadCategories() {
    state = state.copyWith(status: CategoriesStateStatus.loading);
    final categories = _categoryRepository.getCategories();
    state = state.copyWith(
        categories: categories, status: CategoriesStateStatus.data);
  }
}
