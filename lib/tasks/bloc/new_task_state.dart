part of 'new_task_cubit.dart';

enum NewTaskStatus { initial, submitting, success, error }

class NewTaskState extends Equatable {
  const NewTaskState({
    required this.name,
    required this.categoryId,
    required this.status,
    required this.errorMessage,
  });

  factory NewTaskState.initial() {
    return NewTaskState(
      name: '',
      categoryId: -1,
      status: NewTaskStatus.initial,
      errorMessage: '',
    );
  }

  final String name;
  final int categoryId;
  final NewTaskStatus status;
  final String errorMessage;

  @override
  List<Object> get props => [name, categoryId, status, errorMessage];

  NewTaskState copyWith({
    String? name,
    int? categoryId,
    NewTaskStatus? status,
    String? errorMessage,
  }) {
    return NewTaskState(
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
