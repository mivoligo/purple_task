import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do/globals/hive_names.dart';
import 'package:to_do/models/task.dart';

class TaskViewModel with ChangeNotifier {
  List<Task> _taskList = [];

  List<Task> get taskList => _taskList;

  addTask(Task task) async {
    var box = await Hive.openBox<Task>(TASK_BOX);

    box.add(task);

    notifyListeners();
  }

  getTasksForCategory(int categoryId) async {
    final box = await Hive.openBox<Task>(TASK_BOX);

    _taskList =
        box.values.where((task) => task.categoryId == categoryId).toList();

    notifyListeners();
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
}
