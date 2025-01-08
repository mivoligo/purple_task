import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:purple_task/core/database/app_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_dao.g.dart';

@DriftAccessor(tables: [Categories])
class CategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  CategoryDao(super.db);

  Stream<List<Category>> watchAllCategories() => select(categories).watch();

  Future<List<Category>> getAllCategories() {
    return (select(categories)
          ..orderBy([(t) => OrderingTerm(expression: t.position)]))
        .get();
  }

  Future<int> addCategory(CategoriesCompanion categoriesCompanion) async {
    final expr = categories.position.max();

    final query = (selectOnly(categories)..addColumns([expr]));

    final previousMaxPosition =
        await query.map((row) => row.read(expr)).getSingleOrNull();

    final currentMaxPosition =
        previousMaxPosition == null ? 0 : previousMaxPosition + 1;

    return into(categories).insert(
      categoriesCompanion.copyWith(position: Value(currentMaxPosition)),
    );
  }

  Future<int> deleteCategory(int id) =>
      (delete(categories)..where((tbl) => tbl.id.equals(id))).go();

  Future<bool> updateCategory(CategoriesCompanion categoriesCompanion) =>
      update(categories).replace(categoriesCompanion);

  Future<void> updateCategoriesList(
    List<CategoriesCompanion> categoriesCompanionList,
  ) async {
    await transaction(
      () async {
        for (final companion in categoriesCompanionList) {
          await update(categories).replace(companion);
        }
      },
    );
  }
}

@riverpod
CategoryDao categoryDao(Ref ref) {
  final database = ref.watch(appDatabaseProvider);
  return CategoryDao(database);
}
