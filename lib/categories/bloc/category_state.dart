part of 'category_cubit.dart';

enum CategoryStatus { initial, editing, success, error }

class CategoryState extends Equatable {
  const CategoryState({
    required this.category,
    required this.status,
    required this.errorMessage,
  });

  factory CategoryState.initial() {
    return CategoryState(
      category: null,
      status: CategoryStatus.initial,
      errorMessage: '',
    );
  }

  final CategoryEntity? category;
  final CategoryStatus status;
  final String errorMessage;

  @override
  List<Object?> get props => [category, status, errorMessage];

  CategoryState copyWith({
    CategoryEntity? category,
    CategoryStatus? status,
    String? errorMessage,
  }) {
    return CategoryState(
      category: category ?? this.category,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
