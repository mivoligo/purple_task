import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/models/task.dart';
import '../data/repositories/task_repository.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(TaskRepository taskRepository)
      : _taskRepository = taskRepository,
        super(TaskState.initial());

  final TaskRepository _taskRepository;

  Future<void> addTask() async {
    emit(state.copyWith(status: TaskStatus.submitting));
    try {
      final task = state.task!;
      await _taskRepository.addTask(task);
      emit(state.copyWith(status: TaskStatus.success));
    } on Exception catch (_) {
      emit(state.copyWith(
        status: TaskStatus.error,
        errorMessage: 'Something went badly',
      ));
    }
  }

  void nameChanged({required String name}) {
    emit(state.copyWith(
      task: state.task?.copyWith(name: name),
      status: TaskStatus.initial,
    ));
  }

  void dueDateChanged({required int dueDate}) {
    emit(state.copyWith(
      task: state.task?.copyWith(dueDate: dueDate),
      status: TaskStatus.initial,
    ));
  }

  void isDoneChanged({required bool isDone}) {
    emit(state.copyWith(
      task: state.task?.copyWith(isDone: isDone),
      status: TaskStatus.initial,
    ));
  }

  void doneTimeChanged({required int doneTime}) {
    emit(state.copyWith(
      task: state.task?.copyWith(doneTime: doneTime),
      status: TaskStatus.initial,
    ));
  }

  void categoryIdChanged({required int categoryId}) {
    emit(state.copyWith(
      task: state.task?.copyWith(categoryId: categoryId),
      status: TaskStatus.initial,
    ));
  }
}
