import 'package:equatable/equatable.dart';

class CategoryState extends Equatable {
  const CategoryState({
    required this.allTasksNumber,
    required this.activeTasksNumber,
    required this.completedTasksNumber,
  });

  factory CategoryState.initial() {
    return const CategoryState(
      allTasksNumber: 0,
      activeTasksNumber: 0,
      completedTasksNumber: 0,
    );
  }

  final int allTasksNumber;
  final int activeTasksNumber;
  final int completedTasksNumber;

  double get progress {
    if (allTasksNumber > 0) {
      return completedTasksNumber / allTasksNumber;
    } else {
      return 0.0;
    }
  }

  CategoryState copyWith({
    int? allTasksNumber,
    int? activeTasksNumber,
    int? completedTasksNumber,
  }) {
    return CategoryState(
      allTasksNumber: allTasksNumber ?? this.allTasksNumber,
      activeTasksNumber: activeTasksNumber ?? this.activeTasksNumber,
      completedTasksNumber: completedTasksNumber ?? this.completedTasksNumber,
    );
  }

  @override
  List<Object?> get props => [
        allTasksNumber,
        activeTasksNumber,
        completedTasksNumber,
      ];
}
