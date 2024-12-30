import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:purple_task/core/constants/hive_names.dart';
import 'package:purple_task/core/database/app_database.dart' as db;
import 'package:purple_task/core/helpers.dart';
import 'package:purple_task/features/todos/database/category_dao.dart';
import 'package:purple_task/features/todos/models/category.dart';
import 'package:purple_task/features/todos/models/category_entity.dart';
import 'package:purple_task/features/todos/repositories/drift_category_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'migrator.g.dart';

class SettingsMigrator {
  SettingsMigrator({
    required this.asyncPrefs,
    required this.settingsBox,
  });

  final SharedPreferencesAsync asyncPrefs;

  final Box<dynamic> settingsBox;

  Future<void> migrateSettingsFromHiveToSharedPreferences() async {
    await Future.wait([
      _migrateDateFormat(),
      _migrateTimeFormat(),
      _migrateDisplayTaskDoneTimePref(),
    ]);

    await settingsBox.deleteFromDisk();
  }

  Future<void> _migrateDateFormat() async {
    final currentSetting = settingsBox.get(dateFormatKey);
    if (currentSetting == null) {
      return;
    }
    await asyncPrefs.setString(dateFormatKey, currentSetting as String);
  }

  Future<void> _migrateTimeFormat() async {
    final currentSetting = settingsBox.get(timeFormatKey);
    if (currentSetting == null) {
      return;
    }
    await asyncPrefs.setString(timeFormatKey, currentSetting as String);
  }

  Future<void> _migrateDisplayTaskDoneTimePref() async {
    final currentSetting = settingsBox.get(displayTaskDonePrefKey);
    if (currentSetting == null) {
      return;
    }
    await asyncPrefs.setBool(displayTaskDonePrefKey, currentSetting as bool);
  }
}

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

@riverpod
CategoriesMigrator categoriesMigrator(Ref ref) => CategoriesMigrator(
      categoriesBox: Hive.box<CategoryEntity>(categoryBox),
      categoryDao: ref.watch(categoryDaoProvider),
    );
