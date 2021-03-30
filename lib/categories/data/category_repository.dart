import 'dart:math';

import 'package:ant_icons/ant_icons.dart';
import 'package:hive/hive.dart';

import '../../db_models/category.dart';
import '../../globals/globals.dart';

class CategoryRepository {
  Box<Category> box = Hive.box<Category>(categoryBox);

  final random = Random();

  late String name;
  late int color;
  int icon = AntIcons.folder.codePoint;

  void addCategory() {
    final id = DateTime.now().millisecondsSinceEpoch;
    final category = Category(
      name: name,
      color: color,
      icon: icon,
      id: id,
    );
    box.add(category);
  }

  void updateCategory(int index, Category category) {
    box.putAt(index, category);
  }

  void deleteCategory(int index) {
    box.deleteAt(index);
  }

  List<Category> getCategories() {
    return box.values.toList();
  }

  void setRandomColor() {
    color = categoryColors[random.nextInt(categoryColors.length)];
  }
}
