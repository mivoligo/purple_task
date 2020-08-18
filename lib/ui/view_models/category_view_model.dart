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
}
