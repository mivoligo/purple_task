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
    await Hive.openBox(hiveBox);
  }

  @override
  addCategory(Category category) async {
    print('Adding category to Hive');
    var box = Hive.box(hiveBox);

    var categoryMap = category.toMap(category);
    box.add(categoryMap);
  }

  updateCategory(int index, Category newCategory) {
    var box = Hive.box(hiveBox);

    var newCategoryMap = newCategory.toMap(newCategory);

    box.putAt(index, newCategoryMap);
  }

  @override
  deleteCategory(int categoryId) {
    var box = Hive.box(hiveBox);
    box.deleteAt(categoryId);
  }

  @override
  Future<List<Category>> getCategories() async {
    var box = Hive.box(hiveBox);

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
