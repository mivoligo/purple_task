import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:purple_task/core/constants/key_names.dart';
import 'package:purple_task/core/hive_legacy/hive_entities/category_entity.dart';
import 'package:purple_task/core/hive_legacy/hive_entities/task_entity.dart';
import 'package:purple_task/core/hive_legacy/providers/providers.dart';
import 'package:purple_task/core/shared_prefs/shared_prefs_provider.dart';
import 'package:purple_task/features/migrator/categories_migrator.dart';
import 'package:purple_task/features/migrator/repositories/providers/providers.dart';
import 'package:purple_task/features/migrator/settings_migrator.dart';
import 'package:purple_task/features/migrator/tasks_migrator.dart';
import 'package:purple_task/features/todos/daos/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
SettingsMigrator settingsMigrator(Ref ref) => SettingsMigrator(
      asyncPrefs: ref.read(sharedPreferencesAsyncProvider),
      settingsBox: Hive.box(settingsBox),
    );

@riverpod
CategoriesMigrator categoriesMigrator(Ref ref) => CategoriesMigrator(
      categoriesBox: Hive.box<CategoryEntity>(categoryBox),
      categoryDao: ref.watch(categoryDaoProvider),
    );

@riverpod
TasksMigrator tasksMigrator(Ref ref) => TasksMigrator(
      tasksBox: Hive.box<TaskEntity>(taskBox),
      taskDao: ref.watch(taskDaoProvider),
    );

@riverpod
Future<bool> needsMigrationFromHive(Ref ref) async {
  final hasAnyHiveBox = await ref.read(hasAnyHiveBoxProvider.future);
  final pref = ref.read(migrationRepositoryProvider);
  final migrated = await pref.migratedFromHive();
  return hasAnyHiveBox && !migrated;
}
