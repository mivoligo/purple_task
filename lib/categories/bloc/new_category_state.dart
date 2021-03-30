part of 'new_category_cubit.dart';

abstract class NewCategoryState extends Equatable {
  const NewCategoryState();

  @override
  List<Object> get props => [];
}

class NewCategoryInitial extends NewCategoryState {}

class NewCategoryName extends NewCategoryState {
  NewCategoryName({required this.color});

  final int color;

  @override
  List<Object> get props => [color];
}

class NewCategoryColor extends NewCategoryState {
  NewCategoryColor(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class NewCategoryIcon extends NewCategoryState {}

class NewCategoryTasks extends NewCategoryState {}
