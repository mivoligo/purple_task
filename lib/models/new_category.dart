import 'dart:math';

import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:to_do/globals/category_colors.dart';

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

  // check if adding category was completed or canceled
  bool _addingNewCategoryCompleted = false;

  bool get addingNewCategoryCompleted => _addingNewCategoryCompleted;

  set addingNewCategoryCompleted(bool value) {
    _addingNewCategoryCompleted = value;
    notifyListeners();
  }

  resetNewCategory() {
    final _random = Random();
    // reset name
    _name = '';
    // get random color from list
    _color = categoryColors[_random.nextInt(categoryColors.length)];
    // set icon to default
    _icon = AntIcons.folder.codePoint;
  }
}
