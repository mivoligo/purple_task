import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../data/category_repository.dart';
import '../data/model/category.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(CategoryState.initial());

  final CategoryRepository _categoryRepository;

  void loadCategory({required Category category}) {
    emit(state.copyWith(category: category, status: CategoryStatus.initial));
  }

  void updateName({required String name}) {
    emit(state.copyWith(
      category: state.category?.copyWith(name: name),
      status: CategoryStatus.initial,
    ));
  }

  void updateColor({required Color color}) {
    emit(state.copyWith(
      category: state.category?.copyWith(color: color),
      status: CategoryStatus.initial,
    ));
  }

  void updateIcon({required int icon}) {
    emit(state.copyWith(
      category: state.category?.copyWith(icon: icon),
      status: CategoryStatus.initial,
    ));
  }

  Future<void> updateCategory() async {
    emit(state.copyWith(status: CategoryStatus.editing));
    try {
      await _categoryRepository.updateCategory(state.category!);
      emit(state.copyWith(status: CategoryStatus.success));
    } on Exception catch (err) {
      emit(state.copyWith(
        status: CategoryStatus.error,
        errorMessage: 'Something went wrong: $err',
      ));
      emit(state.copyWith(status: CategoryStatus.initial));
    }
  }

  Future<void> removeCategory() async {
    emit(state.copyWith(status: CategoryStatus.editing));
    try {
      _categoryRepository.deleteCategory(state.category!);
      emit(state.copyWith(status: CategoryStatus.success));
    } on Exception catch (err) {
      emit(state.copyWith(
        status: CategoryStatus.error,
        errorMessage: 'Something went wrong: $err',
      ));
    }
  }
}
