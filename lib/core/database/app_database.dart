import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:purple_task/core/database/app_database.steps.dart';
import 'package:purple_task/core/database/migration/ant_icon_migration.dart';
import 'package:purple_task/features/todos/daos/category_dao.dart';
import 'package:purple_task/features/todos/daos/task_dao.dart';

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
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 2;

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

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: stepByStep(
        from1To2: (m, schema) async {
          await customStatement('PRAGMA foreign_keys = OFF');

          final db = m.database;
          for (final entry in antIconsV1ToV2.entries) {
            final oldIcon = entry.key;
            final newIcon = entry.value;

            await db.customStatement('''
              UPDATE categories
              SET icon = $newIcon
              WHERE icon = $oldIcon
            ''');
          }
        },
      ),
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}
