import 'dart:math';

import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../db_models/db_models.dart';
import '../../globals/globals.dart';
import '../ui.dart';

class NewCategoryViewModel extends ChangeNotifier {
  String _name = '';

  String get name => _name;

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  int _color = 0xff9c27b0;

  int get color => _color;

  set color(int value) {
    _color = value;
    notifyListeners();
  }

  int _icon = AntIcons.folder.codePoint;

  int get icon => _icon;

  set icon(int value) {
    _icon = value;
    notifyListeners();
  }

  late int _categoryId;

  int get categoryId => _categoryId;

  void setCategoryId() {
    final timeStamp = DateTime.now().millisecondsSinceEpoch;
    _categoryId = timeStamp;
  }

  List<Task> _tasks = [];

  List<Task> get tasks => _tasks.reversed.toList();

  void addTaskToTemporaryList(BuildContext context) {
    final taskModel = Provider.of<TaskViewModel>(context, listen: false);
    final task = Task(
      name: taskModel.newTaskName,
      isDone: false,
      categoryId: _categoryId,
    );
    _tasks.add(task);
    notifyListeners();
  }

  void addTasksToDb(BuildContext context) {
    final taskModel = Provider.of<TaskViewModel>(context, listen: false);
    _tasks.forEach(taskModel.addTask);
  }

  // check if adding category was completed or canceled
  bool _addingNewCategoryCompleted = false;

  bool get addingNewCategoryCompleted => _addingNewCategoryCompleted;

  set addingNewCategoryCompleted(bool value) {
    _addingNewCategoryCompleted = value;
    notifyListeners();
  }

  void addNewCategory(BuildContext context) {
    final id = _categoryId;
    final categoryModel =
        Provider.of<CategoryViewModel>(context, listen: false);
    final category = Category(
      name: _name,
      color: _color,
      icon: _icon,
      id: id,
    );
    categoryModel.addCategory(category);
  }

  void resetNewCategory() {
    final _random = Random();
    // reset name
    _name = '';
    // get random color from list
    _color = categoryColors[_random.nextInt(categoryColors.length)];
    // set icon to default
    _icon = AntIcons.folder.codePoint;
    // empty tasks list
    _tasks = [];
  }
}
