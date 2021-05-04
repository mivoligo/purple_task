import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:purple_task/globals/strings/strings.dart';

import '../../globals/globals.dart';
import '../entities/entities.dart';

class TaskViewModel extends ChangeNotifier {
  late String _newTaskName;

  String get newTaskName => _newTaskName;

  set newTaskName(String value) {
    _newTaskName = value;
    notifyListeners();
  }

  List<TaskEntity> getAllTasksForCategory(int categoryId) {
    final box = Hive.box<TaskEntity>(taskBox);
    return box.values.where((task) => task.categoryId == categoryId).toList();
  }

  List<TaskEntity> getPlannedTasksForCategory(int? categoryId) {
    final box = Hive.box<TaskEntity>(taskBox);
    return box.values
        .where((task) => task.categoryId == categoryId && task.isDone == false)
        .toList();
  }

  List<TaskEntity> getOverdueTasksForCategory(int? categoryId) {
    final allTasksInCategory = getPlannedTasksForCategory(categoryId);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    var overdueTasks = <TaskEntity>[];
    for (var task in allTasksInCategory) {
      if (task.dueDate != null) {
        final dueDateTime = DateTime.fromMillisecondsSinceEpoch(task.dueDate!);
        final dueDate =
            DateTime(dueDateTime.year, dueDateTime.month, dueDateTime.day);
        if (dueDate.isBefore(today)) {
          overdueTasks.add(task);
        }
      }
    }
    ;
    overdueTasks.sort((a, b) => a.dueDate!.compareTo(b.dueDate!));
    return overdueTasks;
  }

  List<TaskEntity> getTodaysTasksForCategory(int? categoryId) {
    final allTasksInCategory = getPlannedTasksForCategory(categoryId);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    var todaysTasks = <TaskEntity>[];
    for (var task in allTasksInCategory) {
      if (task.dueDate != null) {
        final dueDateTime = DateTime.fromMillisecondsSinceEpoch(task.dueDate!);
        final dueDate =
            DateTime(dueDateTime.year, dueDateTime.month, dueDateTime.day);
        if (dueDate == today) {
          todaysTasks.add(task);
        }
      }
    }
    return todaysTasks;
  }

  List<TaskEntity> getTomorrowsTasksForCategory(int? categoryId) {
    final allTasksInCategory = getPlannedTasksForCategory(categoryId);
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    var tomorrowTasks = <TaskEntity>[];
    for (var task in allTasksInCategory) {
      if (task.dueDate != null) {
        final dueDateTime = DateTime.fromMillisecondsSinceEpoch(task.dueDate!);
        final dueDate =
            DateTime(dueDateTime.year, dueDateTime.month, dueDateTime.day);
        if (dueDate == tomorrow) {
          tomorrowTasks.add(task);
        }
      }
    }
    return tomorrowTasks;
  }

  List<TaskEntity> getFutureTasksForCategory(int? categoryId) {
    final allTasksInCategory = getPlannedTasksForCategory(categoryId);
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    var futureTasks = <TaskEntity>[];
    for (var task in allTasksInCategory) {
      if (task.dueDate != null) {
        final dueDateTime = DateTime.fromMillisecondsSinceEpoch(task.dueDate!);
        final dueDate =
            DateTime(dueDateTime.year, dueDateTime.month, dueDateTime.day);
        if (dueDate.isAfter(tomorrow)) {
          futureTasks.add(task);
        }
      }
    }
    futureTasks.sort((a, b) => a.dueDate!.compareTo(b.dueDate!));
    return futureTasks;
  }

  List<TaskEntity> getNoDueDateTasksForCategory(int? categoryId) {
    final allTasksInCategory = getPlannedTasksForCategory(categoryId);
    var noDueDateTasks = <TaskEntity>[];
    for (var task in allTasksInCategory) {
      if (task.dueDate == null) {
        noDueDateTasks.add(task);
      }
    }
    return noDueDateTasks.reversed.toList();
  }

  List<TaskEntity> getCompletedTasksForCategory(int? categoryId) {
    final box = Hive.box<TaskEntity>(taskBox);
    return box.values
        .where((task) => task.categoryId == categoryId && task.isDone == true)
        .toList();
  }

  List<TaskEntity> getTodayCompletedTasksForCategory(int? categoryId) {
    final allCompletedTasksForCategory =
        getCompletedTasksForCategory(categoryId);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    var todayCompletedTasks = <TaskEntity>[];
    for (var task in allCompletedTasksForCategory) {
      if (task.doneTime != null) {
        final doneTime = DateTime.fromMillisecondsSinceEpoch(task.doneTime!);
        final doneDate = DateTime(doneTime.year, doneTime.month, doneTime.day);
        if (doneDate == today) {
          todayCompletedTasks.add(task);
        }
      }
    }
    todayCompletedTasks.sort((b, a) => a.doneTime!.compareTo(b.doneTime!));
    return todayCompletedTasks;
  }

  List<TaskEntity> getYesterdayCompletedTasksForCategory(int? categoryId) {
    final allCompletedTasksForCategory =
        getCompletedTasksForCategory(categoryId);
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    var yesterdayCompletedTasks = <TaskEntity>[];
    for (var task in allCompletedTasksForCategory) {
      if (task.doneTime != null) {
        final doneTime = DateTime.fromMillisecondsSinceEpoch(task.doneTime!);
        final doneDate = DateTime(doneTime.year, doneTime.month, doneTime.day);
        if (doneDate == yesterday) {
          yesterdayCompletedTasks.add(task);
        }
      }
    }
    yesterdayCompletedTasks.sort((b, a) => a.doneTime!.compareTo(b.doneTime!));
    return yesterdayCompletedTasks;
  }

  List<TaskEntity> getEarlierCompletedTasksForCategory(int? categoryId) {
    final allCompletedTasksForCategory =
        getCompletedTasksForCategory(categoryId);
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    var earlierCompletedTasks = <TaskEntity>[];
    var completedTasksWithoutDoneTime = <TaskEntity>[];
    for (var task in allCompletedTasksForCategory) {
      if (task.doneTime != null) {
        final doneTime = DateTime.fromMillisecondsSinceEpoch(task.doneTime!);
        final doneDate = DateTime(doneTime.year, doneTime.month, doneTime.day);
        if (doneDate.isBefore(yesterday)) {
          earlierCompletedTasks.add(task);
        }
      } else {
        completedTasksWithoutDoneTime.add(task);
      }
    }
    earlierCompletedTasks.sort((b, a) => a.doneTime!.compareTo(b.doneTime!));
    earlierCompletedTasks.addAll(completedTasksWithoutDoneTime);
    return earlierCompletedTasks;
  }

  Future<void> addTask(TaskEntity task) async {
    var box = await Hive.openBox<TaskEntity>(taskBox);

    box.add(task);

    notifyListeners();
  }

  int numberOfAllPlannedTasks() {
    final box = Hive.box<TaskEntity>(taskBox);
    final result = box.values.where((task) => task.isDone == false).length;
    return result;
  }

  int numberOfAllTasksForCategory(int? categoryId) {
    final box = Hive.box<TaskEntity>(taskBox);
    final result =
        box.values.where((task) => task.categoryId == categoryId).length;
    return result;
  }

  int numberOfCompletedTasksForCategory(int? categoryId) {
    final box = Hive.box<TaskEntity>(taskBox);
    final result = box.values
        .where((task) => task.categoryId == categoryId && task.isDone == true)
        .length;
    return result;
  }

  int numberOfPlannedTasksForCategory(int? categoryId) {
    final box = Hive.box<TaskEntity>(taskBox);
    final result = box.values
        .where((task) => task.categoryId == categoryId && task.isDone == false)
        .length;
    return result;
  }

  double completionProgress(int? categoryId) {
    if (numberOfAllTasksForCategory(categoryId) == 0) {
      return 0.0; // to avoid error when creating category without tasks
    }
    return numberOfCompletedTasksForCategory(categoryId) /
        numberOfAllTasksForCategory(categoryId);
  }

  void updateTask(dynamic key, TaskEntity task) {
    final box = Hive.box<TaskEntity>(taskBox);

    box.put(key, task);

    notifyListeners();
  }

  void deleteTask(dynamic key) {
    final box = Hive.box<TaskEntity>(taskBox);

    box.delete(key);

    notifyListeners();
  }

  void deleteAllTasksForCategory(int? categoryId) {
    final box = Hive.box<TaskEntity>(taskBox);
    List _tasks =
        box.values.where((task) => task.categoryId == categoryId).toList();
    for (var task in _tasks) {
      task.remove();
    }
    notifyListeners();
  }

  void deleteCompletedTasksForCategory(int? categoryId) {
    final box = Hive.box<TaskEntity>(taskBox);
    List _tasks = box.values
        .where((task) => task.categoryId == categoryId && task.isDone == true)
        .toList();
    for (var task in _tasks) {
      task.remove();
    }
    notifyListeners();
  }

  int setTaskDoneTime() {
    final now = DateTime.now().millisecondsSinceEpoch;
    return now;
  }

  String displayDueDate(int? dateInMillis, String? dateFormat) {
    if (dateInMillis != null) {
      final now = DateTime.now();
      final todayDate = DateTime(now.year, now.month, now.day);
      final tomorrowDate = DateTime(now.year, now.month, now.day + 1);
      final dueDateTime = DateTime.fromMillisecondsSinceEpoch(dateInMillis);
      final dueDate =
          DateTime(dueDateTime.year, dueDateTime.month, dueDateTime.day);
      if (dueDate == todayDate) {
        return today;
      } else if (dueDate == tomorrowDate) {
        return tomorrow;
      } else {
        return DateFormat(dateFormat).format(dueDate);
      }
    }
    return noDate;
  }
}
