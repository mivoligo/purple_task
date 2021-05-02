import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../globals/globals.dart' as g;

import 'base_settings_repository.dart';

final settingsRepositoryProvider = Provider((ref) => SettingsRepository());

class SettingsRepository extends BaseSettingsRepository {
  final _box = Hive.box(g.settingsBox);

  @override
  void setTimeFormat({required String value}) {
    _box.put(g.timeFormatKey, value);
  }

  @override
  String getTimeFormat() {
    return _box.get(g.timeFormatKey, defaultValue: 'Hm');
  }

  @override
  void setDateFormat({required String value}) {
    _box.put(g.dateFormatKey, value);
  }

  @override
  String getDateFormat() {
    return _box.get(g.dateFormatKey, defaultValue: 'd MMM y');
  }

  @override
  void setDisplayTaskDoneTimePref({required bool value}) {
    _box.put(g.displayTaskDonePrefKey, value);
  }

  @override
  bool getDisplayTaskDoneTimePref() {
    return _box.get(g.displayTaskDonePrefKey, defaultValue: false);
  }
}
