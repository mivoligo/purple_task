import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/models.dart';
import '../../repositories/repositories.dart';
import '../controllers.dart';

final tasksProvider = StateNotifierProvider<TasksController, TasksState>((ref) {
  return TasksController(
    baseTaskRepository: ref.watch(taskRepositoryProvider),
  );
});

final filteredTasksProvider =
    Provider.family<List<Task>, int>((ref, categoryId) {
  final filter = ref.watch(tasksProvider).filter;
  final tasks = ref.watch(tasksProvider).tasks;

  switch (filter) {
    case Filter.all:
      return tasks.where((task) => task.categoryId == categoryId).toList();
    case Filter.active:
      return tasks
          .where((task) => task.categoryId == categoryId && !task.isDone)
          .toList();
    case Filter.completed:
      return tasks
          .where((task) => task.categoryId == categoryId && task.isDone)
          .toList();
  }
});

final allActiveTasksProvider = Provider<int>((ref) {
  final tasks = ref.watch(tasksProvider).tasks;
  return tasks.where((element) => !element.isDone).length;
});

final uncategorizedTasksProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(tasksProvider).tasks;
  return tasks.where((element) => element.categoryId == -1).toList();
});

final activeTasksNumberProvider = Provider.family<int, int>((ref, categoryId) {
  final tasks = ref.watch(tasksProvider).tasks;
  return tasks
      .where((task) => task.categoryId == categoryId && !task.isDone)
      .length;
});

final progressProvider = Provider.family<double, int>((ref, categoryId) {
  final tasks = ref.watch(tasksProvider).tasks;
  final allTasks = tasks.where((task) => task.categoryId == categoryId).length;
  final completedTasks = tasks
      .where((task) => task.categoryId == categoryId && task.isDone)
      .length;
  if (allTasks > 0) {
    return completedTasks / allTasks;
  } else {
    return 0;
  }
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
    final newTask = await _taskRepository.add(task: task);
    state = state.copyWith(
      tasks: [...state.tasks, newTask],
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

  Future<void> removeAllTasksForCategory({required int categoryId}) async {
    await _taskRepository.removeAllTasksForCategory(categoryId);
    state = state.copyWith(
      tasks: state.tasks
          .where((element) => element.categoryId != categoryId)
          .toList(),
      status: TasksStateStatus.data,
    );
  }

  Future<void> removeCompletedTasksForCategory(
      {required int categoryId}) async {
    await _taskRepository.removeCompletedTasksForCategory(categoryId);
    state = state.copyWith(
      tasks: state.tasks
          .where((element) =>
              !(element.categoryId == categoryId && element.isDone))
          .toList(),
      status: TasksStateStatus.data,
    );
  }

  void filterTasks({required Filter filter}) {
    state = state.copyWith(filter: filter);
  }
}
