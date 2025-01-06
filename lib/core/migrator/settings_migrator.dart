import 'package:hive_flutter/hive_flutter.dart';
import 'package:purple_task/core/constants/hive_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
