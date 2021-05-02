import 'package:equatable/equatable.dart';
import '../../models/models.dart';

enum CategoriesStateStatus { initial, loading, data, error }

class CategoriesState extends Equatable {
  CategoriesState({
    required this.categories,
    required this.status,
  });

  factory CategoriesState.initial() {
    return CategoriesState(
      categories: [],
      status: CategoriesStateStatus.initial,
    );
  }

  final List<Category> categories;
  final CategoriesStateStatus status;

  CategoriesState copyWith({
    List<Category>? categories,
    CategoriesStateStatus? status,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [categories, status];
}
