import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/models/task.dart';
import '../data/repositories/task_repository.dart';

part 'new_task_state.dart';

class NewTaskCubit extends Cubit<NewTaskState> {
  NewTaskCubit(TaskRepository taskRepository)
      : _taskRepository = taskRepository,
        super(NewTaskState.initial());

  final TaskRepository _taskRepository;

  void loadEmptyTask({int? categoryId}) {
    emit(state.copyWith(categoryId: categoryId, status: NewTaskStatus.initial));
  }

  Future<void> addTask() async {
    emit(state.copyWith(status: NewTaskStatus.submitting));
    try {
      final task = Task(name: state.name, categoryId: state.categoryId);
      await _taskRepository.addTask(task);
      emit(state.copyWith(status: NewTaskStatus.success));
    } on Exception catch (_) {
      emit(state.copyWith(
        status: NewTaskStatus.error,
        errorMessage: 'Something went badly',
      ));
    }
  }

  void nameChanged({required String name}) {
    emit(state.copyWith(
      name: name,
      status: NewTaskStatus.initial,
    ));
  }

  void categoryIdChanged({required int categoryId}) {
    emit(state.copyWith(
      categoryId: categoryId,
      status: NewTaskStatus.initial,
    ));
  }
}
