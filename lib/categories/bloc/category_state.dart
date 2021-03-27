part of 'category_cubit.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  CategoryLoaded(this.categories);

  final List<Category> categories;

  @override
  List<Object> get props => [categories];
}

class CategoryError extends CategoryState {}
