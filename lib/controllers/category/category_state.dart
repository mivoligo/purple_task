import 'package:equatable/equatable.dart';
import '../../models/models.dart';

enum CategoryStatus { initial, data, error, remove }

class CategoryState extends Equatable {
  CategoryState({
    required this.category,
    required this.status,
  });

  factory CategoryState.initial() {
    return CategoryState(
      category: Category.empty(),
      status: CategoryStatus.initial,
    );
  }

  final Category category;
  final CategoryStatus status;

  CategoryState copyWith({
    Category? category,
    CategoryStatus? status,
  }) {
    return CategoryState(
      category: category ?? this.category,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [category, status];
}
