import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../db_models/category.dart';
import '../data/category_repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(CategoryInitial());

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
}
