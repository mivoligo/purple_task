import 'package:drift/drift.dart';
import 'package:hive/hive.dart';
import 'package:purple_task/core/database/app_database.dart' as db;
import 'package:purple_task/core/helpers.dart';
import 'package:purple_task/features/todos/daos/category_dao.dart';
import 'package:purple_task/features/todos/models/category.dart';
import 'package:purple_task/features/todos/models/category_entity.dart';

class CategoriesMigrator {
  CategoriesMigrator({
    required this.categoriesBox,
    required this.categoryDao,
  });

  final Box<CategoryEntity> categoriesBox;
  final CategoryDao categoryDao;

  Future<void> migrateCategoriesFromHiveToDrift() async {
    final currentCategories = categoriesBox.values
        .map(Category.fromEntity)
        .toList()
      ..sort((a, b) => a.id.compareTo(b.id));

    for (final category in currentCategories) {
      await categoryDao.addCategory(
        db.CategoriesCompanion(
          id: Value(category.id),
          name: Value(category.name),
          color: Value(category.color.intValue),
          icon: Value(category.icon),
        ),
      );
    }
  }
}
