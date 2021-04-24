import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/models/category.dart';
import '../data/repositories/category_repository.dart';

part 'category_list_state.dart';

class CategoryListCubit extends Cubit<CategoryListState> {
  CategoryListCubit(this._categoryRepository) : super(CategoryListInitial());

  final CategoryRepository _categoryRepository;

  void loadCategories() {
    emit(CategoryListLoading());
    try {
      final categories = _categoryRepository.getCategories();
      emit(CategoryListLoaded(categories));
    } on Exception {
      emit(CategoryListError());
    }
  }
}
