import 'package:hive/hive.dart';
import '../../constants/constants.dart';

import 'base_settings_repository.dart';

class SettingsRepository extends BaseSettingsRepository {
  final _box = Hive.box(settingsBox);

  @override
  void setTimeFormat({required String value}) {
    _box.put(timeFormatKey, value);
  }

  @override
  String getTimeFormat() {
    return _box.get(timeFormatKey, defaultValue: 'Hm');
  }

  @override
  void setDateFormat({required String value}) {
    _box.put(dateFormatKey, value);
  }

  @override
  String getDateFormat() {
    return _box.get(dateFormatKey, defaultValue: 'd MMM y');
  }

  @override
  void setDisplayTaskDoneTimePref({required bool value}) {
    _box.put(displayTaskDonePrefKey, value);
  }

  @override
  bool getDisplayTaskDoneTimePref() {
    return _box.get(displayTaskDonePrefKey, defaultValue: false);
  }
}
