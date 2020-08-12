import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do/globals/hive_names.dart';
import 'package:to_do/models/category.dart';

class CategoryViewModel with ChangeNotifier {
  List<Category> _categoryList = [];

  List<Category> get categoryList => _categoryList;

//  initHive() async {
//    print('Initializing Hive');
//    Directory dir = await getApplicationSupportDirectory();
//    Hive.init(dir.path);
//    print('${dir.path}');
//  }

  addCategory(Category category) async {
    var box = await Hive.openBox<Category>(CATEGORY_BOX);

    box.add(category);

    notifyListeners();
  }

  getCategory() async {
    final box = await Hive.openBox<Category>(CATEGORY_BOX);

    _categoryList = box.values.toList();

    notifyListeners();
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
