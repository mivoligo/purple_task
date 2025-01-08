import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:purple_task/features/todos/daos/category_dao.dart';
import 'package:purple_task/features/todos/daos/task_dao.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database.g.dart';

class TaskItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get description => text().nullable()();

  BoolColumn get isDone => boolean()();

  IntColumn get categoryId => integer().references(Categories, #id)();

  IntColumn get createdAt => integer().nullable()();

  IntColumn get dueAt => integer().nullable()();

  IntColumn get doneAt => integer().nullable()();

  IntColumn get position => integer().nullable()();
}

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  IntColumn get color => integer()();

  IntColumn get icon => integer()();

  IntColumn get position => integer().nullable()();
}

@DriftDatabase(
  tables: [TaskItems, Categories],
  daos: [CategoryDao, TaskDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'todo_database',
      native: DriftNativeOptions(
        databasePath: () async {
          final dir = await getApplicationSupportDirectory();
          return p.join(dir.path, 'todo_db.sqlite');
        },
      ),
    );
  }
}

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) => AppDatabase();
