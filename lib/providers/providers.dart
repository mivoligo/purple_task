import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../categories/controllers/categories_controller.dart';
import '../categories/controllers/category_controller.dart';
import '../constants/constants.dart';
import '../controllers/controllers.dart';
import '../helpers.dart';
import '../migrator.dart';
import '../repositories/app_version_repository/app_version_repository.dart';
import '../repositories/repositories.dart';
import '../repositories/settings_repository/shared_pref_settings_repository.dart';
import '../tasks/controllers/tasks_controller.dart';
import '../tasks/models/task.dart';

part 'providers.g.dart';

@riverpod
class NoDueDateTasksInCategory extends _$NoDueDateTasksInCategory {
  @override
  List<Task> build(int categoryId) {
    final tasks = ref
        .watch(tasksNotifierProvider)
        .where(
          (task) =>
              task.categoryId == categoryId &&
              !task.isDone &&
              task.dueDate == null,
        )
        .toList();
    return tasks;
  }
}

@riverpod
class OverdueTasksInCategory extends _$OverdueTasksInCategory {
  @override
  List<Task> build(int categoryId) {
    final tasks = ref.watch(tasksNotifierProvider).where(
          (task) =>
              task.categoryId == categoryId &&
              !task.isDone &&
              task.dueDate != null,
        );
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final overdueTasks = <Task>[];
    for (final task in tasks) {
      final taskDueDate = task.dueDate!.millisToDay();
      if (taskDueDate.isBefore(today)) {
        overdueTasks.add(task);
      }
    }
    overdueTasks.sort(
      (a, b) => a.dueDate!.compareTo(b.dueDate!),
    );
    return overdueTasks;
  }
}

@riverpod
class TodayTasksInCategory extends _$TodayTasksInCategory {
  @override
  List<Task> build(int categoryId) {
    final tasks = ref.watch(tasksNotifierProvider).where(
          (task) =>
              !task.isDone &&
              task.categoryId == categoryId &&
              task.dueDate != null,
        );
    final todayTasks = <Task>[];
    for (final task in tasks) {
      final taskDueDate = task.dueDate!.millisToDay();
      if (taskDueDate.isToday) {
        todayTasks.add(task);
      }
    }
    return todayTasks;
  }
}

@riverpod
class TomorrowTasksInCategory extends _$TomorrowTasksInCategory {
  @override
  List<Task> build(int categoryId) {
    final tasks = ref.watch(tasksNotifierProvider).where(
          (task) =>
              task.categoryId == categoryId &&
              !task.isDone &&
              task.dueDate != null,
        );
    final tomorrowTasks = <Task>[];
    for (final task in tasks) {
      final taskDueDate = task.dueDate!.millisToDay();
      if (taskDueDate.isTomorrow) {
        tomorrowTasks.add(task);
      }
    }
    return tomorrowTasks;
  }
}

@riverpod
class FutureTasksInCategory extends _$FutureTasksInCategory {
  @override
  List<Task> build(int categoryId) {
    final tasks = ref.watch(tasksNotifierProvider).where(
          (task) =>
              task.categoryId == categoryId &&
              !task.isDone &&
              task.dueDate != null,
        );
    final futureTasks = <Task>[];
    for (final task in tasks) {
      final taskDueDate = task.dueDate!.millisToDay();
      if (taskDueDate.isAfterTomorrow) {
        futureTasks.add(task);
      }
    }
    futureTasks.sort((a, b) => a.dueDate!.compareTo(b.dueDate!));
    return futureTasks;
  }
}

@riverpod
class TodayCompletedTasksInCategory extends _$TodayCompletedTasksInCategory {
  @override
  List<Task> build(int categoryId) {
    final tasks = ref.watch(tasksNotifierProvider).where(
          (task) =>
              task.categoryId == categoryId &&
              task.isDone &&
              task.doneTime != null,
        );
    final todayCompletedTasks = <Task>[];
    for (final task in tasks) {
      final taskDoneDate = task.doneTime!.millisToDay();
      if (taskDoneDate.isToday) {
        todayCompletedTasks.add(task);
      }
    }
    todayCompletedTasks.sort((b, a) => a.doneTime!.compareTo(b.doneTime!));
    return todayCompletedTasks;
  }
}

@riverpod
class YesterdayCompletedTasksInCategory
    extends _$YesterdayCompletedTasksInCategory {
  @override
  List<Task> build(int categoryId) {
    final tasks = ref.watch(tasksNotifierProvider).where(
          (task) =>
              task.categoryId == categoryId &&
              task.isDone &&
              task.doneTime != null,
        );
    final yesterdayCompletedTasks = <Task>[];
    for (final task in tasks) {
      final taskDoneDate = task.doneTime!.millisToDay();
      if (taskDoneDate.isYesterday) {
        yesterdayCompletedTasks.add(task);
      }
    }
    yesterdayCompletedTasks.sort((b, a) => a.doneTime!.compareTo(b.doneTime!));
    return yesterdayCompletedTasks;
  }
}

@riverpod
class PastCompletedTasksInCategory extends _$PastCompletedTasksInCategory {
  @override
  List<Task> build(int categoryId) {
    final tasks = ref
        .watch(tasksNotifierProvider)
        .where((task) => task.categoryId == categoryId && task.isDone);
    final pastCompletedTasks = <Task>[];
    final completedTasksWithoutDoneTime = <Task>[];
    for (final task in tasks) {
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
    return [...pastCompletedTasks, ...completedTasksWithoutDoneTime];
  }
}

@riverpod
int numberOfAllActiveTasks(Ref ref) {
  final tasks = ref.watch(tasksNotifierProvider);
  return tasks.where((element) => !element.isDone).length;
}

@riverpod
List<Task> uncategorizedTasks(Ref ref) {
  return ref
      .watch(tasksNotifierProvider)
      .where((element) => element.categoryId == -1)
      .toList();
}

@riverpod
int numberOfActiveTasksInCategory(Ref ref, int? categoryId) {
  if (categoryId == null) {
    return 0;
  }
  return ref
      .watch(tasksNotifierProvider)
      .where((task) => task.categoryId == categoryId && !task.isDone)
      .length;
}

@riverpod
double completionProgress(Ref ref, int categoryId) {
  final tasks = ref.watch(tasksNotifierProvider);
  final allTasksInCategory =
      tasks.where((task) => task.categoryId == categoryId);
  final completedTasksInCategory =
      allTasksInCategory.where((task) => task.isDone);
  if (allTasksInCategory.isNotEmpty) {
    return completedTasksInCategory.length / allTasksInCategory.length;
  }
  return 0.0;
}

@riverpod
BaseSettingsRepository settingsRepository(Ref ref) =>
    SharedPrefSettingsRepository(asyncPrefs: SharedPreferencesAsync());

@riverpod
bool isUncategorizedViewPreferred(Ref ref) {
  final settings = ref.watch(settingsNotifierProvider);

  return settings.value?.isUncategorizedViewPreferred ?? true;
}

@riverpod
Color appBackgroundColor(Ref ref) {
  final currentCategory = ref.watch(categoryNotifierProvider);
  final currentCategoryInList = ref
      .watch(categoriesNotifierProvider)
      .valueOrNull
      ?.firstWhereOrNull((element) => element.id == currentCategory?.id);
  return currentCategoryInList?.color ?? Colors.deepPurple;
}

@riverpod
AppVersionRepository appVersionRepository(Ref ref) =>
    AppVersionRepository(asyncPrefs: SharedPreferencesAsync());

@riverpod
class AppVersion extends _$AppVersion {
  @override
  Future<int?> build() async {
    final appVersionRepository = ref.watch(appVersionRepositoryProvider);

    return appVersionRepository.getAppVersion();
  }

  void setAppVersion() {
    ref.read(appVersionRepositoryProvider).setAppVersion();
  }
}

@riverpod
SettingsMigrator settingsMigrator(Ref ref) => SettingsMigrator(
      asyncPrefs: SharedPreferencesAsync(),
      settingsBox: Hive.box(settingsBox),
    );
