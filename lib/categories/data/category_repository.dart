import 'dart:math';

import 'package:hive/hive.dart';

import '../../db_models/category.dart';
import '../../globals/globals.dart';

class CategoryRepository {
  Box<Category> box = Hive.box<Category>(categoryBox);

  late int color;
  final random = Random();

  Future<void> addCategory({
    required String name,
    required int color,
    required int icon,
  }) async {
    final id = DateTime.now().millisecondsSinceEpoch;
    final category = Category(
      name: name,
      color: color,
      icon: icon,
      id: id,
    );
    await box.add(category);
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
