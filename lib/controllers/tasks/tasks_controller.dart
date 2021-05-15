import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/models.dart';
import '../../repositories/repositories.dart';
import '../controllers.dart';

final tasksProvider = StateNotifierProvider<TasksController, TasksState>((ref) {
  return TasksController(
    baseTaskRepository: ref.watch(taskRepositoryProvider),
  );
});

final noDueDateTasksProvider =
    Provider.family<List<Task>, int>((ref, categoryId) {
  final tasks = ref
      .watch(tasksProvider)
      .tasks
      .where((task) =>
          !task.isDone && task.categoryId == categoryId && task.dueDate == null)
      .toList();
  return tasks.reversed.toList();
});

final overdueTasksProvider =
    Provider.family<List<Task>, int>((ref, categoryId) {
  final tasks = ref
      .watch(tasksProvider)
      .tasks
      .where((task) => !task.isDone && task.categoryId == categoryId);
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  var overdueTasks = <Task>[];
  for (var task in tasks) {
    if (task.dueDate != null) {
      final taskDueTime = DateTime.fromMillisecondsSinceEpoch(task.dueDate!);
      final taskDueDate =
          DateTime(taskDueTime.year, taskDueTime.month, taskDueTime.day);
      if (taskDueDate.isBefore(today)) {
        overdueTasks.add(task);
      }
    }
  }
  overdueTasks.sort((a, b) => a.dueDate!.compareTo(b.dueDate!));
  return overdueTasks;
});

final todayTasksProvider = Provider.family<List<Task>, int>((ref, categoryId) {
  final tasks = ref
      .watch(tasksProvider)
      .tasks
      .where((task) => !task.isDone && task.categoryId == categoryId);
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  var todayTasks = <Task>[];
  for (var task in tasks) {
    if (task.dueDate != null) {
      final taskDueTime = DateTime.fromMillisecondsSinceEpoch(task.dueDate!);
      final taskDueDate =
          DateTime(taskDueTime.year, taskDueTime.month, taskDueTime.day);
      if (taskDueDate == today) {
        todayTasks.add(task);
      }
    }
  }
  return todayTasks;
});

final tomorrowTasksProvider =
    Provider.family<List<Task>, int>((ref, categoryId) {
  final tasks = ref
      .watch(tasksProvider)
      .tasks
      .where((task) => !task.isDone && task.categoryId == categoryId);
  final now = DateTime.now();
  final tomorrow = DateTime(now.year, now.month, now.day + 1);
  var tomorrowTasks = <Task>[];
  for (var task in tasks) {
    if (task.dueDate != null) {
      final taskDueTime = DateTime.fromMillisecondsSinceEpoch(task.dueDate!);
      final taskDueDate =
          DateTime(taskDueTime.year, taskDueTime.month, taskDueTime.day);
      if (taskDueDate == tomorrow) {
        tomorrowTasks.add(task);
      }
    }
  }
  return tomorrowTasks;
});

final futureTasksProvider = Provider.family<List<Task>, int>((ref, categoryId) {
  final tasks = ref
      .watch(tasksProvider)
      .tasks
      .where((task) => !task.isDone && task.categoryId == categoryId);
  final now = DateTime.now();
  final tomorrow = DateTime(now.year, now.month, now.day + 1);
  var futureTasks = <Task>[];
  for (var task in tasks) {
    if (task.dueDate != null) {
      final taskDueTime = DateTime.fromMillisecondsSinceEpoch(task.dueDate!);
      final taskDueDate =
          DateTime(taskDueTime.year, taskDueTime.month, taskDueTime.day);
      if (taskDueDate.isAfter(tomorrow)) {
        futureTasks.add(task);
      }
    }
  }
  futureTasks.sort((a, b) => a.dueDate!.compareTo(b.dueDate!));
  return futureTasks;
});

final todayCompletedTasksProvider =
    Provider.family<List<Task>, int>((ref, categoryId) {
  final tasks = ref
      .watch(tasksProvider)
      .tasks
      .where((task) => task.isDone && task.categoryId == categoryId);
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  var todayCompletedTasks = <Task>[];
  for (var task in tasks) {
    if (task.doneTime != null) {
      final taskDoneTime = DateTime.fromMillisecondsSinceEpoch(task.doneTime!);
      final taskDoneDate =
          DateTime(taskDoneTime.year, taskDoneTime.month, taskDoneTime.day);
      if (taskDoneDate == today) {
        todayCompletedTasks.add(task);
      }
    }
  }
  todayCompletedTasks.sort((b, a) => a.doneTime!.compareTo(b.doneTime!));
  return todayCompletedTasks;
});

final yesterdayCompletedTasksProvider =
    Provider.family<List<Task>, int>((ref, categoryId) {
  final tasks = ref
      .watch(tasksProvider)
      .tasks
      .where((task) => task.isDone && task.categoryId == categoryId);
  final now = DateTime.now();
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  var yesterdayCompletedTasks = <Task>[];
  for (var task in tasks) {
    if (task.doneTime != null) {
      final taskDoneTime = DateTime.fromMillisecondsSinceEpoch(task.doneTime!);
      final taskDoneDate =
          DateTime(taskDoneTime.year, taskDoneTime.month, taskDoneTime.day);
      if (taskDoneDate == yesterday) {
        yesterdayCompletedTasks.add(task);
      }
    }
  }
  yesterdayCompletedTasks.sort((b, a) => a.doneTime!.compareTo(b.doneTime!));
  return yesterdayCompletedTasks;
});

final pastCompletedTasksProvider =
    Provider.family<List<Task>, int>((ref, categoryId) {
  final tasks = ref
      .watch(tasksProvider)
      .tasks
      .where((task) => task.isDone && task.categoryId == categoryId);
  final now = DateTime.now();
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  var pastCompletedTasks = <Task>[];
  var completedTasksWithoutDoneTime = <Task>[];
  for (var task in tasks) {
    if (task.doneTime != null) {
      final taskDoneTime = DateTime.fromMillisecondsSinceEpoch(task.doneTime!);
      final taskDoneDate =
          DateTime(taskDoneTime.year, taskDoneTime.month, taskDoneTime.day);
      if (taskDoneDate.isBefore(yesterday)) {
        pastCompletedTasks.add(task);
      }
    } else {
      completedTasksWithoutDoneTime.add(task);
    }
  }
  pastCompletedTasks.sort((b, a) => a.doneTime!.compareTo(b.doneTime!));
  pastCompletedTasks.addAll(completedTasksWithoutDoneTime);
  return pastCompletedTasks;
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
