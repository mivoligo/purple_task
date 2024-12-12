import 'package:hive/hive.dart';
import '../../constants/constants.dart';

import 'base_settings_repository.dart';

class SettingsRepository extends BaseSettingsRepository {
  final _box = Hive.box(settingsBox);

  @override
  void setTimeFormat({required String value}) => _box.put(timeFormatKey, value);

  @override
  Future<String> getTimeFormat() async =>
      _box.get(timeFormatKey, defaultValue: 'Hm');

  @override
  void setDateFormat({required String value}) => _box.put(dateFormatKey, value);

  @override
  Future<String> getDateFormat() async =>
      _box.get(dateFormatKey, defaultValue: 'd MMM y');

  @override
  void setDisplayTaskDoneTimePref({required bool value}) =>
      _box.put(displayTaskDonePrefKey, value);

  @override
  Future<bool> getDisplayTaskDoneTimePref() async =>
      _box.get(displayTaskDonePrefKey, defaultValue: false);

  @override
  void setUncategorizedViewPreference({required bool value}) =>
      _box.put(uncategorizedViewPreferenceKey, value);

  @override
  Future<bool> getUncategorizedViewPreference() async =>
      _box.get(uncategorizedViewPreferenceKey, defaultValue: true);
}
