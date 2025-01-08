import 'package:drift/drift.dart';
import 'package:hive/hive.dart';
import 'package:purple_task/core/database/app_database.dart' as db;
import 'package:purple_task/features/todos/daos/category_dao.dart';
import 'package:purple_task/features/todos/models/hive_entities/category_entity.dart';

class CategoriesMigrator {
  CategoriesMigrator({
    required Box<CategoryEntity> categoriesBox,
    required CategoryDao categoryDao,
  })  : _categoriesBox = categoriesBox,
        _categoryDao = categoryDao;

  final Box<CategoryEntity> _categoriesBox;
  final CategoryDao _categoryDao;

  Future<void> migrateCategoriesFromHiveToDrift() async {
    final companions = _categoriesBox.values
        .map(
          (e) => db.CategoriesCompanion(
            id: Value(e.id),
            name: Value(e.name),
            color: Value(e.color),
            icon: Value(e.icon),
          ),
        )
        .toList(growable: false);

    await _categoryDao.addCategoriesList(companions);
  }
}
