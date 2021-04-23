part of 'task_list_cubit.dart';

abstract class TaskListState extends Equatable {
  const TaskListState();

  @override
  List<Object> get props => [];
}

class TaskListInitial extends TaskListState {}

class TaskListLoading extends TaskListState {}

class TaskListLoaded extends TaskListState {
  TaskListLoaded({required this.tasks});

  final List<Task> tasks;

  @override
  List<Object> get props => [tasks];
}

class TaskListError extends TaskListState {}
