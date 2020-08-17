import 'dart:math';

import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/globals/category_colors.dart';
import 'package:to_do/models/category.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/ui/view_models/category_view_model.dart';
import 'package:to_do/ui/view_models/task_view_model.dart';

class NewCategory extends ChangeNotifier {
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

  int _categoryId;

  int get categoryId => _categoryId;

  void setCategoryId() {
    int timeStamp = DateTime.now().millisecondsSinceEpoch;
    _categoryId = timeStamp;
  }

  String _taskName = '';

  String get taskName => _taskName;

  set taskName(String value) {
    _taskName = value;
    notifyListeners();
  }

  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  addTask(BuildContext context) {
    TaskViewModel taskDb = Provider.of<TaskViewModel>(context, listen: false);
    Task task = Task(
      name: _taskName,
      isDone: false,
      categoryId: _categoryId,
    );
    _tasks.add(task);
    taskDb.addTask(task);
    notifyListeners();
  }

  // check if adding category was completed or canceled
  bool _addingNewCategoryCompleted = false;

  bool get addingNewCategoryCompleted => _addingNewCategoryCompleted;

  set addingNewCategoryCompleted(bool value) {
    _addingNewCategoryCompleted = value;
    notifyListeners();
  }

  void addNewCategory(BuildContext context) {
    int id = _categoryId;
    CategoryViewModel categoryDb =
        Provider.of<CategoryViewModel>(context, listen: false);
    Category category = Category(
      name: _name,
      color: _color,
      icon: _icon,
      id: id,
    );
    categoryDb.addCategory(category);
  }

  resetNewCategory() {
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
