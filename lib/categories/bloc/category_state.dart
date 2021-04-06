part of 'category_cubit.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoaded extends CategoryState {
  const CategoryLoaded(this.category);

  final Category category;

  @override
  List<Object> get props => [category];
}
