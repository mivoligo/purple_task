import 'package:equatable/equatable.dart';
import '../../models/models.dart';

enum TaskTileStateStatus { initial, data, editName }

class TaskTileState extends Equatable {
  const TaskTileState({
    required this.task,
    required this.status,
  });

  factory TaskTileState.initial() {
    return TaskTileState(
      task: Task.empty(),
      status: TaskTileStateStatus.initial,
    );
  }

  final Task task;
  final TaskTileStateStatus status;

  TaskTileState copyWith({
    Task? task,
    TaskTileStateStatus? status,
  }) {
    return TaskTileState(
      task: task ?? this.task,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [task, status];
}
