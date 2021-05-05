import 'package:equatable/equatable.dart';
import '../../models/models.dart';

enum TasksStateStatus { initial, loading, data, error }

enum Filter { all, active, completed }

class TasksState extends Equatable {
  TasksState({
    required this.tasks,
    required this.status,
    required this.filter,
  });

  factory TasksState.initial() {
    return TasksState(
      tasks: [],
      status: TasksStateStatus.initial,
      filter: Filter.all,
    );
  }

  final List<Task> tasks;
  final TasksStateStatus status;
  final Filter filter;

  TasksState copyWith({
    List<Task>? tasks,
    TasksStateStatus? status,
    Filter? filter,
  }) {
    return TasksState(
      tasks: tasks ?? this.tasks,
      status: status ?? this.status,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [tasks, status, filter];
}
