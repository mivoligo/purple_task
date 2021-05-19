import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/controllers.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';

final categoryRepositoryProvider = Provider((ref) => CategoryRepository());

final categoriesProvider =
    StateNotifierProvider<CategoriesController, CategoriesState>((ref) {
  return CategoriesController(
    baseCategoryRepository: ref.watch(categoryRepositoryProvider),
  );
});

final categoryNameProvider = Provider.family<String, int>((ref, categoryId) {
  final categories = ref.watch(categoriesProvider).categories;
  return categories.firstWhere((element) => element.id == categoryId).name;
});

final categoryColorProvider = Provider.family<Color, int>((ref, categoryId) {
  final categories = ref.watch(categoriesProvider).categories;
  return categories.firstWhere((element) => element.id == categoryId).color;
});

final categoryIconProvider = Provider.family<int, int>((ref, categoryId) {
  final categories = ref.watch(categoriesProvider).categories;
  return categories.firstWhere((element) => element.id == categoryId).icon;
});

final newCategoryControllerProvider =
    StateNotifierProvider.autoDispose<NewCategoryController, NewCategoryState>(
  (ref) {
    return NewCategoryController(
      categoriesController: ref.watch(categoriesProvider.notifier),
      tasksController: ref.watch(tasksProvider.notifier),
    );
  },
);

final categoryProvider =
    StateNotifierProvider.family<CategoryController, CategoryState, Category>(
        (ref, category) {
  return CategoryController(category: category);
});

final taskRepositoryProvider = Provider((ref) => TaskRepository());

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

final taskTileProvider = StateNotifierProvider.family
    .autoDispose<TaskTileController, TaskTileState, Task>(
  (ref, task) => TaskTileController(task: task),
);
final settingsRepositoryProvider = Provider((ref) => SettingsRepository());

final settingsControllerProvider =
    StateNotifierProvider<SettingsController, SettingsState>((ref) {
  return SettingsController(
      baseSettingsRepository: ref.watch(settingsRepositoryProvider));
});

final currentCategoryProvider = StateProvider<Category?>((_) => null);

final backgroundColorProvider = Provider<Color>((ref) {
  final currentCategory = ref.watch(currentCategoryProvider).state;
  final categories = ref.watch(categoriesProvider).categories;
  if (categories.isEmpty) {
    return Colors.purple;
  } else {
    if (currentCategory == null) {
      return categories[0].color;
    } else {
      return currentCategory.color;
    }
  }
});
