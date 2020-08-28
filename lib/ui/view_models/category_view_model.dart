import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do/globals/hive_names.dart';
import 'package:to_do/models/category.dart';

class CategoryViewModel with ChangeNotifier {
  addCategory(Category category) async {
    var box = await Hive.openBox<Category>(CATEGORY_BOX);

    box.add(category);

    notifyListeners();
  }

  List<Category> getListOfCategories() {
    final box = Hive.box<Category>(CATEGORY_BOX);

    List<Category> _categoryList = box.values.toList();

    return _categoryList;
  }

  updateCategory(int index, Category category) {
    final box = Hive.box<Category>(CATEGORY_BOX);

    box.putAt(index, category);

    notifyListeners();
  }

  deleteCategory(int index) {
    final box = Hive.box<Category>(CATEGORY_BOX);

    box.deleteAt(index);

    notifyListeners();
  }

  Category _currentCategory;
  Category get currentCategory => _currentCategory;
  set currentCategory(Category category) {
    _currentCategory = category;
    notifyListeners();
  }

  int _color;

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
}
