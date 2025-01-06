import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:purple_task/core/constants/hive_names.dart';
import 'package:purple_task/core/migrator/categories_migrator.dart';
import 'package:purple_task/core/migrator/settings_migrator.dart';
import 'package:purple_task/features/todos/models/category_entity.dart';
import 'package:purple_task/features/todos/repositories/drift_category_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'providers.g.dart';

@riverpod
SettingsMigrator settingsMigrator(Ref ref) => SettingsMigrator(
      asyncPrefs: SharedPreferencesAsync(),
      settingsBox: Hive.box(settingsBox),
    );

@riverpod
CategoriesMigrator categoriesMigrator(Ref ref) => CategoriesMigrator(
      categoriesBox: Hive.box<CategoryEntity>(categoryBox),
      categoryDao: ref.watch(categoryDaoProvider),
    );
