import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/category_repository.dart';

part 'new_category_state.dart';

class NewCategoryCubit extends Cubit<NewCategoryState> {
  NewCategoryCubit(this._categoryRepository) : super(NewCategoryEmpty());

  final CategoryRepository _categoryRepository;

  Future<void> startNewCategoryCreator() async {
    _categoryRepository.setRandomColor();
    emit(NewCategoryInitial(color: _categoryRepository.color));
    await Future.delayed(Duration(milliseconds: 200));
    emit(NewCategoryName(color: _categoryRepository.color));
  }

  void setName(String name) {
    _categoryRepository.name = name;
    emit(NewCategoryColor(name, _categoryRepository.color));
  }

  void changeTempColor(int color) {
    emit(NewCategoryColor(_categoryRepository.name, color));
  }

  void setColor(int color) {
    _categoryRepository.color = color;
    emit(NewCategoryIcon(
      _categoryRepository.name,
      _categoryRepository.color,
      _categoryRepository.icon,
    ));
  }

  void changeTempIcon(int icon) {
    emit(NewCategoryIcon(
        _categoryRepository.name, _categoryRepository.color, icon));
  }

  void setIcon(int icon) {
    _categoryRepository.icon = icon;
    emit(NewCategoryTasks(
      _categoryRepository.name,
      _categoryRepository.color,
      _categoryRepository.icon,
    ));
  }

  void addNewCategory() {
    _categoryRepository.addCategory();
  }
}
