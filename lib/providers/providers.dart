import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/controllers.dart';
import '../helpers.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';

final categoryRepositoryProvider = Provider((ref) => CategoryRepository());

final categoriesProvider =
    StateNotifierProvider<CategoriesController, CategoriesState>((ref) {
  return CategoriesController(
    baseCategoryRepository: ref.watch(categoryRepositoryProvider),
  );
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
  var todayTasks = <Task>[];
  for (var task in tasks) {
    if (task.dueDate != null) {
      final taskDueDate = task.dueDate?.millisToDay();
      if (taskDueDate!.isToday) {
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
  var tomorrowTasks = <Task>[];
  for (var task in tasks) {
    if (task.dueDate != null) {
      final taskDueDate = task.dueDate!.millisToDay();
      if (taskDueDate.isTomorrow) {
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
  var futureTasks = <Task>[];
  for (var task in tasks) {
    if (task.dueDate != null) {
      final taskDueDate = task.dueDate!.millisToDay();
      if (taskDueDate.isAfterTomorrow) {
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
  var todayCompletedTasks = <Task>[];
  for (var task in tasks) {
    if (task.doneTime != null) {
      final taskDoneDate = task.doneTime!.millisToDay();
      if (taskDoneDate.isToday) {
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
  var yesterdayCompletedTasks = <Task>[];
  for (var task in tasks) {
    if (task.doneTime != null) {
      final taskDoneDate = task.doneTime!.millisToDay();
      if (taskDoneDate.isYesterday) {
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
  var pastCompletedTasks = <Task>[];
  var completedTasksWithoutDoneTime = <Task>[];
  for (var task in tasks) {
    if (task.doneTime != null) {
      final taskDoneDate = task.doneTime!.millisToDay();
      if (taskDoneDate.isBeforeYesterday) {
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

final allActiveTasksProvider = Provider<int>((ref) {
  final tasks = ref.watch(tasksProvider).tasks;
  return tasks.where((element) => !element.isDone).length;
});

final uncategorizedTasksProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(tasksProvider).tasks;
  return tasks.where((element) => element.categoryId == -1).toList();
});

final activeTasksNumberProvider = Provider.family<int, int?>((ref, categoryId) {
  if (categoryId == null) {
    return 0;
  }
  final tasks = ref.watch(tasksProvider).tasks;
  return tasks
      .where((task) => task.categoryId == categoryId && !task.isDone)
      .length;
});

final progressProvider = Provider.family<double, int?>((ref, categoryId) {
  if (categoryId == null) {
    return 0;
  }
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

final currentCategoryIndexProvider = StateProvider<int>((_) => 0);

final backgroundColorNarrowLayoutProvider = Provider<Color>((ref) {
  final categories = ref.watch(categoriesProvider).categories;
  final currentIndex = ref.watch(currentCategoryIndexProvider);
  if (categories.isEmpty) {
    return Colors.deepPurple;
  } else {
    return categories[currentIndex].color;
  }
});

final backgroundColorWideLayoutProvider = Provider<Color>((ref) {
  final currentCategory = ref.watch(currentCategoryProvider);
  return currentCategory?.color ?? Colors.deepPurple;
});

enum CategoryCreatorStatus { normal, success }

final categoryCreatorStatusProvider =
    StateProvider((_) => CategoryCreatorStatus.normal);

enum CategoryScreenStatus { data, remove }

final categoryScreenStatusProvider =
    StateProvider((_) => CategoryScreenStatus.data);
