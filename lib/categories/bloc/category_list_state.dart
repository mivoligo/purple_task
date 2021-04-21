part of 'category_list_cubit.dart';

abstract class CategoryListState extends Equatable {
  const CategoryListState();
  @override
  List<Object> get props => [];
}

class CategoryListInitial extends CategoryListState {}

class CategoryListLoading extends CategoryListState {}

class CategoryListLoaded extends CategoryListState {
  CategoryListLoaded(this.categories);

  final List<Category> categories;

  @override
  List<Object> get props => [categories];
}

class CategoryListError extends CategoryListState {}
