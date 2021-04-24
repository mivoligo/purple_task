import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/models/task.dart';
import '../data/repositories/task_repository.dart';

part 'task_list_state.dart';

class TaskListCubit extends Cubit<TaskListState> {
  TaskListCubit(this._taskRepository) : super(TaskListInitial());

  final TaskRepository _taskRepository;

  void loadTasksForCategory(int categoryId) {
    emit(TaskListLoading());
    try {
      final tasks = _taskRepository.getAllTasksForCategory(categoryId);
      emit(TaskListLoaded(tasks: tasks));
    } on Exception catch (_) {
      emit(TaskListError());
    }
  }
}
