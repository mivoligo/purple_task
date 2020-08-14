import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do/globals/hive_names.dart';
import 'package:to_do/models/task.dart';

class TaskViewModel with ChangeNotifier {
//  List<Task> _taskList = [];

//  List<Task> get taskList => _taskList;

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

  List<Task> allTasksForCategory(int categoryId) {
    final box = Hive.box<Task>(TASK_BOX);
    List<Task> taskList =
        box.values.where((task) => task.categoryId == categoryId).toList();
    return taskList;
  }

  List<Task> completedTasksForCategory(int categoryId) {
    final box = Hive.box<Task>(TASK_BOX);
    List<Task> taskList = box.values
        .where((task) => task.categoryId == categoryId && task.isDone == true)
        .toList();
    return taskList;
  }

  List<Task> plannedTasksForCategory(int categoryId) {
    final box = Hive.box<Task>(TASK_BOX);
    List<Task> taskList = box.values
        .where((task) => task.categoryId == categoryId && task.isDone == false)
        .toList();
    return taskList;
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
