import 'package:hive_flutter/hive_flutter.dart';
import 'package:purple_task/core/constants/hive_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsMigrator {
  const SettingsMigrator({
    required SharedPreferencesAsync asyncPrefs,
    required Box<dynamic> settingsBox,
  })  : _asyncPrefs = asyncPrefs,
        _settingsBox = settingsBox;

  final SharedPreferencesAsync _asyncPrefs;

  final Box<dynamic> _settingsBox;

  Future<void> migrateSettingsFromHiveToSharedPreferences() async {
    await Future.wait([
      _migrateDateFormat(),
      _migrateTimeFormat(),
      _migrateDisplayTaskDoneTimePref(),
    ]);
  }

  Future<void> _migrateDateFormat() async {
    final currentSetting = _settingsBox.get(dateFormatKey);
    if (currentSetting == null) {
      return;
    }
    await _asyncPrefs.setString(dateFormatKey, currentSetting as String);
  }

  Future<void> _migrateTimeFormat() async {
    final currentSetting = _settingsBox.get(timeFormatKey);
    if (currentSetting == null) {
      return;
    }
    await _asyncPrefs.setString(timeFormatKey, currentSetting as String);
  }

  Future<void> _migrateDisplayTaskDoneTimePref() async {
    final currentSetting = _settingsBox.get(displayTaskDonePrefKey);
    if (currentSetting == null) {
      return;
    }
    await _asyncPrefs.setBool(displayTaskDonePrefKey, currentSetting as bool);
  }
}
