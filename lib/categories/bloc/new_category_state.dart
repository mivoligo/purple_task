part of 'new_category_cubit.dart';

abstract class NewCategoryState extends Equatable {
  const NewCategoryState();

  @override
  List<Object> get props => [];
}

class NewCategoryEmpty extends NewCategoryState {}

class NewCategoryInitial extends NewCategoryState {
  NewCategoryInitial({required this.color});

  final int color;

  @override
  List<Object> get props => [color];
}

class NewCategoryName extends NewCategoryState {
  NewCategoryName({required this.color});

  final int color;

  @override
  List<Object> get props => [color];
}

class NewCategoryColor extends NewCategoryState {
  NewCategoryColor(this.name, this.color);

  final String name;
  final int color;

  @override
  List<Object> get props => [name, color];
}

class NewCategoryIcon extends NewCategoryState {
  NewCategoryIcon(this.name, this.color, this.icon);

  final String name;
  final int color;
  final int icon;

  @override
  List<Object> get props => [name, color, icon];
}

class NewCategoryTasks extends NewCategoryState {
  NewCategoryTasks(this.name, this.color, this.icon);

  final String name;
  final int color;
  final int icon;

  @override
  List<Object> get props => [name, color, icon];
}
