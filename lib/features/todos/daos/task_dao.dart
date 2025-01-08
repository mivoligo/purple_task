import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/database/app_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_dao.g.dart';

@DriftAccessor(tables: [TaskItems])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  TaskDao(super.db);

  Stream<List<TaskItem>> watchAllTasks() => select(taskItems).watch();

  Future<List<TaskItem>> getAllTasks() => (select(taskItems)
        ..orderBy([(t) => OrderingTerm(expression: t.position)]))
      .get();

  Future<int> addTask(TaskItemsCompanion companion) async {
    final expr = taskItems.position.max();

    final query = selectOnly(taskItems)..addColumns([expr]);

    final previousMaxPosition =
        await query.map((row) => row.read(expr)).getSingleOrNull();

    final currentMaxPosition =
        previousMaxPosition == null ? 0 : previousMaxPosition + 1;

    return into(taskItems).insert(
      companion.copyWith(
        isDone: const Value(false),
        position: Value(currentMaxPosition),
      ),
    );
  }

  Future<int> deleteTask(int id) =>
      (delete(taskItems)..where((tbl) => tbl.id.equals(id))).go();

  Future<void> deleteAllTasksInCategory(int categoryId) async {
    await transaction(() async {
      await (delete(taskItems)
            ..where((tbl) => tbl.categoryId.equals(categoryId)))
          .go();
    });
  }

  Future<void> deleteCompletedTasksInCategory(int categoryId) async {
    await transaction(() async {
      await (delete(taskItems)
            ..where(
              (tbl) =>
                  tbl.categoryId.equals(categoryId) & tbl.isDone.equals(true),
            ))
          .go();
    });
  }

  Future<bool> updateTask(TaskItemsCompanion companion) =>
      update(taskItems).replace(companion);

  Future<void> updateTasksList(List<TaskItemsCompanion> companionsList) async {
    await transaction(() async {
      for (final companion in companionsList) {
        await update(taskItems).replace(companion);
      }
    });
  }
}

@riverpod
TaskDao taskDao(Ref ref) {
  final database = ref.watch(appDatabaseProvider);
  return TaskDao(database);
}
