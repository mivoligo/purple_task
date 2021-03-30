import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../db_models/category.dart';
import '../data/category_repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this._categoryRepository) : super(CategoryInitial());

  final CategoryRepository _categoryRepository;

  Future<void> loadCategories() async {
    emit(CategoryLoading());
    try {
      final categories = await _categoryRepository.getCategories();
      emit(CategoryLoaded(categories));
    } on Exception {
      emit(CategoryError());
    }
  }

  void addCategory({
    required String name,
    required int color,
    required int icon,
  }) {
    _categoryRepository.addCategory();
    loadCategories();
  }

  void removeCategory(int index) {
    _categoryRepository.deleteCategory(index);
    loadCategories();
  }
}
