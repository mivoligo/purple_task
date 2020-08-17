import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do/globals/hive_names.dart';
import 'package:to_do/models/task.dart';

class TaskViewModel with ChangeNotifier {
  String _newTaskName;

  String get newTaskName => _newTaskName;

  set newTaskName(String value) {
    _newTaskName = value;
    notifyListeners();
  }

  List<Task> _taskListAll = [];

  List<Task> get taskListAll => _taskListAll;

  getAllTasksForCategory(int categoryId) async {
    final box = await Hive.openBox<Task>(TASK_BOX);
    _taskListAll =
        box.values.where((task) => task.categoryId == categoryId).toList();
    notifyListeners();
  }

  List<Task> _taskListPlanned = [];

  List<Task> get tasksListPlanned => _taskListPlanned;

  getPlannedTasksForCategory(int categoryId) async {
    final box = await Hive.openBox<Task>(TASK_BOX);
    _taskListPlanned = box.values
        .where((task) => task.categoryId == categoryId && task.isDone == false)
        .toList();
    notifyListeners();
  }

  List<Task> _taskListCompleted = [];

  List<Task> get tasksListCompleted => _taskListCompleted;

  getCompletedTasksForCategory(int categoryId) async {
    final box = await Hive.openBox<Task>(TASK_BOX);
    _taskListCompleted = box.values
        .where((task) => task.categoryId == categoryId && task.isDone == true)
        .toList();
    notifyListeners();
  }

  getTasksForCategory(int categoryId) {
    getAllTasksForCategory(categoryId);
    getPlannedTasksForCategory(categoryId);
    getCompletedTasksForCategory(categoryId);
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

  double completionProgress(int categoryId) =>
      numberOfCompletedTasksForCategory(categoryId) /
      numberOfAllTasksForCategory(categoryId);

  updateTask(int index, Task task) {
    final box = Hive.box<Task>(TASK_BOX);

    box.putAt(index, task);

    notifyListeners();
  }

  deleteTask(int index) {
    final box = Hive.box<Task>(TASK_BOX);

    box.deleteAt(index);

    notifyListeners();
  }

  deleteAllTasksForCategory(int categoryId) {
    final box = Hive.box<Task>(TASK_BOX);
    List _tasks =
        box.values.where((task) => task.categoryId == categoryId).toList();
    _tasks.forEach((element) => element.delete());
  }

  deleteCompletedTasksForCategory(int categoryId) {
    final box = Hive.box<Task>(TASK_BOX);
    List _tasks = box.values
        .where((task) => task.categoryId == categoryId && task.isDone == true)
        .toList();
    _tasks.forEach((element) => element.delete());
  }
}
