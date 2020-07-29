import 'dart:math';

import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:to_do/globals/category_colors.dart';

class Category {
  final String name;
  final Color color;
  final IconData icon;

  Category({
    this.name,
    this.color,
    this.icon,
  });
}

class CategoryList extends ChangeNotifier {
  List<Category> categoryList = [
    Category(name: 'Home', color: Colors.blue, icon: AntIcons.home),
    Category(name: 'Work', color: Colors.amber, icon: AntIcons.database),
//    Category(name: 'Other', color: Colors.green, icon: Icons.note),
//    Category(name: 'Other one', color: Colors.grey, icon: Icons.nature),
  ];

  void addCategory(Category category) {
    categoryList.add(category);
    notifyListeners();
  }
}

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
