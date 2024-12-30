import 'package:hive/hive.dart';

import 'package:purple_task/core/constants/hive_names.dart';
import 'package:purple_task/features/settings/settings_repository/base_settings_repository.dart';

class SettingsRepository extends BaseSettingsRepository {
  final _box = Hive.box<dynamic>(settingsBox);

  @override
  void setTimeFormat({required String value}) => _box.put(timeFormatKey, value);

  @override
  Future<String> getTimeFormat() async =>
      _box.get(timeFormatKey, defaultValue: 'Hm') as String;

  @override
  void setDateFormat({required String value}) => _box.put(dateFormatKey, value);

  @override
  Future<String> getDateFormat() async =>
      _box.get(dateFormatKey, defaultValue: 'd MMM y') as String;

  @override
  void setDisplayTaskDoneTimePref({required bool value}) =>
      _box.put(displayTaskDonePrefKey, value);

  @override
  Future<bool> getDisplayTaskDoneTimePref() async =>
      _box.get(displayTaskDonePrefKey, defaultValue: false) as bool;

  @override
  void setUncategorizedViewPreference({required bool value}) =>
      _box.put(uncategorizedViewPreferenceKey, value);

  @override
  Future<bool> getUncategorizedViewPreference() async =>
      _box.get(uncategorizedViewPreferenceKey, defaultValue: true) as bool;
}
