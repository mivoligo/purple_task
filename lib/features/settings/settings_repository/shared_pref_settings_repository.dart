import 'package:purple_task/core/constants/key_names.dart';
import 'package:purple_task/features/settings/settings_repository/base_settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefSettingsRepository implements BaseSettingsRepository {
  SharedPrefSettingsRepository({required SharedPreferencesAsync asyncPrefs})
      : _asyncPrefs = asyncPrefs;

  final SharedPreferencesAsync _asyncPrefs;

  @override
  Future<void> setDateFormat({required String value}) async {
    await _asyncPrefs.setString(dateFormatKey, value);
  }

  @override
  Future<String> getDateFormat() async {
    return await _asyncPrefs.getString(dateFormatKey) ?? 'd MMM y';
  }

  @override
  Future<void> setTimeFormat({required String value}) async {
    await _asyncPrefs.setString(timeFormatKey, value);
  }

  @override
  Future<String> getTimeFormat() async {
    return await _asyncPrefs.getString(timeFormatKey) ?? 'Hm';
  }

  @override
  Future<void> setDisplayTaskDoneTimePref({required bool value}) async {
    await _asyncPrefs.setBool(displayTaskDonePrefKey, value);
  }

  @override
  Future<bool> getDisplayTaskDoneTimePref() async {
    return await _asyncPrefs.getBool(displayTaskDonePrefKey) ?? false;
  }

  @override
  Future<void> setUncategorizedViewPreference({required bool value}) async {
    await _asyncPrefs.setBool(uncategorizedViewPreferenceKey, value);
  }

  @override
  Future<bool> getUncategorizedViewPreference() async {
    return await _asyncPrefs.getBool(uncategorizedViewPreferenceKey) ?? true;
  }
}
