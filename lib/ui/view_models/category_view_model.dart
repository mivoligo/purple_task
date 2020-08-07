import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do/models/category.dart';

class CategoryViewModel with ChangeNotifier {
  String _categoryBox = 'category_box';

  List<Category> _categoryList = [];

  List<Category> get categoryList => _categoryList;

  initHive() async {
    print('Initializing Hive');
    Directory dir = await getApplicationSupportDirectory();
    Hive.init(dir.path);
    print('${dir.path}');
//    await Hive.openBox(_categoryBox);
  }

  addCategory(Category category) async {
    var box = await Hive.openBox<Category>(_categoryBox);

    box.add(category);

    notifyListeners();
  }

  getCategory() async {
    final box = await Hive.openBox<Category>(_categoryBox);

    _categoryList = box.values.toList();

    notifyListeners();
  }

  updateCategory(int index, Category category) {
    final box = Hive.box<Category>(_categoryBox);

    box.putAt(index, category);

    notifyListeners();
  }

  deleteCategory(int index) {
    final box = Hive.box<Category>(_categoryBox);

    box.deleteAt(index);

//    getCategory(); // TODO Check if needed

    notifyListeners();
  }
}
