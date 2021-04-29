import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../globals/globals.dart';
import '../entities/entities.dart';

class CategoryViewModel extends ChangeNotifier {
  Future<void> addCategory(CategoryEntity category) async {
    var box = await Hive.openBox<CategoryEntity>(categoryBox);

    box.add(category);

    notifyListeners();
  }

  List<CategoryEntity> getListOfCategories() {
    final box = Hive.box<CategoryEntity>(categoryBox);

    final _categoryList = box.values.toList();

    return _categoryList;
  }

  void updateCategory(int index, CategoryEntity category) {
    final box = Hive.box<CategoryEntity>(categoryBox);

    box.putAt(index, category);

    notifyListeners();
  }

  void deleteCategory(int index) {
    final box = Hive.box<CategoryEntity>(categoryBox);

    box.deleteAt(index);

    notifyListeners();
  }

  bool checkIfCategoryExist(int categoryId) {
    final box = Hive.box<CategoryEntity>(categoryBox);
    return box.values.where((category) => category.id == categoryId).isNotEmpty;
  }

  CategoryEntity? _currentCategory;
  CategoryEntity? get currentCategory => _currentCategory;
  set currentCategory(CategoryEntity? category) {
    _currentCategory = category;
    notifyListeners();
  }

  late int _color;

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
