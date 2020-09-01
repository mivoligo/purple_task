import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../globals/hive_names.dart';
import '../../db_models/task.dart';

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

  List<Task> getCompletedTasksForCategory(int categoryId) {
    final box = Hive.box<Task>(TASK_BOX);
    return box.values
        .where((task) => task.categoryId == categoryId && task.isDone == true)
        .toList();
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
}
