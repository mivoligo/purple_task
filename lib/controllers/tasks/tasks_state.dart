import 'package:equatable/equatable.dart';
import '../../models/models.dart';

enum TasksStateStatus { initial, loading, data, error }

class TasksState extends Equatable {
  TasksState({
    required this.tasks,
    required this.status,
  });

  factory TasksState.initial() {
    return TasksState(
      tasks: [],
      status: TasksStateStatus.initial,
    );
  }

  final List<Task> tasks;
  final TasksStateStatus status;

  TasksState copyWith({
    List<Task>? tasks,
    TasksStateStatus? status,
  }) {
    return TasksState(
      tasks: tasks ?? this.tasks,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [tasks];
}
