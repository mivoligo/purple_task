part of 'task_cubit.dart';

enum TaskStatus { initial, submitting, success, error }

class TaskState extends Equatable {
  const TaskState({
    required this.task,
    required this.status,
    required this.errorMessage,
  });

  factory TaskState.initial() {
    return TaskState(
      task: null,
      status: TaskStatus.initial,
      errorMessage: '',
    );
  }

  final Task? task;
  final TaskStatus status;
  final String errorMessage;

  @override
  List<Object?> get props => [task, status, errorMessage];

  TaskState copyWith({
    Task? task,
    TaskStatus? status,
    String? errorMessage,
  }) {
    return TaskState(
      task: task ?? this.task,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
