import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../db_models/category.dart';
import '../data/category_repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this._categoryRepository) : super(CategoryInitial());

  final CategoryRepository _categoryRepository;

  void loadCategories() {
    emit(CategoryLoading());
    try {
      final categories = _categoryRepository.getCategories();
      emit(CategoryLoaded(categories));
    } on Exception {
      emit(CategoryError());
    }
  }

  void removeCategory(int index) {
    _categoryRepository.deleteCategory(index);
    loadCategories();
  }
}
