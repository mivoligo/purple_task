import 'dart:io';

import 'package:hive/hive.dart';
import 'package:to_do/local_db/interface/category_interface.dart';
import 'package:to_do/models/category.dart';
import 'package:path_provider/path_provider.dart';

class HiveMethods implements CategoryInterface {
  final String hiveBox = 'Categories';

  @override
  init() async {
    print('Initializing Hive');
    Directory dir = await getApplicationSupportDirectory();
    Hive.init(dir.path);
    print('${dir.path}');
  }

  @override
  addCategory(Category category) async {
    print('Adding category to Hive');
    var box = await Hive.openBox(hiveBox);

    var categoryMap = category.toMap(category);
    int idOfInput = await box.add(categoryMap);

    close();
    return idOfInput;
  }

  updateCategory(int index, Category newCategory) async {
    var box = await Hive.openBox(hiveBox);

    var newCategoryMap = newCategory.toMap(newCategory);

    box.putAt(index, newCategoryMap);

    close();
  }

  @override
  deleteCategory(int categoryId) async {
    var box = await Hive.openBox(hiveBox);
    await box.deleteAt(categoryId);
  }

  @override
  Future<List<Category>> getCategories() async {
    var box = await Hive.openBox(hiveBox);

    List<Category> categoryList = [];

    for (int i = 0; i < box.length; i++) {
      var categoryMap = box.getAt(i);

      categoryList.add(Category.fromMap(categoryMap));
    }

    return categoryList;
  }

  @override
  close() => Hive.close();
}
