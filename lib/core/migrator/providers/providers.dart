import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:purple_task/core/constants/hive_names.dart';
import 'package:purple_task/core/migrator/migrator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'providers.g.dart';

@riverpod
SettingsMigrator settingsMigrator(Ref ref) => SettingsMigrator(
      asyncPrefs: SharedPreferencesAsync(),
      settingsBox: Hive.box(settingsBox),
    );
