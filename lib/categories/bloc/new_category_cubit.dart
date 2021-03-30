import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/category_repository.dart';

part 'new_category_state.dart';

class NewCategoryCubit extends Cubit<NewCategoryState> {
  NewCategoryCubit(this._categoryRepository) : super(NewCategoryInitial());

  final CategoryRepository _categoryRepository;

  void startNewCategoryCreator() {
    emit(NewCategoryInitial());
    _categoryRepository.setRandomColor();
    emit(NewCategoryName(color: _categoryRepository.color));
  }

  void setName(String name) {
    _categoryRepository.name = name;
    emit(NewCategoryColor(name));
  }

  void setColor(int color) {
    _categoryRepository.color = color;
    emit(NewCategoryIcon());
  }

  void setIcon(int icon) {
    _categoryRepository.icon = icon;
    emit(NewCategoryTasks());
  }

  void cancelNewCategoryCreator() {}
}
