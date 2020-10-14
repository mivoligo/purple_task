import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../../globals/globals.dart';
import '../../db_models/db_models.dart';

class TaskViewModel with ChangeNotifier {
  String _newTaskName;

  String get newTaskName => _newTaskName;

  set newTaskName(String value) {
    _newTaskName = value;
    notifyListeners();
  }

  List<Task> getAllTasksForCategory(int categoryId) {
    final box = Hive.box<Task>(TASK_BOX);
    return box.values.where((task) => task.categoryId == categoryId).toList();
  }

  List<Task> getPlannedTasksForCategory(int categoryId) {
    final box = Hive.box<Task>(TASK_BOX);
    return box.values
        .where((task) => task.categoryId == categoryId && task.isDone == false)
        .toList();
  }

  List<Task> getOverdueTasksForCategory(int categoryId) {
    final allTasksInCategory = getPlannedTasksForCategory(categoryId);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    List<Task> overdueTasks = [];
    allTasksInCategory.forEach(
      (task) {
        if (task.dueDate != null) {
          final dueDateTime = DateTime.fromMillisecondsSinceEpoch(task.dueDate);
          final dueDate =
              DateTime(dueDateTime.year, dueDateTime.month, dueDateTime.day);
          if (dueDate.isBefore(today)) {
            overdueTasks.add(task);
          }
        }
      },
    );
    overdueTasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return overdueTasks;
  }

  List<Task> getTodaysTasksForCategory(int categoryId) {
    final allTasksInCategory = getPlannedTasksForCategory(categoryId);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    List<Task> todaysTasks = [];
    allTasksInCategory.forEach(
      (task) {
        if (task.dueDate != null) {
          final dueDateTime = DateTime.fromMillisecondsSinceEpoch(task.dueDate);
          final dueDate =
              DateTime(dueDateTime.year, dueDateTime.month, dueDateTime.day);
          if (dueDate == today) {
            todaysTasks.add(task);
          }
        }
      },
    );
    return todaysTasks;
  }

  List<Task> getTomorrowsTasksForCategory(int categoryId) {
    final allTasksInCategory = getPlannedTasksForCategory(categoryId);
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    List<Task> tomorrowTasks = [];
    allTasksInCategory.forEach(
      (task) {
        if (task.dueDate != null) {
          final dueDateTime = DateTime.fromMillisecondsSinceEpoch(task.dueDate);
          final dueDate =
              DateTime(dueDateTime.year, dueDateTime.month, dueDateTime.day);
          if (dueDate == tomorrow) {
            tomorrowTasks.add(task);
          }
        }
      },
    );
    return tomorrowTasks;
  }

  List<Task> getFutureTasksForCategory(int categoryId) {
    final allTasksInCategory = getPlannedTasksForCategory(categoryId);
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    List<Task> futureTasks = [];
    allTasksInCategory.forEach(
      (task) {
        if (task.dueDate != null) {
          final dueDateTime = DateTime.fromMillisecondsSinceEpoch(task.dueDate);
          final dueDate =
              DateTime(dueDateTime.year, dueDateTime.month, dueDateTime.day);
          if (dueDate.isAfter(tomorrow)) {
            futureTasks.add(task);
          }
        }
      },
    );
    futureTasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return futureTasks;
  }

  List<Task> getNoDueDateTasksForCategory(int categoryId) {
    final allTasksInCategory = getPlannedTasksForCategory(categoryId);
    List<Task> noDueDateTasks = [];
    allTasksInCategory.forEach(
      (task) {
        if (task.dueDate == null) {
          noDueDateTasks.add(task);
        }
      },
    );
    return noDueDateTasks;
  }

  List<Task> getCompletedTasksForCategory(int categoryId) {
    final box = Hive.box<Task>(TASK_BOX);
    return box.values
        .where((task) => task.categoryId == categoryId && task.isDone == true)
        .toList();
  }

  List<Task> getTodayCompletedTasksForCategory(int categoryId) {
    final allCompletedTasksForCategory =
        getCompletedTasksForCategory(categoryId);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    List<Task> todayCompletedTasks = [];
    allCompletedTasksForCategory.forEach(
      (task) {
        if (task.doneTime != null) {
          final doneTime = DateTime.fromMillisecondsSinceEpoch(task.doneTime);
          final doneDate =
              DateTime(doneTime.year, doneTime.month, doneTime.day);
          if (doneDate == today) {
            todayCompletedTasks.add(task);
          }
        }
      },
    );
    todayCompletedTasks.sort((b, a) => a.doneTime.compareTo(b.doneTime));
    return todayCompletedTasks;
  }

  List<Task> getYesterdayCompletedTasksForCategory(int categoryId) {
    final allCompletedTasksForCategory =
        getCompletedTasksForCategory(categoryId);
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    List<Task> yesterdayCompletedTasks = [];
    allCompletedTasksForCategory.forEach(
      (task) {
        if (task.doneTime != null) {
          final doneTime = DateTime.fromMillisecondsSinceEpoch(task.doneTime);
          final doneDate =
              DateTime(doneTime.year, doneTime.month, doneTime.day);
          if (doneDate == yesterday) {
            yesterdayCompletedTasks.add(task);
          }
        }
      },
    );
    yesterdayCompletedTasks.sort((b, a) => a.doneTime.compareTo(b.doneTime));
    return yesterdayCompletedTasks;
  }

  List<Task> getEarlierCompletedTasksForCategory(int categoryId) {
    final allCompletedTasksForCategory =
        getCompletedTasksForCategory(categoryId);
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    List<Task> earlierCompletedTasks = [];
    allCompletedTasksForCategory.forEach(
      (task) {
        if (task.doneTime != null) {
          final doneTime = DateTime.fromMillisecondsSinceEpoch(task.doneTime);
          final doneDate =
              DateTime(doneTime.year, doneTime.month, doneTime.day);
          if (doneDate.isBefore(yesterday)) {
            earlierCompletedTasks.add(task);
          }
        }
      },
    );
    earlierCompletedTasks.sort((b, a) => a.doneTime.compareTo(b.doneTime));
    return earlierCompletedTasks;
  }

  addTask(Task task) async {
    var box = await Hive.openBox<Task>(TASK_BOX);

    box.add(task);

    notifyListeners();
  }

  int numberOfAllPlannedTasks() {
    final box = Hive.box<Task>(TASK_BOX);
    int result = box.values.where((task) => task.isDone == false).length;
    return result;
  }

  int numberOfAllTasksForCategory(int categoryId) {
    final box = Hive.box<Task>(TASK_BOX);
    int result =
        box.values.where((task) => task.categoryId == categoryId).length;
    return result;
  }

  int numberOfCompletedTasksForCategory(int categoryId) {
    final box = Hive.box<Task>(TASK_BOX);
    int result = box.values
        .where((task) => task.categoryId == categoryId && task.isDone == true)
        .length;
    return result;
  }

  int numberOfPlannedTasksForCategory(int categoryId) {
    final box = Hive.box<Task>(TASK_BOX);
    int result = box.values
        .where((task) => task.categoryId == categoryId && task.isDone == false)
        .length;
    return result;
  }

  double completionProgress(int categoryId) {
    if (numberOfAllTasksForCategory(categoryId) == 0) {
      return 0.0; // to avoid error when creating category without tasks
    }
    return numberOfCompletedTasksForCategory(categoryId) /
        numberOfAllTasksForCategory(categoryId);
  }

  updateTask(dynamic key, Task task) {
    final box = Hive.box<Task>(TASK_BOX);

    box.put(key, task);

    notifyListeners();
  }

  deleteTask(dynamic key) {
    final box = Hive.box<Task>(TASK_BOX);

    box.delete(key);

    notifyListeners();
  }

  deleteAllTasksForCategory(int categoryId) {
    final box = Hive.box<Task>(TASK_BOX);
    List _tasks =
        box.values.where((task) => task.categoryId == categoryId).toList();
    _tasks.forEach((element) => element.delete());
    notifyListeners();
  }

  deleteCompletedTasksForCategory(int categoryId) {
    final box = Hive.box<Task>(TASK_BOX);
    List _tasks = box.values
        .where((task) => task.categoryId == categoryId && task.isDone == true)
        .toList();
    _tasks.forEach((element) => element.delete());
    notifyListeners();
  }

  int setTaskDoneTime() {
    final now = DateTime.now().millisecondsSinceEpoch;
    return now;
  }

  String displayDueDate(int dateInMillis, String dateFormat) {
    if (dateInMillis != null) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final tomorrow = DateTime(now.year, now.month, now.day + 1);
      final dueDateTime = DateTime.fromMillisecondsSinceEpoch(dateInMillis);
      final dueDate =
          DateTime(dueDateTime.year, dueDateTime.month, dueDateTime.day);
      if (dueDate == today) {
        return TODAY;
      } else if (dueDate == tomorrow) {
        return TOMORROW;
      } else {
        return DateFormat(dateFormat).format(dueDate);
      }
    }
    return NO_DATE;
  }
}
