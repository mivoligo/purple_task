import 'dart:math';
import 'dart:ui';

import 'package:hive/hive.dart';

import '../../db_models/category.dart';
import '../../globals/globals.dart';
import 'model/category.dart';

class CategoryRepository {
  Box<CategoryEntity> box = Hive.box<CategoryEntity>(categoryBox);

  late Color color;
  final random = Random();

  Future<Category> addCategory({
    required String name,
    required Color color,
    required int icon,
  }) async {
    final id = DateTime.now().millisecondsSinceEpoch;
    final category = Category(
      name: name,
      color: color,
      icon: icon,
      id: id,
    );
    await box.add(category.toEntity());
    return category;
  }

  void updateCategory(int index, CategoryEntity category) {
    box.putAt(index, category);
  }

  Future<Category> deleteCategory(Category category) async {
    await box.values
        .firstWhere((element) => element.id == category.id)
        .delete();
    return category;
  }

  List<Category> getCategories() {
    return box.values.map((e) => Category.fromEntity(e)).toList();
  }

  void setRandomColor() {
    color = Color(categoryColors[random.nextInt(categoryColors.length)]);
  }
}
