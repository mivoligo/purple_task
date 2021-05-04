import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/models.dart';
import '../../repositories/repositories.dart';
import '../controllers.dart';

final tasksProvider = StateNotifierProvider<TasksController, TasksState>((ref) {
  return TasksController(
    baseTaskRepository: ref.watch(taskRepositoryProvider),
  );
});

class TasksController extends StateNotifier<TasksState> {
  TasksController({
    required BaseTaskRepository baseTaskRepository,
  })  : _taskRepository = baseTaskRepository,
        super(TasksState.initial()) {
    _fetchTasks();
  }

  final BaseTaskRepository _taskRepository;

  void _fetchTasks() {
    state = state.copyWith(status: TasksStateStatus.loading);
    final tasks = _taskRepository.getTasks();
    state = state.copyWith(
      tasks: tasks,
      status: TasksStateStatus.data,
    );
  }

  Future<void> add({required Task task}) async {
    await _taskRepository.add(task: task);
    state = state.copyWith(
      tasks: [...state.tasks, task],
      status: TasksStateStatus.data,
    );
  }

  Future<void> remove({required Task task}) async {
    await _taskRepository.remove(task: task);
    state = state.copyWith(
      tasks: state.tasks.where((element) => element.key != task.key).toList(),
      status: TasksStateStatus.data,
    );
  }

  Future<void> update({required Task task}) async {
    await _taskRepository.update(task: task);
    state = state.copyWith(
      tasks: [
        for (final element in state.tasks)
          if (element.key == task.key) task else element,
      ],
      status: TasksStateStatus.data,
    );
  }
}
