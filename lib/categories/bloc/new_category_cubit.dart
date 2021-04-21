import 'package:ant_icons/ant_icons.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../data/category_repository.dart';

part 'new_category_state.dart';

class NewCategoryCubit extends Cubit<NewCategoryState> {
  NewCategoryCubit(this._categoryRepository)
      : super(NewCategoryState.initial());

  final CategoryRepository _categoryRepository;

  Future<void> startNewCategoryCreator() async {
    _categoryRepository.setRandomColor();
    emit(state.copyWith(color: _categoryRepository.color));
    await Future.delayed(Duration(milliseconds: 200));
    emit(state.copyWith(status: NewCategoryStatus.name));
  }

  void setName(String name) {
    emit(state.copyWith(name: name, status: NewCategoryStatus.color));
  }

  void changeTempColor(Color color) {
    emit(state.copyWith(color: color));
  }

  void setColor(Color color) {
    emit(state.copyWith(color: color, status: NewCategoryStatus.icon));
  }

  void changeTempIcon(int icon) {
    emit(state.copyWith(icon: icon));
  }

  void setIcon(int icon) {
    emit(state.copyWith(icon: icon, status: NewCategoryStatus.tasks));
  }

  void addNewCategory() {
    _categoryRepository.addCategory(
      name: state.name,
      icon: state.icon,
      color: state.color,
    );
  }
}
