import 'package:drift/drift.dart';

import '../../database/app_database.dart';

part 'category_dao.g.dart';

@DriftAccessor(tables: [Categories])
class CategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  CategoryDao(AppDatabase db) : super(db);

  Stream<List<Category>> watchAllCategories() => select(categories).watch();

  Future<List<Category>> getAllCategories() => select(categories).get();

  Future<int> addCategory(CategoriesCompanion categoriesCompanion) =>
      into(categories).insert(categoriesCompanion);

  Future<int> deleteCategory(int id) =>
      (delete(categories)..where((tbl) => tbl.id.equals(id))).go();

  Future<bool> updateCategory(CategoriesCompanion categoriesCompanion) =>
      update(categories).replace(categoriesCompanion);
}
