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
      emit(TaskListLoaded(tasks: List.from(tasks)));
    } on Exception catch (_) {
      emit(TaskListError());
    }
  }

  void deleteAllTasksForCategory(int categoryId) async {
    try {
      await _taskRepository.deleteAllTasksForCategory(categoryId);
      final tasks = _taskRepository.getAllTasksForCategory(categoryId);
      emit(TaskListLoaded(tasks: List.from(tasks)));
    } on Exception catch (_) {
      emit(TaskListError());
    }
  }

  void deleteCompletedTasksForCategory(int categoryId) async {
    await _taskRepository.deleteCompletedTasksForCategory(categoryId);
    // final tasks = _taskRepository.getAllTasksForCategory(categoryId);
    // emit(TaskListLoaded(tasks: tasks));
  }
}
